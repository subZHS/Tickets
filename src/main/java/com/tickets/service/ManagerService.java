package com.tickets.service;

import com.tickets.model.Manager;
import com.tickets.util.LoginMessage;

import java.util.List;

public interface ManagerService {

    /*
    会员登录，判断用户是否存在, 判断密码是否匹配，判断是否验证邮箱(isvalid)
     */
    public LoginMessage login(String managerid, String inputPwd);

    /*
    得到管理员信息
     */
    public Manager getManager();

    /*
    修改管理员信息
     */
    public boolean modifyManager(Manager manager);

}
