package us.siraflega.controllers;

import java.security.Principal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import us.siraflega.entities.Company;
import us.siraflega.entities.Education;
import us.siraflega.entities.Employee;
import us.siraflega.entities.Language;
import us.siraflega.entities.User;
import us.siraflega.entities.WorkExperience;
import us.siraflega.services.EducationService;
import us.siraflega.services.EmployeeService;
import us.siraflega.services.LanguageService;
import us.siraflega.services.UserService;

@Controller
public class EducationController {
	@Autowired
	EducationService educationService;
	@Autowired
	LanguageService languageService;
	@Autowired
	UserService userService;
	@Autowired
	EmployeeService employeeService;
	
	@RequestMapping(value="/educationInistitiute",method=RequestMethod.GET)
	@ResponseBody
	public String getExistingInistitution(HttpServletRequest req){
		String query=req.getParameter("q");
		List<String>existingInistituteList=educationService.getInistitutionList(query);
		Gson gson = new Gson();
		System.out.println("raw value:"+req.getParameter("q"));
		String jsonstring=gson.toJson(existingInistituteList);
		System.out.println("the json value:"+jsonstring);
		return jsonstring;
	}
	@RequestMapping(value="/saveEducation",method=RequestMethod.POST,produces="application/json")
	public @ResponseBody String saveEducation(@RequestBody String jsonEducation,Principal principal){
		System.out.println(jsonEducation+"Education .........................................................");
		String name = principal.getName();
		User user = userService.getUserByName(name);
		Employee employee=employeeService.getEmployeeBy(user.getEmail());
		JSONObject jsonObject=new JSONObject(jsonEducation);
		String inistitution=jsonObject.getString("inistitution");
		String level=jsonObject.getString("level");
		String title=jsonObject.getString("title");
		String startDate=jsonObject.getString("startDate");
		Date start_Date= null;
		try {
			start_Date = new SimpleDateFormat("dd/MM/yyyy", Locale.ENGLISH)
			.parse(startDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String endDate=jsonObject.getString("endDate");
		Date end_Date= null;
		try {
			end_Date = new SimpleDateFormat("dd/MM/yyyy", Locale.ENGLISH)
			.parse(endDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String remark=jsonObject.getString("remark");
		Education newEducation=new Education();
		newEducation.setEmployee(employee);
		newEducation.setEndDate(end_Date);
		newEducation.setStartDate(start_Date);
		newEducation.setRemark(remark);
		newEducation.setInstitute(inistitution);
		newEducation.setLevel(level);
		newEducation.setTitle(title);
		Education savedEducation=educationService.saveEducation(newEducation);
		jsonObject.put("institute", ""+savedEducation.getInstitute());
		jsonObject.put("id", ""+savedEducation.getId());
		jsonObject.put("level",savedEducation.getLevel());
		jsonObject.put("startDate",savedEducation.getStartDate()+"");
		jsonObject.put("endDate",savedEducation.getEndDate()+"");
		jsonObject.put("title",savedEducation.getTitle());
		jsonObject.put("remark",savedEducation.getRemark());
		return jsonObject.toString();
	}
	@RequestMapping(value="/updateEducation",method=RequestMethod.POST,produces="application/json")
	public @ResponseBody String updateEducation(@RequestBody String jsonEducation){
		System.out.println(jsonEducation+"Education .........................................................");
		JSONObject jsonObject=new JSONObject(jsonEducation);
		
		String educationId=jsonObject.getString("educationId");
		String inistitution=jsonObject.getString("inistitution");
		String level=jsonObject.getString("level");
		String title=jsonObject.getString("title");
		String startDate=jsonObject.getString("startDate");
		Date start_Date= null;
		try {
			start_Date = new SimpleDateFormat("dd/MM/yyyy", Locale.ENGLISH)
			.parse(startDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String endDate=jsonObject.getString("endDate");
		Date end_Date= null;
		try {
			end_Date = new SimpleDateFormat("dd/MM/yyyy", Locale.ENGLISH)
			.parse(endDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String remark=jsonObject.getString("remark");
		Education existingEducation=educationService.getEducationToEdit(Integer.parseInt(educationId));
		existingEducation.setEndDate(end_Date);
		existingEducation.setStartDate(start_Date);
		existingEducation.setRemark(remark);
		existingEducation.setInstitute(inistitution);
		existingEducation.setLevel(level);
		existingEducation.setTitle(title);
		Education savedEducation=educationService.saveEducation(existingEducation);
		jsonObject.put("institute", ""+savedEducation.getInstitute());
		jsonObject.put("id", ""+savedEducation.getId());
		jsonObject.put("level",savedEducation.getLevel());
		jsonObject.put("startDate",savedEducation.getStartDate()+"");
		jsonObject.put("endDate",savedEducation.getEndDate()+"");
		jsonObject.put("title",savedEducation.getTitle());
		jsonObject.put("remark",savedEducation.getRemark());
		return jsonObject.toString();
	}
//	deleteEducation
	@RequestMapping(value="/deleteEducation",method=RequestMethod.POST,produces="application/json")
	public @ResponseBody String deleteWorkExp(@RequestBody String jsonEducation){
		
		JSONObject jsonObject=new JSONObject(jsonEducation);
		String idToBeDeleted=jsonObject.getString("id");
		System.out.println("Id to be delete isssssssssssssssssss:"+idToBeDeleted);
		educationService.deleteEducation(Integer.parseInt(idToBeDeleted));
		return jsonObject.toString();
	}
	@RequestMapping(value="/saveLanguage",method=RequestMethod.POST,produces="application/json")
	public @ResponseBody String saveLanguage(@RequestBody String jsonLanguage,Principal principal){
		System.out.println(jsonLanguage+"Language .........................................................");
		String name = principal.getName();
		User user = userService.getUserByName(name);
		Employee employee=employeeService.getEmployeeBy(user.getEmail());
		JSONObject jsonObject=new JSONObject(jsonLanguage);
		String languageName=jsonObject.getString("languageName");
		String proficencyLevel=jsonObject.getString("languageLevel");
		Language newLanguage=new Language();
		newLanguage.setTalkedby(employee);
		newLanguage.setLevel(proficencyLevel);
		newLanguage.setName(languageName);
		Language savedLanguage=languageService.saveLanguage(newLanguage);
		jsonObject.put("id", ""+savedLanguage.getId());
		jsonObject.put("level",savedLanguage.getLevel());
		jsonObject.put("name",savedLanguage.getName());
		return jsonObject.toString();
	}
	
	@RequestMapping(value="/updateLanguage",method=RequestMethod.POST,produces="application/json")
	public @ResponseBody String updateLanguage(@RequestBody String jsonLanguage){
		System.out.println(jsonLanguage+"Language update .........................................................");
		JSONObject jsonObject=new JSONObject(jsonLanguage);
		String languageName=jsonObject.getString("languageName");
		String proficencyLevel=jsonObject.getString("languageLevel");
		String languageUpdateId=jsonObject.getString("languageId");
		Language existingLanguage=languageService.getExistingLanguage(Integer.parseInt(languageUpdateId));
		existingLanguage.setLevel(proficencyLevel);
		existingLanguage.setName(languageName);
		Language savedLanguage=languageService.saveLanguage(existingLanguage);
		jsonObject.put("id", ""+savedLanguage.getId());
		jsonObject.put("level",savedLanguage.getLevel());
		jsonObject.put("name",savedLanguage.getName());
		return jsonObject.toString();
	}
	
//	deleteEducation
	@RequestMapping(value="/deleteLanguage",method=RequestMethod.POST,produces="application/json")
	public @ResponseBody String deleteLanguage(@RequestBody String jsonLanguage){
		
		JSONObject jsonObject=new JSONObject(jsonLanguage);
		String idToBeDeleted=jsonObject.getString("id");
		System.out.println("Id to be delete isssssssssssssssssss:"+idToBeDeleted);
		languageService.deleteEducation(Integer.parseInt(idToBeDeleted));
		return jsonObject.toString();
	}
}
