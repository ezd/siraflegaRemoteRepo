package us.siraflega.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import us.siraflega.entities.WorkExperience;
import us.siraflega.repositories.WorkExperienceRepository;

@Service
public class WorkExperienceService {
	@Autowired
	WorkExperienceRepository workExperienceRepository;

	public WorkExperience getworkExpriance(int id) {
		// TODO Auto-generated method stub
		return workExperienceRepository.findOne(id);
	}

	public WorkExperience updateExpriance(WorkExperience workExpToBeEdited) {
		return workExperienceRepository.save(workExpToBeEdited);
	}

	public WorkExperience saveExpriance(WorkExperience newWorkExp) {
		if(newWorkExp.isCurrentlyWorking())
			workExperienceRepository.setOffCurrentlyWorking(false);
		WorkExperience savedEx = workExperienceRepository.save(newWorkExp);
		return savedEx;
	}

	public void deleteExp(int idToBeDeleted) {
		workExperienceRepository.delete(idToBeDeleted);

	}

}
