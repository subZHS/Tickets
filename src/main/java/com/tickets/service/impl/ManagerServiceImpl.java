package com.tickets.service.impl;

import com.tickets.dao.ManagerDao;
import com.tickets.model.Balance;
import com.tickets.model.Manager;
import com.tickets.service.ManagerService;
import com.tickets.util.LoginMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ManagerServiceImpl implements ManagerService {

    @Autowired
    ManagerDao managerDao;

    public LoginMessage login(String managerid, String inputPwd) {
        Manager manager=getManager();
        if (!manager.getManagerid().equals(managerid)){
            return LoginMessage.MemberNotExist;
        }
        if(!manager.getPassword().equals(inputPwd)){
            return LoginMessage.WrongPassword;
        }
        return LoginMessage.Success;
    }

    public Manager getManager() {
        return (Manager) managerDao.find().get(0);
    }

    public boolean modifyManager(Manager manager) {
        return managerDao.updateById(manager);
    }

}
