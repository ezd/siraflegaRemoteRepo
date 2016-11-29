package us.siraflega.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import us.siraflega.entities.Application;

public interface ApplicationRepository extends  JpaRepository<Application, Integer> {

	List<Application> findByApplicantIdAndJobId(Integer applicantId, Integer jobId);

	List<Application> findByApplicantId(Integer applicantId);

	List<Application> findByJobId(Integer jobId);

}
