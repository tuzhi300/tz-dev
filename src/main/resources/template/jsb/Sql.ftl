
DROP PROCEDURE IF EXISTS  build_menu ;
DELIMITER //
CREATE  PROCEDURE build_menu()
    BEGIN
    DECLARE tmpId BIGINT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
        END;
    DECLARE EXIT HANDLER FOR SQLWARNING
        BEGIN
            ROLLBACK;
        END;
    START TRANSACTION;
        -- 管理角色 角色ID
        SET @rootRoleId = 1;
        -- 目录菜单 菜单ID
        SET @rootMenuId = 1;
        -- 客户端类型，不同的客户端，可以有不同的角色和菜单配置
        SET @clientType = 'admin';
        -- Controller 字典ID
        SET @ctrParentId = 5;
        -- Module 字典ID
        SET @moduleParentId = 6;


        -- 添加Controller到字典
        -- 没有即添加
        SET @ctrId = REPLACE(UUID(), '-', '');
        INSERT INTO `sys_dic` (`id`, `parent_id`, `display_name`, `key`, `value`, `type`)
        SELECT @ctrParentId,'${table.comment}','${table.className}Controller','${table.className}Controller',1
        FROM DUAL
        WHERE NOT EXISTS(SELECT id from `sys_dic` where `parent_id` = @ctrParentId and `key` = '${table.className}Controller');
        -- 获取Controller Id
        SELECT id INTO @ctrId from `sys_dic` where `parent_id` = @ctrParentId and `key` = '${table.className}Controller';


        -- 添加接口数据
        -- 列表接口
        SET @listApiId = REPLACE(UUID(), '-', '');
        INSERT INTO `sys_api` (`id`, `name`, `code`,`controller`) VALUES (@listApiId, '${table.comment}列表查询' , '${module}:${table.path}:list' , @ctrId);
        -- 详情接口
        SET @infoApiId = REPLACE(UUID(), '-', '');
        INSERT INTO `sys_api` (`id`, `name`, `code`,`controller`) VALUES (@infoApiId, '${table.comment}详情查询' , '${module}:${table.path}:info' , @ctrId);
        -- 新增接口
        SET @saveApiId = REPLACE(UUID(), '-', '');
        INSERT INTO `sys_api` (`id`, `name`, `code`,`controller`) VALUES (@saveApiId, '新增${table.comment}' , '${module}:${table.path}:save' , @ctrId);
        -- 修改接口
        SET @updateApiId = REPLACE(UUID(), '-', '');
        INSERT INTO `sys_api` (`id`, `name`, `code`,`controller`) VALUES (@updateApiId, '修改${table.comment}' , '${module}:${table.path}:update' , @ctrId);
        -- 删除接口
        SET @deleteApiId = REPLACE(UUID(), '-', '');
        INSERT INTO `sys_api` (`id`, `name`, `code`,`controller`) VALUES (@deleteApiId, '删除${table.comment}' , '${module}:${table.path}:delete' , @ctrId);


        -- 添加功能模块
        -- 没有即添加
        SET @moduleId = REPLACE(UUID(), '-', '');
        INSERT INTO `sys_dic` (`id`, `parent_id`, `display_name`, `key`, `value`, `type`)
        SELECT @moduleId, @moduleParentId, '${module}','${module}', '${module}', 1
        FROM DUAL
        WHERE NOT EXISTS(SELECT id from `sys_dic` where `parent_id` = @moduleParentId and `key` = '${module}');
        -- 获取module Id
        SELECT id INTO @moduleId from `sys_dic` where `parent_id` = @moduleParentId and `key` = '${module}';

        -- 添加功能数据
        -- 列表查询功能
        SET @funListId = REPLACE(UUID(), '-', '');
        INSERT INTO `sys_function` (`id`, `name`,`module_id`) VALUES (@funListId, '${table.comment}列表查询', @moduleId);
        -- 详情查询功能
        SET @funInfoId = REPLACE(UUID(), '-', '');
        INSERT INTO `sys_function` (`id`, `name`,`module_id`) VALUES (@funInfoId, '${table.comment}详情查询', @moduleId);
        -- 新增功能
        SET @funAddId = REPLACE(UUID(), '-', '');
        INSERT INTO `sys_function` (`id`, `name`,`module_id`) VALUES (@funAddId, '${table.comment}新增', @moduleId);
        -- 修改功能
        SET @funUpdateId = REPLACE(UUID(), '-', '');
        INSERT INTO `sys_function` (`id`, `name`,`module_id`) VALUES (@funUpdateId, '${table.comment}修改', @moduleId);
        -- 删除功能
        SET @funDeleteId = REPLACE(UUID(), '-', '');
        INSERT INTO `sys_function` (`id`, `name`,`module_id`) VALUES (@funDeleteId, '${table.comment}删除', @moduleId);

        -- 添加功能与api关系
        -- 列表查询功能
        INSERT INTO `sys_function_api` (`api_id`,`function_id`) VALUES (@listApiId,@funListId);
        -- 详情查询功能
        INSERT INTO `sys_function_api` (`api_id`,`function_id`) VALUES (@infoApiId,@funInfoId);
        -- 新增功能
        INSERT INTO `sys_function_api` (`api_id`,`function_id`) VALUES (@saveApiId,@funAddId);
        -- 修改功能
        INSERT INTO `sys_function_api` (`api_id`,`function_id`) VALUES (@infoApiId,@funUpdateId);
        INSERT INTO `sys_function_api` (`api_id`,`function_id`) VALUES (@updateApiId,@funUpdateId);
        -- 删除功能
        INSERT INTO `sys_function_api` (`api_id`,`function_id`) VALUES (@deleteApiId,@funDeleteId);

        -- 添加菜单
        INSERT INTO `sys_menu` (`parent_id`, `name`, `url`, `icon`, `order_num`, `status`, `type`,`create_time`,`client_type`)
        VALUES (@rootMenuId , '${table.comment}', '${module}/${table.memberName}/index', 'system', 1, 1, 1,'${createTime}', @clientType);
        SET @menuId = @@identity;

        -- 添加菜单功能
        -- 列表查询功能
        INSERT INTO `sys_menu_function` (`menu_id`,`function_id`) VALUES (@menuId, @funListId);
        -- 详情查询功能
        INSERT INTO `sys_menu_function` (`menu_id`,`function_id`) VALUES (@menuId, @funInfoId);
        -- 新增功能
        INSERT INTO `sys_menu_function` (`menu_id`,`function_id`) VALUES (@menuId, @funAddId);
        -- 修改功能
        INSERT INTO `sys_menu_function` (`menu_id`,`function_id`) VALUES (@menuId, @funUpdateId);
        -- 删除功能
        INSERT INTO `sys_menu_function` (`menu_id`,`function_id`) VALUES (@menuId, @funDeleteId);

        -- 添加角色菜单功能
        INSERT INTO `sys_role_function` (`role_id`, `right_type`, `menu_id`, `function_id`) values ( @rootRoleId, 1, @menuId, @funListId);
        INSERT INTO `sys_role_function` (`role_id`, `right_type`, `menu_id`, `function_id`) values ( @rootRoleId, 1, @menuId, @funInfoId);
        INSERT INTO `sys_role_function` (`role_id`, `right_type`, `menu_id`, `function_id`) values ( @rootRoleId, 1, @menuId, @funAddId);
        INSERT INTO `sys_role_function` (`role_id`, `right_type`, `menu_id`, `function_id`) values ( @rootRoleId, 1, @menuId, @funUpdateId);
        INSERT INTO `sys_role_function` (`role_id`, `right_type`, `menu_id`, `function_id`) values ( @rootRoleId, 1, @menuId, @funDeleteId);

    COMMIT;
    END //
DELIMITER ;
call build_menu();
drop procedure build_menu;


