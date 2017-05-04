package us.siraflega.controllers;

import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.google.gson.Gson;

import us.siraflega.entities.Company;
import us.siraflega.entities.PostedJob;
import us.siraflega.services.CompanyService;
import us.siraflega.services.PostedJobService;
import us.siraflega.services.UserService;

@Controller
public class IndexController {
	public static int timesvisited=100;
	private final int PAGE_HOLDING_CAPACITY = 8;
	int pageNumber;
	@Autowired
	PostedJobService postedJobService;//
	@Autowired
	CompanyService companyService;
	@Autowired
	UserService userService;

	@Autowired
	private ServletContext servletContext;
	//userService.getTimesvisited()
	@RequestMapping({ "/index", "/" })
	public String getIndex(Model model, HttpServletRequest request) {
		timesvisited=userService.updateTimevisitied();
		servletContext.setAttribute("timesvisited",timesvisited);
		pageNumber = 1;
		List<PostedJob> postedJobs = postedJobService.getPostedJobs(pageNumber, PAGE_HOLDING_CAPACITY);
		for (PostedJob job : postedJobs)
			job.setDiscription(this.shortString(job.getDiscription(), 20));

		model.addAttribute("pageNumber", pageNumber);
		model.addAttribute("postedJobs", postedJobs);
		model.addAttribute("catigory", "all");
		model.addAttribute("currentDate", new Date());
		List<String> positionList = postedJobService.getPositionList();
		model.addAttribute("positions", positionList);
		int totalJobsSize = postedJobService.getPostedJobsSize();
		int totalPageSize = (totalJobsSize % PAGE_HOLDING_CAPACITY == 0 ? totalJobsSize / PAGE_HOLDING_CAPACITY
				: ((totalJobsSize - (totalJobsSize % PAGE_HOLDING_CAPACITY)) / PAGE_HOLDING_CAPACITY) + 1);
		model.addAttribute("totalPageSize", totalPageSize);
		if (totalPageSize <= 10) {
			model.addAttribute("startat", 1);
			model.addAttribute("endat", totalPageSize);
		} else if (totalPageSize < (pageNumber + 5)) {
			if ((totalPageSize - 10) > 1)
				model.addAttribute("startat", (totalPageSize - 10));
			else
				model.addAttribute("startat", 1);
			model.addAttribute("endat", totalPageSize);
		} else {
			model.addAttribute("startat", (pageNumber - 4));
			model.addAttribute("endat", pageNumber + 5);
		}
		return "index";
	}

	//
	// 12345678911 12 13 14 15 16 17 18 19 20 21 22 23
	@RequestMapping(value = "/jobPosts/{category}/{number}")
	public String pageJobs(Model model, @PathVariable("category") String category,
			@PathVariable("number") int pageNumber) {
		List<PostedJob> postedJobs = postedJobService.getPostedJobs(pageNumber, category, PAGE_HOLDING_CAPACITY);
		for (PostedJob job : postedJobs)
			job.setDiscription(this.shortString(job.getDiscription(), 20));
		model.addAttribute("pageNumber", pageNumber);
		model.addAttribute("catigory", category);
		model.addAttribute("postedJobs", postedJobs);
		List<String> positionList = postedJobService.getPositionList();
		model.addAttribute("positions", positionList);
		model.addAttribute("currentDate", new Date());
		int totalJobsSize = postedJobService.getPostedJobsSize(category);
		int totalPageSize = (totalJobsSize % PAGE_HOLDING_CAPACITY == 0 ? totalJobsSize / PAGE_HOLDING_CAPACITY
				: ((totalJobsSize - (totalJobsSize % PAGE_HOLDING_CAPACITY)) / PAGE_HOLDING_CAPACITY) + 1);
		model.addAttribute("totalPageSize", totalPageSize);
		
		if (totalPageSize <= 10) {
			model.addAttribute("startat", 1);
			model.addAttribute("endat", totalPageSize);
		} else if (totalPageSize < (pageNumber + 5)) {
			if ((totalPageSize - 10) > 1)
				model.addAttribute("startat", (totalPageSize - 10));
			else
				model.addAttribute("startat", 1);
			model.addAttribute("endat", totalPageSize);
		} else {
			model.addAttribute("startat", (pageNumber - 4));
			model.addAttribute("endat", pageNumber + 5);
		}
		return "index";
	}
	private String getRawText(String htmltext) {
				String rowtext = Jsoup.parse(htmltext).text();
		return rowtext;
	}
	
	String shortString(String longString, int numberOfWords) {
		String text = "";
		String htmlfree=this.getRawText(longString);
		
		String[] words = htmlfree.split(" ");
		int i = 0;
		boolean itrate=words.length>0;
			while (itrate) {
				if(words[i].contains("<li>") || words[i].contains("<p>")){
					text+=this.getRawText(words[i]);
				}else{
					text += words[i] + " ";
				}
				if((i+1)<words.length && text.length()<120){
					itrate=true;
					i++;
				}else{
					itrate=false;
				}
				
		}
		return text.trim();
		
	}
	@RequestMapping(value = "/catigories", method = RequestMethod.GET)
	@ResponseBody
	public String getcatigories(HttpServletRequest req) {
		String query = req.getParameter("q");
		List<String> catigoryList = postedJobService.getcatigoriesContains(query);
		Gson gson = new Gson();
		String jsonstring = gson.toJson(catigoryList);
		return jsonstring;
	}
}
