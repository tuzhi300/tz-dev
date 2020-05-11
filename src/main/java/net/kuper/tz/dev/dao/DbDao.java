package net.kuper.tz.dev.dao;

import net.kuper.tz.dev.entity.ColumnEntity;
import net.kuper.tz.dev.entity.SchemaEntity;
import net.kuper.tz.dev.entity.TableEntity;
import net.kuper.tz.dev.param.ColumnQuery;
import net.kuper.tz.dev.param.TablePaginationQuery;
import net.kuper.tz.dev.param.TableQuery;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DbDao {

    List<SchemaEntity> querySchemaList();

    List<TableEntity> queryTableList(TablePaginationQuery query);

    List<TableEntity> queryTables(TableQuery query);

    List<ColumnEntity> queryColumnList(ColumnQuery query);

}
