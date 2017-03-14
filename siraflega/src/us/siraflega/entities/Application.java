package us.siraflega.entities;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.Transient;

@Entity
public class Application {
	@Id
	@GeneratedValue
	Integer id;
	
	Integer applicantId;
	Integer jobId;
	Date applicationDate;
	
	@Transient
	Integer applicatinEmpid;
	@Transient
	String applicantFullName;
	
	public Integer getApplicatinEmpid() {
		return applicatinEmpid;
	}
	public void setApplicatinEmpid(Integer applicatinEmpid) {
		this.applicatinEmpid = applicatinEmpid;
	}
	public String getApplicantFullName() {
		return applicantFullName;
	}
	public void setApplicantFullName(String applicantFullName) {
		this.applicantFullName = applicantFullName;
	}
	@Lob
	@Column(length = 10000)
	String letter;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Date getApplicationDate() {
		return applicationDate;
	}
	public void setApplicationDate(Date applicationDate) {
		this.applicationDate = applicationDate;
	}
	public String getLetter() {
		return letter;
	}
	public void setLetter(String letter) {
		this.letter = letter;
	}
	public Integer getApplicantId() {
		return applicantId;
	}
	public void setApplicantId(Integer applicantId) {
		this.applicantId = applicantId;
	}
	public Integer getJobId() {
		return jobId;
	}
	public void setJobId(Integer jobId) {
		this.jobId = jobId;
	}
	
	

}
