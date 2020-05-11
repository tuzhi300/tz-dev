<template>
  <el-dialog
    :close-on-click-modal="false"
    :visible.sync="visible"
    :destroy-on-close="true"
    title="新增${table.comment}"
    width="560px">
    <eForm ref="form"/>
    <div slot="footer" class="dialog-footer">
      <el-button
        type="text"
        @click="handleCancel">
        取消
      </el-button>
      <el-button
        :loading="addLoading"
        type="primary"
        @click="handleAdd">
        新增
      </el-button>
    </div>
  </el-dialog>
</template>
<script>
    import {add} from '@/api/'
    import eForm from './form'

    export default {
    components: { eForm },
    data() {
      return {
        visible: false,
        addLoading: false
      }
    },
    methods: {
      show() {
        this.visible = true
      },
      handleCancel() {
        this.visible = false
      },
      handleAdd() {
        this.$refs['form'].$refs['form'].validate((valid) => {
          if (valid) {
            this.subAdd()
          }
        })
      },
      subAdd() {
        const data = this.$refs['form'].data
        const param = {
<#if table.columnList??>
<#list table.columnList as column>
          ${column.memberName}: data.${column.memberName}<#if column_has_next>,</#if>
</#list>
</#if>
        }
        this.addLoading = true
        add${table.className}(param).then(res => {
          this.addLoading = false
          this.visible = false
          this.$message({
            message: '新增成功',
            type: 'success',
            onClose: () => {
              this.$emit('reloadList')
            }
          })
        }).catch(err => {
          this.addLoading = false
          console.log(err)
        })
      }
    }
  }
</script>
