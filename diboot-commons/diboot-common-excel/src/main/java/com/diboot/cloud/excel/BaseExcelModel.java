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
package com.diboot.cloud.excel;

import com.alibaba.excel.annotation.ExcelIgnore;
import com.fasterxml.jackson.annotation.JsonIgnore;

import java.io.Serializable;

/***
 * excel数据导入导出实体基类
 * @auther wangyl@dibo.ltd
 * @date 2019-10-9
 */
public class BaseExcelModel implements Serializable {
    private static final long serialVersionUID = 6343247548525494223L;

    /**
     * 验证错误
     */
    @ExcelIgnore
    @JsonIgnore
    private String validateError;

    @ExcelIgnore
    @JsonIgnore
    private int rowIndex;

    public int getRowIndex(){
        return rowIndex;
    }

    public String getValidateError(){
        return validateError;
    }

    /**
     * 绑定错误
     * @param validateError
     */
    public void addValidateError(String validateError){
        if(this.validateError == null){
            this.validateError = validateError;
        }
        else{
            this.validateError += ", " + validateError;
        }
    }

    public void setRowIndex(int rowIndex){
        this.rowIndex = rowIndex;
    }
}
