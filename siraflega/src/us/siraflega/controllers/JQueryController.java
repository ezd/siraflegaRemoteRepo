package us.siraflega.controllers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonParser;

import us.siraflega.entities.User;
import us.siraflega.services.UserService;

@Controller
public class JQueryController {
	@RequestMapping("/jquery")
	public String getJQueryPage(){
		return "jquery";
	}
	@Autowired
	UserService userService;
	@RequestMapping(value="/jqusers",method=RequestMethod.GET,produces="application/json")
	public @ResponseBody String  getUsersList(Model model) {
		List<User> usersList = userService.getAllUsers();
	    List<HashMap<String, String>> objList=new ArrayList<HashMap<String, String>>();
		for(User usr:usersList){
			HashMap<String, String> obj=new HashMap<String, String>();
	        	obj.put("userName", usr.getUserName());
	        	obj.put("password", usr.getPassword());
	        	obj.put("id", usr.getId()+"");
	        	objList.add(obj);
		}
				Gson gson = new Gson();
		 String jsonUsersList = gson.toJson(objList);
		 return jsonUsersList;
	}
	@RequestMapping(value="/jqusers",method=RequestMethod.POST,produces="application/json")
	public @ResponseBody String  saveUser(@RequestBody String jsonUser) {
		Gson gson = new Gson();
		User user =(User)gson.fromJson(jsonUser, User.class);
		user.setEmail("biliyala.ezd2@gmail.com");
	try {
		userService.saveUser(user, "Employee");
		HashMap<String, String> normalObj = new HashMap<String, String>();
		 normalObj.put("userName", user.getUserName());
		 normalObj.put("password", user.getPassword());
		 List<HashMap<String, String>> objList=new ArrayList<HashMap<String, String>>();
		 objList.add(normalObj);
		String convertedJsonObject=gson.toJson(objList);
		 return convertedJsonObject;
	} catch (Exception e) {
			return "faile";
	}
		
	}
	@RequestMapping(value="/jqusers{id}",method=RequestMethod.GET,produces="application/json")
	public @ResponseBody String  deleteUser(@RequestParam("id") int id) {
		try {
			userService.getDelete(id);
			return "deleted";
		} catch (Exception e) {
			return "not_deleted";
		}
			
		 
	}
	
}
