import request from '@/utils/request'

/**
 * 新增${table.comment}
 * @param data
 */
export function ${table.memberName}Add(data) {
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
export function ${table.memberName}Del(id) {
  return request({
    url: '${module}/${table.path}/' + id,
    method: 'delete'
  })
}
/**
 * 修改${table.comment}
 * @param data
 */
export function ${table.memberName}Edit(data) {
  return request({
    url: '${module}/${table.path}',
    method: 'put',
    data
  })
}

/**
 * ${table.comment}分页查询
 * @param data
 */
export function ${table.memberName}Query(params) {
  return request({
    url: '${module}/${table.path}',
    method: 'get',
    params
  })
}
/**
 * ${table.comment}详情查询
 * @param data
 */
export function ${table.memberName}Info(id) {
  return request({
    url: '${module}/${table.path}/' + id,
    method: 'get'
  })
}
