package net.kuper.tz.dev.service.impl;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import lombok.extern.slf4j.Slf4j;
import net.kuper.tz.core.controller.exception.ApiException;
import net.kuper.tz.core.utils.DateUtils;
import net.kuper.tz.core.utils.FileIOUtils;
import net.kuper.tz.dev.dao.DbDao;
import net.kuper.tz.dev.entity.ColumnEntity;
import net.kuper.tz.dev.entity.TableEntity;
import net.kuper.tz.dev.entity.TmplFile;
import net.kuper.tz.dev.param.ColumnQuery;
import net.kuper.tz.dev.param.GenerateCode;
import net.kuper.tz.dev.param.TableQuery;
import net.kuper.tz.dev.service.CodeService;
import net.kuper.tz.dev.util.ColUtil;
import net.kuper.tz.dev.util.FMUtil;
import net.kuper.tz.dev.util.StringUtils;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.*;
import java.net.URL;
import java.util.*;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

@Slf4j
@Service("codeService")
public class CodeServiceImpl implements CodeService {


    @Autowired
    private DbDao dbDao;
    @Autowired
    private ObjectMapper objectMapper;

    /**
     * 构建模板数据
     *
     * @param gen
     * @param tableList
     * @return
     */
    private List<Map<String, Object>> buildData(GenerateCode gen, List<TableEntity> tableList) {
        List<Map<String, Object>> mapList = new ArrayList<>();
        for (TableEntity table : tableList) {
            //配置信息
            Map<String, Object> map = new HashMap<>();
            map.put("package", gen.getPkg());
            map.put("module", gen.getModule());
            map.put("author", gen.getAuthor());
            map.put("email", gen.getContact());
            map.put("createTime", DateUtils.date2String(new Date()));
            map.put("schemaName", gen.getSchemaName());
            //表信息
            Map<String, Object> tableMap = new HashMap<>();
            String tableName = StringUtils.subPrefix(table.getName(), gen.getTablePrefix());
            tableMap.put("className", StringUtils.toTypeName(tableName));
            tableMap.put("memberName", StringUtils.toMeneberName(tableName));
            tableMap.put("name", table.getName());
            tableMap.put("comment", table.getComment());
            tableMap.put("path", StringUtils.toPathName(tableName));
            tableMap.put("routerName", StringUtils.toTypeName(gen.getModule()) + StringUtils.toTypeName(tableName) + "Index");

            Map<String, Object> primaryKey = null;
            List<String> classPathList = new ArrayList<>();
            // 列信息
            List<Map> columnList = new ArrayList<>();
            for (ColumnEntity column : table.getColumnList()) {
                Map<String, Object> columnMap = new HashMap<>();
                columnMap.put("name", column.getName());
                columnMap.put("comment", column.getComment());
                columnMap.put("memberName", StringUtils.toMeneberName(column.getName()));
                columnMap.put("methodName", StringUtils.toTypeName(column.getName()));
                columnMap.put("extra", column.getExtra());
                columnMap.put("length", column.getLength() == null ? 0 : Long.valueOf(column.getLength()));
                columnMap.put("nullable", column.getNullable());
                columnMap.put("defaultValue", column.getDefaultValue());
                String colClassName = ColUtil.colType2JavaType(column.getDataType());
                String colClassPath = ColUtil.columnClassPath(colClassName);
                columnMap.put("className", colClassName);
                columnMap.put("classPath", colClassPath);
                if (!net.kuper.tz.core.utils.StringUtils.isEmpty(colClassPath) && !classPathList.contains(colClassPath)) {
                    classPathList.add(colClassPath);
                }
                if ("PRI".equals(column.getColumnKey())) {
                    primaryKey = columnMap;
                }
                columnList.add(columnMap);
            }
            if (primaryKey == null) {
                primaryKey = columnList.get(0);
            }
            tableMap.put("columnList", columnList);
            tableMap.put("primaryKey", primaryKey);
            tableMap.put("classPathList", classPathList);
            map.put("table", tableMap);
            mapList.add(map);
        }
        return mapList;
    }

    @Override
    public byte[] genCode(GenerateCode generateCode) {
        byte[] result = new byte[0];
        try {
            TableQuery query = new TableQuery();
            query.setSchemaName(generateCode.getSchemaName());
            query.setTableNames(generateCode.getTableNames());
            List<TableEntity> tableList = dbDao.queryTables(query);
            if (tableList != null) {
                for (TableEntity tableEntity : tableList) {
                    ColumnQuery columnQuery = new ColumnQuery();
                    columnQuery.setSchemaName(generateCode.getSchemaName());
                    columnQuery.setTableName(tableEntity.getName());
                    List<ColumnEntity> columnList = dbDao.queryColumnList(columnQuery);
                    tableEntity.setColumnList(columnList);
                }

                List<Map<String, Object>> mapList = buildData(generateCode, tableList);
                result = buildFile(generateCode, mapList);
            }
        } catch (IOException e) {
            log.error(e.getMessage(), e);
            throw new ApiException(e,"生成代码异常");
        } catch (TemplateException e) {
            log.error(e.getMessage(), e);
            throw new ApiException(e,"生成代码异常");
        }
        return result;
    }

    private String buildFile(Map map, TmplFile tmplFile) throws IOException, TemplateException {
        String name = null;
        StringWriter writer = null;
        try {
            writer = new StringWriter();
            Template t = new Template("template", new StringReader(tmplFile.getOut()), new Configuration(Configuration.VERSION_2_3_23));
            t.process(map, writer);
            name = writer.toString();
            name = name.replace(".", "/");
            name = name + "." + tmplFile.getOutType();
        } finally {
            if (null != writer) {
                IOUtils.closeQuietly(writer);
            }
        }
        return name;
    }

    /**
     * 生产压缩文件
     *
     * @param mapList
     * @return
     * @throws IOException
     */
    private byte[] buildFile(GenerateCode code, List<Map<String, Object>> mapList) throws IOException, TemplateException {
        byte[] zipData = null;
        ByteArrayOutputStream outputStream = null;
        ZipOutputStream zip = null;
        outputStream = new ByteArrayOutputStream();
        try {
            zip = new ZipOutputStream(outputStream);
            for (Map<String, Object> map : mapList) {
                log.info(objectMapper.writeValueAsString(map));
                URL tmplUrl = CodeService.class.getClassLoader().getResource("templates" + File.separator + code.getTemplate() + File.separator + "template.json");
                String tmplJson = FileIOUtils.readFile2String(tmplUrl.getFile());
                List<TmplFile> listll = objectMapper.readValue(tmplJson, new TypeReference<List<TmplFile>>() {
                });
                for (TmplFile tmplFile : listll) {
                    String tmpl = code.getTemplate() + File.separator + tmplFile.getFile() + ".ftl";
                    String fileName = buildFile(map, tmplFile);
                    StringWriter writer = new StringWriter();
                    Template template = FMUtil.getTemplate(tmpl);
                    FMUtil.createDoc(template, map, writer);
                    zip.putNextEntry(new ZipEntry(fileName));
                    IOUtils.write(writer.toString(), zip, "UTF-8");
                    IOUtils.closeQuietly(writer);
                }
            }
            IOUtils.closeQuietly(zip);
            zipData = outputStream.toByteArray();
            IOUtils.closeQuietly(outputStream);
        } catch (TemplateException e) {
            throw e;
        } finally {
            try {
                IOUtils.closeQuietly(zip);
            } catch (Exception e) {

            }
            try {
                IOUtils.closeQuietly(outputStream);
            } catch (Exception e) {

            }
        }
        return zipData;
    }
}
