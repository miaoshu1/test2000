package com.bjpowernode.crm.web.controller;

import com.bjpowernode.crm.constants.Constants;
import com.bjpowernode.crm.pojo.User;
import com.bjpowernode.crm.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Map;

@RestController// @Controller + @ResponseBody
@RequestMapping("user")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired(required = false)
    private HttpSession session;

    @Autowired(required = false)
    private HttpServletRequest request;

    @Autowired(required = false)
    private HttpServletResponse response;

    @RequestMapping("login.do")
    public Map login(String username,String password){
        // 不要使用 localhost 访问
        String ip = request.getRemoteAddr();

        User user = userService.getUser(username,password,ip);

        session.setAttribute(Constants.LOGIM_USER,user);

        return Constants.Result.SUC;
    }

    @RequestMapping("changePwd.do")
    public Map changePwd(String oldPwd,String newPwd){
        User user = (User)session.getAttribute(Constants.LOGIM_USER);

        int update = userService.update(oldPwd, newPwd);

        return Constants.Result.SUC_WITH_MSG;
    }
}
