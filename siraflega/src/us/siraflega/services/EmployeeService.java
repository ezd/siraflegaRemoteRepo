package us.siraflega.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import us.siraflega.entities.Company;
import us.siraflega.entities.Education;
import us.siraflega.entities.Employee;
import us.siraflega.entities.Language;
import us.siraflega.entities.WorkExperience;
import us.siraflega.repositories.CompanyRepository;
import us.siraflega.repositories.EducationRepository;
import us.siraflega.repositories.EmployeeRepository;
import us.siraflega.repositories.LanguageRepository;
import us.siraflega.repositories.WorkExperienceRepository;

@Service
@Transactional
public class EmployeeService {

	@Autowired
	EmployeeRepository employeeRepository;
	@Autowired
	EducationRepository educationRepository;
	@Autowired
	WorkExperienceRepository workExperienceRepository;
	@Autowired
	LanguageRepository languageRepository;
	@Autowired
	CompanyRepository companyRepository;

	public Employee getEmployeeBy(String email) {
		return employeeRepository.findByEmail(email);
	}
public List<WorkExperience> getExpeianceWithCompany(Employee employee){
	List<WorkExperience> expriances= workExperienceRepository
			.findByWorkedByOrderByEndsDesc(employee);
	for(WorkExperience experiance:expriances){
		
		Company company=companyRepository.findByExperienceRefers(experiance);
		experiance.setCompany(company);
	}
	return expriances;
}
	public Employee getFullEmployeeBy(String email) {
		Employee employee = getEmployeeBy(email);
		if (employee != null) {
			List<Education> educations = educationRepository
					.findByEmployeeOrderByStartDateDesc(employee);
			employee.setEducations(educations);
			List<WorkExperience> experiances = getExpeianceWithCompany(employee);
			employee.setExperiences(experiances);
			List<Language> languages = languageRepository
					.findByTalkedby(employee);
			employee.setLanguages(languages);
		}
		return employee;
	}
	public void updateEmployee(Employee employee) {
		employeeRepository.save(employee);
	}
	public void saveEmployee(Employee employee) {
		employeeRepository.save(employee);
		
	}
	public Employee saveEmployeeInfo(Employee employee) {
		return employeeRepository.save(employee);
		
	}
	public Employee getEmployeeByID(Integer applicantId) {
		// TODO Auto-generated method stub
		Employee employee =employeeRepository.findOne(applicantId);
		return employee;
	}

}
