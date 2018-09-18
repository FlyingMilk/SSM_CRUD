package com.jpj.cpss.bean;

import javax.validation.constraints.Pattern;

public class Product {
    private Integer productId;

   @Pattern(regexp="(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{1,10})"
    		,message="名称格式为3-16位英文，数字或1-10位中文！")
    private String productName;

    //@Pattern(regexp="^[0-9]*$ ",message="价格不能为空且必须是数字！")
    private Integer productPrice;

    private String productGenre;
    
   // @Pattern(regexp="^[0-9]*$ ",message="数量不能为空且必须是数字！")
    private Integer productNum;

    private String productDescribe;

    public Product() {
		super();
		// TODO Auto-generated constructor stub
	}

    public Product(Integer productId, String productName, Integer productPrice, String productGenre, Integer productNum,
			String productDescribe) {
		super();
		this.productId = productId;
		this.productName = productName;
		this.productPrice = productPrice;
		this.productGenre = productGenre;
		this.productNum = productNum;
		this.productDescribe = productDescribe;
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

    public Integer getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(Integer productPrice) {
        this.productPrice = productPrice;
    }

    public String getProductGenre() {
        return productGenre;
    }

    public void setProductGenre(String productGenre) {
        this.productGenre = productGenre == null ? null : productGenre.trim();
    }

    public Integer getProductNum() {
        return productNum;
    }

    public void setProductNum(Integer productNum) {
        this.productNum = productNum;
    }

    public String getProductDescribe() {
        return productDescribe;
    }

    public void setProductDescribe(String productDescribe) {
        this.productDescribe = productDescribe == null ? null : productDescribe.trim();
    }

	@Override
	public String toString() {
		return "Product [productId=" + productId + ", productName=" + productName + ", productPrice=" + productPrice
				+ ", productGenre=" + productGenre + ", productNum=" + productNum + ", productDescribe="
				+ productDescribe + "]";
	}
    
}