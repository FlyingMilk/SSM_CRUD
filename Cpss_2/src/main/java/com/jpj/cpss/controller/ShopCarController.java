package com.jpj.cpss.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jpj.cpss.bean.Msg;
import com.jpj.cpss.bean.ShopCar;
import com.jpj.cpss.service.ShopCarService;

@Controller
public class ShopCarController {
	@Autowired
	ShopCarService shopCarService;

	
	/**
	 * 添加购物车  商品界面
	 * @param shopcar
	 * @param result
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/shopcar",method=RequestMethod.POST)
	public Msg savepros(@Valid ShopCar shopcar,BindingResult result){
		if(result.hasErrors()){
			//校验失败，返回失败，在模态框中显示错误信息
			Map<String, Object> map = new HashMap<>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				System.out.println("错误的字段名："+fieldError.getField());
				System.out.println("错误信息："+fieldError.getDefaultMessage());
				map.put(fieldError.getField(),fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}
		else{
			shopCarService.saveShopCar(shopcar);
			return Msg.success();	
		}
	}
	/*
	 * 查询所有购物车信息
	 */
	@RequestMapping("/shopcar")
	@ResponseBody
	public Msg getgetProductsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
			@RequestParam(value = "loginname") String loginname) {
		// 引入PageHelper分页插件
		// 只需要在查询之前调用，传入页码，页面大小
		PageHelper.startPage(pn, 6);
		// startPage后面紧跟的这个查询就是一个分页查询
		List<ShopCar> shopCars = shopCarService.getMyShopCar(loginname);
		// 用PageInfo对结果进行包装，只需要将PageInfo交给页面就可以,
		// PageInfo封装了详细的分页信息，包括查询的数据,传入连续显示的页数
		PageInfo page = new PageInfo(shopCars,5);
		return Msg.success().add("pageInfo",page);
	}

	@RequestMapping("/shopcar/selectMyShopCar")
	public String showMyShopCar(){
		return "shopcar/myshopcar";
	}
	
	/**
	 * 查询选中的总价
	 * @return
	 */
	@RequestMapping(value ="/shopcarnum",method = RequestMethod.GET)
	public Msg selectAllTotal(@PathVariable("carIds") String carIds){
		int allTotal = 0;
		System.out.println(carIds);
		if(carIds.contains(",")){
			List<Integer> del_ids = new ArrayList<>();
			String[] str_ids = carIds.split(",");
			//组装id的集合		
			for(String carId : str_ids){
				del_ids.add(Integer.parseInt(carId));
				System.out.println("2 "+Integer.parseInt(carId));
			}
			List<ShopCar> shopCars= shopCarService.selectAllTotal(del_ids);
			for (int i = 0; i < shopCars.size(); i++) {
				System.out.println("s1" + shopCars.get(i).getOrderTotal());
				allTotal += shopCars.get(i).getOrderTotal();
			}
			
			System.out.println(allTotal);
			return Msg.success().add("allTotal", allTotal);
		}
		else{
			return Msg.fail();
		}
	}

	
	/**
	 * 删除产品 单个 批量 二合一
	 * 批量删除： id用- 隔开  1-2-3
	 * 单个删除：  1
	 * @param productId
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/shopcar/{carIds}",method=RequestMethod.DELETE)
	public Msg delectProById(@PathVariable("carIds")String carIds){
		//批量删除
		if(carIds.contains("-")){
			List<Integer> del_ids = new ArrayList<>();
			String[] str_ids = carIds.split("-");
			//组装id的集合		
			for(String carId : str_ids){
				del_ids.add(Integer.parseInt(carId));
			}
			shopCarService.deteleBatch(del_ids);
		}else{  //单个删除	
			Integer carId = Integer.parseInt(carIds);
	//		System.out.println(productId);
			shopCarService.delectProduct(carId);
		}
		return Msg.success();
	}
}
