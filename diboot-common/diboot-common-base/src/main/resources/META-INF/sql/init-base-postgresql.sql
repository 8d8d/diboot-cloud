-- 建表
create table dictionary (
  id                   bigserial not null,
  parent_id            bigint        not null,
  tenant_id            bigint        not null default 0,
  app_module          VARCHAR(50) not null,
  type                 VARCHAR(50)   not null,
  item_name            VARCHAR(100)  not null,
  item_value           VARCHAR(100)  null,
  description          VARCHAR(100)  null,
  extdata              VARCHAR(200)  null,
  sort_id              SMALLINT      not null default 99,
  is_deletable         BOOLEAN       not null default TRUE,
  is_editable          BOOLEAN       not null default TRUE,
  is_deleted           BOOLEAN       not null default FALSE,
  create_time          timestamp     not null default CURRENT_TIMESTAMP,
  constraint PK_dictionary primary key (id)
);
-- 添加备注
comment on column dictionary.id is 'ID';
comment on column dictionary.parent_id is '父ID';
comment on column dictionary.tenant_id is '租户ID';
comment on column dictionary.app_module is '应用模块';
comment on column dictionary.type is '字典类型';
comment on column dictionary.item_name is '显示名';
comment on column dictionary.item_value is '存储值';
comment on column dictionary.description is '描述说明';
comment on column dictionary.extdata is '扩展JSON';
comment on column dictionary.sort_id is '排序号';
comment on column dictionary.is_editable is '是否可改';
comment on column dictionary.is_deletable is '是否可删';
comment on column dictionary.is_deleted is '删除标记';
comment on column dictionary.create_time is '创建时间';

comment on table dictionary is '数据字典';
-- 创建索引
create index idx_directory on dictionary(type, item_value);
create index idx_directory_tenant on dictionary(tenant_id);

-- 用户表
create table iam_user
(
  id bigserial not null,
  tenant_id            bigint        not null default 0,
  org_id bigint not null default 0,
  user_num varchar(20) not null,
  realname varchar(50) not null,
  gender varchar(10) not null,
  birthdate date null,
  mobile_phone varchar(20) null,
  email varchar(50) null,
  avatar_url varchar(200) null,
  status varchar(10) not null default 'A',
  is_deleted BOOLEAN not null DEFAULT FALSE,
  create_time  timestamp   not null default CURRENT_TIMESTAMP
);
-- 添加备注
comment on column iam_user.id is 'ID';
comment on column iam_user.tenant_id is '租户ID';
comment on column iam_user.org_id is '组织ID';
comment on column iam_user.user_num is '用户编号';
comment on column iam_user.realname is '真实姓名';
comment on column iam_user.gender is '性别';
comment on column iam_user.birthdate is '出生日期';
comment on column iam_user.mobile_phone is '手机号';
comment on column iam_user.email is 'Email';
comment on column iam_user.avatar_url is '头像';
comment on column iam_user.status is '状态';
comment on column iam_user.is_deleted is '删除标记';
comment on column iam_user.create_time is '创建时间';
comment on table iam_user is '系统用户';
-- 索引
create index idx_iam_user_1 on iam_user (org_id);
create index idx_iam_user_2 on iam_user (mobile_phone);
create unique index uidx_iam_user on iam_user (tenant_id, user_num);
create index idx_iam_user_tenant on iam_user(tenant_id);

-- 账号表
create table iam_account
(
  id bigserial not null,
  tenant_id            bigint        not null default 0,
  user_type varchar(100) default 'IamUser' not null,
  user_id bigint not null,
  auth_type varchar(20) default 'PWD' not null,
  auth_account varchar(100) not null,
  auth_secret varchar(32) null,
  secret_salt varchar(32) null,
  status varchar(10) default 'A' not null,
  is_deleted BOOLEAN default FALSE not null,
  create_time timestamp default CURRENT_TIMESTAMP not null
);
comment on column iam_account.id is 'ID';
comment on column iam_account.tenant_id is '租户ID';
comment on column iam_account.user_type is '用户类型';
comment on column iam_account.user_id is '用户ID';
comment on column iam_account.auth_type is '认证方式';
comment on column iam_account.auth_account is '用户名';
comment on column iam_account.auth_secret is '密码';
comment on column iam_account.secret_salt is '加密盐';
comment on column iam_account.status is '用户状态';
comment on column iam_account.is_deleted is '是否删除';
comment on column iam_account.create_time is '创建时间';
comment on table iam_account is '登录账号';
-- 创建索引
create unique index idx_iam_account on iam_account(tenant_id, auth_account, auth_type, user_type);
create index idx_iam_account_tenant on iam_account(tenant_id);

-- 角色表
create table iam_role
(
  id bigserial not null,
  tenant_id            bigint        not null default 0,
  name varchar(20) not null,
  code varchar(20) not null,
  description varchar(100) null,
  is_deleted BOOLEAN default FALSE not null,
  create_time timestamp default CURRENT_TIMESTAMP null
);
comment on column iam_role.id is 'ID';
comment on column iam_role.tenant_id is '租户ID';
comment on column iam_role.name is '名称';
comment on column iam_role.code is '编码';
comment on column iam_role.description is '备注';
comment on column iam_role.is_deleted is '是否删除';
comment on column iam_role.create_time is '创建时间';
comment on table iam_role is '角色';
-- 创建索引
create index idx_iam_role_tenant on iam_role(tenant_id);

-- 用户角色表
create table iam_user_role
(
  id bigserial not null,
  tenant_id            bigint        not null default 0,
  user_type varchar(100) default 'IamUser' not null,
  user_id bigint not null,
  role_id bigint not null,
  is_deleted BOOLEAN default FALSE not null,
  create_time timestamp default CURRENT_TIMESTAMP not null
);
comment on column iam_user_role.id is 'ID';
comment on column iam_user_role.tenant_id is '租户ID';
comment on column iam_user_role.user_type is '用户类型';
comment on column iam_user_role.user_id is '用户ID';
comment on column iam_user_role.role_id is '角色ID';
comment on column iam_user_role.is_deleted is '是否删除';
comment on column iam_user_role.create_time is '创建时间';
comment on table iam_user_role is '用户角色关联';
-- 索引
create index idx_iam_user_role on iam_user_role (user_type, user_id);
create index idx_iam_user_role_tenant on iam_user_role(tenant_id);

-- 前端权限表
create table iam_resource_permission
(
  id bigserial not null,
  tenant_id            bigint        not null default 0,
  app_module          varchar(50) not null,
  parent_id bigint default 0   not null,
  display_type varchar(20) not null,
  display_name varchar(100) not null,
  frontend_code varchar(100)   null,
  api_set varchar(3000)   null,
  sort_id bigint    null,
  is_deleted BOOLEAN default FALSE not null,
  create_time timestamp default CURRENT_TIMESTAMP not null,
  update_time timestamp null,
  constraint PK_iam_resource_permission primary key (id)
);
comment on column iam_resource_permission.id is 'ID';
comment on column iam_resource_permission.tenant_id is '租户ID';
comment on column iam_resource_permission.app_module is '应用模块';
comment on column iam_resource_permission.parent_id is '菜单ID';
comment on column iam_resource_permission.display_type is '展现类型';
comment on column iam_resource_permission.display_name is '显示名称';
comment on column iam_resource_permission.frontend_code is '前端编码';
comment on column iam_resource_permission.api_set is '接口列表';
comment on column iam_resource_permission.sort_id is '排序号';
comment on column iam_resource_permission.is_deleted is '是否删除';
comment on column iam_resource_permission.create_time is '创建时间';
comment on column iam_resource_permission.update_time is '更新时间';
comment on table iam_resource_permission is '前端权限表';
-- 索引
create index idx_iam_resource_permission on iam_resource_permission (parent_id);
create index idx_resource_permission_tenant on iam_resource_permission(tenant_id);

-- 角色-权限
create table iam_role_resource
(
  id bigserial not null ,
  tenant_id            bigint        not null default 0,
  role_id bigint not null ,
  permission_id bigint not null ,
  is_deleted BOOLEAN default FALSE not null ,
  create_time timestamp default CURRENT_TIMESTAMP not null
);
comment on column iam_role_resource.id is 'ID';
comment on column iam_role_resource.tenant_id is '租户ID';
comment on column iam_role_resource.role_id is '角色ID';
comment on column iam_role_resource.permission_id is '权限ID';
comment on column iam_role_resource.is_deleted is '是否删除';
comment on column iam_role_resource.create_time is '创建时间';
comment on table iam_role_resource is '角色权限';
-- 索引
create index idx_iam_role_resource on iam_role_resource (role_id, permission_id);
create index idx_iam_role_resource_tenant on iam_role_resource(tenant_id);

-- 登录日志表
create table iam_login_trace
(
  id bigserial not null ,
  tenant_id            bigint        not null default 0,
  user_type varchar(100) default 'IamUser' not null ,
  user_id bigint not null ,
  auth_type varchar(20) default 'PWD' not null ,
  auth_account varchar(100) not null ,
  ip_address varchar(50) null ,
  user_agent varchar(200) null ,
  is_success BOOLEAN default FALSE not null ,
  create_time timestamp default CURRENT_TIMESTAMP not null
);
comment on column iam_login_trace.id is 'ID';
comment on column iam_login_trace.tenant_id is '租户ID';
comment on column iam_login_trace.user_type is '用户类型';
comment on column iam_login_trace.user_id is '用户ID';
comment on column iam_login_trace.auth_type is '认证方式';
comment on column iam_login_trace.auth_account is '用户名';
comment on column iam_login_trace.ip_address is 'IP';
comment on column iam_login_trace.user_agent is '客户端信息';
comment on column iam_login_trace.is_success is '是否成功';
comment on column iam_login_trace.create_time is '创建时间';
comment on table iam_login_trace is '登录日志';
-- 创建索引
create index idx_iam_login_trace on iam_login_trace (user_type, user_id);
create index idx_iam_login_trace_2 on iam_login_trace (auth_account);
create index idx_iam_login_trace_tenant on iam_login_trace(tenant_id);

-- 操作日志表
create table iam_operation_log
(
  id bigserial not null ,
  tenant_id            bigint        not null default 0,
  app_module          varchar(50) not null,
  business_obj varchar(100)  not null,
  operation   varchar(100)  not null,
  user_type varchar(100) default 'IamUser' not null ,
  user_id bigint not null ,
  user_realname    varchar(100)  null,
  request_uri    varchar(500)                  not null,
  request_method varchar(20)                   not null,
  request_params    varchar(1000)              null,
  request_ip   varchar(50)                     null,
  status_code   smallint   default 0   not null,
  error_msg     varchar(1000)           null,
  is_deleted BOOLEAN default FALSE not null,
  create_time timestamp default CURRENT_TIMESTAMP not null
);
comment on column iam_operation_log.id is 'ID';
comment on column iam_operation_log.tenant_id is '租户ID';
comment on column iam_operation_log.app_module is '应用模块';
comment on column iam_operation_log.business_obj is '业务对象';
comment on column iam_operation_log.operation is '操作描述';
comment on column iam_operation_log.user_type is '用户类型';
comment on column iam_operation_log.user_id is '用户ID';
comment on column iam_operation_log.user_realname is '用户姓名';
comment on column iam_operation_log.request_uri is '请求URI';
comment on column iam_operation_log.request_method is '请求方式';
comment on column iam_operation_log.request_params is '请求参数';
comment on column iam_operation_log.request_ip is 'IP';
comment on column iam_operation_log.status_code is '状态码';
comment on column iam_operation_log.error_msg is '异常信息';
comment on column iam_operation_log.is_deleted is '是否删除';
comment on column iam_operation_log.create_time is '创建时间';
comment on table iam_operation_log is '操作日志';
-- 创建索引
create index idx_iam_operation_log on iam_operation_log (user_type, user_id);
create index idx_iam_operation_log_tenant on iam_operation_log(tenant_id);

-- 部门表
CREATE TABLE iam_org (
   id bigserial not null ,
   parent_id            bigint        not null default 0,
   name varchar(100) NOT NULL,
   short_name varchar(50) NOT NULL,
   org_comment varchar(255) NOT NULL,
   level smallint DEFAULT 1 NOT NULL,
   sort_id bigint DEFAULT 1 NOT NULL,
   is_deleted BOOLEAN default FALSE not null,
   create_time timestamp default CURRENT_TIMESTAMP not null
);
comment on column iam_org.id is 'ID';
comment on column iam_org.parent_id is '上级ID';
comment on column iam_org.name is '名称';
comment on column iam_org.short_name is '简称';
comment on column iam_org.org_comment is '备注';
comment on column iam_org.level is '层级';
comment on column iam_org.sort_id is '排序号';
comment on column iam_org.is_deleted is '是否删除';
comment on column iam_org.create_time is '创建时间';
comment on table iam_org is '部门';
create index idx_iam_org on iam_org (parent_id);