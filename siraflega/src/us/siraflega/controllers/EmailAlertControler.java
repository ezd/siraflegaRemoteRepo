package us.siraflega.controllers;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import us.siraflega.entities.EmailAlertRequest;
import us.siraflega.services.EmailAlertService;

@Controller
public class EmailAlertControler {
	@Autowired
	EmailAlertService emailAlertService;

	@RequestMapping("/verifyEmailAlert/{verifykey}/{email}")
	public String sendReminder(Model model, @PathVariable String encryptedKey, @PathVariable String email) {

		if (encryptedKey != null) {
			String unencryptedKey = encryptedKey.substring(3);
			if (emailAlertService.verifyAlertRequest(unencryptedKey, email)) {
				model.addAttribute("isAlertVerified", true);
			}
		}

		return "redirect:/index";

	}

	@RequestMapping(value = "/deleteEmailAlert", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody String deleteEmailAlert(@RequestBody String jsonDeletEmailAlert) {

		JSONObject jsonObject = new JSONObject(jsonDeletEmailAlert);
		String emailToBeDeleted = jsonObject.getString("email");
		if(emailAlertService.deleteAlertRequest(emailToBeDeleted)){
			return "isDeleted:true";
		}
		return "isDeleted:false";
	}
	
	@RequestMapping(value = "/saveEmailAlert", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody String saveEmailAlert(@RequestBody String jsonSaveEmailAlert) {

		JSONObject jsonObject = new JSONObject(jsonSaveEmailAlert);
		String alertRequesterName = jsonObject.getString("alertRequesterName");
		String alertRequesterEmail = jsonObject.getString("alertRequesterEmail");
		String emailAlertRequestPosition = jsonObject.getString("emailAlertRequestPosition");
		EmailAlertRequest emailAlertRequest=new EmailAlertRequest();
		emailAlertRequest.setRecEmailAddress(alertRequesterEmail);
		emailAlertRequest.setRecName(alertRequesterName);
		emailAlertRequest.setPosition(emailAlertRequestPosition);
		if(emailAlertService.saveAlertRequest(emailAlertRequest)){
			return "isSaved:true";
		}
		return "isSaved:false";
	}
}
