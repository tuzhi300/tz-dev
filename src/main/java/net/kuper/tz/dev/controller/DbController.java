package net.kuper.tz.dev.controller;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import net.kuper.tz.core.controller.Res;
import net.kuper.tz.core.controller.auth.IgnoreAuth;
import net.kuper.tz.core.controller.log.Log;
import net.kuper.tz.core.controller.log.LogType;
import net.kuper.tz.core.mybatis.Pagination;
import net.kuper.tz.core.validator.ValidatorUtils;
import net.kuper.tz.dev.entity.ColumnEntity;
import net.kuper.tz.dev.entity.SchemaEntity;
import net.kuper.tz.dev.entity.TableEntity;
import net.kuper.tz.dev.param.ColumnQuery;
import net.kuper.tz.dev.param.TablePaginationQuery;
import net.kuper.tz.dev.service.DbService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Api(value = "数据库信息")
@RestController
@RequestMapping("/dev/db")
public class DbController {

    @Autowired
    private DbService dbService;

    @ApiOperation("数据库列表")
    @Log(value = "数据库列表", type = LogType.QUERY)
//    @RequiresPermissions("gen:db:schemas" )
    @IgnoreAuth
    @GetMapping("/scheams")
    public Res<List<SchemaEntity>> queryScheamList() {
        return Res.ok(dbService.querySchemaList());
    }

    @ApiOperation("数据表查询")
    @Log(value = "数据表查询", type = LogType.QUERY)
//    @RequiresPermissions("gen:db:tables" )
    @IgnoreAuth
    @GetMapping("/tables")
    public Res<Pagination<TableEntity>> queryTableList(TablePaginationQuery query) {
        ValidatorUtils.validateEntity(query);
        return Res.ok(dbService.queryTableList(query));
    }

    @ApiOperation("数据列查询")
    @Log(value = "数据列查询", type = LogType.QUERY)
//    @RequiresPermissions("gen:db:columns" )
    @IgnoreAuth
    @GetMapping("/columns")
    public Res<List<ColumnEntity>> queryColumnList(ColumnQuery query) {
        ValidatorUtils.validateEntity(query);
        return Res.ok(dbService.queryColumn(query));
    }
}
