package us.siraflega.controllers;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import us.siraflega.entities.Company;
import us.siraflega.entities.PostedJob;
import us.siraflega.services.PostedJobService;

@Controller
public class IndexController {
	@Autowired
	PostedJobService postedJobService;
	@RequestMapping({"/index","/"})
	public String getIndex(Model model){
		int totalJobsSize=postedJobService.getPostedJobsSize();
		int pageHoldingCapacity=1;
		int pageNumber=1;
		//employer.getPosts()==null?0:employer.getPosts().size();
		int totalPageSize=(totalJobsSize%pageHoldingCapacity==0?totalJobsSize/pageHoldingCapacity:((totalJobsSize-(totalJobsSize%pageHoldingCapacity))/pageHoldingCapacity)+1);
		System.out.println("????????????totalPageSize:"+totalPageSize);
		model.addAttribute("totalPageSize", totalPageSize);
		List<PostedJob>postedJobs=postedJobService.getPostedJobs(pageNumber,pageHoldingCapacity);
		for(PostedJob job:postedJobs)
			job.setDiscription(this.shortString(job.getDiscription()));
		System.out.println("========size"+postedJobs.size());
		model.addAttribute("pageNumber", pageNumber);
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
	@RequestMapping(value="/jobPosts/{category}/{number}")
	public String pageJobs(Model model,@PathVariable("category") String category, @PathVariable("number") int pageNumber){
		int totalJobsSize=postedJobService.getPostedJobsSize();
		int pageHoldingCapacity=1;
		//int pageNumber=1;
		//employer.getPosts()==null?0:employer.getPosts().size();
		int totalPageSize=(totalJobsSize%pageHoldingCapacity==0?totalJobsSize/pageHoldingCapacity:((totalJobsSize-(totalJobsSize%pageHoldingCapacity))/pageHoldingCapacity)+1);
		System.out.println("come to mee totalPageSize:"+totalPageSize);
		model.addAttribute("totalPageSize", totalPageSize);
		List<PostedJob>postedJobs=postedJobService.getPostedJobs(pageNumber,pageHoldingCapacity);
		for(PostedJob job:postedJobs)
			job.setDiscription(this.shortString(job.getDiscription()));
		System.out.println("========size"+postedJobs.size());
		model.addAttribute("pageNumber", pageNumber);
		model.addAttribute("postedJobs", postedJobs);
		model.addAttribute("currentDate", new Date());
		int startat=1;
		int endat=10;
		if(totalPageSize<=10){
			startat=1;
			endat=totalPageSize;
		}else if(pageNumber<=5){
			startat=1;
			endat=10;
		}else if((pageNumber+5)>totalPageSize){
			startat=totalPageSize-10;
			endat=totalPageSize;
		}else{
			startat=pageNumber-4;
			endat=pageNumber+5;
		}
		model.addAttribute("startat", startat);
		model.addAttribute("endat", endat);
		return "index";
	}
	String shortString(String longString){
		String string="";
		String[] words=longString.split(" ");
		for(int i=0;i<40;i++)
			string+=words[i]+" ";
		
		System.out.println("the string cutted:"+string);
		return string;
	}
}
