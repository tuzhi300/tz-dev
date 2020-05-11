# 模板说明

## 模板项目结构
```shell script
templates
|-conf.json
|-v3
  |-template.json
  |- ...模板文件
```
### 结构说明
1. templates 模板文件根文件夹
2. conf.json 模板文件夹配置
1. v3 模板文件夹，可以自定义名称，然后配置在conf.json
1. v3/template.json 模板文件配置
1. v3/模板文件 使用freemarker语法编写，模板文件使用ftl结尾

### template.json说明
```json
[
  {
    "file": "h-add",
    "out": "${basePkg}/${module}/{className}Entity",
    "outType": "java"
  }
]
```
1. file 模板文件名称，如：h-add.ftl
1. out 输出文件名称，不带后缀; 使用freemarker语法编写，参数请参考后文模板参数说明
1. outType 输出文件后缀名

## 模板参数说明
### 参数说明
#### 最外层参数
* "package": "提交的包名",
* "createTime": "文件生成时间",
* "author": "作者",
* "module": "模块",
* "email": "邮箱",
* "table": Object 

#### table 参数
* "classPathList": Array Java数据类,
* "path": "user 表名去后缀后的名称",
* "routerName": "TestUserIndex 模块+表名（去后缀）+Index 前后端路由，组件名称",
* "name": "sys_user 原始表名",
* "memberName": "user 可作为成员变量名",
* "columnList": Array 数据列
* "className": "User 去后缀的表名，可作类名",
* "comment": "管理员信息，表备注信息",
* "primaryKey": Object 主键，与列字段相同。

#### column 列参数
* "extra": "",
* "classPath": "对应的Java数据类",
* "name": "del_flag 列名",
* "memberName": "delFlag 成员变量名",
* "methodName": "DelFlag 函数名",
* "comment": "删除： 1是，0否 列备注",
* "className": "Integer 对应的Java数据类型"


### 参数示例
```json
{
    "package": "com.gen",
    "createTime": "2020-02-28 00:41:22",
    "author": "kuper",
    "module": "test",
    "email": "shengongwen@163.com",
    "table": {
        "classPathList": [
            "java.util.Date"
        ],
        "path": "user",
        "routerName": "TestUserIndex",
        "name": "sys_user",
        "memberName": "user",
        "columnList": [
            {
                "extra": "auto_increment",
                "classPath": "",
                "name": "id",
                "memberName": "id",
                "methodName": "Id",
                "comment": "",
                "className": "Long"
            },
            {
                "extra": "",
                "classPath": "",
                "name": "username",
                "memberName": "username",
                "methodName": "Username",
                "comment": "用户名",
                "className": "String"
            },
            {
                "extra": "",
                "classPath": "",
                "name": "password",
                "memberName": "password",
                "methodName": "Password",
                "comment": "密码",
                "className": "String"
            },
            {
                "extra": "",
                "classPath": "",
                "name": "salt",
                "memberName": "salt",
                "methodName": "Salt",
                "comment": "盐",
                "className": "String"
            },
            {
                "extra": "",
                "classPath": "",
                "name": "email",
                "memberName": "email",
                "methodName": "Email",
                "comment": "邮箱",
                "className": "String"
            },
            {
                "extra": "",
                "classPath": "",
                "name": "mobile",
                "memberName": "mobile",
                "methodName": "Mobile",
                "comment": "手机号",
                "className": "String"
            },
            {
                "extra": "",
                "classPath": "",
                "name": "status",
                "memberName": "status",
                "methodName": "Status",
                "comment": "状态  0：禁用   1：正常",
                "className": "Integer"
            },
            {
                "extra": "",
                "classPath": "",
                "name": "dept_id",
                "memberName": "deptId",
                "methodName": "DeptId",
                "comment": "所属部门",
                "className": "Long"
            },
            {
                "extra": "",
                "classPath": "java.util.Date",
                "name": "create_time",
                "memberName": "createTime",
                "methodName": "CreateTime",
                "comment": "创建时间",
                "className": "Date"
            },
            {
                "extra": "",
                "classPath": "",
                "name": "del_flag",
                "memberName": "delFlag",
                "methodName": "DelFlag",
                "comment": "删除： 1是，0否",
                "className": "Integer"
            }
        ],
        "className": "User",
        "comment": "管理员信息",
        "primaryKey": {
            "extra": "auto_increment",
            "classPath": "",
            "name": "id",
            "memberName": "id",
            "methodName": "Id",
            "comment": "",
            "className": "Long"
        }
    }
}
```