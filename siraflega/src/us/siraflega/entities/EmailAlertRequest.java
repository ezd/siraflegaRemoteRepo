package us.siraflega.entities;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
public class EmailAlertRequest {
	@Id
	@GeneratedValue
	Integer id;
	
	String position;
	String recEmailAddress;
	String recName;
	String verifyKey;
	boolean isVerified;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getRecEmailAddress() {
		return recEmailAddress;
	}
	public void setRecEmailAddress(String recEmailAddress) {
		this.recEmailAddress = recEmailAddress;
	}
	public String getRecName() {
		return recName;
	}
	public void setRecName(String recName) {
		this.recName = recName;
	}
	public String getVerifyKey() {
		return verifyKey;
	}
	public void setVerifyKey(String verifyKey) {
		this.verifyKey = verifyKey;
	}
	public boolean isVerified() {
		return isVerified;
	}
	public void setVerified(boolean isVerified) {
		this.isVerified = isVerified;
	}
	
	

}
