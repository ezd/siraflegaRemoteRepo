package us.siraflega.entities;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;

@Entity
public class WorkExperience {
	@Id
	@GeneratedValue
	Integer id;
	@ManyToOne
	@JoinColumn(name = "Worked_Company_Id")
	Company company;
	String postion;
	@Lob
	@Column(length = 10000)
	String discription;
	Date starts;
	Date ends;
	boolean currentlyWorking;

	public boolean isCurrentlyWorking() {
		return currentlyWorking;
	}

	public void setCurrentlyWorking(boolean currentlyWorking) {
		this.currentlyWorking = currentlyWorking;
	}

	public Company getCompany() {
		return company;
	}

	public void setCompany(Company company) {
		this.company = company;
	}

	@ManyToOne
	@JoinColumn(name = "workerId")
	Employee workedBy;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getPostion() {
		return postion;
	}

	public void setPostion(String postion) {
		this.postion = postion;
	}

	public String getDiscription() {
		return discription;
	}

	public void setDiscription(String discription) {
		this.discription = discription;
	}

	public Date getStarts() {
		return starts;
	}

	public void setStarts(Date starts) {
		this.starts = starts;
	}

	public Date getEnds() {
		return ends;
	}

	public void setEnds(Date ends) {
		this.ends = ends;
	}

	public Employee getWorkedBy() {
		return workedBy;
	}

	public void setWorkedBy(Employee workedBy) {
		this.workedBy = workedBy;
	}

}
