package ${package}.${module}.service.impl;

import ${package}.${module}.dao.${table.className}Dao;
import ${package}.${module}.entity.${table.className}Entity;
import ${package}.${module}.param.${table.className}Add;
import ${package}.${module}.param.${table.className}Update;
import ${package}.${module}.param.${table.className}Query;
import ${package}.${module}.service.${table.className}Service;
import net.kuper.jsb.core.mybatis.Pagination;

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
    public Pagination<${table.className}Entity> queryList(${table.className}Query ${table.memberName}Query) {
        PageHelper.startPage(${table.memberName}Query.getPage(), ${table.memberName}Query.getPageSize());
        List<${table.className}Entity> list = ${table.memberName}Dao.queryList(${table.memberName}Query);
        return new Pagination<${table.className}Entity>(list);
    }

    @Override
    public ${table.className}Entity queryObject(${table.primaryKey.className} ${table.primaryKey.memberName}) {
        return ${table.memberName}Dao.queryObject(${table.primaryKey.memberName});
    }

    @Override
    public ${table.className}Entity save(${table.className}Add ${table.memberName}Add) {
        ${table.memberName}Dao.save(${table.memberName}Add);
        return ${table.memberName}Dao.queryObject(${table.memberName}Add.get${table.primaryKey.methodName}());
    }

    @Override
    public void update(${table.className}Update ${table.memberName}Update) {
        ${table.memberName}Dao.update(${table.memberName}Update);
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
