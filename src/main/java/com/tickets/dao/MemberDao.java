package com.tickets.dao;

import com.tickets.model.Member;

import java.util.List;

/**
 * Created by lenovo on 2018/3/1.
 */
public interface MemberDao {

    public Member find(String memberid);

    public List find(String column, Object value);

    public List find();

    public boolean save(Member member);

    public boolean updateById(Member member);

    public List<Member> getTop10ConsumeMemberList();

}
