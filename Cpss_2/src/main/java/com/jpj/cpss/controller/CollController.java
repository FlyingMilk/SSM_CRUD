package com.jpj.cpss.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jpj.cpss.bean.Coll;
import com.jpj.cpss.bean.Msg;
import com.jpj.cpss.bean.Product;
import com.jpj.cpss.service.CollService;

@Controller
public class CollController {

	@Autowired
	CollService collService;
	
	/**
	 * 收藏信息保存
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/coll",method=RequestMethod.POST)
	public Msg saveCell(@RequestParam("loginname")String loginname
			,@RequestParam("productId")Integer productId
			,@RequestParam("productName")String productName
			,@RequestParam("collFlag")String collFlag){
		
		Coll coll = new Coll();
		coll.setLoginname(loginname);
		coll.setProductId(productId);
		coll.setProductName(productName);
		Integer collflag = Integer.parseInt(collFlag);
		coll.setCollFlag(collflag);
		collService.saveCell(coll);
		return Msg.success();
	}
	
	/**
	 * 收藏信删除
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/deletecoll",method=RequestMethod.GET)
	public Msg deleteCell(@RequestParam("loginname")String loginname
			,@RequestParam("productId")Integer productId){

		System.out.println(loginname+ " "+productId);
		collService.deleteCell(loginname,productId);
		return null;
	}
	
	/**
	 * 收藏信息保存
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/getallcoll",method=RequestMethod.GET)
	public Msg countCell(@RequestParam("loginname")String loginname
			,@RequestParam("productId")Integer productId){

		long num1 = collService.countCell(loginname,productId);
		return Msg.success().add("num1", num1);
	}
}
