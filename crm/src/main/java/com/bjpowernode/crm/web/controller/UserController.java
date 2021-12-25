package com.bjpowernode.crm.web.controller;

import com.bjpowernode.crm.constants.Constants;
import com.bjpowernode.crm.pojo.User;
import com.bjpowernode.crm.services.UserService;
import com.bjpowernode.crm.utils.MD5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.HashMap;
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
    public Map login(String username,String password, Boolean autoLogin) throws UnsupportedEncodingException {
        // 不要使用 localhost 访问
        String ip = request.getRemoteAddr();

        User user = userService.getUser(username,password,ip);

        session.setAttribute(Constants.LOGIM_USER,user);

        if (autoLogin){
            int maxAge = 3600 * 24 * 10;//10天

            /*
                为了数据更加安全，会对cookie保存的数据进行特殊的编码处理（一般属于公司内部特有的一种算法），
                即便数据被“猜测”到表示的含义，也无法得到真实的数据，因为不知道数据是如何进行怎样的编码处理。
             */

            username = Base64.getEncoder().encodeToString(username.getBytes("UTF-8"));
            Cookie cookie1 = new Cookie(Constants.CookieNames.USER_NAME, username);
            cookie1.setMaxAge(maxAge);
            cookie1.setPath("/");// 访问服务器下的任何资源都会携带cookie信息

            // 由于cookie保存到磁盘中（不安全），因此对密码进行加密保存
            password = MD5Util.getMD5(password);
            password = Base64.getEncoder().encodeToString(password.getBytes("UTF-8"));
            Cookie cookie2 = new Cookie(Constants.CookieNames.USER_PWD, password);
            cookie2.setMaxAge(maxAge);
            cookie2.setPath("/");

            // 必须添加到响应对象中，浏览器才会保存该cookie数据
            response.addCookie(cookie1);
            response.addCookie(cookie2);


        }

        return Constants.Result.SUC;
    }

    @RequestMapping("changePwd.do")
    public Map changePwd(String oldPwd,String newPwd){
        User user = (User)session.getAttribute(Constants.LOGIM_USER);
        userService.changePwd(oldPwd, newPwd, user);

        return new HashMap(){{
            put("success", true);
            put("msg", "修改密码成功！请重新登陆！");
        }};
    }

    @RequestMapping("logout.do")
    public void logout(HttpServletResponse response) throws IOException{
        session.removeAttribute(Constants.LOGIM_USER);

        //清除免登陆的cookie数据
        Cookie cookie = new Cookie(Constants.CookieNames.USER_NAME, null);
        cookie.setMaxAge(0);
        cookie.setPath("/");
        response.addCookie(cookie);

        response.sendRedirect("/");
    }
}
