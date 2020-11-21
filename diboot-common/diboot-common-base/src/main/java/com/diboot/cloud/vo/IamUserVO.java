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
package com.diboot.cloud.vo;

import com.diboot.core.binding.annotation.BindDict;
import com.diboot.core.binding.annotation.BindEntityList;
import com.diboot.cloud.entity.IamRole;
import com.diboot.cloud.entity.IamUser;
import lombok.Data;

import java.util.List;

/**
* 系统用户 VO定义
* @author mazc@dibo.ltd
* @version 2.0
* @date 2019-12-17
*/
@Data
public class IamUserVO extends IamUser {
    private static final long serialVersionUID = 7571698765478647277L;

    private String username;

    @BindDict(type="GENDER", field = "gender")
    private String genderLabel;

    @BindDict(type="USER_STATUS", field = "status")
    private String statusLabel;

    // 字段关联：this.id=iam_user_role.user_id AND iam_user_role.role_id=id
    @BindEntityList(entity = IamRole.class, condition = "this.id=iam_user_role.user_id AND iam_user_role.role_id=id")
    private List<IamRole> roleList;
}