package ${package}.${module}.entity;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.io.Serializable;
<#if table.classPathList??>
<#list table.classPathList as path>
<#if path?? &&  path != ''>
import ${path};
</#if>
</#list>
</#if>

/**
 * ${table.comment}
 *
 * @author ${author}
 * @email ${email}
 * @date ${createTime}
 */
@ApiModel(value = "${table.comment}")
public class ${table.className}Entity implements Serializable {
    private static final long serialVersionUID = 1L;

<#if table.columnList??>
    <#list table.columnList as column>
    <#if column.comment != ''>
    /**
     * ${column.comment}
     */
    </#if>
    @ApiModelProperty(value = "${column.comment}")
    private ${column.className} ${column.memberName};
    </#list>
</#if>


<#if table.columnList??>
    <#list table.columnList as column>
    <#if column.comment != ''>
    /**
    * 设置：${column.comment}
    */
    </#if>
    public void set${column.methodName}(${column.className} ${column.memberName}) {
        this.${column.memberName} = ${column.memberName};
    }


    <#if column.comment != ''>
    /**
    * 获取：${column.comment}
    */
    </#if>
    public ${column.className} get${column.methodName}() {
        return this.${column.memberName};
    }
    </#list>
</#if>

}
