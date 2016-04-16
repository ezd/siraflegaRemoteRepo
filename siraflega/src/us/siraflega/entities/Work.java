package us.siraflega.entities;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
public class Work {
	@Id
	@GeneratedValue
	private Integer id;
	@ManyToOne
	@JoinColumn(name="employer_id")
	Employer workedBy;
	@ManyToOne
	@JoinColumn(name="company_id")
	Company company;
	String postion;
	@Column(name="starting_from")
	Date startsFrom;
	@Column(name="up_to")
	Date upto;
	boolean currentlyWorking;
	public boolean isCurrentlyWorking() {
		return currentlyWorking;
	}
	public void setCurrentlyWorking(boolean currentlyWorking) {
		this.currentlyWorking = currentlyWorking;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Employer getWorkedBy() {
		return workedBy;
	}
	public void setWorkedBy(Employer workedBy) {
		this.workedBy = workedBy;
	}
	public Company getCompany() {
		return company;
	}
	public void setCompany(Company company) {
		this.company = company;
	}
	public String getPostion() {
		return postion;
	}
	public void setPostion(String postion) {
		this.postion = postion;
	}
	public Date getStartsFrom() {
		return startsFrom;
	}
	public void setStartsFrom(Date startsFrom) {
		this.startsFrom = startsFrom;
	}
	public Date getUpto() {
		return upto;
	}
	public void setUpto(Date upto) {
		this.upto = upto;
	}
	
}
