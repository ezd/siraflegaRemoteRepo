package util;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;
import javax.sql.rowset.Joinable;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;

import us.siraflega.entities.EmailAlertRequest;
import us.siraflega.entities.PostedJob;
import us.siraflega.services.EmailAlertService;
import us.siraflega.services.PostedJobService;

public class EmailAlert{

	@Autowired
	EmailAlertService eas;
	
	@Autowired
	PostedJobService postedJobService=new PostedJobService();
	
			//* "0 0 * * * *" = the top of every hour of every day.
			//	* "*/10 * * * * *" = every ten seconds.
			//* "0 0 8-10 * * *" = 8, 9 and 10 o'clock of every day.
			//* "0 0/30 8-10 * * *" = 8:00, 8:30, 9:00, 9:30 and 10 o'clock every day.
			//* "0 0 9-17 * * MON-FRI" = on the hour nine-to-five weekdays
			//* "0 0 0 25 12 ?" = every Christmas Day at midnight

	@Scheduled(cron="0 0/2 0 * * * ")
	public void execute(){
		eas.getRequestedjobspool().clear();
		eas.getNamespool().clear();
		//get email address and subject
		List<EmailAlertRequest> verifiedRequests= eas.getVerifiedRequests();
		//get job by subject
		for(EmailAlertRequest req:verifiedRequests){
			List<PostedJob> top10jobs=postedJobService.getTop10Jobs(req.getPosition());
			if(eas.getRequestedjobspool().isEmpty()){
				eas.getRequestedjobspool().put(req.getRecEmailAddress(), top10jobs);
				eas.getNamespool().put(req.getRecEmailAddress(), req.getRecName());
			}else{
				if(eas.getRequestedjobspool().get(req.getRecEmailAddress())==null){
					eas.getRequestedjobspool().put(req.getRecEmailAddress(), top10jobs);
					eas.getNamespool().put(req.getRecEmailAddress(), req.getRecName());
				}else{
					eas.getRequestedjobspool().get(req.getRecEmailAddress()).addAll(top10jobs);
				}
			}
			
		}
		//send email address
//		for(int i=0;i<this.getRequestedjobspool().size();i++){
//			
//		}
		SimpleDateFormat sdf = new SimpleDateFormat("dd-M-yyyy hh:mm:ss");
		String today = sdf.format(new Date());
		for(Map.Entry<String, List<PostedJob>> entry:eas.getRequestedjobspool().entrySet()){
			String email=entry.getKey().toString();
			String name=eas.getNamespool().get(email).toString();
			List<PostedJob> positions=entry.getValue();
			eas.setName(name);
			eas.setPositions(positions);
			String messages=eas.getPositionmessage(); 
			eas.sendemailalert(email, "Jobs from siraflega.com on "+today, "List of jobs newly posted on siraflega.com", messages);
		}
		//eas.sendemailalert("biliyala.ezd2@gmail.com",eas.getPositionmessage("email rescipiant name", new ArrayList<PostedJob>()),"msg desc","msg subj");
	}

}
