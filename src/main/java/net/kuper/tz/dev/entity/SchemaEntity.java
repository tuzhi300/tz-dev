package net.kuper.tz.dev.entity;

import io.swagger.annotations.ApiModelProperty;

public class SchemaEntity {

    @ApiModelProperty(value = "")
    private String catalogName;
    @ApiModelProperty(value = "数据库名")
    private String schemaName;
    @ApiModelProperty(value = "字符集")
    private String characterSetName;
    @ApiModelProperty(value = "collationName")
    private String collationName;

    public String getCatalogName() {
        return catalogName;
    }

    public void setCatalogName(String catalogName) {
        this.catalogName = catalogName;
    }

    public String getSchemaName() {
        return schemaName;
    }

    public void setSchemaName(String schemaName) {
        this.schemaName = schemaName;
    }

    public String getCharacterSetName() {
        return characterSetName;
    }

    public void setCharacterSetName(String characterSetName) {
        this.characterSetName = characterSetName;
    }

    public String getCollationName() {
        return collationName;
    }

    public void setCollationName(String collationName) {
        this.collationName = collationName;
    }
}
