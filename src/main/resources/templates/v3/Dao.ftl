package ${package}.${module}.dao;

<#if table.primaryKey.classPath?? && table.primaryKey.classPath != ''>
import ${table.primaryKey.classPath};
</#if>
import ${package}.${module}.entity.${table.className}Entity;
import ${package}.${module}.entity.${table.className}UpdateEntity;
import ${package}.${module}.entity.${table.className}QueryEntity;

import java.util.List;

/**
 * ${table.comment}
 *
 * @author ${author}
 * @email ${email}
 * @date ${createTime}
 */
public interface ${table.className}Dao {

    /**
     * ${table.comment}详情
     *
     * @param ${table.primaryKey.memberName}
     * @return
     */
    ${table.className}Entity queryObject(${table.primaryKey.className} ${table.primaryKey.memberName});

    /**
     *  ${table.comment}列表
     *
     * @param ${table.memberName}QueryEntity
     * @return
     */
    List<${table.className}Entity> queryList(${table.className}QueryEntity ${table.memberName}QueryEntity);

    /**
     * ${table.comment}新增
     *
     * @param ${table.memberName}UpdateEntity
     */
    void save(${table.className}UpdateEntity ${table.memberName}UpdateEntity);

    /**
     *  ${table.comment}修改
     *
     * @param ${table.memberName}UpdateEntity
     */
    void update(${table.className}UpdateEntity ${table.memberName}UpdateEntity);

    /**
     * ${table.comment}单条删除
     *
     * @param ${table.primaryKey.memberName}
     */
    void delete(${table.primaryKey.className} ${table.primaryKey.memberName});

    /**
     * ${table.comment}批量删除
     *
     * @param ${table.primaryKey.memberName}s
     */
    void deleteBatch(${table.primaryKey.className}[] ${table.primaryKey.memberName}s);
}
