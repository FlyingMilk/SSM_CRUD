package com.jpj.cpss.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.github.pagehelper.PageInfo;
import com.jpj.cpss.bean.Product;

//使用Spring测试模块提供的测试请求功能，测试请求的正确性

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations={"classpath:applicationContext.xml","file:src/main/webapp/WEB-INF/mvc-dispatcher-servlet.xml"})
public class MvcTest {
	
	//传入Springmvc的ioc
	@Autowired
	WebApplicationContext context;
	//虚拟mvc请求，获取处理结果
	MockMvc mockMvc;
	
	@Before
	public void initMockMvc(){
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();		
	}
	@Test
	public void testPage() throws Exception{
		//模拟请求，拿到返回值
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/products").param("pn","5")).andReturn();
		//请求成功后，请求域中会有PageInfo,我们可以取出PageInfo进行验证
		MockHttpServletRequest request = result.getRequest();
		PageInfo pi = (PageInfo) request.getAttribute("pageInfo");
		System.out.println("当前页码：" + pi.getPageNum());
		System.out.println("总页码：" + pi.getPages());
		System.out.println("总记录数：" + pi.getTotal());
		System.out.println("在页面连续显示的页码" );
		int[] nums = pi.getNavigatepageNums();
		for(int i : nums){
			System .out.print(" "+ i);
		}
		//获取产品数据
		List<Product> list = pi.getList();
		for(Product product : list){
			System.out.println("id"+product.getProductId()+"==>name"+product.getProductName());
		}
			
	}

}
