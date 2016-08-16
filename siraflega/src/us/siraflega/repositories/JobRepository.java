package us.siraflega.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;

import us.siraflega.entities.Employer;
import us.siraflega.entities.PostedJob;

public interface JobRepository extends JpaRepository<PostedJob, Integer>{

	List<PostedJob> findByJobPostedBy(Employer employer);
	List<PostedJob> findByJobPostedBy(Employer employer,Pageable pageable);
	
//	List<PostedJob> findAll(Pageable pageable);
	
	
//	@Query("SELECT DISTINCT c.city from Company AS c WHERE c.city like %:term%")
//	List<String> findCompanyDistinctByCity(@Param("term") String term);
	@Query("SELECT DISTINCT pj.position FROM PostedJob as pj where pj.title LIKE %:term%")
	List<String> findJobCatigoriesContainsPositionStarts(@Param("term") String term);
	@Query("SELECT DISTINCT pj.position FROM PostedJob as pj where pj.discription  LIKE %:term%")
	List<String> findJobCatigoriesContainsDescriptionStarts(@Param("term") String term);
	@Query("SELECT pj FROM PostedJob as pj where pj.position=:term")// limit :starts,:size"
	Page<PostedJob> findByTitle(@Param("term") String categorySelected,Pageable pageable);//,@Param("starts") int starts,@Param("size") int size,String order
	@Query(value="SELECT count(*) FROM siraflega_db.posted_job where position= ?1",nativeQuery=true)
	int countCatigory(String catigory);
	
	@Query("SELECT DISTINCT pj.position FROM PostedJob as pj ")
	List<String> findAllPositions();
//	ByOrderByStartsFromDesc     findTopByOrderByAgeDesc();
	List<PostedJob> findTop10ByPositionOrderByPostedDateDesc(String position);
//	(String position,Sort sort);
	
//	SELECT * FROM siraflega_db.posted_job
//	where position='Software programmer II'
//	limit 4,2
}
