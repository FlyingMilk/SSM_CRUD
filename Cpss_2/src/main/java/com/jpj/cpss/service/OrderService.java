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

	//����ɾ��
	public void delectOrder(Integer orderId) {
		orderMapper.deleteByPrimaryKey(orderId);
	}

	/**
	 * ����ɾ��
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
		//�Զ����ѯ����
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

	/**  ��ʵ����Ҫ   �����������CASCADE����
	 * ɾ����Ʒ��ʱ��ͬʱ�������Ʒ�������ɾ����ض���
	 * ����Ա��Ʒ����ɾ��
	 * @param productName
	 */
	public void deleteByName(String productName) {
		OrderExample example = new OrderExample();
		Criteria criteria = example.createCriteria();
		criteria.andProductNameEqualTo(productName);
		orderMapper.deleteByExample(example);
		
	}

	
	/**
	 * ɾ���û�ʱ�����û��� ��ѯ�������ȡ��ض�������Ʒ���ƺ���Ʒ�������������Ʒ�����Ʒ���� 
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
	 * �������෵�������ĺ�
	 * @return
	 */
	public List<Integer> selectnumbyname() {
		List<Integer> sum  = orderMapper.countNumByName();
		return sum;
	}
	
	/**
	 * �������෵������
	 * @return
	 */
	public List<String> selectnamebyname() {
		List<String> names  = orderMapper.countNameByName();
		return names;
	}
	
	/**
	 * �������෵�������ĺ�
	 * @return
	 */
	public List<Integer> selectnumbygen() {
		List<Integer> sum  = orderMapper.countNumByGen();
		return sum;
	}
	
	/**
	 * �������෵������
	 * @return
	 */
	public List<String> selectnamebygen() {
		List<String> names  = orderMapper.countNameByGen();
		return names;
	}
	
	/**
	 * �������Ʒ��ؼ۸�
	 * @return
	 */
	public List<Integer> selectpricebyname() {
		List<Integer> prices  = orderMapper.selectpricebyname();
		return prices;
	}
	
}
