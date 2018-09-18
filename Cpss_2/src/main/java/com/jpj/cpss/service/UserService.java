package com.jpj.cpss.service;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jpj.cpss.bean.ProductExample;
import com.jpj.cpss.bean.Users;
import com.jpj.cpss.bean.UsersExample;
import com.jpj.cpss.bean.UsersExample.Criteria;
import com.jpj.cpss.dao.UsersMapper;

@Service
public class UserService {
	@Autowired
	UsersMapper usersMapper;
	
	/**
	 * 查询所有用户信息
	 * @return
	 */
	public List<Users> list() {
		// TODO Auto-generated method stub
		return usersMapper.selectByExample(null);
	}
	
	/**
	 * 登录时查询账号信息
	 * @param loginname
	 * @param password
	 * @param username 
	 * @return
	 */
	public boolean checkUser(String loginname,String password, String username){
		UsersExample example = new UsersExample();
		Criteria criteria = example.createCriteria();
		criteria.andLoginnameEqualTo(loginname).andPasswordEqualTo(password).andUsernameEqualTo(username);
		long count = usersMapper.countByExample(example);
		return count == 0;
	}
	
	/**
	 * 添加时查询账号信息
	 * @param loginname
	 * @param password
	 * @return
	 */
	public boolean checkUserAdd(String loginname){
		UsersExample example = new UsersExample();
		Criteria criteria = example.createCriteria();
		criteria.andLoginnameEqualTo(loginname);
		long count = usersMapper.countByExample(example);
		return count == 0;
	}

	public void saveUser(Users users) {
		usersMapper.insertSelective(users);	
	}

	public Users getUser(Integer id) {
		Users user = usersMapper.selectByPrimaryKey(id);
		return user;
		
	}

	/**
	 * 用户更新保存
	 * @param user
	 */
	public void updateUser(Users user) {
		usersMapper.updateByPrimaryKeySelective(user);
		
	}

	/**
	 * 根据id删除
	 * @param id
	 */
	public void delectUser(Integer id) {
		usersMapper.deleteByPrimaryKey(id);
		
	}
	/**
	 * 批量删除
	 * @param productIds
	 */
	public void deteleBatch(List<Integer> ids) {
		UsersExample example = new UsersExample();
		Criteria criteria = example.createCriteria();
		//delect from xxx where product_id in(1,2,3,)
		criteria.andIdIn(ids);
		usersMapper.deleteByExample(example);
		
	}

	/**
	 * 查询所有普通用户
	 * @return
	 */
	public List<Users> getAllUsers() {
		UsersExample usersExample = new UsersExample();  
	    Criteria criteria = usersExample.createCriteria();
	    criteria.andUsernameEqualTo("普通用户");
		List<Users> list = usersMapper.selectByExample(usersExample);
		return list;
	}

	/**
	 * 查询所有用户
	 * @return
	 */
	public List<Users> getAll() {
		List<Users> list = usersMapper.selectByExample(null);
		return list;
	}

	/**
	 * 更新密码   普通用户界面
	 * @param password
	 * @param loginname
	 */
	public void updateUserPsd(String password, String loginname) {
		usersMapper.updateByLoginname(password, loginname);
		
	}

	/**
	 * 根据账号查询密码 普通用户界面 修改密码时
	 * @param loginname
	 * @return
	 */
	public List<Users>  selectMypsd(String loginname) {
		UsersExample example = new UsersExample();
		Criteria criteria = example.createCriteria();
	    criteria.andLoginnameEqualTo(loginname);
	    List<Users> list = usersMapper.selectByExample(example);
		return list;
		
	}
}

