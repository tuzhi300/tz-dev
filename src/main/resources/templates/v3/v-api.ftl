import request from '@/utils/request'

/**
 * 新增${table.comment}
 * @param data
 */
export function add${table.className}(data) {
  return request({
    url: '${module}/${table.path}',
    method: 'post',
    data
  })
}

/**
 * 删除${table.comment}
 * @param data
 */
export function delete${table.className}(id) {
  return request({
    url: '${module}/${table.path}/' + id,
    method: 'delete'
  })
}

/**
 * 修改${table.comment}
 * @param data
 */
export function update${table.className}(data) {
  return request({
    url: '${module}/${table.path}',
    method: 'put',
    data
  })
}

/**
 * 分页查询${table.comment}
 * @param params
 */
export function query${table.className}s(params) {
  return request({
    url: '${module}/${table.path}',
    method: 'get',
    params
  })
}

/**
 * 查询${table.comment}详情
 * @param id
 */
export function query${table.className}(id) {
  return request({
    url: '${module}/${table.path}/' + id,
    method: 'get'
  })
}
