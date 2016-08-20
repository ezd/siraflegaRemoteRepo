package us.siraflega.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import us.siraflega.entities.Work;
import us.siraflega.entities.WorkExperience;
import us.siraflega.repositories.WorkRepository;

@Service
public class WorkeService {
	@Autowired
	WorkRepository workExperienceRepository;

	public Work saveExpriance(Work newWorkExp) {
		// TODO Auto-generated method stub
		return workExperienceRepository.save(newWorkExp);
	}

	public Work getWorkExp(int id) {
		// TODO Auto-generated method stub
		return workExperienceRepository.findOne(id);
	}

	public Work updateExpriance(Work existingWorkExp) {
		// TODO Auto-generated method stub
		if (existingWorkExp.isCurrentlyWorking())
			workExperienceRepository.setOffCurrentlyWorking(false);
		Work savedEx = workExperienceRepository.save(existingWorkExp);
		return savedEx;
	}

	public void deleteExp(int id) {
		// TODO Auto-generated method stub
		workExperienceRepository.delete(id);
	}

	
}
