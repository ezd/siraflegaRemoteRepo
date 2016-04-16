package us.siraflega.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import us.siraflega.entities.Employee;
import us.siraflega.entities.Language;

public interface LanguageRepository extends JpaRepository<Language, Integer>{

	List<Language> findByTalkedby(Employee employee);

}
