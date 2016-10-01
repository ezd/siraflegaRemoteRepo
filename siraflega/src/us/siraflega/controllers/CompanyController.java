package us.siraflega.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import us.siraflega.entities.Company;
import us.siraflega.services.CompanyService;

@Controller
public class CompanyController {
	
	@Autowired
	CompanyService companyService;
	
	@RequestMapping(value="/company/{companyId}", method=RequestMethod.GET)
	String getCampany(Model model,@PathVariable int companyId){
		System.out.println("it is comiiiiiiiiiiiiiiiiiiiiiiiiiiiiiing");
		
		Company company=companyService.getCompany(companyId);
		model.addAttribute("company",company);
		return "companypage";
	}
	
}
