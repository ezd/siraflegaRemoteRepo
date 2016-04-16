package us.siraflega.entities;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;

@Entity
public class Employer {

	@Id
	@GeneratedValue
	Integer id;
	String firstName;
	String middleName;
	String lastName;
	String email;
	String telephone;
	
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	@OneToMany(mappedBy="workedBy")
	List<Work>works;
	public List<Work> getWorks() {
		return works;
	}
	public void setWorks(List<Work> works) {
		this.works = works;
	}
	public List<PostedJob> getJobPosts() {
		return jobPosts;
	}
	public void setJobPosts(List<PostedJob> jobPosts) {
		this.jobPosts = jobPosts;
	}
	@OneToMany(mappedBy="jobPostedBy", cascade=CascadeType.REMOVE)
	List<PostedJob> jobPosts;
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getMiddleName() {
		return middleName;
	}
	public void setMiddleName(String middleName) {
		this.middleName = middleName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public List<PostedJob> getPosts() {
		return jobPosts;
	}
	public void setPosts(List<PostedJob> jobPosts) {
		this.jobPosts = jobPosts;
	}
	
	

}
