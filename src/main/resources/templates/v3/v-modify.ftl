<template>
  <el-dialog
    class="app-dialog"
    :close-on-click-modal="false"
    :visible.sync="visible"
    :destroy-on-close="true"
    title="修改${table.comment}"
    width="560px">
    <eForm ref="form" v-loading="dataLoading"/>
    <div slot="footer" class="dialog-footer">
      <el-button
        type="text"
        @click="handleCancel">
        取消
      </el-button>
      <el-button
        :loading="updateLoading"
        type="primary"
        @click="handleModify">
        修改
      </el-button>
    </div>
  </el-dialog>
</template>
<script>
  import {query, update} from '@/api/'
  import eForm from './form'

  export default {
    components: { eForm },
    data() {
      return {
        visible: false,
        dataLoading: false,
        updateLoading: false,
        ${table.primaryKey.name}: ''
      }
    },
    methods: {
      show(id) {
        this.visible = true
        this.${table.primaryKey.name} = id
        this.loadDetail()
      },
      loadDetail() {
        this.dataLoading = true
        query${table.className}(this.${table.primaryKey.name}).then(res => {
          this.dataLoading = false
          if (res && res.code === 1000) {
            this.$refs['form'].bindData(res.data)
          } else if (res) {
            this.$message.error(res.msg)
          }
        }).catch(err => {
          this.dataLoading = false
          console.log(err)
        })
      },
      handleCancel() {
        this.visible = false
      },
      handleModify() {
        this.$refs['form'].$refs['form'].validate((valid) => {
          if (valid) {
            this.subModify()
          }
        })
      },
      subModify() {
        const data = this.$refs['form'].data
        const param = {
<#if table.columnList??>
<#list table.columnList as column>
          ${column.memberName}: data.${column.memberName}<#if column_has_next>,</#if>
</#list>
</#if>
        }
        this.updateLoading = true
        update${table.className}(param).then(res => {
          this.updateLoading = false
          this.visible = false
          this.$message({
            message: '修改成功',
            type: 'success',
            onClose: () => {
              this.$emit('reloadList')
            }
          })
        }).catch(err => {
          this.updateLoading = false
          console.log(err)
        })
      }
    }
  }
</script>
