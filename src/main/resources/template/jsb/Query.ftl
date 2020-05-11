package ${package}.${module}.param;

import io.swagger.annotations.ApiModel;
import net.kuper.jsb.core.mybatis.PaginationQuery;

import io.swagger.annotations.ApiModelProperty;
import java.io.Serializable;

/**
 * 分页查询${table.comment}
 *
 * @author ${author}
 * @email ${email}
 * @date ${createTime}
 */
@ApiModel(value = "分页查询${table.comment}")
public class ${table.className}Query extends PaginationQuery implements Serializable {
    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "排序字段")
    private String sidx;
    @ApiModelProperty(value = "排序方式",notes = "可选AES，DESC，默认DESC")
    private String order = "DESC";
    @ApiModelProperty(value = "搜索关键词",notes = "实用于单个关键字查询")
    private String key;


    public String getSidx() {
        return sidx;
    }

    public void setSidx(String sidx) {
        this.sidx = sidx;
    }

    public String getOrder() {
        return order;
    }

    public void setOrder(String order) {
        this.order = order;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }


}
