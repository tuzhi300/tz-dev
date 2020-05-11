package net.kuper.tz.dev.util;

import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.PropertiesConfiguration;

/**
 * sql字段转java
 *
 * @author jie
 * @date 2019-01-03
 */
public class ColUtil {


    private static ColUtil instance;

    private Configuration cfg;

    private ColUtil() {
        try {
            cfg = new PropertiesConfiguration("type.properties");
        } catch (ConfigurationException e) {
            e.printStackTrace();
        }
    }

    private static synchronized ColUtil getInstance() {
        if (instance == null) {
            instance = new ColUtil();
        }
        return instance;
    }


    public static String colType2JavaType(String colType) {
        String value = "";
        if (getInstance().cfg != null) {
            value = getInstance().cfg.getString(colType);
        }
        if (net.kuper.tz.core.utils.StringUtils.isEmpty(value)) {
            value = "String";
        }
        return value;
    }


    public static String columnClassPath(String className) {
        String type = "";
        if ("BigDecimal".equalsIgnoreCase(className)) {
            type = "java.math.BigDecimal";
        } else if ("Date".equalsIgnoreCase(className)) {
            type = "java.util.Date";
        }
        return type;
    }
}
