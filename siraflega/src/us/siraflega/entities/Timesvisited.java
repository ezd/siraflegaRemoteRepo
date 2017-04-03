package us.siraflega.entities;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class Timesvisited {
	@Id
	Long id;
	int timesvisited;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public int getTimesvisited() {
		return timesvisited;
	}
	public void setTimesvisited(int timesvisited) {
		this.timesvisited = timesvisited;
	}
	

}
