<template>
  <el-form ref="form" :model="data" :rules="rules" label-position="right" label-width="80px">
    <#list table.columnList as column>
      <#if column.name != table.primaryKey.name>
    <el-form-item label="<#if column.comment?? && column.comment != '' >${column.comment}<#else>${column.memberName}</#if>" prop="${column.memberName}">
      <#if column.className == 'Integer' || column.className == 'Long'>
      <el-select
        v-model="data.${column.memberName}"
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
        v-model="data.${column.memberName}"
        placeholder="请输入${column.comment}"
        :precision="2"
        :step="1"
        clearable
        class="form-item-input"/>
      <#elseif column.className == 'Date'>
      <el-date-picker
        v-model="data.${column.memberName}"
        type="date"
        value-format="yyyy-MM-dd HH:mm:ss"
        placeholder="请选择${column.comment}"
        clearable
        class="form-item-input"/>
      <#else >
      <el-input
        v-model="data.${column.memberName}"
        placeholder="请输入${column.comment}"
        clearable
        class="form-item-input"/>
      </#if>
    </el-form-item>
      </#if>
    </#list>
  </el-form>
</template>

<script>

  export default {
    data() {
      return {
        data: {
<#if table.columnList??>
  <#list table.columnList as column>
          ${column.memberName}: ''<#if column_has_next>,</#if>
  </#list>
</#if>
        },
        rules: {
<#if table.columnList??>
  <#list table.columnList as column>
    <#if column.name != table.primaryKey.name>
          <#assign hasLast = false >
          ${column.memberName}: [<#if column.nullable == 'NO'>
            { required: true, message: '${column.comment}不能为空', trigger: 'blur' }<#assign hasLast = true ></#if><#if column.length gt 0><#if hasLast >,</#if>
            { min: 0, max: ${column.length?c}, message: '长度在 0 到 ${column.length}个字符', trigger: 'blur' }<#assign hasLast = true ></#if><#if column.className == 'Integer' || column.className == 'Long' || column.className == 'Float' || column.className == 'Double' || column.className == 'BigDecimal'><#if hasLast >,</#if>
            { type: 'number', message: '请输入数字类型', trigger: 'blur,change' }</#if>
          ]<#if column_has_next>,</#if>
    </#if>
  </#list>
</#if>
        }
      }
    },
    created() {
    },
    methods: {
      bindData(form) {
        this.data = {
<#if table.columnList??>
<#list table.columnList as column>
          ${column.memberName}: form.${column.memberName}<#if column_has_next>,</#if>
</#list>
</#if>
        }
      }
    }
  }
</script>

<style scoped>
</style>
