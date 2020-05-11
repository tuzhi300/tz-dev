package ${package}.${module}.controller;


import net.kuper.jsb.core.controller.Resp;
import net.kuper.jsb.core.annotation.Log;
import net.kuper.jsb.core.mybatis.Pagination;
import net.kuper.jsb.core.validator.ValidatorUtils;
import net.kuper.jsb.core.validator.group.AddGroup;
import net.kuper.jsb.core.validator.group.UpdateGroup;
import ${package}.${module}.entity.${table.className}Entity;
import ${package}.${module}.param.${table.className}Add;
import ${package}.${module}.param.${table.className}Update;
import ${package}.${module}.param.${table.className}Query;
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
     * @param ${table.memberName}Query
     */
    @ApiOperation("分页查询${table.comment}" )
    @RequiresPermissions("${module}:${table.path}:list" )
    @ResponseBody
    @GetMapping
    public Resp<Pagination<${table.className}Entity>> list(${table.className}Query ${table.memberName}Query) {
        ValidatorUtils.validateEntity(${table.memberName}Query);
        Pagination pagination = ${table.memberName}Service.queryList(${table.memberName}Query);
        return Resp.ok(pagination);
    }


    /**
     * ${table.comment}详情查询
     *
     * @param ${table.primaryKey.memberName}
     * @return
     */
    @ApiOperation("${table.comment}详情查询" )
    @RequiresPermissions("${module}:${table.path}:info" )
    @ResponseBody
    @GetMapping(value = "/{${table.primaryKey.memberName}}" )
    public Resp<${table.className}Entity> info(@PathVariable("${table.primaryKey.memberName}") ${table.primaryKey.className} ${table.primaryKey.memberName}) {
        ${table.className}Entity  ${table.memberName} = ${table.memberName}Service.queryObject(${table.primaryKey.memberName});
        return Resp.ok(${table.memberName});
    }

    /**
     * 添加${table.comment}
     *
     * @param ${table.memberName}Add
     */
    @Log("添加${table.comment}" )
    @ApiOperation("添加${table.comment}" )
    @RequiresPermissions("${module}:${table.path}:save" )
    @ResponseBody
    @PostMapping
    public Resp<${table.className}Entity> save(@RequestBody ${table.className}Add ${table.memberName}Add) {
        ValidatorUtils.validateEntity(${table.memberName}Add, AddGroup.class);
        ${table.className}Entity ${table.memberName}Entity =${table.memberName}Service.save(${table.memberName}Add);
        return Resp.ok(${table.memberName}Entity);
    }

    /**
     * 修改${table.comment}
     * @param ${table.memberName}Update
     */
    @Log("修改${table.comment}" )
    @ApiOperation("修改${table.comment}" )
    @RequiresPermissions("${module}:${table.path}:update" )
    @ResponseBody
    @PutMapping
    public Resp update(@RequestBody ${table.className}Update ${table.memberName}Update) {
        ValidatorUtils.validateEntity(${table.memberName}Update, UpdateGroup.class);
        ${table.memberName}Service.update(${table.memberName}Update);
        return Resp.ok();
    }

    /**
     * 删除${table.comment}
     * @param ${table.primaryKey.memberName}
     */
    @Log("删除${table.comment}" )
    @ApiOperation("删除${table.comment}" )
    @RequiresPermissions("${module}:${table.path}:delete" )
    @ResponseBody
    @DeleteMapping(value = "/{${table.primaryKey.memberName}}" )
    public Resp delete(@PathVariable("${table.primaryKey.memberName}") ${table.primaryKey.className} ${table.primaryKey.memberName}) {
        ${table.memberName}Service.delete(${table.primaryKey.memberName});
        return Resp.ok();
    }

}
