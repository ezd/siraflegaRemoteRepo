package us.siraflega.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import us.siraflega.entities.Company;
import us.siraflega.entities.Employer;
import us.siraflega.entities.PostedJob;
import us.siraflega.entities.Work;
import us.siraflega.repositories.CompanyRepository;
import us.siraflega.repositories.EmployerRepository;
import us.siraflega.repositories.JobRepository;
import us.siraflega.repositories.WorkRepository;

@Service
@Transactional
public class EmployeerService {

	@Autowired
	EmployerRepository employerRepository;
	@Autowired
	CompanyRepository companyRepository;
	@Autowired
	JobRepository jobRepository;
	@Autowired
	WorkRepository workRepository;
	
	public Employer getEmployerBy(String email) {
		// TODO Auto-generated method stub
		return employerRepository.findByEmail(email);
	}
	public Employer getFullEmployerBy(String email) {
		Employer employer=getEmployerBy(email);
		if(employer!=null){
		List<Work>employerWorks=workRepository.findByWorkedByOrderByUptoDesc(employer);
		employer.setWorks(employerWorks);
//		Company company=companyRepository.findByAgents(employer);
		//employer.setWorksFor(company);
		List<PostedJob> postedJobs=jobRepository.findByJobPostedBy(employer);
//		for(PostedJob job:postedJobs){
//			Company company=companyRepository.findByJobs(job);
//		}
		employer.setPosts(postedJobs);
		}
		
		return employer;
	}
	public Employer saveEmployer(Employer employer) {
		// TODO Auto-generated method stub
		return employerRepository.save(employer);
	}
	public Employer getEmployer(int id) {
		return employerRepository.findOne(id);
	}

}
