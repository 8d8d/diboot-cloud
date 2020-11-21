/*
 * Copyright (c) 2015-2021, www.dibo.ltd (service@dibo.ltd).
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
package com.diboot.cloud.annotation.process;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.List;

/**
 * <Description>
 *
 * @author Mazhicheng
 * @version v2.0
 * @date 2020/02/28
 */
@Getter @Setter
public class ApiPermissionWrapper implements Serializable {
    private static final long serialVersionUID = 544405101900928328L;

    public ApiPermissionWrapper(){}

    public ApiPermissionWrapper(String classTitle){
        this.classTitle = classTitle;
    }

    // 类别标题
    private String classTitle;

    /**
     * 子节点
     */
    private List<ApiPermission> children;

}
