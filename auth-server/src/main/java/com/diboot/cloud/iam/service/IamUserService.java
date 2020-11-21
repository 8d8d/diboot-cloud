/*
 * Copyright (c) 2015-2020, www.dibo.ltd (service@dibo.ltd).
 * <p>
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy of
 * the License at
 * <p>
 * https://www.apache.org/licenses/LICENSE-2.0
 * <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 */
package com.diboot.cloud.iam.service;

import com.diboot.cloud.dto.IamUserAccountDTO;
import com.diboot.cloud.entity.IamUser;
import com.diboot.cloud.vo.IamRoleVO;

import java.util.List;

/**
* 系统用户相关Service
* @author mazc@dibo.ltd
* @version 2.0
* @date 2019-12-17
*/
public interface IamUserService extends BaseIamService<IamUser> {

    /**
     * 构建role-permission角色权限数据格式(合并role等)，用于前端适配
     * @param iamUser
     * @return
     */
    IamRoleVO buildRoleVo4FrontEnd(IamUser iamUser);

    /***
     * 获取用户的所有角色列表（包括扩展的关联角色）
     * @param iamUser
     * @return
     */
    List<IamRoleVO> getAllRoleVOList(IamUser iamUser);

    /***
     * 添加用户和账号
     * @param userAccountDTO
     * @return
     */
    boolean createUserAndAccount(IamUserAccountDTO userAccountDTO) throws Exception;

    /***
     * 更新用户和账号
     * @param userAccountDTO
     * @return
     */
    boolean updateUserAndAccount(IamUserAccountDTO userAccountDTO) throws Exception;

    /***
     * 删除用户和账号
     * @param id
     * @return
     * @throws Exception
     */
    boolean deleteUserAndAccount(Long id) throws Exception;

}