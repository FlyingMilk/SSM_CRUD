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
	 * ע����������ͨ�û�
	 * @param users
	 * @param result
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/registeruser",method=RequestMethod.POST)	
	public Msg saveregister(@Valid Users users,BindingResult result){
		if(result.hasErrors()){
			//У��ʧ�ܣ�����ʧ�ܣ���ģ̬������ʾ������Ϣ
			Map<String, Object> map = new HashMap<>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				System.out.println("������ֶ�����"+fieldError.getField());
				System.out.println("������Ϣ��"+fieldError.getDefaultMessage());
				map.put(fieldError.getField(),fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}else{
		userService.saveUser(users);
			return Msg.success();
		}
	}
	
	/*
	 * �����˺Ų�ѯ���� ��ͨ�û����� �޸�����ʱ
	 */
	@ResponseBody
	@RequestMapping(value="/selectmypsd",method=RequestMethod.GET)
	public String selectMypsd(@RequestParam(value = "loginname") String loginname){
		List<Users> list = userService.selectMypsd(loginname);
		String psd = list.get(0).getPassword();
		return psd;
	}
	
	/**
	 * �޸��û�����   �ҵ���Ϣ����
	 * �༭����
	 * @param user
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/myinfo",method=RequestMethod.POST)
	public Msg saveUser(@RequestParam(value = "password") String password,
			@RequestParam(value = "loginname") String loginname) {
		//System.out.println("��Ҫ�޸ĵ�Ա�����ݣ�"+product);
				userService.updateUserPsd(password,loginname);
				return Msg.success();
	}
	
	
	/**
	 * ��ȡ�û��˺���Ϣ
	 * ���� -��� ����
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/loginnames")
	public Msg getAllUsers(){
		List<Users> list = userService.getAllUsers();
		return Msg.success().add("Users", list);
	}
	/**
	 * ����idɾ���û� 
	 * ɾ������
	 * @param id
	 * @return
	 */
	//@PathVariable��������ӳ��URL�е�ռλ����Ŀ�귽���Ĳ�����
	@ResponseBody
	@RequestMapping(value="/user/{ids}",method=RequestMethod.DELETE)
	public Msg deleteUserById(@PathVariable("ids") String ids){
		//����ɾ��
				if(ids.contains("-")){
					List<Integer> del_ids = new ArrayList<>();
					String[] str_ids = ids.split("-");
					//��װid�ļ���		
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
	 * �޸��û���Ϣ
	 * �༭����
	 * @param user
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/user/{id}",method=RequestMethod.PUT)
	public Msg saveUser(Users user) {
		//System.out.println("��Ҫ�޸ĵ�Ա�����ݣ�"+product);
				userService.updateUser(user);
				return Msg.success();
	}
	/*
	 * ����id��ȡ�û���Ϣ
	 * �༭����
	 */
	@RequestMapping(value="/user/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getUser(@PathVariable("id")Integer id){
		Users user = userService.getUser(id);
		return Msg.success().add("user", user);
	}
	
	/**
	 * �����û�����
	 * ��ӽ���
	 * @param users
	 * @param result
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/users",method=RequestMethod.POST)	
	public Msg saveuser(@Valid Users users,BindingResult result){
		if(result.hasErrors()){
			//У��ʧ�ܣ�����ʧ�ܣ���ģ̬������ʾ������Ϣ
			Map<String, Object> map = new HashMap<>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				System.out.println("������ֶ�����"+fieldError.getField());
				System.out.println("������Ϣ��"+fieldError.getDefaultMessage());
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
	 * ��ѯ�����û���Ϣ
	 */
	@RequestMapping("/allusers")
	@ResponseBody
	public Msg getgetProductsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
		// ����PageHelper��ҳ���
		// ֻ��Ҫ�ڲ�ѯ֮ǰ���ã�����ҳ�룬ҳ���С
		PageHelper.startPage(pn, 6);
		// startPage��������������ѯ����һ����ҳ��ѯ
		List<Users> users = userService.getAll();
		// ��PageInfo�Խ�����а�װ��ֻ��Ҫ��PageInfo����ҳ��Ϳ���,
		// PageInfo��װ����ϸ�ķ�ҳ��Ϣ��������ѯ������,����������ʾ��ҳ��
		PageInfo page = new PageInfo(users,5);
		return Msg.success().add("pageInfo",page);
	}

	/**
	 * ��¼ʱ��ѯ�˺���Ϣ
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
	 * ���ʱ��ѯ�˺���Ϣ
	 * @param loginname
	 * @param password
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/checkuseradd")
	public Msg checkuseradd(@RequestParam("loginname")String loginname){
		String 	regex = "(^[a-zA-Z0-9_-]{5,16}$)|(^[\u2E80-\u9FFF]{2,10})";
		if(!loginname.matches(regex)){
			return Msg.fail().add("va_msg", "�˺Ÿ�ʽΪ5-16λӢ�ģ����ֻ�2-10λ���ģ�");
		}
		boolean b = userService.checkUserAdd(loginname);
		if(!b){
			return Msg.fail().add("va_msg", "�˺��Ѵ��ڣ�");
		}else{
			return Msg.success();
		}
	}
	
	
	/**
	 * ��ת�������Ա������
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
	 * ��ת������ͨ�û�������
	 * @return
	 */
	@RequestMapping("/usermain")
	public String userlogincheck(){
		return "usermain";
	}
	
	/**
	 * ��ת����ע�����
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
	 * ������Ʒexcel��
	 */
	@RequestMapping(value = "/userdownLoadExcel", method = RequestMethod.GET)
    public String downLoadExcel(HttpServletRequest request, HttpServletResponse response) throws IOException{
		List<Users>  listAll = userService.getAll();
        if (listAll != null && listAll.size() > 0) {
            String fileName = "�û���.xls";
            response.setHeader("Content-disposition", "attachment;filename="
                    + new String(fileName.getBytes("gb2312"), "ISO8859-1"));//�����ļ�ͷ�����ʽ
            response.setContentType("APPLICATION/OCTET-STREAM;charset=UTF-8");//��������
            response.setHeader("Cache-Control", "no-cache");//����ͷ
            response.setDateHeader("Expires", 0);//��������ͷ

            HSSFWorkbook userworkbook = new HSSFWorkbook();

            HSSFSheet usersheet = userworkbook.createSheet();
            CellStyle cellStyle = userworkbook.createCellStyle();

            cellStyle.setDataFormat(userworkbook.createDataFormat().getFormat("yyyy-MM-dd HH:mm:ss"));

            
            // ��������
            HSSFFont font = userworkbook.createFont();
            font.setFontHeightInPoints((short) 20); //����߶�
            font.setColor(HSSFFont.COLOR_RED); //������ɫ
            font.setFontName("����"); //����
            font.setItalic(true); //�Ƿ�ʹ��б��
     
            usersheet.setColumnWidth(0, 2000);
            usersheet.setColumnWidth(1, 3000);
            usersheet.setColumnWidth(2, 2000);
            usersheet.setColumnWidth(3, 5000);
            usersheet.setColumnWidth(4, 3000);

            String[] title = {"ID","�˺�","����","��������","Ȩ��"};
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
