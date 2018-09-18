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
	 * ��ӹ��ﳵ  ��Ʒ����
	 * @param shopcar
	 * @param result
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/shopcar",method=RequestMethod.POST)
	public Msg savepros(@Valid ShopCar shopcar,BindingResult result){
		if(result.hasErrors()){
			//У��ʧ�ܣ�����ʧ�ܣ���ģ̬������ʾ������Ϣ
			Map<String, Object> map = new HashMap<>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				System.out.println("������ֶ�����"+fieldError.getField());
				System.out.println("������Ϣ��"+fieldError.getDefaultMessage());
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
	 * ��ѯ���й��ﳵ��Ϣ
	 */
	@RequestMapping("/shopcar")
	@ResponseBody
	public Msg getgetProductsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
			@RequestParam(value = "loginname") String loginname) {
		// ����PageHelper��ҳ���
		// ֻ��Ҫ�ڲ�ѯ֮ǰ���ã�����ҳ�룬ҳ���С
		PageHelper.startPage(pn, 6);
		// startPage��������������ѯ����һ����ҳ��ѯ
		List<ShopCar> shopCars = shopCarService.getMyShopCar(loginname);
		// ��PageInfo�Խ�����а�װ��ֻ��Ҫ��PageInfo����ҳ��Ϳ���,
		// PageInfo��װ����ϸ�ķ�ҳ��Ϣ��������ѯ������,����������ʾ��ҳ��
		PageInfo page = new PageInfo(shopCars,5);
		return Msg.success().add("pageInfo",page);
	}

	@RequestMapping("/shopcar/selectMyShopCar")
	public String showMyShopCar(){
		return "shopcar/myshopcar";
	}
	
	/**
	 * ��ѯѡ�е��ܼ�
	 * @return
	 */
	@RequestMapping(value ="/shopcarnum",method = RequestMethod.GET)
	public Msg selectAllTotal(@PathVariable("carIds") String carIds){
		int allTotal = 0;
		System.out.println(carIds);
		if(carIds.contains(",")){
			List<Integer> del_ids = new ArrayList<>();
			String[] str_ids = carIds.split(",");
			//��װid�ļ���		
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
	 * ɾ����Ʒ ���� ���� ����һ
	 * ����ɾ���� id��- ����  1-2-3
	 * ����ɾ����  1
	 * @param productId
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/shopcar/{carIds}",method=RequestMethod.DELETE)
	public Msg delectProById(@PathVariable("carIds")String carIds){
		//����ɾ��
		if(carIds.contains("-")){
			List<Integer> del_ids = new ArrayList<>();
			String[] str_ids = carIds.split("-");
			//��װid�ļ���		
			for(String carId : str_ids){
				del_ids.add(Integer.parseInt(carId));
			}
			shopCarService.deteleBatch(del_ids);
		}else{  //����ɾ��	
			Integer carId = Integer.parseInt(carIds);
	//		System.out.println(productId);
			shopCarService.delectProduct(carId);
		}
		return Msg.success();
	}
}
