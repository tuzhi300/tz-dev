package ${package}.${module}.entity;

import lombok.Data;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

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
@Data
public class ${table.className}Entity implements Serializable {
    private static final long serialVersionUID = 1L;

<#if table.columnList??>
    <#list table.columnList as column>
    <#if column.comment != ''>
    /**
     * ${column.comment}
     */
    </#if>
    <#if column.className == 'Date'>
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    </#if>
    @ApiModelProperty(value = "${column.comment}")
    private ${column.className} ${column.memberName};
    </#list>
</#if>

}
