package net.kuper.tz.dev.controller;


import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import net.kuper.tz.core.controller.auth.IgnoreAuth;
import net.kuper.tz.core.controller.log.Log;
import net.kuper.tz.core.controller.log.LogType;
import net.kuper.tz.core.utils.DateUtils;
import net.kuper.tz.dev.param.GenerateCode;
import net.kuper.tz.dev.service.CodeService;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

@Api(value = "代码生成")
@RestController
@RequestMapping("/dev/code")
public class CodeController {

    @Autowired
    private CodeService codeService;

    @ApiOperation("下载生成代码")
    @Log(value = "下载生成代码", type = LogType.QUERY)
//    @RequiresPermissions("gen:code:download" )
    @IgnoreAuth
    @GetMapping("/download")
    public void genCode(GenerateCode code, HttpServletResponse response) throws IOException {
        code.setTemplate("v3");
        byte[] data = codeService.genCode(code);
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
        String fileName = code.getSchemaName() + DateUtils.date2String(new Date(), dateFormat) + ".zip";
        if (code.getTableNames().size() == 1) {
            fileName = code.getTableNames().get(0) + DateUtils.date2String(new Date(), dateFormat) + ".zip";
        }
        response.reset();
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
        response.setHeader("filename", fileName);
        response.setHeader("Access-Control-Expose-Headers", "filename,Content-Disposition");
        response.addHeader("Content-Length", "" + data.length);
        response.setContentType("application/octet-stream; charset=UTF-8");
        IOUtils.write(data, response.getOutputStream());
    }

//    @ApiOperation("下载生成代码")
//    @Log(value = "下载生成代码", type = LogType.QUERY)
////    @RequiresPermissions("gen:code:download" )
//    @IgnoreAuth
//    @GetMapping("/download")
//    public void genCode(HttpServletResponse response) throws IOException {
//        GenerateCode code = new GenerateCode();
//        code.setAuthor("kuper");
//        code.setContact("shengongwen@163.com");
//        code.setModule("test");
//        code.setPkg("com.gen");
//        code.setSchemaName("haoge");
//        code.setTableNames(Arrays.asList("sys_user", "sys_role"));
//        code.setTablePrefix("sys");
//        code.setTemplate("v3");
//        byte[] data = codeService.genCode(code);
//        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
//        String fileName = code.getSchemaName() + DateUtils.date2String(new Date(), dateFormat) + ".zip";
//        if (code.getTableNames().size() == 1) {
//            fileName = code.getTableNames().get(0) + DateUtils.date2String(new Date(), dateFormat) + ".zip";
//        }
//        response.reset();
//        response.setHeader("Access-Control-Allow-Origin", "*");
//        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
//        response.setHeader("filename", fileName);
//        response.setHeader("Access-Control-Expose-Headers", "filename,Content-Disposition");
//        response.addHeader("Content-Length", "" + data.length);
//        response.setContentType("application/octet-stream; charset=UTF-8");
//        IOUtils.write(data, response.getOutputStream());
//    }

}
