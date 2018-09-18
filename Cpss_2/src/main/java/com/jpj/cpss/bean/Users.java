package com.jpj.cpss.bean;

import java.util.Date;

import javax.validation.constraints.Pattern;

public class Users {
    private Integer id;
    
    @Pattern(regexp="(^[a-zA-Z0-9_-]{5,16}$)|(^[\u2E80-\u9FFF]{2,10})",message="�˺Ÿ�ʽΪ5-16λӢ�ģ����ֻ�2-10λ���ģ�")
    private String loginname;

    @Pattern(regexp="^[a-zA-Z0-9_-]{3,16}$",message="�����ʽΪ3-16λӢ�ģ�����")
    private String password;

    private Date createdate;

    private String username;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getLoginname() {
        return loginname;
    }

    public void setLoginname(String loginname) {
        this.loginname = loginname == null ? null : loginname.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    public Date getCreatedate() {
        return createdate;
    }

    public void setCreatedate(Date createdate) {
        this.createdate = createdate;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username == null ? null : username.trim();
    }
}