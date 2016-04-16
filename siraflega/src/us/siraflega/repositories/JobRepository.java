package us.siraflega.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;

import us.siraflega.entities.Employer;
import us.siraflega.entities.PostedJob;

public interface JobRepository extends JpaRepository<PostedJob, Integer>{

	List<PostedJob> findByJobPostedBy(Employer employer);
	List<PostedJob> findByJobPostedBy(Employer employer,Pageable pageable);
//	List<PostedJob> findAll(Pageable pageable);
}
