package us.siraflega.services;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import us.siraflega.entities.Company;
import us.siraflega.repositories.CompanyRepository;

@Service
public class CompanyService {
	@Autowired
	CompanyRepository companyRepository;

	public List<Company> getCompanyList() {
		// TODO Auto-generated method stub
		return companyRepository.findAll();
	}

	public List<String> getCityList(String query) {
		// TODO Auto-generated method stub
		List<String>citiesList=new ArrayList<String>();
		citiesList=companyRepository.findCompanyDistinctByCity(query);
		return citiesList;
	}

	public Company saveNewCompany(Company company) {
		// TODO Auto-generated method stub
		return companyRepository.save(company);
		
	}

	public Company getCompany(int id) {
		// TODO Auto-generated method stub
		
		return companyRepository.findOne(id);
	}

}
