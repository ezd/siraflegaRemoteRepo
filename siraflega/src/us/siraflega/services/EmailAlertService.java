package us.siraflega.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import us.siraflega.entities.EmailAlertRequest;
import us.siraflega.repositories.EmailAlertRepository;

@Service
public class EmailAlertService {
	
	@Autowired
	EmailAlertRepository emailAlertRepository;
	
	List<EmailAlertRequest> searchExistingRequest(String emailRequest){
		return emailAlertRepository.findByRecEmailAddress(emailRequest);
	}
	
	public boolean saveAlertRequest(EmailAlertRequest alertRequest){
		List<EmailAlertRequest> existingEmailAlertRequests=this.searchExistingRequest(alertRequest.getRecEmailAddress());
		if(existingEmailAlertRequests==null){
			emailAlertRepository.save(alertRequest);
			return true;
		}
		return false;
		
	}
	
	public boolean verifyAlertRequest(String verifyKey,String email){
		List<EmailAlertRequest> existingEmailAlertRequests=this.searchExistingRequest(email);
		if(existingEmailAlertRequests!=null && existingEmailAlertRequests.get(0).getVerifyKey().equals(verifyKey)){
			EmailAlertRequest emailAlertRequest=existingEmailAlertRequests.get(0);
			emailAlertRequest.setVerified(true);
			emailAlertRepository.save(emailAlertRequest);
			return true;
		}
		return false;
		
	}
	
	public boolean deleteAlertRequest(String emailAddress){
		List<EmailAlertRequest> existingEmailAlertRequests=this.searchExistingRequest(emailAddress);
		if(existingEmailAlertRequests!=null){
			emailAlertRepository.delete(existingEmailAlertRequests.get(0));
			return true;
		}
		return false;
		
	}

}
