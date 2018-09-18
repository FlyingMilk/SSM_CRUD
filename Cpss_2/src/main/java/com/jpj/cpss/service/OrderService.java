package com.jpj.cpss.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jpj.cpss.bean.Order;
import com.jpj.cpss.bean.OrderExample;
import com.jpj.cpss.bean.OrderExample.Criteria;


import com.jpj.cpss.dao.OrderMapper;

@Service
public class OrderService {
	@Autowired
	OrderMapper orderMapper;

	public List<Order> getAll() {
		return orderMapper.selectByExample(null);
	}

	public void saveOrder(Order order) {
		orderMapper.insertSelective(order);
		
	}

	public Order getOrderById(Integer orderId) {
		Order order = orderMapper.selectByPrimaryKey(orderId);
		return order;
	}

	//单个删除
	public void delectOrder(Integer orderId) {
		orderMapper.deleteByPrimaryKey(orderId);
	}

	/**
	 * 批量删除
	 * @param del_ids
	 */
	public void deteleBatch(List<Integer> orderIds) {
		OrderExample example = new OrderExample();
		Criteria criteria = example.createCriteria();
		//delect from xxx where product_id in(1,2,3,)
		criteria.andOrderIdIn(orderIds);
		orderMapper.deleteByExample(example);
		
	}

	public void updateOrder(Order order) {
		orderMapper.updateByPrimaryKeySelective(order);
		
	}

	public List<Order> getAllMyOrder(String loginname) {
		OrderExample example = new OrderExample();
		Criteria criteria = example.createCriteria();
		criteria.andLoginnameEqualTo(loginname);
		List<Order> list = orderMapper.selectByExample(example);
		//自定义查询方法
		List<Order> list1= orderMapper.selectByloginname(loginname);
		return list;
	}

	public void saveMyOrder(String loginname, String productName, Integer productPrice, Integer orderNum,
			Integer orderTotal) {
		Order record = new Order();

		record.setLoginname(loginname);
		record.setProductName(productName);
		record.setProductPrice(productPrice);
		record.setOrderNum(orderNum);
		record.setOrderTotal(orderTotal);
		orderMapper.insertSelective(record);
		
	}

	/**  其实不需要   外键关联加了CASCADE属性
	 * 删除商品的时候同时根据名称发送请求删除相关订单
	 * 管理员商品界面删除
	 * @param productName
	 */
	public void deleteByName(String productName) {
		OrderExample example = new OrderExample();
		Criteria criteria = example.createCriteria();
		criteria.andProductNameEqualTo(productName);
		orderMapper.deleteByExample(example);
		
	}

	
	/**
	 * 删除用户时根据用户名 查询订单表获取相关订单的商品名称和商品数量并根据名称返还商品数量 
	 * @param loginname
	 */
	public List<Order> selectProByName(String loginname) {
		OrderExample example = new OrderExample();
		Criteria criteria = example.createCriteria();
		criteria.andLoginnameEqualTo(loginname);
		List<Order> list = orderMapper.selectByExample(example);
		return list;
		
	}
	
	/**
	 * 根据种类返回数量的和
	 * @return
	 */
	public List<Integer> selectnumbyname() {
		List<Integer> sum  = orderMapper.countNumByName();
		return sum;
	}
	
	/**
	 * 根据种类返回名称
	 * @return
	 */
	public List<String> selectnamebyname() {
		List<String> names  = orderMapper.countNameByName();
		return names;
	}
	
	/**
	 * 根据种类返回数量的和
	 * @return
	 */
	public List<Integer> selectnumbygen() {
		List<Integer> sum  = orderMapper.countNumByGen();
		return sum;
	}
	
	/**
	 * 根据种类返回名称
	 * @return
	 */
	public List<String> selectnamebygen() {
		List<String> names  = orderMapper.countNameByGen();
		return names;
	}
	
	/**
	 * 根据名称返回价格
	 * @return
	 */
	public List<Integer> selectpricebyname() {
		List<Integer> prices  = orderMapper.selectpricebyname();
		return prices;
	}
	
}
