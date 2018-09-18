package com.jpj.cpss.controller;


import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import javax.validation.constraints.Max;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jpj.cpss.bean.Msg;
import com.jpj.cpss.bean.Product;
import com.jpj.cpss.bean.Users;
import com.jpj.cpss.service.UserService;



@Controller
@SessionAttributes("seuser")
public class UserController {

	@Autowired
	UserService userService;

	/**
	 * 注册界面添加普通用户
	 * @param users
	 * @param result
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/registeruser",method=RequestMethod.POST)	
	public Msg saveregister(@Valid Users users,BindingResult result){
		if(result.hasErrors()){
			//校验失败，返回失败，在模态框中显示错误信息
			Map<String, Object> map = new HashMap<>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				System.out.println("错误的字段名："+fieldError.getField());
				System.out.println("错误信息："+fieldError.getDefaultMessage());
				map.put(fieldError.getField(),fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}else{
		userService.saveUser(users);
			return Msg.success();
		}
	}
	
	/*
	 * 根据账号查询密码 普通用户界面 修改密码时
	 */
	@ResponseBody
	@RequestMapping(value="/selectmypsd",method=RequestMethod.GET)
	public String selectMypsd(@RequestParam(value = "loginname") String loginname){
		List<Users> list = userService.selectMypsd(loginname);
		String psd = list.get(0).getPassword();
		return psd;
	}
	
	/**
	 * 修改用户密码   我的信息界面
	 * 编辑界面
	 * @param user
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/myinfo",method=RequestMethod.POST)
	public Msg saveUser(@RequestParam(value = "password") String password,
			@RequestParam(value = "loginname") String loginname) {
		//System.out.println("将要修改的员工数据："+product);
				userService.updateUserPsd(password,loginname);
				return Msg.success();
	}
	
	
	/**
	 * 获取用户账号信息
	 * 订单 -添加 界面
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/loginnames")
	public Msg getAllUsers(){
		List<Users> list = userService.getAllUsers();
		return Msg.success().add("Users", list);
	}
	/**
	 * 根据id删除用户 
	 * 删除界面
	 * @param id
	 * @return
	 */
	//@PathVariable可以用来映射URL中的占位符到目标方法的参数中
	@ResponseBody
	@RequestMapping(value="/user/{ids}",method=RequestMethod.DELETE)
	public Msg deleteUserById(@PathVariable("ids") String ids){
		//批量删除
				if(ids.contains("-")){
					List<Integer> del_ids = new ArrayList<>();
					String[] str_ids = ids.split("-");
					//组装id的集合		
					for(String id : str_ids){
						del_ids.add(Integer.parseInt(id));
					}
					userService.deteleBatch(del_ids);
				}else{
					Integer id = Integer.parseInt(ids);
					userService.delectUser(id);
					
				}
				return Msg.success();
	}
	/**
	 * 修改用户信息
	 * 编辑界面
	 * @param user
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/user/{id}",method=RequestMethod.PUT)
	public Msg saveUser(Users user) {
		//System.out.println("将要修改的员工数据："+product);
				userService.updateUser(user);
				return Msg.success();
	}
	/*
	 * 根据id获取用户信息
	 * 编辑界面
	 */
	@RequestMapping(value="/user/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getUser(@PathVariable("id")Integer id){
		Users user = userService.getUser(id);
		return Msg.success().add("user", user);
	}
	
	/**
	 * 保存用户数据
	 * 添加界面
	 * @param users
	 * @param result
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/users",method=RequestMethod.POST)	
	public Msg saveuser(@Valid Users users,BindingResult result){
		if(result.hasErrors()){
			//校验失败，返回失败，在模态框中显示错误信息
			Map<String, Object> map = new HashMap<>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				System.out.println("错误的字段名："+fieldError.getField());
				System.out.println("错误信息："+fieldError.getDefaultMessage());
				map.put(fieldError.getField(),fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}else{
		userService.saveUser(users);
		return Msg.success();
		}
	}

	@RequestMapping("/login")
	public ModelAndView listCategory() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("login");
		return mav;
	}
	
	@RequestMapping("/user/selectUser")
	 public String selectUser(){
		return "user/userselect";
		
	}
	
	
	@RequestMapping("/user/selectMyInfo")
	 public String selectMyInfo(){
		return "user/myinfo";
		
	}
	/*
	 * 查询所有用户信息
	 */
	@RequestMapping("/allusers")
	@ResponseBody
	public Msg getgetProductsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
		// 引入PageHelper分页插件
		// 只需要在查询之前调用，传入页码，页面大小
		PageHelper.startPage(pn, 6);
		// startPage后面紧跟的这个查询就是一个分页查询
		List<Users> users = userService.getAll();
		// 用PageInfo对结果进行包装，只需要将PageInfo交给页面就可以,
		// PageInfo封装了详细的分页信息，包括查询的数据,传入连续显示的页数
		PageInfo page = new PageInfo(users,5);
		return Msg.success().add("pageInfo",page);
	}

	/**
	 * 登录时查询账号信息
	 * @param loginname
	 * @param password
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/checkUser")
	public Msg checkuser(@RequestParam("loginname")String loginname,@RequestParam("password")String password
			,@RequestParam("username")String username ,Model model,HttpSession session){
		boolean b = userService.checkUser(loginname,password,username);
		int sum = 0;
		if(!b){
			Users seuser = new Users();
			seuser.setLoginname(loginname);
			seuser.setUsername(username);
			String sessionkey = ""+sum;
			String string = "";
			session.setAttribute("seuser", seuser);
		/*	while(session.getAttributeNames().hasMoreElements())
			 {string = session.getAttributeNames().nextElement();
			System.out.println(string);}*/
			
			sum++;
			return Msg.success();
			
 		}else{
			return Msg.fail();
		}
	}
	

	/**
	 * 添加时查询账号信息
	 * @param loginname
	 * @param password
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/checkuseradd")
	public Msg checkuseradd(@RequestParam("loginname")String loginname){
		String 	regex = "(^[a-zA-Z0-9_-]{5,16}$)|(^[\u2E80-\u9FFF]{2,10})";
		if(!loginname.matches(regex)){
			return Msg.fail().add("va_msg", "账号格式为5-16位英文，数字或2-10位中文！");
		}
		boolean b = userService.checkUserAdd(loginname);
		if(!b){
			return Msg.fail().add("va_msg", "账号已存在！");
		}else{
			return Msg.success();
		}
	}
	
	
	/**
	 * 跳转进入管理员主界面
	 * @return
	 */
	@RequestMapping("/main")
	public String logincheck(){
		return "main";
	}
	
	@RequestMapping("/logout")
	public String logout(){
		return "logout";
	}
	
	/**
	 * 跳转进入普通用户主界面
	 * @return
	 */
	@RequestMapping("/usermain")
	public String userlogincheck(){
		return "usermain";
	}
	
	/**
	 * 跳转进入注册界面
	 * @return
	 */
	@RequestMapping("/register")
	public String showregister(){
		return "register";
	}
	
	@RequestMapping("/loginFrom")
	public String login(@RequestParam(value = "loginname", required = false) String loginname,
			@RequestParam(value = "password", required = false) String password) {
		int num = 0;
		List<Users> users = userService.getAll();
		for (int i = 0; i < users.size(); i++) {
			if (users.get(i).getPassword().equals(password) && users.get(i).getLoginname().equals(loginname)) {
				num++;
			}
		}
		if (num != 0) {
			return "success";
		} else {

			return "false";
		}
	}
	
	
	/*
	 * 导出产品excel表
	 */
	@RequestMapping(value = "/userdownLoadExcel", method = RequestMethod.GET)
    public String downLoadExcel(HttpServletRequest request, HttpServletResponse response) throws IOException{
		List<Users>  listAll = userService.getAll();
        if (listAll != null && listAll.size() > 0) {
            String fileName = "用户表.xls";
            response.setHeader("Content-disposition", "attachment;filename="
                    + new String(fileName.getBytes("gb2312"), "ISO8859-1"));//设置文件头编码格式
            response.setContentType("APPLICATION/OCTET-STREAM;charset=UTF-8");//设置类型
            response.setHeader("Cache-Control", "no-cache");//设置头
            response.setDateHeader("Expires", 0);//设置日期头

            HSSFWorkbook userworkbook = new HSSFWorkbook();

            HSSFSheet usersheet = userworkbook.createSheet();
            CellStyle cellStyle = userworkbook.createCellStyle();

            cellStyle.setDataFormat(userworkbook.createDataFormat().getFormat("yyyy-MM-dd HH:mm:ss"));

            
            // 设置字体
            HSSFFont font = userworkbook.createFont();
            font.setFontHeightInPoints((short) 20); //字体高度
            font.setColor(HSSFFont.COLOR_RED); //字体颜色
            font.setFontName("黑体"); //字体
            font.setItalic(true); //是否使用斜体
     
            usersheet.setColumnWidth(0, 2000);
            usersheet.setColumnWidth(1, 3000);
            usersheet.setColumnWidth(2, 2000);
            usersheet.setColumnWidth(3, 5000);
            usersheet.setColumnWidth(4, 3000);

            String[] title = {"ID","账号","密码","创建日期","权限"};
            HSSFRow firstrow = usersheet.createRow(0);
			for(int i = 0;i<title.length;i++){
				HSSFCell cell=firstrow.createCell(i);
				cell .setCellValue(title[i]);
			}
			
            int rowNum = 1;
            for (Users user:listAll) {
                Row row = usersheet.createRow(rowNum);

                Cell cell = row.createCell(0);
                cell.setCellValue(user.getId());

                Cell cell1 = row.createCell(1);
                cell1.setCellValue(user.getLoginname());

                Cell cell2 = row.createCell(2);
                cell2.setCellValue(user.getPassword());

                Cell cell3 = row.createCell(3);
                

                DateFormat df = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
                cell3.setCellValue(df.format(user.getCreatedate()));

                Cell cell4 = row.createCell(4);
                cell4.setCellValue(user.getUsername());

                rowNum++;
            }

            userworkbook.write(response.getOutputStream());

            response.getOutputStream().flush();
            response.getOutputStream().close();
        }
        return null;
    }
}
