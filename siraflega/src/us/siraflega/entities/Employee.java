package us.siraflega.entities;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.OneToMany;
import javax.persistence.Transient;

@Entity
public class Employee {

	@Id
	@GeneratedValue
	Integer id;
	@OneToMany(mappedBy="workedBy",cascade=CascadeType.REMOVE)
	List<WorkExperience> experiences;
	String firstName;
	String middleName;
	String lastName;
	String email;
	String telephone;
	String address;
	int age;
	String sex;
	@Lob
	@Column(length = 10000)
	String summary;
	
	@Transient
	String returnTo;
	@Transient
	String jobid;
	
	
	
	public String getReturnTo() {
		return returnTo;
	}
	public void setReturnTo(String returnTo) {
		this.returnTo = returnTo;
	}
	public String getJobid() {
		return jobid;
	}
	public void setJobid(String jobid) {
		this.jobid = jobid;
	}
	@OneToMany(mappedBy="employee",cascade=CascadeType.REMOVE)
	List<Education> educations;
	@OneToMany(mappedBy="talkedby",cascade=CascadeType.REMOVE)
	List<Language> languages;

	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	public List<WorkExperience> getExperiences() {
		return experiences;
	}
	public void setExperiences(List<WorkExperience> experiences) {
		this.experiences = experiences;
	}
	public List<Language> getLanguages() {
		return languages;
	}
	public void setLanguages(List<Language> languages) {
		this.languages = languages;
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
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	public List<Education> getEducations() {
		return educations;
	}
	public void setEducations(List<Education> educations) {
		this.educations = educations;
	}
}
