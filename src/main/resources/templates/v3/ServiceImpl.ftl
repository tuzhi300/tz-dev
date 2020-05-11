package ${package}.${module}.service.impl;

import ${package}.${module}.dao.${table.className}Dao;
import ${package}.${module}.entity.${table.className}Entity;
import ${package}.${module}.entity.${table.className}UpdateEntity;
import ${package}.${module}.entity.${table.className}QueryEntity;
import ${package}.${module}.service.${table.className}Service;
import net.kuper.tz.core.mybatis.Pagination;

<#if table.primaryKey.classPath?? && table.primaryKey.classPath != ''>
import ${table.primaryKey.classPath}
</#if>
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * ${table.comment}Service实现类
 *
 * @author ${author}
 * @email ${email}
 * @date ${createTime}
 */
@Service("${table.memberName}Service" )
public class ${table.className}ServiceImpl implements ${table.className}Service {

    @Autowired
    private ${table.className}Dao ${table.memberName}Dao;

    @Override
    public Pagination<${table.className}Entity> queryList(${table.className}QueryEntity ${table.memberName}QueryEntity) {
        PageHelper.startPage(${table.memberName}QueryEntity.getPage(), ${table.memberName}QueryEntity.getPageSize());
        List<${table.className}Entity> ${table.memberName}List = ${table.memberName}Dao.queryList(${table.memberName}QueryEntity);
        return new Pagination<${table.className}Entity>(${table.memberName}List);
    }

    @Override
    public ${table.className}Entity queryObject(${table.primaryKey.className} ${table.primaryKey.memberName}) {
        return ${table.memberName}Dao.queryObject(${table.primaryKey.memberName});
    }

    @Override
    public ${table.className}Entity save(${table.className}UpdateEntity ${table.memberName}UpdateEntity) {
        ${table.memberName}Dao.save(${table.memberName}UpdateEntity);
        return ${table.memberName}Dao.queryObject(${table.memberName}UpdateEntity.get${table.primaryKey.methodName}());
    }

    @Override
    public void update(${table.className}UpdateEntity ${table.memberName}UpdateEntity) {
        ${table.memberName}Dao.update(${table.memberName}UpdateEntity);
    }

    @Override
    public void delete(${table.primaryKey.className} ${table.primaryKey.memberName}) {
        ${table.memberName}Dao.delete(${table.primaryKey.memberName});
    }

    @Override
    public void deleteBatch(${table.primaryKey.className}[] ${table.primaryKey.memberName}s) {
        ${table.memberName}Dao.deleteBatch(${table.primaryKey.memberName}s);
    }
}
