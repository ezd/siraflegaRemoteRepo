package us.siraflega.services;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import us.siraflega.entities.Education;
import us.siraflega.repositories.EducationRepository;
@Service
public class EducationService {
@Autowired
EducationRepository educationRepository;
	public List<String> getInistitutionList(String query) {
		List<String>inistitutionList=new ArrayList<String>();
		inistitutionList=educationRepository.findInistitutionsLike(query);
		
		return inistitutionList;
	}
	public Education saveEducation(Education newEducation) {
		// TODO Auto-generated method stub
		return educationRepository.save(newEducation);
	}
	public Education getEducationToEdit(int educationId) {
		return educationRepository.findOne(educationId);
	}
	public void deleteEducation(int id) {
		educationRepository.delete(id);
		
	}

}
