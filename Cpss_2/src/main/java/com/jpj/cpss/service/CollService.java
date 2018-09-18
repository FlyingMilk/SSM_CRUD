package com.jpj.cpss.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jpj.cpss.bean.Coll;
import com.jpj.cpss.bean.CollExample;
import com.jpj.cpss.bean.CollExample.Criteria;
import com.jpj.cpss.bean.ProductExample;
import com.jpj.cpss.dao.CollMapper;

@Service
public class CollService {
	
	@Autowired
	CollMapper collMapper;

	public void saveCell(Coll coll) {
		collMapper.insert(coll);
		
	}

	public void deleteCell(String loginname, Integer productId) {
		CollExample example = new CollExample();
		Criteria criteria = example.createCriteria();
		criteria.andLoginnameEqualTo(loginname).andProductIdEqualTo(productId);
		collMapper.deleteByExample(example);
		
	}

	public long countCell(String loginname, Integer productId) {
		CollExample example = new CollExample();
		Criteria criteria = example.createCriteria();
		criteria.andLoginnameEqualTo(loginname).andProductIdEqualTo(productId);
		long num = collMapper.countByExample(example);
		return num;
		
	}

}
