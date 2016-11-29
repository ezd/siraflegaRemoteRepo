package us.siraflega.services;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import us.siraflega.entities.EmailAlertRequest;
import us.siraflega.entities.PostedJob;
import us.siraflega.repositories.EmailAlertRepository;

@Service
public class EmailAlertService {

	@Autowired
	EmailAlertRepository emailAlertRepository;

	private HashMap<String, List<PostedJob>> requestedjobspool = new HashMap<String, List<PostedJob>>();
	private HashMap<String, String> namespool = new HashMap<String, String>();

	public HashMap<String, String> getNamespool() {
		return namespool;
	}

	public void setNamespool(HashMap<String, String> namespool) {
		this.namespool = namespool;
	}

	public HashMap<String, List<PostedJob>> getRequestedjobspool() {
		return requestedjobspool;
	}

	public void setRequestedjobspool(HashMap<String, List<PostedJob>> requestedjobspool) {
		this.requestedjobspool = requestedjobspool;
	}

	List<EmailAlertRequest> searchExistingRequest(String emailRequest, String position) {
		return emailAlertRepository.findByRecEmailAddressAndPosition(emailRequest, position);
	}
	List<EmailAlertRequest> searchExistingRequest(String emailRequest, String position,String key) {
		return emailAlertRepository.findByRecEmailAddressAndPositionAndVerifyKey(emailRequest, position,key);
	}

	public boolean saveAlertRequest(EmailAlertRequest alertRequest) {

		List<EmailAlertRequest> existingEmailAlertRequests = this
				.searchExistingRequest(alertRequest.getRecEmailAddress(), alertRequest.getPosition());
		if (existingEmailAlertRequests.size() == 0) {
			
			emailAlertRepository.save(alertRequest);
			return true;
		} else {
			return false;
		}

	}

	public boolean verifyAlertRequest(String verifyKey, String email, String posistion) {
		List<EmailAlertRequest> existingEmailAlertRequests = this.searchExistingRequest(email, posistion,verifyKey);
		if (!existingEmailAlertRequests.isEmpty() && existingEmailAlertRequests.get(0).getVerifyKey().equals(verifyKey)) {
			EmailAlertRequest emailAlertRequest = existingEmailAlertRequests.get(0);
			emailAlertRequest.setVerified(true);
			emailAlertRepository.save(emailAlertRequest);
			return true;
		}
		return false;

	}

	public boolean deleteAlertRequest(String emailAddress, String position) {
		List<EmailAlertRequest> existingEmailAlertRequests = this.searchExistingRequest(emailAddress, position);
		if (existingEmailAlertRequests != null) {
			emailAlertRepository.delete(existingEmailAlertRequests.get(0));
			return true;
		}
		return false;
	}

	public List<EmailAlertRequest> getVerifiedRequests() {
		List<EmailAlertRequest> vrreq = emailAlertRepository.findByIsVerified(true);
		return vrreq;
	}

	/////////////////////////////
	private String name;
	List<PostedJob> positions = new ArrayList<PostedJob>();
	private String positionmessage;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<PostedJob> getPositions() {
		return positions;
	}

	public void setPositions(List<PostedJob> positions) {
		this.positions = positions;
	}

	int getRandomNumber(){
		Random rand = new Random();
		return rand.nextInt();
	}

	public void setPositionmessage(String positionmessage) {
		this.positionmessage = positionmessage;
	}

	String shortString(String longString) {
		String string = "";
		String[] words = longString.split(" ");
		for (int i = 0; i < (words.length > 20 ? 20 : words.length); i++)
			string += words[i] + " ";
		return string;
	}

	public String getPositionmessage() {// String position,String company,String
										// descriptions
		// oldJob=null;
		String oldPosition = "";
		String messagetosend = "<html><body style=\"font-size: 9px;font-family: monospace;color: #4A4A4A;\"> Hello "
				+ this.getName() + ",";
		for (PostedJob job : this.getPositions()) {
			if (!oldPosition.equals(job.getPosition())) {
				messagetosend += "<h3> New " + job.getPosition() + " jobs<h3>";
			}
			messagetosend += "<div style=\"text-align: justify; \">"
					+ "<a href=\"http://siraflega.com/jobPost/"+job.getId()+".html\"><h3>" + job.getPosition() + " for "
					+ job.getCompany().getName() + "</h3></a>" + "<p style=\"margin-top: -10px;\">"
					+ this.shortString(job.getDiscription()) + ".</p>" + "</div>";
			oldPosition = job.getPosition();
		}
		messagetosend += "</body></html>";
		return messagetosend;
	}

	public String getVerificationMessage(String email,String position) {
///verifyEmailAlert/{verifykey}/{email}/{position} 
		String key=this.getRandomNumber()+"";
		return key+"#Thank you for requesting email verification "
				+ "from Siraflega&copy; for <b>"+position+"</b> positions. "
				+ "Pleas follow the following link to <a href=\"http://siraflega.com/verifyEmailAlert?e="
				+ email + "&&k=" + key + "&&p="+position+"\">verify your email alert request.</a>";
	}
	//http://localhost:8080/siraflega for local version
	//http://siraflega.com/ for online version

	public void sendemailalert(String to, String subject, String description, String messageText) {
		// TODO Auto-generated method stub
		String from = "siraflega2016@gmail.com";
		Properties props = System.getProperties();
		props.put("mail.smtp.starttls.enable", "true"); // added this line
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.user", "siraflega2016@gmail.com");
		props.put("mail.smtp.password", "2016siraflega");
		props.put("mail.smtp.port", "587");
		props.put("mail.smtp.auth", "true");
		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication("siraflega2016@gmail.com", "2016siraflega");
			}
		});
		try {
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(from));
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
			message.setDescription(description);
			message.setSubject(subject);
			message.setContent(messageText, "text/html; charset=utf-8");
			Transport.send(message);
		} catch (MessagingException mex) {
			mex.printStackTrace();
		}

	}

}
