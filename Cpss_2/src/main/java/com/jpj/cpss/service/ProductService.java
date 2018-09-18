package com.jpj.cpss.service;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jpj.cpss.bean.Coll;
import com.jpj.cpss.bean.CollExample;
import com.jpj.cpss.bean.Product;
import com.jpj.cpss.bean.ProductExample;
import com.jpj.cpss.bean.ProductExample.Criteria;
import com.jpj.cpss.dao.CollMapper;

import com.jpj.cpss.dao.ProductMapper;

@Service
public class ProductService {

	@Autowired
	ProductMapper productMapper;
	
	@Autowired
	CollMapper collMapper;
	/**
	 * 组合查询    （条件查询   排序）
	 * @param order_by
	 * @param coll_flag 
	 * @param loginname 
	 * @return
	 */
	public List<Product> getAllBy(String order_by,String select_type,String select_text, String coll_flag, String loginname) {
		if (coll_flag.equals("no")) {
			if (order_by.equals("ASC")) {
				if ("productId".equals(select_type)) {
					int id = Integer.parseInt(select_text);
					ProductExample example = new ProductExample();
					Criteria criteria = example.createCriteria();
					criteria.andProductIdEqualTo(id);
					example.setOrderByClause("product_price ASC");
					return productMapper.selectByExample(example);
				} else if ("productName".equals(select_type)) {
					ProductExample example = new ProductExample();
					Criteria criteria = example.createCriteria();
					// criteria.andProductNameEqualTo(select_text);
					criteria.andProductNameLike("%" + select_text + "%");
					example.setOrderByClause("product_price ASC");
					return productMapper.selectByExample(example);
				} else if ("productGenre".equals(select_type)) {
					ProductExample example = new ProductExample();
					Criteria criteria = example.createCriteria();
					// criteria.andProductGenreEqualTo(select_text);
					criteria.andProductGenreLike("%" + select_text + "%");
					example.setOrderByClause("product_price ASC");
					return productMapper.selectByExample(example);
				} else {
					ProductExample example = new ProductExample();
					Criteria criteria = example.createCriteria();
					example.setOrderByClause("product_price ASC");
					return productMapper.selectByExample(example);
				}

			} else if (order_by.equals("DESC")) {
				if ("productId".equals(select_type)) {
					int id = Integer.parseInt(select_text);
					ProductExample example = new ProductExample();
					Criteria criteria = example.createCriteria();
					criteria.andProductIdEqualTo(id);
					example.setOrderByClause("product_price DESC");
					return productMapper.selectByExample(example);
				} else if ("productName".equals(select_type)) {
					ProductExample example = new ProductExample();
					Criteria criteria = example.createCriteria();
					// criteria.andProductNameEqualTo(select_text);
					criteria.andProductNameLike("%" + select_text + "%");
					example.setOrderByClause("product_price DESC");
					return productMapper.selectByExample(example);
				} else if ("productGenre".equals(select_type)) {
					ProductExample example = new ProductExample();
					Criteria criteria = example.createCriteria();
					// criteria.andProductGenreEqualTo(select_text);
					criteria.andProductGenreLike("%" + select_text + "%");
					example.setOrderByClause("product_price DESC");
					return productMapper.selectByExample(example);
				} else {
					ProductExample example = new ProductExample();
					Criteria criteria = example.createCriteria();
					example.setOrderByClause("product_price DESC");
					return productMapper.selectByExample(example);
				}

			} else {
				if (!select_text.equals("no")) {
					if ("productId".equals(select_type)) {
						int id = Integer.parseInt(select_text);
						ProductExample example = new ProductExample();
						Criteria criteria = example.createCriteria();
						criteria.andProductIdEqualTo(id);
						return productMapper.selectByExample(example);
					} else if ("productName".equals(select_type)) {
						ProductExample example = new ProductExample();
						Criteria criteria = example.createCriteria();
						// criteria.andProductNameEqualTo(select_text);
						criteria.andProductNameLike("%" + select_text + "%");
						return productMapper.selectByExample(example);
					} else if ("productGenre".equals(select_type)) {
						ProductExample example = new ProductExample();
						Criteria criteria = example.createCriteria();
						criteria.andProductGenreLike("%" + select_text + "%");
						// criteria.andProductGenreEqualTo(select_text);
						return productMapper.selectByExample(example);
					} else {
						return productMapper.selectByExample(null);
					}
				} else {
					return productMapper.selectByExample(null);
				}
			}
		}else{
			
			CollExample example1 = new CollExample();
			com.jpj.cpss.bean.CollExample.Criteria criteria1 = example1.createCriteria();
			criteria1.andLoginnameEqualTo(loginname);
			List<Coll> colls = collMapper.selectByExample(example1);
			List<String> strs = new ArrayList<String>();
			
			for (int i = 0; i < colls.size(); i++) {

				strs.add(i, colls.get(i).getProductName());
				
			}
			if(order_by.equals("ASC")){
				if("productId".equals(select_type)){
					int id= Integer.parseInt(select_text);
					ProductExample example = new ProductExample();
					Criteria criteria = example.createCriteria();
					criteria.andProductIdEqualTo(id).andProductNameIn(strs);
					example.setOrderByClause("product_price ASC"); 
					return productMapper.selectByExample(example);
				}else if("productName".equals(select_type)){
					ProductExample example = new ProductExample();
					Criteria criteria = example.createCriteria();
				//	criteria.andProductNameEqualTo(select_text);
					criteria.andProductNameLike("%"+select_text+"%").andProductNameIn(strs);;
					example.setOrderByClause("product_price ASC"); 
					return productMapper.selectByExample(example);
				}else if("productGenre".equals(select_type)){
					ProductExample example = new ProductExample();
					Criteria criteria = example.createCriteria();
				//	criteria.andProductGenreEqualTo(select_text);
					criteria.andProductGenreLike("%"+select_text+"%").andProductNameIn(strs);;
					example.setOrderByClause("product_price ASC"); 
					return productMapper.selectByExample(example);
				}else{
					ProductExample example = new ProductExample();
					Criteria criteria = example.createCriteria();
					example.setOrderByClause("product_price ASC");
					criteria.andProductNameIn(strs);
					return productMapper.selectByExample(example);
				}
				
			}else if(order_by.equals("DESC")){
				if("productId".equals(select_type)){
					int id= Integer.parseInt(select_text);
					ProductExample example = new ProductExample();
					Criteria criteria = example.createCriteria();
					criteria.andProductIdEqualTo(id).andProductNameIn(strs);
					example.setOrderByClause("product_price DESC"); 
					return productMapper.selectByExample(example);
				}else if("productName".equals(select_type)){
					ProductExample example = new ProductExample();
					Criteria criteria = example.createCriteria();
//					criteria.andProductNameEqualTo(select_text);
					criteria.andProductNameLike("%"+select_text+"%").andProductNameIn(strs);
					example.setOrderByClause("product_price DESC"); 
					return productMapper.selectByExample(example);
				}else if("productGenre".equals(select_type)){
					ProductExample example = new ProductExample();
					Criteria criteria = example.createCriteria();
					//criteria.andProductGenreEqualTo(select_text);
					criteria.andProductGenreLike("%"+select_text+"%").andProductNameIn(strs);
					example.setOrderByClause("product_price DESC"); 
					return productMapper.selectByExample(example);
				}else{
					ProductExample example = new ProductExample();
					Criteria criteria = example.createCriteria();
					criteria.andProductNameIn(strs);
					example.setOrderByClause("product_price DESC"); 
					return productMapper.selectByExample(example);
				}

			}else{
				if(!select_text.equals("no")){
					if("productId".equals(select_type)){
						int id= Integer.parseInt(select_text);
						ProductExample example = new ProductExample();
						Criteria criteria = example.createCriteria();
						criteria.andProductIdEqualTo(id).andProductNameIn(strs);
						return productMapper.selectByExample(example);
					}else if("productName".equals(select_type)){
						ProductExample example = new ProductExample();
						Criteria criteria = example.createCriteria();
//						criteria.andProductNameEqualTo(select_text);
						criteria.andProductNameLike("%"+select_text+"%").andProductNameIn(strs);
						return productMapper.selectByExample(example);
					}else if("productGenre".equals(select_type)){
						ProductExample example = new ProductExample();
						Criteria criteria = example.createCriteria();
						criteria.andProductGenreLike("%"+select_text+"%").andProductNameIn(strs);
						//criteria.andProductGenreEqualTo(select_text);
						return productMapper.selectByExample(example);
					}else{
						return productMapper.selectByExample(null);
					}
				}
				else{
					ProductExample example = new ProductExample();
					Criteria criteria = example.createCriteria();
					criteria.andProductNameIn(strs);
					return productMapper.selectByExample(example);
				}
			}
		}
		
	}
	
	/*
	 * 
	 * 查询所有信息
	 */
	public List<Product> getAll() {
		return productMapper.selectByExample(null);
	}

	/**
	 * 查询所有种类
	 * @return
	 */
	public List<String> getAllProsGenre() {

		return productMapper.getAllProsGenre();
	}
	

	/**
	 * 产品信息保存
	 * @param product
	 */
	public void savePro(Product product) {
		// TODO Auto-generated method stub
		productMapper.insertSelective(product);
	}

	
	/**
	 * 检验产品名称是否重复
	 * @param proName
	 * @return true 代表可用
	 */
	public boolean checkProName(String proName) {
		ProductExample example = new ProductExample();
		Criteria criteria = example.createCriteria();
		criteria.andProductNameEqualTo(proName);
		long count = productMapper.countByExample(example);
		return count == 0;
	}

	/**
	 * 按照员工ID查询员工
	 * @param id
	 * @return
	 */
	public Product getPro(Integer id) {
		Product product = productMapper.selectByPrimaryKey(id);
		return product;
	}


	/**
	 * 员工更新
	 * @param product
	 */
	public void updatePro(Product product) {
		productMapper.updateByPrimaryKeySelective(product);
		
	}

	/**
	 * 产品删除 
	 * @param id
	 */
	public void delectProduct(Integer productId) {
		productMapper.deleteByPrimaryKey(productId);
		
	}

	/**
	 * 批量删除
	 * @param productIds
	 */
	public void deteleBatch(List<Integer> productIds) {
		ProductExample example = new ProductExample();
		Criteria criteria = example.createCriteria();
		//delect from xxx where product_id in(1,2,3,)
		criteria.andProductIdIn(productIds);
		productMapper.deleteByExample(example);
		
	}


	/**
	 * 根据名称查询价格
	 * @param productName
	 * @return
	 */
	public List<Product> getAllprice(String productName) {
		ProductExample example = new ProductExample();
		Criteria criteria = example.createCriteria();
		//delect from xxx where product_id in(1,2,3,)
		criteria.andProductNameEqualTo(productName);
		List<Product> list = productMapper.selectByExample(example);
		return list;
	}


	/**
	 *根据产品名称   订单数量修改产品数量
	 * @param proNum
	 * @param proName
	 */
	public void updateProNum(Integer proNum,String proName) {
		
		productMapper.updateProNum(proNum,proName);	
	}

	

	

}
