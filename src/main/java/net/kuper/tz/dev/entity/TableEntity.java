package net.kuper.tz.dev.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import io.swagger.annotations.ApiModelProperty;

import java.util.Date;
import java.util.List;

public class TableEntity {

    @ApiModelProperty(value = "表名称")
    private String name;
    @ApiModelProperty(value = "engine")
    private String engine;
    @ApiModelProperty(value = "描述")
    private String comment;
    @ApiModelProperty(value = "创建时间")
    private Date createTime;
    /**
     * 所有列
     */
    @JsonIgnore
    @ApiModelProperty(hidden = true)
    private List<ColumnEntity> columnList;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEngine() {
        return engine;
    }

    public void setEngine(String engine) {
        this.engine = engine;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public List<ColumnEntity> getColumnList() {
        return columnList;
    }

    public void setColumnList(List<ColumnEntity> columnList) {
        this.columnList = columnList;
    }
}
