package com.spring.ex.users.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.ex.users.model.UsersDao;

@Controller
public class UsersUserIdCheckController {
    private final String command = "/users/user/userId_check.us";

    @Autowired
    UsersDao udao;

    // 회원가입페이지(signUpPage.jsp)에서 아이디 중복체크 클릭, (ajax에 담겨서 넘어옴)
    @RequestMapping(value = command)
    @ResponseBody
    public String checkDuplicateUserId(@RequestParam("input_userId") String input_userId) {
        int cnt = -1;
        cnt = udao.checkDuplicateUserId(input_userId);
        System.out.println("checkDuplicateUserId cnt : " + cnt);
        if (cnt == 1) { // 사용 중
            return "NO";
        } else {
            return "YES";
        }
    }
}
