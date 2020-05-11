package net.kuper.tz.dev.param;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.util.List;

@ApiModel(value = "下载代码")
public class GenerateCode {

    @ApiModelProperty(value = "主包名")
    private String pkg;
    @ApiModelProperty(value = "模块名称")
    private String module;
    @ApiModelProperty(value = "数据名称")
    private String schemaName;
    @ApiModelProperty(value = "表前缀")
    private String tablePrefix;
    @ApiModelProperty(value = "表名称")
    private List<String> tableNames;


    @ApiModelProperty(value = "作者")
    private String author;
    @ApiModelProperty(value = "联系方式")
    private String contact;
    @ApiModelProperty(value = "模板名称")
    private String template;


    public String getPkg() {
        return pkg;
    }

    public void setPkg(String pkg) {
        this.pkg = pkg;
    }

    public String getModule() {
        return module;
    }

    public void setModule(String module) {
        this.module = module;
    }

    public String getSchemaName() {
        return schemaName;
    }

    public void setSchemaName(String schemaName) {
        this.schemaName = schemaName;
    }

    public String getTablePrefix() {
        return tablePrefix;
    }

    public void setTablePrefix(String tablePrefix) {
        this.tablePrefix = tablePrefix;
    }

    public List<String> getTableNames() {
        return tableNames;
    }

    public void setTableNames(List<String> tableNames) {
        this.tableNames = tableNames;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getTemplate() {
        return template;
    }

    public void setTemplate(String template) {
        this.template = template;
    }
}
