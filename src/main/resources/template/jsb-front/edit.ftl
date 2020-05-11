<template>
  <el-dialog :append-to-body="true" :visible.sync="visible" :title="'编辑${table.comment}'" width="500px">
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
  import {${table.memberName}Edit, ${table.memberName}Info} from '@/api/'
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
      loading: false,
      ${table.primaryKey.name}: ''
    }
  },
  methods: {
    toEdit(${table.primaryKey.name}) {
      this.$nextTick(() => {
        this.visible = true
        this.${table.primaryKey.name} = ${table.primaryKey.name}
        if (this.$refs.form) {
          this.$refs.form.resetForm()
        }
        this.queryInfo()
      })
    },
    queryInfo() {
      this.loading = true
      ${table.memberName}Info(this.${table.primaryKey.name}).then(res => {
        this.loading = false
        if (res && res.code === 1000) {
          this.$refs.form.bindData(res.data)
        } else if (res) {
          this.$message.error(res.msg)
        }
      }).catch(err => {
        this.loading = false
        console.log(err.response.data.message)
      })
    },
    cancel() {
      this.$refs.form.resetForm()
      this.visible = false
    },
    doSubmit() {
      this.$refs.form.$refs['form'].validate((valid) => {
        if (valid) {
          this.subEdit()
        }
      })
    },
    subEdit() {
      const form = this.$refs.form
      const param = {
        ${table.primaryKey.name}: this.${table.primaryKey.name},
<#if table.columnList??>
<#list table.columnList as column>
<#if column.name != table.primaryKey.name>
        ${column.memberName}: form.form.${column.memberName}<#if column_has_next>,</#if>
</#if>
</#list>
</#if>
      }
      this.$refs.form.loading = true
      ${table.memberName}Edit(param).then(res => {
        this.$refs.form.loading = false
        if (res && res.code === 1000) {
          this.$refs.form.resetForm()
          this.visible = false
          this.$message({
            message: '修改成功',
            type: 'success',
            duration: 2000,
            onClose: () => {
              this.$parent.subQuery()
            }
          })
        } else if (res) {
          this.$message.error(res.msg)
        }
      }).catch(err => {
        this.$refs.form.loading = false
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
