package net.kuper.tz.dev.service.impl;

import com.github.pagehelper.PageHelper;
import net.kuper.tz.core.mybatis.Pagination;
import net.kuper.tz.dev.dao.DbDao;
import net.kuper.tz.dev.entity.ColumnEntity;
import net.kuper.tz.dev.entity.SchemaEntity;
import net.kuper.tz.dev.entity.TableEntity;
import net.kuper.tz.dev.param.ColumnQuery;
import net.kuper.tz.dev.param.TablePaginationQuery;
import net.kuper.tz.dev.service.DbService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("dbService")
public class DbServiceImpl implements DbService {

    @Autowired
    private DbDao dbDao;

    @Override
    public List<SchemaEntity> querySchemaList() {
        return dbDao.querySchemaList();
    }

    @Override
    public Pagination<TableEntity> queryTableList(TablePaginationQuery query) {
        PageHelper.startPage(query.getPage(), query.getPageSize());
        List<TableEntity> tableList = dbDao.queryTableList(query);
        return new Pagination<>(tableList);
    }

    @Override
    public List<ColumnEntity> queryColumn(ColumnQuery query) {
        return dbDao.queryColumnList(query);
    }


}
