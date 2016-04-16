package us.siraflega.repositories;


import org.springframework.data.jpa.repository.JpaRepository;

import us.siraflega.entities.Role;

public interface RoleRepository extends JpaRepository<Role, Integer>{

	Role findByName(String string);

}
