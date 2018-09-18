package com.jpj.cpss.bean;

public class Coll {
    private Integer collId;

    private String loginname;

    private Integer productId;

    private String productName;

    private Integer collFlag;

    public Integer getCollId() {
        return collId;
    }

    public void setCollId(Integer collId) {
        this.collId = collId;
    }

    public String getLoginname() {
        return loginname;
    }

    public void setLoginname(String loginname) {
        this.loginname = loginname == null ? null : loginname.trim();
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName == null ? null : productName.trim();
    }

    public Integer getCollFlag() {
        return collFlag;
    }

    public void setCollFlag(Integer collFlag) {
        this.collFlag = collFlag;
    }
}