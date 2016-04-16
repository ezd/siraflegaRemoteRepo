package us.siraflega.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import us.siraflega.entities.Company;
import us.siraflega.entities.Employer;
import us.siraflega.entities.PostedJob;
import us.siraflega.entities.Work;
import us.siraflega.entities.WorkExperience;

public interface CompanyRepository extends JpaRepository<Company, Integer>{

	Company findByExperienceRefers(WorkExperience experiance);

	Company findByEmployerRefers(Work work);

	Company findByJobs(PostedJob job);
	
	@Query("SELECT DISTINCT c.city from Company AS c WHERE c.city like %:term%")
	List<String> findCompanyDistinctByCity(@Param("term") String term);
}
