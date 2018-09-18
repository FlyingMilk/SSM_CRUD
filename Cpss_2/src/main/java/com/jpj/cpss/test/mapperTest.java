package com.jpj.cpss.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.jpj.cpss.bean.Product;
import com.jpj.cpss.dao.ProductMapper;

//ʹ��Spring�ĵ�Ԫ����
//1.����SpringTestģ��
//2.@ContextConfigurationָ��Spring�����ļ���λ��
//3.@RunWith(SpringJUnit4ClassRunner.class)
//4.ֱ��AutowiredҪʹ�õ����
//����dao��Ĺ���

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class mapperTest {
	@Autowired
	ProductMapper productMapper;
	@Autowired
	SqlSession sqlSession;
	
	@Test
	public void testselect(){
		/*
		//1.����SpringIOC����
		ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
		//2.�������л�ȡmapper
		ProductMapper bean = (ProductMapper) ioc.getBean("ProductMapper.class");*/
	//System.out.println(productMapper);
	
	//���뼸������
	//productMapper.insertSelective(new Product(null,"1",100,"1",1000,"1"));
	
	ProductMapper mapper = sqlSession.getMapper(ProductMapper.class);
	for(int i=0;i<1000;i++){
		String uid = UUID.randomUUID().toString().substring(0, 5)+i;
		mapper.insertSelective(new Product(null,uid,100,"1",1000,"product"+uid));
	}
	System.out.println("1");
	}
	
	
}
