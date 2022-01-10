package com.bjpowernode.crm.web.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;

@RestController
@RequestMapping("tran")
public class TranController {

    @GetMapping("poss.json")
    public Object getPoss(HttpSession session) {
        return session.getServletContext().getAttribute("posiiMap");
    }
}
