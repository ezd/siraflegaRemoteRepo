package us.siraflega.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import us.siraflega.entities.Education;
import us.siraflega.entities.Employee;

public interface EducationRepository extends JpaRepository<Education, Integer>{

	List<Education> findByEmployeeOrderByStartDateDesc(Employee employee);
	@Query("SELECT DISTINCT e.institute from Education AS e WHERE e.institute like %:term%")
	List<String> findInistitutionsLike(@Param("term") String term);
}
