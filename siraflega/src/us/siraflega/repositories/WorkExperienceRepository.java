package us.siraflega.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import us.siraflega.entities.Employee;
import us.siraflega.entities.WorkExperience;

public interface WorkExperienceRepository extends JpaRepository<WorkExperience, Integer>{

	List<WorkExperience> findByWorkedByOrderByEndsDesc(Employee employee);
	@Modifying
	@Query("UPDATE WorkExperience wx set wx.currentlyWorking = ?1")
	@Transactional
	void setOffCurrentlyWorking(boolean currentlyWorking);

}
