package net.kuper.tz.dev.entity;

import io.swagger.annotations.ApiModelProperty;

public class ColumnEntity {

    @ApiModelProperty(value = "列名")
    private String name;
    @ApiModelProperty(value = "数据类型")
    private String dataType;
    @ApiModelProperty(value = "columnKey")
    private String columnKey;
    @ApiModelProperty(value = "extra")
    private String extra;
    @ApiModelProperty(value = "描述")
    private String comment;
    @ApiModelProperty(value = "长度")
    private String length;
    @ApiModelProperty(value = "允许空")
    private String nullable;
    @ApiModelProperty(value = "默认值")
    private String defaultValue;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDataType() {
        return dataType;
    }

    public void setDataType(String dataType) {
        this.dataType = dataType;
    }

    public String getColumnKey() {
        return columnKey;
    }

    public void setColumnKey(String columnKey) {
        this.columnKey = columnKey;
    }

    public String getExtra() {
        return extra;
    }

    public void setExtra(String extra) {
        this.extra = extra;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getLength() {
        return length;
    }

    public void setLength(String length) {
        this.length = length;
    }

    public String getNullable() {
        return nullable;
    }

    public void setNullable(String nullable) {
        this.nullable = nullable;
    }

    public String getDefaultValue() {
        return defaultValue;
    }

    public void setDefaultValue(String defaultValue) {
        this.defaultValue = defaultValue;
    }
}
