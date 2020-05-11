<template>
  <div class="app-container">
    <div class="filter-container">
      <c-filter ref="filter" :filter.sync="listQuery" @reloadList="reloadList"/>
      <el-row class="filter-row">
        <el-col>
          <el-button
            v-if="hasPermission(['${module}:${table.path}:add'])"
            type="success"
            icon="el-icon-plus"
            plain
            @click="handleAdd">
            新增
          </el-button>

          <el-button
            plain
            @click="clearSort">
            取消排序
          </el-button>
        </el-col>
      </el-row>
    </div>
    <el-table
      ref="table"
      v-loading="listLoading"
      :data="list"
      border
      fit
      highlight-current-row
      @sort-change="sortChange"
      @selection-change="handleSelectionChange">
      <el-table-column
        type="selection"
        width="55"/>
  <#if table.columnList??>
    <#list table.columnList as column>
      <el-table-column
        prop="${column.memberName}"
        label="<#if column.comment != ''>${column.comment}<#else>${column.memberName}</#if>"
        sortable="custom"
        header-align="center"/>
    </#list>
  </#if>
      <el-table-column
        label="操作"
        align="center"
        fixed="right"
        width="200"
        class-name="small-padding fixed-width">
        <template slot-scope="{row,$index}">
          <el-button
            v-if="hasPermission(['${module}:${table.path}:update'])"
            type="primary"
            size="mini"
            @click="handleUpdate(row)">
            修改
          </el-button>
          <el-popconfirm
            v-if="hasPermission(['${module}:${table.path}:delete'])"
            title="确定删除本条数据吗？"
            placement="top-start"
            @onConfirm="handleDelete(row,$index)"
            @onCancel="()=>{}">
            <el-button
              slot="reference"
              type="danger"
              size="mini">
              删除
            </el-button>
          </el-popconfirm>
        </template>
      </el-table-column>
    </el-table>

    <div align="right">
      <pagination
        v-show="total>0"
        :total="total"
        :page.sync="listQuery.page"
        :limit.sync="listQuery.pageSize"
        @pagination="getList"/>
    </div>
    <c-modify ref="modify" @reloadList="getList"/>
    <c-add ref="add" @reloadList="getList"/>
  </div>
</template>

<script>
  import { query${table.className}s, delete${table.className} } from '@/api/${module}/${table.memberName}'
  import Pagination from '@/components/Pagination' // secondary package based on el-pagination
  import cFilter from './module/filter'
  import cModify from './module/modify'
  import cAdd from './module/add'

  export default {
    name: '${table.className}',
    components: {
      Pagination,
      cFilter,
      cModify,
      cAdd
    },
    data() {
      return {
        isAlert: true,
        tableKey: 0,
        total: 0,
        listLoading: false,
        deleteLoading: false,
        list: [],
        listSelection: [],
        listQuery: {
          page: 1,
          pageSize: 10,
          roleName: undefined,
          sort: undefined
        }
      }
    },
    mounted() {
      this.getList()
    },
    methods: {
      subQueryList() {
        this.listLoading = true
        query${table.className}s(this.listQuery)
          .then(res => {
            this.listLoading = false
            this.list = res.data.list
            this.total = res.data.count
          })
          .catch(err => {
            this.listLoading = false
            console.log(err)
          })
      },
      getList() {
        this.$refs['filter'].$refs['form'].validate((valid) => {
          if (valid) {
            this.subQueryList()
          }
        })
      },
      reloadList() {
        this.listQuery.page = 1
        this.getList()
      },
      clearSort() {
        this.$refs['table'].clearSort()
        this.listQuery.sidx = undefined
        this.listQuery.stype = undefined
        this.getList()
      },
      sortChange(data) {
        let stype
        if (data.order === 'ascending') {
          stype = 'ASC'
        } else if (data.order === 'descending') {
          stype = 'DESC'
        }
        this.listQuery.sidx = data.prop
        this.listQuery.stype = stype
        this.getList()
      },
      handleSelectionChange(val) {
        this.listSelection = val
      },
      handleAdd() {
        this.$refs['add'].show()
      },
      handleUpdate(row) {
        this.$refs['modify'].show(row.id)
      },
      handleDelete(row, index) {
        this.listLoading = true
        delete${table.className}(row.id)
          .then(res => {
            this.listLoading = false
            this.$message({
              message: '删除成功',
              type: 'success',
              onClose: () => {
                this.list.splice(index, 1)
              }
            })
          })
          .catch(err => {
            this.listLoading = false
            console.log(err)
          })
      }
    }
  }
</script>
