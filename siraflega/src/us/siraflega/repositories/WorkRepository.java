package us.siraflega.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import us.siraflega.entities.Company;
import us.siraflega.entities.Employer;
import us.siraflega.entities.Work;
import us.siraflega.entities.WorkExperience;

public interface WorkRepository extends JpaRepository<Work, Integer>{

	List<Work> findByWorkedByOrderByUptoDesc(Employer employer);

	@Modifying
	@Query("UPDATE Work w set w.currentlyWorking = ?1")
	@Transactional
	void setOffCurrentlyWorking(boolean currentlyWorking);


}
