<#--noinspection ALL-->
<template>
  <div class="app-container">
    <eHeader ref="query" :index-view="indexView"/>
    <!--表格渲染-->
    <el-table v-loading="loading" :empty-text="emptyMessage()" :data="dataList" size="small" border style="width: 100%;">
      <#if table.columnList??>
          <#list table.columnList as column>
      <el-table-column prop="${column.memberName}" label="<#if column.comment != ''>${column.comment}<#else>${column.memberName}</#if>" header-align="center"/>
          </#list>
      </#if>
      <el-table-column label="操作" width="150px" fixed="right" align="center">
        <template slot-scope="scope">
          <el-button v-if="hasPermission('${module}:${table.path}:update')" size="mini" type="success" @click="editHandler(scope.row.${table.primaryKey.memberName})">编辑</el-button>
          <el-popover
            v-if="hasPermission('${module}:${table.path}:delete')"
            :ref="scope.row.id"
            placement="top"
            width="180">
            <p>确定删除本条数据吗？</p>
            <div style="text-align: right; margin: 0">
              <el-button size="mini" type="text" @click="$refs[scope.row.${table.primaryKey.memberName}].doClose()">取消</el-button>
              <el-button :loading="delLoading" type="primary" size="mini" @click="subDelete(scope.row.${table.primaryKey.memberName})">确定</el-button>
            </div>
            <el-button slot="reference" type="danger" size="mini">删除</el-button>
          </el-popover>
        </template>
      </el-table-column>
    </el-table>
    <!--分页组件-->
    <el-pagination
      :total="total"
      :current-page="page"
      :page-size="pageSize"
      :page-sizes="[10, 20, 50, 100]"
      style="margin-top: 8px;"
      layout="total, sizes, prev, pager, next, jumper"
      @size-change="pageSizeChangeHandler"
      @current-change="pageChangeHandler"/>
    <edit ref="editForm" :index-view="indexView"/>
  </div>
</template>

<script>
  import {${table.memberName}Del, ${table.memberName}Query} from '@/api/'
  import eHeader from './module/header'
  import edit from './module/edit'

  export default {
  name: '${table.routerName}',
  components: { eHeader, edit },
  data() {
    return {
      indexView: this,
      errorMsg: '',
      delLoading: false,
      loading: true,
      dataList: [],
      page: 1,
      pageSize: 10,
      total: 0
    }
  },
  created() {
    this.$nextTick(() => {
      this.subQuery()
    })
  },
  methods: {
    subQuery() {
      const sort = 'id,desc'
      const q = this.$refs.query.form
      const params = {
        type: q.type,
        value: q.value,
        page: this.page,
        pageSize: this.pageSize,
        sort: sort }
      this.loading = true
      ${table.memberName}Query(params).then(res => {
        if (res && res.code === 1000) {
          this.dataList = res.data.list
          this.total = res.data.count
          this.page = res.data.page
          this.pageSize = res.data.pageSize
          this.errorMsg = ''
        } else {
          this.errorMsg = res.msg
          this.dataList = []
          this.total = 0
          this.page = 1
        }
        setTimeout(() => {
          this.loading = false
        }, 160)
      }).catch(err => {
        this.loading = false
        console.log(err.response.data.message)
      })
    },
    pageChangeHandler(val) {
      this.page = val
      this.subQuery()
    },
    pageSizeChangeHandler(val) {
      this.pageSize = val
      this.subQuery()
    },
    editHandler(${table.primaryKey.name}) {
      this.$refs.editForm.toEdit(${table.primaryKey.name})
    },
    emptyMessage() {
      if (this.errorMsg && this.errorMsg !== '') {
        return this.errorMsg
      } else {
        return '暂无数据'
      }
    },
    subDelete(id) {
      this.delLoading = true
      ${table.memberName}Del(id).then(res => {
        this.delLoading = false
        this.$refs[id].doClose()
        if (res && res.code === 1000) {
          this.$message({
            message: '删除成功',
            type: 'success',
            duration: 1500,
            onClose: () => {
              this.subQuery()
            }
          })
        } else if (res) {
          this.$message.error(res.msg)
        }
      }).catch(err => {
        this.delLoading = false
        this.$refs[id].doClose()
        console.log(err.response.data.message)
      })
    }
  }
}
</script>

<style scoped>

</style>
