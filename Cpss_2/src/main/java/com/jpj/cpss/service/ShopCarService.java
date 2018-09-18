package com.jpj.cpss.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jpj.cpss.bean.Order;
import com.jpj.cpss.bean.OrderExample;
import com.jpj.cpss.bean.ProductExample;
import com.jpj.cpss.bean.ShopCar;
import com.jpj.cpss.bean.ShopCarExample;
import com.jpj.cpss.bean.ShopCarExample.Criteria;
import com.jpj.cpss.dao.ShopCarMapper;
@Service
public class ShopCarService {
	

	@Autowired
	ShopCarMapper shopCarMapper;
	public void saveShopCar(ShopCar shopcar) {
		shopCarMapper.insertSelective(shopcar);
		
	}
	public List<ShopCar> getMyShopCar(String loginname) {
		ShopCarExample example = new ShopCarExample();
		Criteria criteria = example.createCriteria();
		criteria.andLoginnameEqualTo(loginname);
		List<ShopCar> list = shopCarMapper.selectByExample(example);
		//自定义查询方法
		
		return list;
	}
	public void deteleBatch(List<Integer> carIds) {
		ShopCarExample example = new ShopCarExample();
		Criteria criteria = example.createCriteria();
		//delect from xxx where product_id in(1,2,3,)
		criteria.andCarIdIn(carIds);
		shopCarMapper.deleteByExample(example);
		
	}
	public void delectProduct(Integer carId) {
		shopCarMapper.deleteByPrimaryKey(carId);
		
	}
	public List<ShopCar> selectAllTotal(List<Integer> carIds) {
		ShopCarExample example = new ShopCarExample();
		Criteria criteria = example.createCriteria();
		//delect from xxx where product_id in(1,2,3,)
		criteria.andCarIdIn(carIds);
		System.out.println("1 "+carIds.get(0));
		List<ShopCar> shopCars =  shopCarMapper.selectByExample(example);
		System.err.println(shopCars.get(0).toString());
		return shopCars;
	}

}
