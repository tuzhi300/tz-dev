<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${package}.${module}.dao.${table.className}Dao">

    <#assign hasDel = false >
    <resultMap id="${table.memberName}Map" type="${package}.${module}.entity.${table.className}Entity">
    <#list table.columnList as column>
        <#if column.name = 'del_flag'>
            <#assign hasDel = true >
        </#if>
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

    <sql id="dft_where">
        <#list table.columnList as column>
            <#if column.name != table.primaryKey.name>
                <#if column.className == 'Integer' || column.className == 'Long'>
        <if test="${column.memberName} != null">
            AND `t`.`${column.name}` = ${r'#{'}${column.memberName}${r'}'}
        </if>
                </#if>
                <#if column.className == 'Float' || column.className == 'Double' || column.className == 'BigDecimal'>
        <if test="${column.memberName} != null">
            AND `t`.`${column.name}` < ${r'#{'}${column.memberName}${r'}'}
        </if>
                </#if>
                <#if column.className == 'Date'>
        <if test="${column.memberName} != null">
            AND date_format(`t`.`${column.name}`,'%Y-%m-%d') = date_format(${r'#{'}${column.memberName}${r'}'},'%Y-%m-%d')
        </if>
                </#if>
                <#if column.className == 'String'>
        <if test="${column.memberName} != null and ${column.memberName}.trim() != ''">
            AND `t`.`${column.name}` LIKE concat('%',${r'#{'}${column.memberName}${r'}'} ,'%')
        </if>
                </#if>
            </#if>
        </#list>
    </sql>

    <sql id="dft_order">
        <choose>
            <when test="sidx != null and sidx.trim() != ''">
                <choose>
                <#list table.columnList as column>
                    <#if column.name != table.primaryKey.name>
                    <when test="'${column.memberName}' == sidx ">
                        order by `t`.`${column.name}`
                    </when>
                    </#if>
                </#list>
                    <otherwise>
                        order by `t`.`${table.primaryKey.name}`
                    </otherwise>
                </choose>
            </when>
            <otherwise>
                order by `t`.`${table.primaryKey.name}`
            </otherwise>
        </choose>
        <choose>
            <when test="stype == 'ASC'">
                ASC
            </when>
            <otherwise>
                DESC
            </otherwise>
        </choose>
    </sql>


    <select id="queryObject" resultMap="${table.memberName}Map">
        <include refid="select_normal"/>
        where `t`.`${table.primaryKey.name}` = ${r'#{'}value${r'}'}
    </select>

    <select id="queryList" parameterType="map" resultMap="${table.memberName}Map">
        <include refid="select_normal"/>
        WHERE 1 = 1
        <include refid="dft_where"/>
        <include refid="dft_order"/>
    </select>

    <insert id="save" parameterType="${package}.${module}.entity.${table.className}UpdateEntity" <#if table.primaryKey.extra == 'auto_increment'> useGeneratedKeys="true" keyProperty="${table.primaryKey.memberName }"</#if>>
        <#if table.primaryKey.extra != 'auto_increment'>
        <selectKey keyProperty="${table.primaryKey.name}" resultType="${table.primaryKey.className}" order="BEFORE">
            select REPLACE(UUID(),'-','') from dual
        </selectKey>
        </#if>
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

    <update id="update" parameterType="${package}.${module}.entity.${table.className}UpdateEntity">
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

    <#if hasDel >
    <update id="delete">
        update `${table.name}` set del_flag = del_flag + 1 where `${table.primaryKey.name}` = ${r'#{'}value${r'}'}
    </update>

    <update id="deleteBatch">
        update `${table.name}` set del_flag = del_flag + 1 where `${table.primaryKey.name}` in
        <foreach item="id" collection="array" open="(" separator="," close=")">
            ${r'#{'}id${r'}'}
        </foreach>
    </update>
    <#else >
    <delete id="delete">
        delete from `${table.name}` where `${table.primaryKey.name}` = ${r'#{'}value${r'}'}
    </delete>

    <delete id="deleteBatch">
        delete from `${table.name}` where `${table.primaryKey.name}` in
        <foreach item="id" collection="array" open="(" separator="," close=")">
            ${r'#{'}id${r'}'}
        </foreach>
    </delete>
    </#if>


</mapper>