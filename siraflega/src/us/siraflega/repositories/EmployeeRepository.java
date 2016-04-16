package us.siraflega.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import us.siraflega.entities.Company;
import us.siraflega.entities.Employee;

public interface EmployeeRepository extends JpaRepository<Employee, Integer>{

	Employee findByEmail(String email);

}
