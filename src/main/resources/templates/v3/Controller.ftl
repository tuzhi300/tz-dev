package ${package}.${module}.controller;


import net.kuper.tz.core.controller.Res;
import net.kuper.tz.core.controller.log.Log;
import net.kuper.tz.core.controller.log.LogType;
import net.kuper.tz.core.mybatis.Pagination;
import net.kuper.tz.core.validator.ValidatorUtils;
import net.kuper.tz.core.validator.group.AddGroup;
import net.kuper.tz.core.validator.group.UpdateGroup;
import ${package}.${module}.entity.${table.className}Entity;
import ${package}.${module}.entity.${table.className}UpdateEntity;
import ${package}.${module}.entity.${table.className}QueryEntity;
import ${package}.${module}.service.${table.className}Service;
<#if table.primaryKey.classPath?? && table.primaryKey.classPath != ''>
import ${table.primaryKey.classPath};
</#if>

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.apache.shiro.authz.annotation.RequiresPermissions;


/**
 * ${table.comment}
 *
 * @author ${author}
 * @email ${email}
 * @date ${createTime}
 */
@Api(value = "${table.comment}" , description = "${table.comment}" )
@RestController
@RequestMapping("${module}/${table.path}" )
public class ${table.className}Controller {

    @Autowired
    private ${table.className}Service ${table.memberName}Service;

    /**
     * 分页查询：${table.comment}
     * @param ${table.memberName}QueryEntity
     */
    @Log(type = LogType.QUERY, value = "分页查询${table.comment}")
    @ApiOperation("分页查询${table.comment}" )
    @RequiresPermissions("${module}:${table.path}:list" )
    @ResponseBody
    @GetMapping
    public Res<Pagination<${table.className}Entity>> list(${table.className}QueryEntity ${table.memberName}QueryEntity) {
        ValidatorUtils.validateEntity(${table.memberName}QueryEntity);
        Pagination pagination = ${table.memberName}Service.queryList(${table.memberName}QueryEntity);
        return Res.ok(pagination);
    }


    /**
     * ${table.comment}详情查询
     *
     * @param ${table.primaryKey.memberName}
     * @return
     */
    @Log(type = LogType.QUERY, value = "${table.comment}详情查询")
    @ApiOperation("${table.comment}详情查询" )
    @RequiresPermissions("${module}:${table.path}:detail" )
    @ResponseBody
    @GetMapping(value = "/{${table.primaryKey.memberName}}" )
    public Res<${table.className}Entity> detail(@PathVariable("${table.primaryKey.memberName}") ${table.primaryKey.className} ${table.primaryKey.memberName}) {
        ${table.className}Entity  ${table.memberName} = ${table.memberName}Service.queryObject(${table.primaryKey.memberName});
        return Res.ok(${table.memberName});
    }

    /**
     * 添加${table.comment}
     *
     * @param ${table.memberName}UpdateEntity
     */
    @Log(type = LogType.SAVE,value = "添加${table.comment}" )
    @ApiOperation("添加${table.comment}" )
    @RequiresPermissions("${module}:${table.path}:add" )
    @ResponseBody
    @PostMapping
    public Res<${table.className}Entity> save(@RequestBody ${table.className}UpdateEntity ${table.memberName}UpdateEntity) {
        ValidatorUtils.validateEntity(${table.memberName}UpdateEntity, AddGroup.class);
        ${table.className}Entity ${table.memberName}Entity =${table.memberName}Service.save(${table.memberName}UpdateEntity);
        return Res.ok(${table.memberName}Entity);
    }

    /**
     * 修改${table.comment}
     * @param ${table.memberName}UpdateEntity
     */
    @Log(type = LogType.UPDATE,value = "修改${table.comment}" )
    @ApiOperation("修改${table.comment}" )
    @RequiresPermissions("${module}:${table.path}:update" )
    @ResponseBody
    @PutMapping
    public Res update(@RequestBody ${table.className}UpdateEntity ${table.memberName}UpdateEntity) {
        ValidatorUtils.validateEntity(${table.memberName}UpdateEntity, UpdateGroup.class);
        ${table.memberName}Service.update(${table.memberName}UpdateEntity);
        return Res.ok();
    }

    /**
     * 删除${table.comment}
     * @param ${table.primaryKey.memberName}
     */
    @Log(type = LogType.DELETE, value = "删除${table.comment}" )
    @ApiOperation("删除${table.comment}" )
    @RequiresPermissions("${module}:${table.path}:delete" )
    @ResponseBody
    @DeleteMapping(value = "/{${table.primaryKey.memberName}}" )
    public Res delete(@PathVariable("${table.primaryKey.memberName}") ${table.primaryKey.className} ${table.primaryKey.memberName}) {
        ${table.memberName}Service.delete(${table.primaryKey.memberName});
        return Res.ok();
    }

}