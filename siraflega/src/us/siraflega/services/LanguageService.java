package us.siraflega.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import us.siraflega.entities.Language;
import us.siraflega.repositories.LanguageRepository;

@Service
public class LanguageService {
@Autowired
LanguageRepository languageRepository;
	public Language saveLanguage(Language newLanguage) {
		// TODO Auto-generated method stub
		return languageRepository.save(newLanguage);
	}
	public Language getExistingLanguage(int id) {
		// TODO Auto-generated method stub
		return languageRepository.findOne(id);
	}
	public void deleteEducation(int id) {
		languageRepository.delete(id);
		
	}

}
