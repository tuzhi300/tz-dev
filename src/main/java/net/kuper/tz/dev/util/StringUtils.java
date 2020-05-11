package net.kuper.tz.dev.util;

import org.apache.commons.lang.WordUtils;

public class StringUtils {


    /**
     * 去掉前缀
     */
    public static String subPrefix(String name, String tablePrefix) {
        if (!org.apache.commons.lang.StringUtils.isEmpty(tablePrefix)
                && name.startsWith(tablePrefix)
                && name.length() > tablePrefix.length()) {
            name = name.substring(tablePrefix.length(), name.length());
        }
        return name;
    }

    /**
     * 类型名称
     *
     * @param name
     * @return
     */
    public static String toTypeName(String name) {
        return WordUtils.capitalizeFully(name, new char[]{'_'}).replace("_", "");
    }

    /**
     * 成员变量名称
     *
     * @param name
     * @return
     */
    public static String toMeneberName(String name) {
        return org.apache.commons.lang.StringUtils.uncapitalize(toTypeName(name));
    }

    /**
     * 转换为小写
     *
     * @param name
     * @return
     */
    public static String toPathName(String name) {
        return toTypeName(name).toLowerCase();
    }

//    public static void main(String[] args) {
//        String tableName = StringUtils.subPrefix("tbl_fst_abc", "tbl");
//        System.out.println(tableName);
//        System.out.println(toTypeName(tableName));
//        System.out.println(toMeneberName(tableName));
//        System.out.println(toPathName(tableName));
//    }

}
