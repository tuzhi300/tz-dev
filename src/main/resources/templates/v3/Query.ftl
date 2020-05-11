package ${package}.${module}.entity;

import lombok.Data;
import org.hibernate.validator.constraints.Length;
import net.kuper.tz.core.validator.group.AddGroup;
import net.kuper.tz.core.validator.group.UpdateGroup;
import io.swagger.annotations.ApiModel;
import net.kuper.tz.core.mybatis.PaginationQuery;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
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
 * 分页查询${table.comment}
 *
 * @author ${author}
 * @email ${email}
 * @date ${createTime}
 */
@ApiModel(value = "分页查询${table.comment}")
@Data
public class ${table.className}QueryEntity extends PaginationQuery implements Serializable {

    private static final long serialVersionUID = 1L;

<#if table.columnList??>
    <#list table.columnList as column>
        <#if column.name != table.primaryKey.name>
            <#if column.comment != ''>
    /**
    * ${column.comment}
    */
            </#if>
            <#if column.length gt 0>
    @Length(max = ${column.length?c} ,message = "${column.comment}不能超过${column.length}个字符")
            </#if>

            <#if column.className == 'Date'>
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
            </#if>
    @ApiModelProperty(value = "${column.comment}<#if column.defaultValue?? && column.defaultValue != ''>，默认值：${column.defaultValue}</#if><#if column.length gt 0>，最大长度：${column.length}</#if>"<#if column.nullable == 'NO'>, required = true</#if>, position = ${column_index} )
    private ${column.className} ${column.memberName};
        </#if>
    </#list>
</#if>

}
