<template>
  <div class="head-container">
    <!-- 搜索 -->
    <el-input v-model="form.value" clearable placeholder="输入搜索内容" style="width: 200px;" class="filter-item" @keyup.enter.native="toQuery"/>
    <el-select v-model="form.type" clearable placeholder="类型" class="filter-item" style="width: 130px">
      <el-option v-for="item in queryTypeOptions" :key="item.key" :label="item.name" :value="item.key"/>
    </el-select>
    <el-button class="filter-item" size="mini" type="primary" icon="el-icon-search" @click="toQuery">搜索</el-button>
    <!-- 新增 -->
    <div style="display: inline-block;margin: 0px 2px;">
      <el-button
        v-if="hasPermission('${module}:${table.path}:save')"
        class="filter-item"
        size="mini"
        type="primary"
        icon="el-icon-plus"
        @click="$refs.addForm.visible = true">新增</el-button>
      <add ref="addForm" :index-view="indexView"/>
    </div>
  </div>
</template>

<script>
  import add from './add'

  export default {
  components: { add },
  props: {
    indexView: {
      type: Object,
      required: true
    }
  },
  data() {
    return {
      form: {
        value: '',
        type: 'key1',
        required: true
      },
      queryTypeOptions: [
        { key: 'key1', name: 'name1' }
      ]
    }
  },
  methods: {
    toQuery() {
      this.$parent.page = 1
      this.$parent.subQuery()
    }
  }
}
</script>
