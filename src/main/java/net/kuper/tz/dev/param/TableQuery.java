package net.kuper.tz.dev.param;

import io.swagger.annotations.ApiModelProperty;

import java.util.List;

public class TableQuery {
    @ApiModelProperty(value = "数据库名称")
    private String schemaName;
    @ApiModelProperty(value = "表名称")
    private List<String> tableNames;

    public String getSchemaName() {
        return schemaName;
    }

    public void setSchemaName(String schemaName) {
        this.schemaName = schemaName;
    }

    public List<String> getTableNames() {
        return tableNames;
    }

    public void setTableNames(List<String> tableNames) {
        this.tableNames = tableNames;
    }
}
