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

//使用Spring的单元测试
//1.导入SpringTest模块
//2.@ContextConfiguration指定Spring配置文件的位置
//3.@RunWith(SpringJUnit4ClassRunner.class)
//4.直接Autowired要使用的组件
//测试dao层的工作

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
		//1.创建SpringIOC容器
		ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
		//2.从容器中获取mapper
		ProductMapper bean = (ProductMapper) ioc.getBean("ProductMapper.class");*/
	//System.out.println(productMapper);
	
	//插入几条数据
	//productMapper.insertSelective(new Product(null,"1",100,"1",1000,"1"));
	
	ProductMapper mapper = sqlSession.getMapper(ProductMapper.class);
	for(int i=0;i<1000;i++){
		String uid = UUID.randomUUID().toString().substring(0, 5)+i;
		mapper.insertSelective(new Product(null,uid,100,"1",1000,"product"+uid));
	}
	System.out.println("1");
	}
	
	
}
