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
	 * ��ѯ�����û���Ϣ
	 * @return
	 */
	public List<Users> list() {
		// TODO Auto-generated method stub
		return usersMapper.selectByExample(null);
	}
	
	/**
	 * ��¼ʱ��ѯ�˺���Ϣ
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
	 * ���ʱ��ѯ�˺���Ϣ
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
	 * �û����±���
	 * @param user
	 */
	public void updateUser(Users user) {
		usersMapper.updateByPrimaryKeySelective(user);
		
	}

	/**
	 * ����idɾ��
	 * @param id
	 */
	public void delectUser(Integer id) {
		usersMapper.deleteByPrimaryKey(id);
		
	}
	/**
	 * ����ɾ��
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
	 * ��ѯ������ͨ�û�
	 * @return
	 */
	public List<Users> getAllUsers() {
		UsersExample usersExample = new UsersExample();  
	    Criteria criteria = usersExample.createCriteria();
	    criteria.andUsernameEqualTo("��ͨ�û�");
		List<Users> list = usersMapper.selectByExample(usersExample);
		return list;
	}

	/**
	 * ��ѯ�����û�
	 * @return
	 */
	public List<Users> getAll() {
		List<Users> list = usersMapper.selectByExample(null);
		return list;
	}

	/**
	 * ��������   ��ͨ�û�����
	 * @param password
	 * @param loginname
	 */
	public void updateUserPsd(String password, String loginname) {
		usersMapper.updateByLoginname(password, loginname);
		
	}

	/**
	 * �����˺Ų�ѯ���� ��ͨ�û����� �޸�����ʱ
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

