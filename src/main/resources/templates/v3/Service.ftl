package ${package}.${module}.service;

import net.kuper.tz.core.mybatis.Pagination;
<#if table.primaryKey.classPath?? && table.primaryKey.classPath != ''>
import ${table.primaryKey.classPath};
</#if>
import ${package}.${module}.entity.${table.className}Entity;
import ${package}.${module}.entity.${table.className}UpdateEntity;
import ${package}.${module}.entity.${table.className}QueryEntity;

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
     * @param ${table.memberName}QueryEntity 分页查询参数
     * @return Pagination
     */
    Pagination<${table.className}Entity> queryList(${table.className}QueryEntity ${table.memberName}QueryEntity);

    /**
      * ${table.comment}详情查询
      *
      * @param ${table.primaryKey.memberName}
      * @return ${table.comment}
      */
    ${table.className}Entity queryObject(${table.primaryKey.className} ${table.primaryKey.memberName});

    /**
     * 新增：${table.comment}
     *
     * @param ${table.memberName}UpdateEntity
     * @return ${table.comment}
     */
     ${table.className}Entity save(${table.className}UpdateEntity ${table.memberName}UpdateEntity);

    /**
     * 修改 ${table.comment}
     *
     * @param ${table.memberName}UpdateEntity
     * @return
     */
    void update(${table.className}UpdateEntity ${table.memberName}UpdateEntity);

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

