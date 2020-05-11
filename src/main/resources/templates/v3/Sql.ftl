USE ${schemaName};
DROP PROCEDURE IF EXISTS  build_permission_${table.name} ;
DELIMITER //
CREATE  PROCEDURE build_permission_${table.name}()
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
        SET @rootRoleId = 'init0000000000000000000000000001';
        -- 目录菜单 菜单ID
        SET @rootMenuId = 'init0000000000000000000000000001';
        -- Module 字典KEY
        SET @moduleKey = 'fun_module';

        -- 添加功能模块
        -- 没有即添加
        SET @moduleId = REPLACE(UUID(), '-', '');
        INSERT INTO `sys_macro` (`id`, `parent_key`, `display_name`, `key`, `value`, `type`)
        SELECT @moduleId,@moduleKey,'${module}',CONCAT(@moduleKey,'.${module}'),CONCAT(@moduleKey,'.${module}'),1
        FROM DUAL
        WHERE NOT EXISTS(SELECT id from `sys_macro` where `key` = CONCAT(@moduleKey,'.${module}'));

        -- 添加Controller
        SET @ctrId = REPLACE(UUID(), '-', '');
        INSERT INTO `sys_controller` (`id`, `controller`, `name`, `module`) VALUES (@ctrId, '${table.className}Controller','${table.comment}', CONCAT(@moduleKey,'.${module}'));

        -- 添加功能权限
        -- 列表接口
        SET @listOpeId = REPLACE(UUID(), '-', '');
        INSERT INTO `sys_operation` (`id`, `name`, `code`,`controller_id`) VALUES (@listOpeId, '列表查询' , '${module}:${table.path}:list' , @ctrId);
        -- 详情接口
        SET @infoOpeId = REPLACE(UUID(), '-', '');
        INSERT INTO `sys_operation` (`id`, `name`, `code`,`controller_id`) VALUES (@infoOpeId, '详情查询' , '${module}:${table.path}:detail' , @ctrId);
        -- 新增接口
        SET @saveOpeId = REPLACE(UUID(), '-', '');
        INSERT INTO `sys_operation` (`id`, `name`, `code`,`controller_id`) VALUES (@saveOpeId, '新增' , '${module}:${table.path}:add' , @ctrId);
        -- 修改接口
        SET @updateOpeId = REPLACE(UUID(), '-', '');
        INSERT INTO `sys_operation` (`id`, `name`, `code`,`controller_id`) VALUES (@updateOpeId, '修改' , '${module}:${table.path}:update' , @ctrId);
        -- 删除接口
        SET @deleteOpeId = REPLACE(UUID(), '-', '');
        INSERT INTO `sys_operation` (`id`, `name`, `code`,`controller_id`) VALUES (@deleteOpeId, '删除' , '${module}:${table.path}:delete' , @ctrId);

        -- 添加ElementCategory
        SET @categoryId = REPLACE(UUID(), '-', '');
        INSERT INTO `sys_element_category` ( `id`, `name`) VALUES (@categoryId, '${table.comment}');

        -- 添加页面功能元素
        -- 列表查询功能
        SET @eleListId = REPLACE(UUID(), '-', '');
        INSERT INTO `sys_element` (`id`, `category_id`, `name`, `code`) VALUES (@eleListId, @categoryId, '列表查询', '${module}:${table.path}:list');
        -- 新增功能
        SET @eleAddId = REPLACE(UUID(), '-', '');
        INSERT INTO `sys_element` (`id`, `category_id`, `name`, `code`) VALUES (@eleAddId, @categoryId, '新增', '${module}:${table.path}:add');
        -- 修改功能
        SET @eleUpdateId = REPLACE(UUID(), '-', '');
        INSERT INTO `sys_element` (`id`, `category_id`, `name`, `code`) VALUES (@eleUpdateId, @categoryId, '修改', '${module}:${table.path}:update');
        -- 删除功能
        SET @eleDeleteId = REPLACE(UUID(), '-', '');
        INSERT INTO `sys_element` (`id`, `category_id`, `name`, `code`) VALUES (@eleDeleteId, @categoryId, '删除', '${module}:${table.path}:delete');

        -- 添加元素与操作关系
        -- 列表查询功能
        INSERT INTO `sys_element_operation` (`id`, `operation_id`,`element_id`) VALUES (REPLACE(UUID(), '-', ''), @listOpeId, @eleListId);
        -- 新增功能
        INSERT INTO `sys_element_operation` (`id`, `operation_id`,`element_id`) VALUES (REPLACE(UUID(), '-', ''), @saveOpeId, @eleAddId);
        -- 修改功能
        INSERT INTO `sys_element_operation` (`id`, `operation_id`,`element_id`) VALUES (REPLACE(UUID(), '-', ''), @infoOpeId, @eleUpdateId);
        INSERT INTO `sys_element_operation` (`id`, `operation_id`,`element_id`) VALUES (REPLACE(UUID(), '-', ''), @updateOpeId, @eleUpdateId);
        -- 删除功能
        INSERT INTO `sys_element_operation` (`id`, `operation_id`,`element_id`) VALUES (REPLACE(UUID(), '-', ''), @deleteOpeId, @eleDeleteId);


        -- 添加角色功能
        INSERT INTO `sys_role_element` (`id`, `role_id`, `element_id`, `right_type`) values (REPLACE(UUID(), '-', ''), @rootRoleId, @eleListId, 1);
        INSERT INTO `sys_role_element` (`id`, `role_id`, `element_id`, `right_type`) values (REPLACE(UUID(), '-', ''), @rootRoleId, @eleAddId, 1);
        INSERT INTO `sys_role_element` (`id`, `role_id`, `element_id`, `right_type`) values (REPLACE(UUID(), '-', ''), @rootRoleId, @eleUpdateId, 1);
        INSERT INTO `sys_role_element` (`id`, `role_id`, `element_id`, `right_type`) values (REPLACE(UUID(), '-', ''), @rootRoleId, @eleDeleteId, 1);

        -- 添加菜单
        SET @menuId = REPLACE(UUID(), '-', '');
        INSERT INTO `sys_menu` (`id`, `parent_id`, `type`, `title`, `component`,`route_path`, `route_name`, `icon`)
        VALUES (@menuId, @rootMenuId , 1 , '${table.comment}', '${module}/${table.memberName}/index','${table.path}', '${table.className}', 'system');

        -- 添加角色功能
        INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `right_type`) values (REPLACE(UUID(), '-', ''), @rootRoleId, @menuId, 1);

    COMMIT;
    END //
DELIMITER ;
call build_permission_${table.name}();
drop procedure build_permission_${table.name};


