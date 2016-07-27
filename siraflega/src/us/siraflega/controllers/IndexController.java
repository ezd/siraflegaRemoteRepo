package us.siraflega.controllers;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import us.siraflega.entities.Company;
import us.siraflega.entities.PostedJob;
import us.siraflega.services.PostedJobService;

@Controller
public class IndexController {
	private final int PAGE_HOLDING_CAPACITY=6;
	int pageNumber;
	@Autowired
	PostedJobService postedJobService;//
	@RequestMapping({"/index","/"})
	public String getIndex(Model model){
		int totalJobsSize=postedJobService.getPostedJobsSize();
		pageNumber=1;
		int totalPageSize=(totalJobsSize%PAGE_HOLDING_CAPACITY==0?totalJobsSize/PAGE_HOLDING_CAPACITY:((totalJobsSize-(totalJobsSize%PAGE_HOLDING_CAPACITY))/PAGE_HOLDING_CAPACITY)+1);
		model.addAttribute("totalPageSize", totalPageSize);
		List<PostedJob>postedJobs=postedJobService.getPostedJobs(pageNumber,PAGE_HOLDING_CAPACITY);
		for(PostedJob job:postedJobs)
			job.setDiscription(this.shortString(job.getDiscription()));
		model.addAttribute("pageNumber", pageNumber);
		model.addAttribute("postedJobs", postedJobs);
		model.addAttribute("catigory", "all");
		model.addAttribute("currentDate", new Date());
		if(totalPageSize<=10){
			model.addAttribute("startat", 1);
			model.addAttribute("endat", totalPageSize);
		}else{
			model.addAttribute("startat", 1);
			model.addAttribute("endat", 10);
		}
		return "index";
	}
	@RequestMapping(value="/jobPosts/{category}/{number}")
	public String pageJobs(Model model,@PathVariable("category") String category, @PathVariable("number") int pageNumber){
		int totalJobsSize=postedJobService.getPostedJobsSize(category);
//		pageNumber=pageNumber;
		int totalPageSize=(totalJobsSize%PAGE_HOLDING_CAPACITY==0?totalJobsSize/PAGE_HOLDING_CAPACITY:((totalJobsSize-(totalJobsSize%PAGE_HOLDING_CAPACITY))/PAGE_HOLDING_CAPACITY)+1);
		model.addAttribute("totalPageSize", totalPageSize);
		List<PostedJob>postedJobs=postedJobService.getPostedJobs(pageNumber,category,PAGE_HOLDING_CAPACITY);
		for(PostedJob job:postedJobs)
			job.setDiscription(this.shortString(job.getDiscription()));
		model.addAttribute("pageNumber", pageNumber);
		model.addAttribute("catigory", category);
		model.addAttribute("postedJobs", postedJobs);
		
		model.addAttribute("currentDate", new Date());
		if(totalPageSize<=10){
			model.addAttribute("startat", 1);
			model.addAttribute("endat", totalPageSize);
		}else{
			model.addAttribute("startat", 1);
			model.addAttribute("endat", 10);
		}
		return "index";
	}
	String shortString(String longString){
		String string="";
		String[] words=longString.split(" ");
		for(int i=0;i<(words.length>20?20:words.length);i++)
			string+=words[i]+" ";
		
		
		System.out.println("the string cutted:"+string);
		return string;
	}
	@RequestMapping(value = "/catigories", method = RequestMethod.GET)
	@ResponseBody
	public String getcatigories(HttpServletRequest req) {
		String query = req.getParameter("q");
		List<String> catigoryList = postedJobService.getcatigoriesContains(query);
		Gson gson = new Gson();
		System.out.println("raw value:" + req.getParameter("q"));
		String jsonstring = gson.toJson(catigoryList);
		System.out.println("the json value:" + jsonstring);
		return jsonstring;
	}
}
