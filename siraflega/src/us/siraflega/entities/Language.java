package us.siraflega.entities;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
public class Language {

	@Id
	@GeneratedValue
	Integer id;
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
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public Employee getTalkedby() {
		return talkedby;
	}
	public void setTalkedby(Employee talkedby) {
		this.talkedby = talkedby;
	}
	String name;
	String level;
	@ManyToOne
	@JoinColumn(name="speaker_id")
	Employee talkedby;
}
