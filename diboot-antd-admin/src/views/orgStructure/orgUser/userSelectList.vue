<template>
  <div class="userList content">
    <div class="table-page-search-wrapper">
      <a-form layout="inline">
        <a-row :gutter="18">
          <a-col :md="8" :sm="24">
            <a-form-item label="姓名">
              <a-input v-model="queryParam.realname" placeholder=""/>
            </a-form-item>
          </a-col>
          <a-col :md="8" :sm="24">
            <a-form-item label="工号">
              <a-input v-model="queryParam.userNum" placeholder=""/>
            </a-form-item>
          </a-col>
          <template v-if="advanced">
            <a-col :md="8" :sm="24">
              <a-form-item label="性别">
                <a-select v-model="queryParam.gender" placeholder="请选择">
                  <a-select-option
                    v-for="(gender, index) in more.genderKvList"
                    :key="index"
                    :value="gender.v"
                  >
                    {{ gender.k }}
                  </a-select-option>
                </a-select>
              </a-form-item>
            </a-col>
            <a-col :md="8" :sm="24">
              <a-form-item label="电话">
                <a-input v-model="queryParam.mobilePhone" placeholder=""/>
              </a-form-item>
            </a-col>
            <a-col :md="8" :sm="24">
              <a-form-item label="邮箱">
                <a-input v-model="queryParam.email" placeholder=""/>
              </a-form-item>
            </a-col>
          </template>
          <a-col :md="!advanced && 8 || 24" :sm="24">
            <span class="table-page-search-submitButtons" :style="advanced && { float: 'right', overflow: 'hidden' } || {} ">
              <a-button type="primary" @click="getList">查询</a-button>
              <a-button style="margin-left: 8px" @click="reset">重置</a-button>
              <a @click="toggleAdvanced" style="margin-left: 8px">
                {{ advanced ? '收起' : '展开' }}
                <a-icon :type="advanced ? 'up' : 'down'"/>
              </a>
            </span>
          </a-col>
        </a-row>
      </a-form>
    </div>
    <a-table
      ref="table"
      size="default"
      :columns="columns"
      :dataSource="data"
      :pagination="pagination"
      :loading="loadingData"
      @change="handleTableChange"
      rowKey="id"
    >
      <span slot="action" slot-scope="text, record">
        <a-button type="link" @click="$emit('select', record)">选择</a-button>
      </span>
    </a-table>
  </div>
</template>

<script>
import list from '@/components/diboot/mixins/list'

export default {
  name: 'UserSelectList',
  components: {
  },
  mixins: [list],
  data () {
    return {
      baseApi: '/auth-server/iam/user',
      getMore: true,
      getListFromMixin: true,
      // 表头
      columns: [
        {
          title: '姓名',
          dataIndex: 'realname'
        },
        {
          title: '用户编号',
          dataIndex: 'userNum'
        },
        {
          title: '性别',
          dataIndex: 'genderLabel'
        },
        {
          title: '电话',
          dataIndex: 'mobilePhone'
        },
        {
          title: '邮箱',
          dataIndex: 'email'
        },
        {
          title: '操作',
          dataIndex: 'action',
          width: '150px',
          scopedSlots: { customRender: 'action' }
        }
      ]
    }
  },
  watch: {
    currentNodeId: function (val) {
      if (!val || val === '0' || val === 0) {
        this.customQueryParam = {}
      } else {
        this.customQueryParam = { orgId: val }
      }
      this.getList()
    }
  },
  props: {
    currentNodeId: {
      type: String,
      default: '0'
    }
  }
}
</script>
<style lang="less" scoped>
</style>
