package net.kuper.tz.dev.service;

import net.kuper.tz.core.mybatis.Pagination;
import net.kuper.tz.dev.entity.ColumnEntity;
import net.kuper.tz.dev.entity.SchemaEntity;
import net.kuper.tz.dev.entity.TableEntity;
import net.kuper.tz.dev.param.ColumnQuery;
import net.kuper.tz.dev.param.TablePaginationQuery;

import java.util.List;

public interface DbService {


    List<SchemaEntity> querySchemaList();

    Pagination<TableEntity> queryTableList(TablePaginationQuery query);

    List<ColumnEntity> queryColumn(ColumnQuery query);


}
