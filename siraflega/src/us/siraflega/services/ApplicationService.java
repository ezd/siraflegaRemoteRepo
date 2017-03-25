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
	@Autowired
	PostedJobService postedJobService;
	@Autowired
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
	
	public List<Application> getApplicationsForpost(Integer jobId){
		List<Application> aplicantsfullInfo=applicationRepository.findByJobId(jobId);
		for(int i=0;i<aplicantsfullInfo.size();i++){
			Employee applicantinfo=employeeService.getEmployeeByID(aplicantsfullInfo.get(i).getApplicantId());
			aplicantsfullInfo.get(i).setApplicantFullName(applicantinfo.getFirstName()==null?"":applicantinfo.getFirstName()+" "
					+ applicantinfo.getMiddleName()==null?"":applicantinfo.getMiddleName()+" "
							+ applicantinfo.getLastName()==null?"":applicantinfo.getLastName()+" ");
			
		}
		return aplicantsfullInfo;
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
	String shortString(String longString,int numberOfWords){
		String string="";
		String[] words=longString.split(" ");
		for(int i=0;i<(words.length>numberOfWords?numberOfWords:words.length);i++)
			string+=words[i]+" ";
		return string;
	}
	
	public List<Employee> getApplicants(int jobId){
		List<Application> applications= applicationRepository.findByJobId(jobId);
		List<Employee> applicants=new ArrayList<Employee>();
		for(Application application:applications){
			Integer applicantId=application.getApplicantId();
			Employee applicant=employeeService.getEmployeeByID(applicantId);
			applicant.setSummary(this.shortString(applicant.getSummary(), 80));
			applicants.add(applicant);
		}
		return applicants;
	}
	public Application getApplication(int jobId, Integer applicantId) {
		// TODO Auto-generated method stub
		List<Application> applications=applicationRepository.findByApplicantIdAndJobId(applicantId,jobId);
		if(applications.isEmpty()||applications==null)
			return null;
		return applications.get(0);
	}
	public long numberofApplicants(Integer id) {
		
		long numberofApplyees= applicationRepository.countByJobId(id);
		return numberofApplyees;
	}

}
