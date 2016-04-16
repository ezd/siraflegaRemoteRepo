package us.siraflega.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import us.siraflega.entities.Company;
import us.siraflega.entities.Employer;

public interface EmployerRepository extends JpaRepository<Employer, Integer>{

	Employer findByEmail(String email);

}
