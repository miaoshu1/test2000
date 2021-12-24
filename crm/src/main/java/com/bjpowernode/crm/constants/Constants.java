package com.bjpowernode.crm.constants;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

public interface Constants {
    /** 登陆的用户 */
    String LOGIM_USER = "loginUser";

    interface Result{
        Map SUC = new HashMap(){
            {
                put("success",true);
            }
        };

        Map SUC_WITH_MSG = new HashMap(){
            {
                put("success",true);
                put("msg","操作成功！");
            }
        };
    }

    interface Message{
        String ACT_PWD_ERR = "账号或密码错误！";
        String ACT_GQ = "账号已过期！";
        String ACT_GQ2 = "账号已过期，请联系HR！";
        String ACT_LOCK = "账号已锁定！";
        String IP_UN_ALLOW = "当前IP不允许访问！";
        String ERR_OLDPWD = "原密码不正确！";
        String EMPTY_PWD = "密码不能为空！";
    }

    interface DateFormat{
        SimpleDateFormat SDF19 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        SimpleDateFormat SDF10 = new SimpleDateFormat("yyyy-MM-dd");
    }

    /**cookie的名称*/
    interface CookieNames{
        /**用户名*/
        String USER_NAME = "KN91nml";
        /**密码*/
        String USER_PWD = "jhs981km";
    }
}
