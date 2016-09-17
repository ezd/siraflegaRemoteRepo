package us.siraflega.entities;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.Type;

@Entity
@Table(name="PostedJob")
public class PostedJob {
	@Id
	@GeneratedValue
	Integer id;
	String title;
	@Column(columnDefinition="LONGTEXT")
	String discription;
	String position;
	String sallery;
	Date postedDate;
	Date deadLine;
	@Column(columnDefinition="LONGTEXT")
	String rqdSkills;
	@Column(columnDefinition="LONGTEXT")
	String rqdEducation;
	int rqdExperianceyears;
	@Column(columnDefinition="LONGTEXT")
	String howToApply;
	String email;
	String phone;
	@ManyToOne
	@JoinColumn(name="company_id")
	Company company;
	@ManyToOne
	@JoinColumn(name="poster_id")
	Employer jobPostedBy;
	
	public Employer getJobPostedBy() {
		return jobPostedBy;
	}
	public void setJobPostedBy(Employer jobPostedBy) {
		this.jobPostedBy = jobPostedBy;
	}
	public String getHowToApply() {
		return howToApply;
	}
	public void setHowToApply(String howToApply) {
		this.howToApply = howToApply;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public Company getCompany() {
		return company;
	}
	public void setCompany(Company company) {
		this.company = company;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDiscription() {
		return discription;
	}
	public void setDiscription(String discription) {
		this.discription = discription;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getSallery() {
		return sallery;
	}
	public void setSallery(String sallery) {
		this.sallery = sallery;
	}
	public Date getPostedDate() {
		return postedDate;
	}
	public void setPostedDate(Date postedDate) {
		this.postedDate = postedDate;
	}
	public Date getDeadLine() {
		return deadLine;
	}
	public void setDeadLine(Date deadLine) {
		this.deadLine = deadLine;
	}
	public String getRqdSkills() {
		return rqdSkills;
	}
	public void setRqdSkills(String rqdSkills) {
		this.rqdSkills = rqdSkills;
	}
	public String getRqdEducation() {
		return rqdEducation;
	}
	public void setRqdEducation(String rqdEducation) {
		this.rqdEducation = rqdEducation;
	}
	public int getRqdExperianceyears() {
		return rqdExperianceyears;
	}
	public void setRqdExperianceyears(int rqdExperianceyears) {
		this.rqdExperianceyears = rqdExperianceyears;
	}
	
	

}
