package us.siraflega.entities;

import java.sql.Blob;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

import org.codehaus.jackson.annotate.JsonIgnore;

@Entity
public class Company {
	@Id
	@GeneratedValue
	@JsonIgnore
	Integer id;
	String name;
	String areaOfFocus;
	String address;
	String telephon;
	String website;
	String city;
	String country;
	@JsonIgnore
	Blob logo;
	
	@OneToMany(mappedBy="company",fetch=FetchType.EAGER)
	List<PostedJob> jobs;
	@OneToMany(mappedBy="company")
	List<WorkExperience> experienceRefers;
	@OneToMany(mappedBy="company")
	List<Work> employerRefers;
	public List<WorkExperience> getExperienceRefers() {
		return experienceRefers;
	}
	public void setExperienceRefers(List<WorkExperience> experienceRefers) {
		this.experienceRefers = experienceRefers;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAreaOfFocus() {
		return areaOfFocus;
	}
	public void setAreaOfFocus(String areaOfFocus) {
		this.areaOfFocus = areaOfFocus;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getTelephon() {
		return telephon;
	}
	public void setTelephon(String telephon) {
		this.telephon = telephon;
	}
	public Blob getLogo() {
		return logo;
	}
	public void setLogo(Blob logo) {
		this.logo = logo;
	}
	
	
	public List<PostedJob> getJobs() {
		return jobs;
	}
	public void setJobs(List<PostedJob> jobs) {
		this.jobs = jobs;
	}
	public String getWebsite() {
		return website;
	}
	public void setWebsite(String website) {
		this.website = website;
	}
	
	

}
