<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${package}.${module}.dao.${table.className}Dao">

    <resultMap type="${package}.${module}.entity.${table.className}Entity" id="${table.memberName}Map">
    <#list table.columnList as column>
        <result property="${column.memberName}" column="${column.name}"/>
    </#list>
    </resultMap>


    <sql id="columns">
    <#list table.columnList as column>
        `t`.`${column.name}` <#if column_has_next>,</#if>
    </#list>
    </sql>

    <sql id="select_normal">
        select
        <include refid="columns"/>
        from  `${table.name}` as `t`
    </sql>

    <select id="queryObject" resultMap="${table.memberName}Map">
        <include refid="select_normal"/>
        where `t`.`${table.primaryKey.name}` = ${r'#{'}value${r'}'}
    </select>

    <select id="queryList" parameterType="map" resultMap="${table.memberName}Map">
        <include refid="select_normal"/>
        WHERE 1=1
        <if test="key != null and key.trim() != ''">
            AND `t`.`${table.primaryKey.name}` LIKE concat('%',${r'#{'}key${r'}'},'%')
        </if>
        <choose>
            <when test="sidx != null and sidx.trim() != ''">
                order by ${r'${'}sidx${r'}'} ${r'${'}order${r'}'}
            </when>
            <otherwise>
                order by `t`.`${table.primaryKey.name}` desc
            </otherwise>
        </choose>
    </select>

    <insert id="save" parameterType="${package}.${module}.param.${table.className}Add" <#if table.primaryKey.extra == 'auto_increment'> useGeneratedKeys="true" keyProperty="${table.primaryKey.memberName }"</#if>>
        insert into `${table.name}`
        <trim prefix="(" suffix=")" suffixOverrides=",">
        <#list table.columnList as column>
            <if test="${column.memberName} != null">
                `${column.name}` ,
            </if>
        </#list>
        </trim>
        <trim prefix="values (" suffix=")" suffixOverrides=",">
        <#list table.columnList as column>
            <if test="${column.memberName} != null">
                ${r'#{'}${column.memberName}${r'}'} ,
            </if>
        </#list>
        </trim>
    </insert>

    <update id="update" parameterType="${package}.${module}.param.${table.className}Update">
        update `${table.name}`
        <set>
        <#list table.columnList as column>
          <#if column.name != table.primaryKey.name>
            <if test="${column.memberName} != null">
                `${column.name}` = ${r'#{'}${column.memberName}${r'}'} ,
            </if>
          </#if>
        </#list>
        </set>
        where `${table.primaryKey.name}` = ${r'#{'}${table.primaryKey.memberName}${r'}'}
    </update>

    <delete id="delete">
        delete from `${table.name}` where `${table.primaryKey.name}` = ${r'#{'}value${r'}'}
    </delete>

    <delete id="deleteBatch">
        delete from `${table.name}` where `${table.primaryKey.name}` in
        <foreach item="id" collection="array" open="(" separator="," close=")">
            ${r'#{'}id${r'}'}
        </foreach>
    </delete>

</mapper>