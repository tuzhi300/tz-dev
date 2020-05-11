package net.kuper.tz.dev.param;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import net.kuper.tz.core.mybatis.PaginationQuery;

@ApiModel(value = "分页查询数据表")
public class TablePaginationQuery extends PaginationQuery {

    @ApiModelProperty(value = "数据库名称")
    private String schemaName;
    @ApiModelProperty(value = "表名称")
    private String tableName;

    public String getSchemaName() {
        return schemaName;
    }

    public void setSchemaName(String schemaName) {
        this.schemaName = schemaName;
    }

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }
}
