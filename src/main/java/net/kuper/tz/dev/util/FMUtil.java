package net.kuper.tz.dev.util;

import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.springframework.core.io.DefaultResourceLoader;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;

import java.io.*;
import java.util.Locale;
import java.util.Map;

public class FMUtil {

    private static Configuration configuration = null;

    static {
        configuration = new Configuration(Configuration.VERSION_2_3_28);
        configuration.setDefaultEncoding("utf-8");
        try {
            ResourceLoader resourceLoader = new DefaultResourceLoader();
            //指定模板目录在类路径：WEB-INF/classes
            Resource resource = resourceLoader.getResource("classpath:templates");
            File file = resource.getFile();
            //设置要解析的模板所在的目录，并加载模板文件
            configuration.setDirectoryForTemplateLoading(file);
            //设置包装器，并将对象包装为数据模型
            configuration.setObjectWrapper(new DefaultObjectWrapper());
            //设置编码
            configuration.setEncoding(Locale.CHINA, "UTF-8");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static Template getTemplate(String file) throws IOException {
        Template t = null;
        try {
            t = configuration.getTemplate(file);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return t;
    }

    public static Writer getWriter(String dir, String wordName) {
        File file = new File(dir);
        if (!file.exists()) {
            file.mkdirs();
        }
        File outFile = new File(dir + File.separator + wordName);
        Writer out = null;
        try {
            out = new BufferedWriter(new OutputStreamWriter(
                    new FileOutputStream(outFile), "utf-8"));
        } catch (Exception e1) {
            e1.printStackTrace();
        }
        return out;
    }

    public static void createDoc(Template t, Map dataMap, Writer out) {
        try {
            t.process(dataMap, out);
        } catch (TemplateException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
