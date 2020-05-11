<template>
  <el-dialog :append-to-body="true" :visible.sync="visible" :title="'新增${table.comment}'" width="500px">
    <div v-if="visible">
      <eForm v-loading="loading" ref="form"/>
    </div>
    <div slot="footer" class="dialog-footer">
      <el-button type="text" @click="cancel">取消</el-button>
      <el-button :loading="loading" type="primary" @click="doSubmit">确认</el-button>
    </div>
  </el-dialog>
</template>
<script>
  import {${table.memberName}Add} from '@/api/'
  import eForm from './form'

  export default {
  components: { eForm },
  props: {
    indexView: {
      type: Object,
      required: true
    }
  },
  data() {
    return {
      visible: false,
      loading: false
    }
  },
  methods: {
    cancel() {
      this.$refs.form.resetForm()
      this.visible = false
    },
    doSubmit() {
      this.$refs.form.$refs['form'].validate((valid) => {
        if (valid) {
          this.subAdd()
        }
      })
    },
    subAdd() {
      const form = this.$refs.form
      const param = {
<#if table.columnList??>
<#list table.columnList as column>
<#if column.name != table.primaryKey.name>
        ${column.memberName}: form.form.${column.memberName}<#if column_has_next>,</#if>
</#if>
</#list>
</#if>
      }
      this.loading = true
      ${table.memberName}Add(param).then(res => {
        this.loading = false
        if (res && res.code === 1000) {
          this.$refs.form.resetForm()
          this.visible = false
          this.$message({
            message: '新增成功',
            type: 'success',
            duration: 2000,
            onClose: () => {
              this.indexView.subQuery()
            }
          })
        } else if (res) {
          this.$message.error(res.msg)
        }
      }).catch(err => {
        this.loading = false
        console.log(err.response.data.message)
      })
    }
  }
}
</script>

<style scoped>
  div{
    display: inline-block;
    margin-right: 3px;
  }
</style>
