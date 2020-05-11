package ${package}.${module}.service;

import net.kuper.jsb.core.mybatis.Pagination;
<#if table.primaryKey.classPath?? && table.primaryKey.classPath != ''>
import ${table.primaryKey.classPath};
</#if>
import ${package}.${module}.entity.${table.className}Entity;
import ${package}.${module}.param.${table.className}Add;
import ${package}.${module}.param.${table.className}Update;
import ${package}.${module}.param.${table.className}Query;

/**
 * ${table.comment}
 *
 * @author ${author}
 * @email ${email}
 * @date ${createTime}
 */
public interface ${table.className}Service {

    /**
     * 分页查询:${table.comment}
     *
     * @param ${table.memberName}Query 分页查询参数
     * @return Pagination
     */
    Pagination<${table.className}Entity> queryList(${table.className}Query ${table.memberName}Query);

    /**
      * ${table.comment}详情查询
      *
      * @param ${table.primaryKey.memberName}
      * @return ${table.comment}
      */
    ${table.className}Entity queryObject(${table.primaryKey.className} ${table.primaryKey.memberName});

    /**
     * 创建：${table.comment}
     *
     * @param ${table.memberName}Add
     * @return ${table.comment}
     */
     ${table.className}Entity save(${table.className}Add ${table.memberName}Add);

    /**
     * 修改 ${table.comment}
     *
     * @param ${table.memberName}Update
     * @return
     */
    void update(${table.className}Update ${table.memberName}Update);

    /**
     * ${table.comment}单条根据删除
     *
     * @param ${table.primaryKey.memberName}
     * @return
     */
    void delete(${table.primaryKey.className} ${table.primaryKey.memberName});

    /**
     * ${table.comment}批量删除
     *
     * @param ${table.primaryKey.memberName}s
     * @return
     */
    void deleteBatch(${table.primaryKey.className}[] ${table.primaryKey.memberName}s);

}

