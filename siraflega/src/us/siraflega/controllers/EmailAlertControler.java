package us.siraflega.controllers;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import us.siraflega.entities.EmailAlertRequest;
import us.siraflega.services.EmailAlertService;
import util.EmailAlert;

@Controller
public class EmailAlertControler {
	@Autowired
	EmailAlertService emailAlertService;
//jobPosts/{category}/{number}
	@RequestMapping("/verifyEmailAlert")
	public String sendReminder(Model model,@RequestParam("e") String email,@RequestParam("k") String key,@RequestParam("p") String position) {
System.out.println("it comes to verify");
System.out.println("email:"+email+",key:"+key+",position:"+position);
		if (key != null) {
//			String unencryptedKey = encryptedKey.substring(3);
			if (emailAlertService.verifyAlertRequest(key, email,position)) {
				return "redirect:/index.html?verifiedReqeusted=true&verified=true";
			}else{
				return "redirect:/index.html?verifiedReqeusted=true&verified=false";
			}
		}
		return "redirect:/index.html?verifiedReqeusted=true&verified=false";
		

	}

	@RequestMapping(value = "/deleteEmailAlert", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody String deleteEmailAlert(@RequestBody String jsonDeletEmailAlert) {

		JSONObject jsonObject = new JSONObject(jsonDeletEmailAlert);
		String emailToBeDeleted = jsonObject.getString("email");
		String positionToBeDeleted = jsonObject.getString("position");
		if(emailAlertService.deleteAlertRequest(emailToBeDeleted,positionToBeDeleted)){
			return "isDeleted:true";
		}
		return "isDeleted:false";
	}
	
	@RequestMapping(value = "/alertme", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody String saveEmailAlert(@RequestBody String jsonSaveEmailAlert) {

		JSONObject jsonObject = new JSONObject(jsonSaveEmailAlert);
		String alertRequesterName = jsonObject.getString("user_name");
		String alertRequesterEmail = jsonObject.getString("user_eamil");
		String emailAlertRequestPosition = jsonObject.getString("selecte_position");
		EmailAlertRequest emailAlertRequest=new EmailAlertRequest();
		emailAlertRequest.setRecEmailAddress(alertRequesterEmail);
		emailAlertRequest.setRecName(alertRequesterName);
		emailAlertRequest.setPosition(emailAlertRequestPosition);
		int i=0;
		i=i+10;
		String verificatinmsgs[]=emailAlertService.getVerificationMessage(alertRequesterEmail,emailAlertRequestPosition).split("#");
		emailAlertRequest.setVerifyKey(verificatinmsgs[0]);
		if(emailAlertService.saveAlertRequest(emailAlertRequest)){
			System.out.println("email is saved");
			emailAlertService.sendemailalert(alertRequesterEmail, "Email alert request verification", "Email alert request verification", verificatinmsgs[1]);
			System.out.println("email send");
			jsonObject.put("isSaved", "true");
		}else{
		System.out.println("email is not saved");
		jsonObject.put("isSaved", "false");
		}
		return jsonObject.toString();
	}
}
