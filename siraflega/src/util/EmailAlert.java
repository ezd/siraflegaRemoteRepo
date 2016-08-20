package util;
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

	@Scheduled(cron="0 0 1 * * MON,THU")
	public void execute(){
		int i=0;
		i=i+10;
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
		i=10;
		for(Map.Entry<String, List<PostedJob>> entry:eas.getRequestedjobspool().entrySet()){
			String email=entry.getKey().toString();
			String name=eas.getNamespool().get(email).toString();
			List<PostedJob> positions=entry.getValue();
			eas.setName(name);
			eas.setPositions(positions);
			String messages=eas.getPositionmessage(); 
			eas.sendemailalert(email, "check if it works", "it should work", messages);
		}
		//eas.sendemailalert("biliyala.ezd2@gmail.com",eas.getPositionmessage("email rescipiant name", new ArrayList<PostedJob>()),"msg desc","msg subj");
	}

}
