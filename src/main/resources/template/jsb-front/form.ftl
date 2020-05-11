<template>
  <div id="form">
    <el-form ref="form" :model="form" :rules="rules" size="small" label-width="80px">
<#if table.columnList??>
<#list table.columnList as column>
<#if column.name != table.primaryKey.name>
      <el-form-item label="<#if column.comment?? && column.comment != '' >${column.comment}<#else>${column.memberName}</#if>" prop="${column.memberName}">
        <el-input v-model="form.${column.memberName}" style="width: 370px;"/>
      </el-form-item>
</#if>
</#list>
</#if>
    </el-form>
  </div>
</template>

<script>
export default {
  data() {
    return {
      loading: false,
      form: {
<#if table.columnList??>
    <#list table.columnList as column>
        ${column.memberName}: ''<#if column_has_next>,</#if>
    </#list>
</#if>
      },
      rules: {
<#if table.columnList??>
<#list table.columnList as column>
        ${column.memberName}: [
          { required: true, message: '${column.comment}不能为空', trigger: 'blur' }
        ]<#if column_has_next>,</#if>
</#list>
</#if>
      }
    }
  },
  methods: {
    bindData(form) {
      this.form = {
<#if table.columnList??>
<#list table.columnList as column>
        ${column.memberName}: form.${column.memberName}<#if column_has_next>,</#if>
</#list>
</#if>
      }
    },
    resetForm() {
      this.$refs['form'].resetFields()
      this.form = {
<#if table.columnList??>
    <#list table.columnList as column>
        ${column.memberName}: ''<#if column_has_next>,</#if>
    </#list>
</#if>
      }
    }
  }
}
</script>

<style scoped>

</style>
