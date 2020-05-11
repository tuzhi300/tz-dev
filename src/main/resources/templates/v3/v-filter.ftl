<template>
  <div id="customer">
    <el-form ref="form" :inline="true" :model="filter" :rules="rules">
<#list table.columnList as column>
    <#if column_index == 4>
      <template v-if="advanced">
    </#if>
    <#if column.name != table.primaryKey.name>
      <el-form-item label="<#if column.comment?? && column.comment != '' >${column.comment}<#else>${column.memberName}</#if>" prop="${column.memberName}">
        <#if column.className == 'Integer' || column.className == 'Long'>
        <el-select
          v-model="filter.${column.memberName}"
          placeholder="请选择${column.comment}"
          clearable
          class="form-item-input">
          <!-- <el-option v-for="item in importanceOptions" :key="item" :label="item" :value="item" /> -->
          <el-option :key="0" :label="0" :value="0" />
          <el-option :key="1" :label="1" :value="1" />
          <el-option :key="2" :label="2" :value="2" />
        </el-select>
        <#elseif column.className == 'Float' || column.className == 'Double' || column.className == 'BigDecimal'>
        <el-input-number
          v-model="filter.${column.memberName}"
          placeholder="请输入${column.comment}"
          :precision="2"
          :step="1"
          clearable
          class="form-item-input"/>
        <#elseif column.className == 'Date'>
        <el-date-picker
          v-model="filter.${column.memberName}"
          type="date"
          value-format="yyyy-MM-dd HH:mm:ss"
          placeholder="请选择${column.comment}"
          clearable
          class="form-item-input"/>
        <#else >
        <el-input
          v-model="filter.${column.memberName}"
          placeholder="请输入${column.comment}"
          clearable
          class="form-item-input"/>
        </#if>
      </el-form-item>
    </#if>
    <#if column_index gte 4 && !column_has_next>
      </template>
    </#if>
</#list>
    </el-form>

    <el-row>
      <el-col align="right">
        <el-button
          v-if="hasPermission(['${module}:${table.path}:list'])"
          type="primary"
          icon="el-icon-search"
          @click="handleSearch">
          查询
        </el-button>
        <el-button
          type="info"
          icon="el-icon-delete"
          plain
          @click="handleEmptyFilter">
          重置
        </el-button>
        <el-button
          type="text"
          style="min-width:60px;"
          @click="handleSwitchAdvanced">
          <template v-if="advanced">
            收起
            <i class="el-icon-arrow-down"/>
          </template>
          <template v-else>
            展开
            <i class="el-icon-arrow-up"/>
          </template>
        </el-button>
      </el-col>
    </el-row>
  </div>
</template>

<script>
  export default {
    props: {
      filter: {
        required: true,
        type: Object
      }
    },
    computed: {
      currentFilter: {
        get() {
          return this.filter
        },
        set(val) {
          this.$emit('update:filter', val)
        }
      }
    },
    data() {
      return {
        // 高级搜索 展开/关闭
        advanced: false,
        rules: {
<#if table.columnList??>
  <#list table.columnList as column>
    <#if column.name != table.primaryKey.name>
      <#assign hasLast = false >
          ${column.memberName}: [<#if column.length gt 0>
            { min: 0, max: ${column.length?c}, message: '长度在 0 到 ${column.length}个字符', trigger: 'blur' }<#assign hasLast = true ></#if><#if column.className == 'Integer' || column.className == 'Long' || column.className == 'Float' || column.className == 'Double' || column.className == 'BigDecimal'><#if hasLast >,</#if>
            { type: 'number', message: '请输入数字类型', trigger: 'blur,change' }</#if>
          ]<#if column_has_next>,</#if>
    </#if>
  </#list>
</#if>
        }
      }
    },
    methods: {
      handleSwitchAdvanced() {
        this.advanced = !this.advanced
      },
      handleSearch() {
        this.$emit('reloadList')
      },
      emptyFilter() {
<#if table.columnList??>
  <#list table.columnList as column>
        this.filter.${column.memberName} = null
  </#list>
</#if>
      },
      handleEmptyFilter() {
        this.emptyFilter()
        this.$emit('reloadList')
      }
    }

  }
</script>
