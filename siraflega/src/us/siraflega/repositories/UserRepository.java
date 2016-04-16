package us.siraflega.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import us.siraflega.entities.User;

public interface UserRepository extends JpaRepository<User, Integer>{

	User findByUserName(String name);

	User findByEmail(String userEmail);

}
