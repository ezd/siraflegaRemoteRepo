package us.siraflega.services;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import us.siraflega.entities.Application;
import us.siraflega.entities.Employee;
import us.siraflega.entities.PostedJob;
import us.siraflega.repositories.ApplicationRepository;

@Service
public class ApplicationService {
	@Autowired
	ApplicationRepository applicationRepository;
	PostedJobService postedJobService;
	EmployeeService employeeService;
	
	
	public Application saveApplication(int applicantId,int jobId,String letter){
		Application application=new Application();
		application.setApplicantId(applicantId);
		application.setJobId(jobId);
		application.setApplicationDate(new Date());
		application.setLetter(letter);
		return applicationRepository.save(application);
	}
	public List<Application> getApplications(Integer jobId){
		return applicationRepository.findByJobId(jobId);
	}
	public boolean isApplied(Integer applicantId,Integer jobId){
		return !applicationRepository.findByApplicantIdAndJobId(applicantId,jobId).isEmpty();
	}
	public List<PostedJob> getAppliedJob(Integer applicantId){
		List<Application> applications= applicationRepository.findByApplicantId(applicantId);
		List<PostedJob> jobs=new ArrayList<PostedJob>();
		for(Application application:applications){
			jobs.add(postedJobService.getPostdJob(application.getJobId()));
		}
		return jobs;
	}
	
	public List<Employee> getApplicants(Integer jobId){
		List<Application> applications= applicationRepository.findByJobId(jobId);
		List<Employee> applicants=new ArrayList<Employee>();
		for(Application application:applications){
			applicants.add(employeeService.getEmployeeBy(application.getApplicantId()));
		}
		return applicants;
	}
	public Application getApplication(int jobId, Integer applicantId) {
		// TODO Auto-generated method stub
		List<Application> applications=applicationRepository.findByApplicantIdAndJobId(applicantId,jobId);
		if(applications.isEmpty())
			return null;
		return applications.get(0);
	}

}
