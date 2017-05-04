package us.siraflega.controllers;

import java.security.Principal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.security.web.authentication.logout.CookieClearingLogoutHandler;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.security.web.authentication.rememberme.AbstractRememberMeServices;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;

import us.siraflega.entities.Application;
import us.siraflega.entities.Company;
import us.siraflega.entities.Employee;
import us.siraflega.entities.Employer;
import us.siraflega.entities.PostedJob;
import us.siraflega.entities.Role;
import us.siraflega.entities.User;
import us.siraflega.entities.Work;
import us.siraflega.entities.WorkExperience;
import us.siraflega.services.ApplicationService;
import us.siraflega.services.CompanyService;
import us.siraflega.services.EmployeeService;
import us.siraflega.services.EmployeerService;
import us.siraflega.services.PostedJobService;
import us.siraflega.services.UserService;
import us.siraflega.services.WorkExperienceService;
import us.siraflega.services.WorkeService;

@Controller
public class UserController {

	private final int PAGE_HOLDING_CAPACITY2 = 6;

	@ModelAttribute("user")
	public User construct() {
		return new User();
	}

	@ModelAttribute("job")
	public PostedJob constructJob() {
		return new PostedJob();
	}

	@ModelAttribute("employee")
	public Employee constructEmp() {
		return new Employee();
	}

	@ModelAttribute("expriance")
	public WorkExperience constructWE() {
		return new WorkExperience();
	}

	@ModelAttribute("company")
	public Company constructCo() {
		return new Company();
	}

	org.hibernate.Session hsession;
	@Autowired
	UserService userService;
	@Autowired
	CompanyService companyService;
	@Autowired
	EmployeeService employeeService;
	@Autowired
	EmployeerService employerService;
	@Autowired
	WorkExperienceService workExperienceService;
	@Autowired
	WorkeService workService;
	@Autowired
	PostedJobService postedJobService;
	@Autowired
	ApplicationService applicationService;

	@RequestMapping("/users")
	public String getUsersList(Model model) {
		List<User> usersList = userService.getAllUsers();
		model.addAttribute("users", usersList);
		return "users";
	}

	public List<String> getCompanyNameList(List<Company> companyList) {
		List<String> companyNameList = new ArrayList<String>();
		for (Company company : companyList) {
			companyNameList.add(company.getName());
		}
		return companyNameList;
	}

	@RequestMapping(value = "/cities", method = RequestMethod.GET)
	@ResponseBody
	public String searchCities(HttpServletRequest req) {
		String query = req.getParameter("q");
		List<String> existingCitiesList = companyService.getCityList(query);
		Gson gson = new Gson();
		String jsonstring = gson.toJson(existingCitiesList);
		return jsonstring;
	}

	@RequestMapping("/register")
	public String registerForm() {
		return "user-register";
	}

	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String registerUser(Model model, @ModelAttribute("user") User user, @RequestParam("type") String type,
			final RedirectAttributes redirectAttributes, HttpServletRequest request) {
		String unEncPass = user.getPassword();
		String unEncUserName = user.getUserName();
		if ((userService.getUserByEmail(user.getEmail()) != null)
				|| (userService.getUserByName(user.getUserName()) != null)) {
			redirectAttributes.addFlashAttribute("user", user);
			return "redirect:/register.html?success=false&message=Exists";
		}
		User savedUser = userService.saveUser(user, type);
		if (savedUser == null) {
			// model.addAttribute("user", user);
			return "redirect:/register.html?success=false&message=notsaved";
		} else {
			authenticateUserAndSetSession(unEncUserName, unEncPass, request);
			return "redirect:/userDetail";
		}
	}

	@Autowired
	protected AuthenticationManager authenticationManager;

	private void authenticateUserAndSetSession(String username, String password, HttpServletRequest request) {
		UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(username, password);

		// generate session if one doesn't exist
		request.getSession();

		token.setDetails(new WebAuthenticationDetails(request));
		try {
			Authentication authenticatedUser = authenticationManager.authenticate(token);
			SecurityContextHolder.getContext().setAuthentication(authenticatedUser);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@RequestMapping(value = "/userDetail", method = RequestMethod.GET)
	public String registerUserDetail(Model model, Principal principal, HttpServletRequest request,
			HttpServletResponse response, final RedirectAttributes redirectAttributes) {
		String name = principal.getName();
		User user = userService.getUserByName(name);
		if (user == null) {
			logOutAndInvalidate(request, response);

			return "redirect:/userDetail";
		}
		Role userRole = user.getRole();
		// for (Role r : userRoles) {
		// }
		model.addAttribute("user", user);
		Employee employee = employeeService.getEmployeeBy(user.getEmail());
		model.addAttribute("employee", employee);
		Employer employer = employerService.getEmployerBy(user.getEmail());
		model.addAttribute("employer", employer);
		if (userRole.getName().toString().equalsIgnoreCase("ROLE_EMPLOYEE")) {
			model.addAttribute("type", "employee");
		} else if (userRole.getName().toString().equalsIgnoreCase("ROLE_EMPLOYER")) {
			model.addAttribute("type", "employer");
		}
		return "userDetail";
	}

	private void logOutAndInvalidate(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession(false);
		if (session != null) {
			session.invalidate();
		}
		// log out and clear the sessions
		CookieClearingLogoutHandler cookieClearingLogoutHandler = new CookieClearingLogoutHandler(
				AbstractRememberMeServices.SPRING_SECURITY_REMEMBER_ME_COOKIE_KEY);
		SecurityContextLogoutHandler securityContextLogoutHandler = new SecurityContextLogoutHandler();
		cookieClearingLogoutHandler.logout(request, response, null);
		securityContextLogoutHandler.logout(request, response, null);

	}

	@RequestMapping("/users/sendReminder/{id}")
	public String sendReminder(Model model, @PathVariable int id) {
		String result;
		User user = userService.getOneBy(id);
		String to = user.getEmail();
		String from = "seatac.test@gmail.com";
		Properties props = System.getProperties();
		props.put("mail.smtp.starttls.enable", "true"); // added this line
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.user", "seatac.test@gmail.com");
		props.put("mail.smtp.password", "test654321");
		props.put("mail.smtp.port", "587");
		props.put("mail.smtp.auth", "true");
		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication("seatac.test@gmail.com", "test654321");
			}
		});
		try {
			// Create a default MimeMessage object.
			MimeMessage message = new MimeMessage(session);
			// Set From: header field of the header.
			message.setFrom(new InternetAddress(from));
			// Set To: header field of the header.
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
			// Set Subject: header field
			message.setDescription("This is the discription");
			message.setSubject("xProfile combilation reminder from Siraflega.com!");
			// Now set the actual message

			message.setContent("<body><strong>Hi " + user.getUserName() + "</strong>, <br>"
					+ "You have created user account on <a href=\"www.siraflega.com\">www.siraflega.com</a> not yet completed. "
					+ "In order to get the full penefit of the application please complete your <a href=\"www.siraflega.com\">profile</a>.<br>"
					+ "Best regards,<br>" + "Admin</body>", "text/html; charset=utf-8");
			// message.setText();
			Transport.send(message);
			result = "Sent message successfully....";
			model.addAttribute("result", result);
		} catch (MessagingException mex) {
			mex.printStackTrace();
			result = "Error: unable to send message....";
			model.addAttribute("result", result);
		}
		return "incomplet-user";
	}

	@RequestMapping("/users/remove/{id}")
	String removeUser(@PathVariable int id) {
		userService.removeUser(id);
		return "redirect:/users.html";
	}

	@RequestMapping("/account")
	public String getMyAccount(Model model, Principal principal, HttpServletRequest request,
			HttpServletResponse response, @RequestParam(value = "returnTo", required = false) String returnTo,
			@RequestParam(value = "jobid", required = false) String jobId) {

		String name = principal.getName();
		User user = userService.getUserByName(name);
		if (user == null) {
			logOutAndInvalidate(request, response);
			return "redirect:/account";
		}
		model.addAttribute("user", user);
		String email = user.getEmail();
		model.addAttribute("userEmail", email);
		Employee employee = employeeService.getFullEmployeeBy(email);
		Employer employer = employerService.getFullEmployerBy(email);
		List<Company> companyList = companyService.getCompanyList();
		model.addAttribute("companyList", getCompanyNameList(companyList));
		model.addAttribute("companyObjList", companyList);
		// this values for returning
		model.addAttribute("returnTo", returnTo);
		model.addAttribute("jobid", jobId);

		if (employee != null) {
			model.addAttribute("employee", employee);
			return "employee-detail";
		}
		if (employer != null) {
			Work currentWork = employer.getWorks() == null ? employer.getWorks().get(0) : null;
			model.addAttribute("employer", employer);
			for (Work work : employer.getWorks()) {
				if (work.isCurrentlyWorking()) {
					work.setUpto(new Date());
					currentWork = work;
				}
			}
			model.addAttribute("currentWork", currentWork);
			return "employer-detail";
		}
		Role role = user.getRole();
		if (role.getName().equalsIgnoreCase("ROLE_EMPLOYEE")) {
			model.addAttribute("employee", new Employee());
			model.addAttribute("isNewEmployee", true);
			return "employee-detail";
		} else if (role.getName().equalsIgnoreCase("ROLE_EMPLOYER")) {
			model.addAttribute("employer", new Employer());
			model.addAttribute("isNewEmployer", true);
			model.addAttribute("currentWork", new Work());
			model.addAttribute("currentTime", new Date());
			return "employer-detail";
		} else {
			logOutAndInvalidate(request, response);
		}
		return "redirect:/account";
	}

	@RequestMapping(value = "/updateEmployee", method = RequestMethod.POST)
	public String updateEmployee(@ModelAttribute("employee") Employee employee, Model model, Principal principal) {
		User logedInUser = userService.getUserByName(principal.getName());
		employee.setSummary(this.getRawText(employee.getSummary()));
		if (employee.getId() != null) {
			employee.setEmail(logedInUser.getEmail());
			employeeService.updateEmployee(employee);
		} else {
			employee.setEmail(logedInUser.getEmail());
			employeeService.saveEmployee(employee);
		}
		if(employee.getReturnTo()==null || employee.getReturnTo()==""){
			return "redirect:/account";
		}
		return "redirect:/account?returnTo=" + employee.getReturnTo() + "&&jobid=" + employee.getJobid();
	}
	
	private String getRawText(String htmltext) {
		String test=htmltext;
		if (htmltext.startsWith("<") && htmltext.endsWith(">"))
			test= htmltext.substring(htmltext.indexOf(">")+1,htmltext.lastIndexOf("<")-1);
		return test;
	}
	@RequestMapping(value = "/saveEmployeePersonalInfo", method = RequestMethod.POST)
	public String saveEmployeePersonalInfo(@ModelAttribute("employee") Employee employee, Model model) {
		Employee savedEmployee = employeeService.saveEmployeeInfo(employee);
		String status;
		if (savedEmployee != null) {
			model.addAttribute("employee", employee);
			status = "success";
		} else {
			status = "fail";
		}
		return "redirect:/userDetail?status=" + status;
	}

	@RequestMapping(value = "/saveCompany", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody String saveCompany(@RequestBody String jsonCompany) {
		Gson gson = new Gson();
		Company company = (Company) gson.fromJson(jsonCompany, Company.class);
		Company savedCompany = companyService.saveNewCompany(company);
		return gson.toJson(savedCompany);
	}

	@RequestMapping(value = "/deleteWorkExp", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody String deleteWorkExp(@RequestBody String jsonWork) {

		JSONObject jsonObject = new JSONObject(jsonWork);
		String idToBeDeleted = jsonObject.getString("id");
		workExperienceService.deleteExp(Integer.parseInt(idToBeDeleted));
		return jsonObject.toString();
	}

	// updatePassword
	@RequestMapping(value = "/updateUser", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody String updateUser(@RequestBody String jsonUser, Principal principal,
			HttpServletRequest request, HttpServletResponse response) {
		String name = principal.getName();
		User exisitingUser = userService.getUserByName(name);
		JSONObject jsonObject = new JSONObject(jsonUser);
		String newUserName = jsonObject.getString("userName");
		String newUserEmail = jsonObject.getString("userEmail");
		String userPassword = jsonObject.getString("userOldPassword"); // not
																		// found
		User updatedUser = null;
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		if (!encoder.matches(userPassword, exisitingUser.getPassword())) {
			return jsonObject.put("isPassCorrect", "notCorrect").toString();
		} else if (!exisitingUser.getEmail().equalsIgnoreCase(newUserEmail)
				&& userService.getUserByEmail(newUserEmail) != null) {
			return jsonObject.put("isEmaiExist", "EmaiExist").toString();
		} else if (!exisitingUser.getUserName().equalsIgnoreCase(newUserName)
				&& userService.getUserByName(newUserName) != null) {
			return jsonObject.put("isUserNameExist", "UserNameExist").toString();
		} else {
			exisitingUser.setUserName(newUserName);
			exisitingUser.setEmail(newUserEmail);
			updatedUser = userService.saveUserWithOutPassword(exisitingUser);
			logOutAndInvalidate(request, response);
			authenticateUserAndSetSession(updatedUser.getUserName(), userPassword, request);
			jsonObject.put("id", "" + updatedUser.getId());
			jsonObject.put("userName", updatedUser.getUserName());
			jsonObject.put("email", updatedUser.getEmail());
			return jsonObject.toString();
		}
	}

	@RequestMapping(value = "/updatePassword", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody String updatePassword(@RequestBody String jsonUserPassword, Principal principal,
			HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject(jsonUserPassword);
		String newUserPassword = jsonObject.getString("newPassword");
		String inputOldpassunEncoded = jsonObject.getString("passwordTochange");
		String name = principal.getName();
		User exisitingUser = userService.getUserByName(name);
		User updatedUser = null;
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		if (!encoder.matches(inputOldpassunEncoded, exisitingUser.getPassword())) {
			return jsonObject.put("isPassCorrect", "notCorrect").toString();
		} else {
			exisitingUser.setPassword(newUserPassword);
			updatedUser = userService.saveUser(exisitingUser);
			logOutAndInvalidate(request, response);
			authenticateUserAndSetSession(updatedUser.getUserName(), newUserPassword, request);

		}

		return jsonObject.toString();
	}

	@RequestMapping(value = "/updateEmployerInfo", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody String updateEmployerInfo(@RequestBody String jsonEmployer) {
		JSONObject jsonObject = new JSONObject(jsonEmployer);
		String firstName = jsonObject.getString("fName");
		String meddileName = jsonObject.getString("mName");
		String lastName = jsonObject.getString("lName");
		String phone = jsonObject.getString("phone");
		int id = Integer.parseInt(jsonObject.getString("id"));
		Employer employer = employerService.getEmployer(id);
		employer.setFirstName(firstName);
		employer.setMiddleName(meddileName);
		employer.setLastName(lastName);
		employer.setTelephone(phone);
		employer = employerService.saveEmployer(employer);
		jsonObject.put("fName", employer.getFirstName());
		jsonObject.put("mName", employer.getMiddleName());
		jsonObject.put("lName", employer.getLastName());
		jsonObject.put("phone", employer.getTelephone());
		return jsonObject.toString();
	}

	@RequestMapping(value = "/saveEmployerInfo", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody String saveEmployerInfo(@RequestBody String jsonEmployer) {
		JSONObject jsonObject = new JSONObject(jsonEmployer);
		String firstName = jsonObject.getString("fName");
		String meddileName = jsonObject.getString("mName");
		String lastName = jsonObject.getString("lName");
		String phone = jsonObject.getString("phone");
		Employer employer = new Employer();
		employer.setFirstName(firstName);
		employer.setMiddleName(meddileName);
		employer.setLastName(lastName);
		employer.setTelephone(phone);
		employer = employerService.saveEmployer(employer);
		jsonObject.put("fName", employer.getFirstName());
		jsonObject.put("mName", employer.getMiddleName());
		jsonObject.put("lName", employer.getLastName());
		jsonObject.put("id", employer.getId());
		jsonObject.put("phone", employer.getTelephone());
		return jsonObject.toString();
	}

	@RequestMapping(value = "/saveWrorkExp", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody String saveWorkExp(@RequestBody String jsonWork, Principal principal) {
		String name = principal.getName();
		User user = userService.getUserByName(name);
		Employee employee = employeeService.getEmployeeBy(user.getEmail());
		JSONObject jsonObject = new JSONObject(jsonWork);
		String companyId = jsonObject.getString("companyId");
		String position = jsonObject.getString("position");
		String startDate = jsonObject.getString("startDate");
		Date start_Date = null;
		try {
			start_Date = new SimpleDateFormat("dd/MM/yyyy", Locale.ENGLISH).parse(startDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String endDate = jsonObject.getString("endDate");
		Date end_Date = null;
		try {
			end_Date = new SimpleDateFormat("dd/MM/yyyy", Locale.ENGLISH).parse(endDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String description = jsonObject.getString("description");
		String workExpId = jsonObject.getString("workExpId");
		boolean isCurrentlyWorking = jsonObject.getBoolean("isCurrent");
		Company newCompanySelected = companyService.getCompany(Integer.parseInt(companyId));
		WorkExperience newWorkExp = new WorkExperience();
		newWorkExp.setWorkedBy(employee);
		newWorkExp.setCompany(newCompanySelected);
		newWorkExp.setPostion(position);
		newWorkExp.setStarts(start_Date);
		newWorkExp.setEnds(end_Date);
		newWorkExp.setDiscription(description);
		newWorkExp.setCurrentlyWorking(isCurrentlyWorking);
		WorkExperience savedWorkExp = workExperienceService.saveExpriance(newWorkExp);
		jsonObject.put("id", "" + savedWorkExp.getId());
		jsonObject.put("companyId", "" + savedWorkExp.getCompany().getId());
		jsonObject.put("position", savedWorkExp.getPostion());
		jsonObject.put("startDate", savedWorkExp.getStarts() + "");
		jsonObject.put("endDate", savedWorkExp.getEnds() + "");
		jsonObject.put("companyName", savedWorkExp.getCompany().getName());
		jsonObject.put("companyCity", savedWorkExp.getCompany().getCity());
		jsonObject.put("companyCountry", savedWorkExp.getCompany().getCountry());
		jsonObject.put("description", savedWorkExp.getDiscription());
		jsonObject.put("isCurrentlyWorking", savedWorkExp.isCurrentlyWorking());
		return jsonObject.toString();
	}

	@RequestMapping(value = "/saveEmployerWrorkExp", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody String saveEmployerWrorkExp(@RequestBody String jsonWork, Principal principal) {
		String name = principal.getName();
		User user = userService.getUserByName(name);
		Employer employer = employerService.getEmployerBy(user.getEmail());
		JSONObject jsonObject = new JSONObject(jsonWork);
		String companyId = jsonObject.getString("companyId");
		String position = jsonObject.getString("position");
		String startDate = jsonObject.getString("startDate");
		Date start_Date = null;
		try {
			start_Date = new SimpleDateFormat("dd/MM/yyyy", Locale.ENGLISH).parse(startDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String endDate = jsonObject.getString("endDate");
		Date end_Date = null;
		try {
			end_Date = new SimpleDateFormat("dd/MM/yyyy", Locale.ENGLISH).parse(endDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		boolean isCurrentlyWorking = jsonObject.getBoolean("isCurrent");
		Company newCompanySelected = companyService.getCompany(Integer.parseInt(companyId));
		Work newWorkExp = new Work();
		newWorkExp.setWorkedBy(employer);
		newWorkExp.setCompany(newCompanySelected);
		newWorkExp.setPostion(position);
		newWorkExp.setStartsFrom(start_Date);
		newWorkExp.setUpto(end_Date);
		newWorkExp.setCurrentlyWorking(isCurrentlyWorking);
		Work savedWorkExp = workService.saveExpriance(newWorkExp);
		jsonObject.put("id", "" + savedWorkExp.getId());
		jsonObject.put("companyId", "" + savedWorkExp.getCompany().getId());
		jsonObject.put("position", savedWorkExp.getPostion());
		jsonObject.put("startDate", savedWorkExp.getStartsFrom() + "");
		jsonObject.put("endDate", savedWorkExp.getUpto() + "");
		jsonObject.put("companyName", savedWorkExp.getCompany().getName());
		jsonObject.put("companyCity", savedWorkExp.getCompany().getCity());
		jsonObject.put("companyCountry", savedWorkExp.getCompany().getCountry());
		jsonObject.put("isCurrentlyWorking", savedWorkExp.isCurrentlyWorking());
		return jsonObject.toString();
	}

	@RequestMapping(value = "/updateWrorkExp", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody String updateWorkExp(@RequestBody String jsonWork) {
		JSONObject jsonObject = new JSONObject(jsonWork);
		String companyId = jsonObject.getString("companyId");
		String position = jsonObject.getString("position");
		String startDate = jsonObject.getString("startDate");
		Date start_Date = null;
		try {
			start_Date = new SimpleDateFormat("dd/MM/yyyy", Locale.ENGLISH).parse(startDate);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		String endDate = jsonObject.getString("endDate");
		Date end_Date = null;
		try {
			end_Date = new SimpleDateFormat("dd/MM/yyyy", Locale.ENGLISH).parse(endDate);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		String description = jsonObject.getString("description");
		String workExpId = jsonObject.getString("workExpId");
		boolean isCurrentlyWorking = jsonObject.getBoolean("isCurrent");
		Company newCompanySelected = companyService.getCompany(Integer.parseInt(companyId));
		WorkExperience workExpToBeEdited = workExperienceService.getworkExpriance(Integer.parseInt(workExpId));
		workExpToBeEdited.setCompany(newCompanySelected);
		workExpToBeEdited.setPostion(position);
		workExpToBeEdited.setStarts(start_Date);
		workExpToBeEdited.setEnds(end_Date);
		workExpToBeEdited.setDiscription(description);
		workExpToBeEdited.setCurrentlyWorking(isCurrentlyWorking);
		WorkExperience savedWorkExp = workExperienceService.updateExpriance(workExpToBeEdited);
		jsonObject.put("id", "" + savedWorkExp.getId());
		jsonObject.put("companyId", "" + savedWorkExp.getCompany().getId());
		jsonObject.put("position", savedWorkExp.getPostion());
		jsonObject.put("startDate", savedWorkExp.getStarts() + "");
		jsonObject.put("endDate", savedWorkExp.getEnds() + "");
		jsonObject.put("companyName", savedWorkExp.getCompany().getName());
		jsonObject.put("companyCity", savedWorkExp.getCompany().getCity());
		jsonObject.put("companyCountry", savedWorkExp.getCompany().getCountry());
		jsonObject.put("description", savedWorkExp.getDiscription());
		jsonObject.put("isCurrentlyWorking", savedWorkExp.isCurrentlyWorking());
		return jsonObject.toString();
	}

	@RequestMapping(value = "/updateEmployerWrokExp", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody String updateEmployerWrokExp(@RequestBody String jsonWork, Principal principal) {
		String name = principal.getName();
		User user = userService.getUserByName(name);
		Employer employer = employerService.getEmployerBy(user.getEmail());
		JSONObject jsonObject = new JSONObject(jsonWork);
		String workExpId = jsonObject.getString("workExpId");
		String companyId = jsonObject.getString("companyId");
		String position = jsonObject.getString("position");
		String startDate = jsonObject.getString("startDate");
		Date start_Date = null;
		try {
			start_Date = new SimpleDateFormat("dd/MM/yyyy", Locale.ENGLISH).parse(startDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String endDate = jsonObject.getString("endDate");
		Date end_Date = null;
		try {
			end_Date = new SimpleDateFormat("dd/MM/yyyy", Locale.ENGLISH).parse(endDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		boolean isCurrentlyWorking = jsonObject.getBoolean("isCurrent");
		Company newCompanySelected = companyService.getCompany(Integer.parseInt(companyId));
		Work existingWorkExp = workService.getWorkExp(Integer.parseInt(workExpId));
		existingWorkExp.setWorkedBy(employer);
		existingWorkExp.setCompany(newCompanySelected);
		existingWorkExp.setPostion(position);
		existingWorkExp.setStartsFrom(start_Date);
		existingWorkExp.setUpto(end_Date);
		existingWorkExp.setCurrentlyWorking(isCurrentlyWorking);
		Work savedWorkExp = workService.updateExpriance(existingWorkExp);
		jsonObject.put("id", "" + savedWorkExp.getId());
		jsonObject.put("companyId", "" + savedWorkExp.getCompany().getId());
		jsonObject.put("position", savedWorkExp.getPostion());
		jsonObject.put("startDate", savedWorkExp.getStartsFrom() + "");
		jsonObject.put("endDate", savedWorkExp.getUpto() + "");
		jsonObject.put("companyName", savedWorkExp.getCompany().getName());
		jsonObject.put("companyCity", savedWorkExp.getCompany().getCity());
		jsonObject.put("companyCountry", savedWorkExp.getCompany().getCountry());
		jsonObject.put("isCurrentlyWorking", savedWorkExp.isCurrentlyWorking());
		return jsonObject.toString();
	}

	// deleteEmployerWorkExp
	@RequestMapping(value = "/deleteEmployerWorkExp", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody String deleteEmployerWorkExp(@RequestBody String jsonWork) {

		JSONObject jsonObject = new JSONObject(jsonWork);
		String idToBeDeleted = jsonObject.getString("id");
		workService.deleteExp(Integer.parseInt(idToBeDeleted));
		return jsonObject.toString();
	}

	// employerPosts
	private final int PAGE_HOLDING_CAPACITYX = 4;

	@RequestMapping("/employerPosts/{pageNumber}")
	public String registerForm(Model model, Principal principal, @PathVariable int pageNumber) {
		int x = 0;
		x+=1;
		int y=x;
		String userName = principal.getName();
		User user = userService.getUserByName(userName);
		Employer employer = employerService.getEmployerBy(user.getEmail());
		int totalJobsSize = (postedJobService.getPostedJobs(employer)==null||postedJobService.getPostedJobs(employer).isEmpty()) ? 0
				: postedJobService.getPostedJobs(employer).size();
		int totalPageSize = (totalJobsSize % PAGE_HOLDING_CAPACITYX == 0 ? totalJobsSize / PAGE_HOLDING_CAPACITYX
				: ((totalJobsSize - (totalJobsSize % PAGE_HOLDING_CAPACITYX)) / PAGE_HOLDING_CAPACITYX) + 1);
		model.addAttribute("totalPageSize", totalPageSize);
		if (totalPageSize <= 10) {
			model.addAttribute("startat", 1);
			model.addAttribute("endat", totalPageSize);
		} else if (totalPageSize < (pageNumber + 5)) {
			model.addAttribute("startat", (totalPageSize - 10));
			model.addAttribute("endat", totalPageSize);
		} else {
			model.addAttribute("startat", (pageNumber - 4));
			model.addAttribute("endat", (pageNumber + 5));
		}
		model.addAttribute("totalPageSize", totalPageSize);
		List<PostedJob> postedJobs = postedJobService.getPostedJobs(employer, pageNumber, PAGE_HOLDING_CAPACITYX);
		model.addAttribute("pageNumber", pageNumber);
		model.addAttribute("employer", employer);
		model.addAttribute("postedJobs", postedJobs);
		model.addAttribute("currentDate", new Date());
		List<Company> companyList = companyService.getCompanyList();
		model.addAttribute("companyObjList", companyList);
		return "employerPosts";
	}

	// DD/MM/YYYY
	@InitBinder
	public void initBinderAll(WebDataBinder binder) {
		binder.registerCustomEditor(Company.class, new CompanyPropertyEditor());

	}

	@RequestMapping(value = "/postJob", method = RequestMethod.POST)
	String postJob(Model model, @ModelAttribute @Valid PostedJob job, BindingResult result, Principal principal) {
		String userName = principal.getName();
		User user = userService.getUserByName(userName);
		Employer poster = employerService.getEmployerBy(user.getEmail());
		job.setJobPostedBy(poster);
		if (job.getId() == null) {
			postedJobService.save(job);
		} else {
			PostedJob existingJob = postedJobService.getPostdJob(job.getId());
			existingJob.setCompany(job.getCompany());
			existingJob.setDeadLine(job.getDeadLine());
			existingJob.setDiscription(this.getRawText(job.getDiscription()));
			existingJob.setEmail(job.getEmail());
			existingJob.setHowToApply(this.getRawText(job.getHowToApply()));
			existingJob.setPhone(job.getPhone());
			existingJob.setPosition(job.getPosition());
			existingJob.setPostedDate(job.getPostedDate());
			existingJob.setRqdEducation(this.getRawText(job.getRqdEducation()));
			existingJob.setRqdExperianceyears(job.getRqdExperianceyears());
			existingJob.setRqdSkills(this.getRawText(job.getRqdSkills()));
			
			existingJob.setSallery(job.getSallery());
			existingJob.setTitle(job.getTitle());
			postedJobService.save(existingJob);
		}
		return "redirect:/employerPosts/1.html";
		// "redirect:/employerPosts/1.html";
	}

	@RequestMapping(value = "/jobPost/{jobId}", method = RequestMethod.GET)
	String preview(Model model, @PathVariable int jobId) {
		PostedJob postedJob = postedJobService.getPostdJob(jobId);
		model.addAttribute("postedJob", postedJob);
		model.addAttribute("currentDate", new Date());
		return "previewJob";
	}

	// deletePostedJob
	@RequestMapping(value = "/deletePostedJob", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody String deletePostedJob(@RequestBody String jsonPostedJob) {

		JSONObject jsonObject = new JSONObject(jsonPostedJob);
		String idToBeDeleted = jsonObject.getString("id");
		postedJobService.deletePostedJob(Integer.parseInt(idToBeDeleted));
		return jsonObject.toString();
	}

	@RequestMapping(value = "/apply/{jobId}", method = RequestMethod.GET)
	String apply(Model model, @PathVariable int jobId, Principal principal,
			@RequestParam(value = "langoption", defaultValue = "english") String langoption) {
		int i = 0;
		i++;
		String name = principal.getName();
		User user = userService.getUserByName(name);
		Employee employee = employeeService.getEmployeeBy(user.getEmail());
		PostedJob postedJob = postedJobService.getPostdJob(jobId);
		model.addAttribute("employee", employee);
		model.addAttribute("postedJob", postedJob);
		model.addAttribute("langoption", langoption);
		model.addAttribute("currentDate", new Date());
		Application application = null;
		boolean isApplied = false;
		if (employee != null) {
			application = applicationService.getApplication(jobId, employee.getId());
			isApplied = applicationService.isApplied(employee.getId(), jobId);
		}
		model.addAttribute("application", application);
		model.addAttribute("isApplied", isApplied);

		return "applyforjob";
	}

	/**
	 * applicantId : $('#empId').val(), jobId : $('#jobId').val(),
	 * applicationLetter : $('#letterPr').val(),
	 * 
	 * @param jsonApplication
	 * @return
	 */
	@RequestMapping(value = "/apply", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody String apply(@RequestBody String jsonApplication) {

		JSONObject jsonObject = new JSONObject(jsonApplication);
		String applicantId = jsonObject.getString("applicantId");
		String jobId = jsonObject.getString("jobId");
		String applicationLetter = jsonObject.getString("applicationLetter");
		applicationService.saveApplication(Integer.parseInt(applicantId), Integer.parseInt(jobId), applicationLetter);
		boolean isApplied = applicationService.isApplied(Integer.getInteger(applicantId), Integer.getInteger(jobId));
		jsonObject.put("isApplied", isApplied);
		return jsonObject.toString();
	}

	// applicationDetail
	@RequestMapping(value = "/applicationsDetail/{jobId}", method = RequestMethod.GET)
	public String applicationsDetail(Model model, @PathVariable int jobId) {

		// List<Employee> applicants = applicationService.getApplicants(jobId);
		// int totalApplicantSize = applicants.isEmpty() ? 0 :
		// applicants.size();
		// pageNumber = 1;
		// int totalPageSize = (totalApplicantSize % PAGE_HOLDING_CAPACITY == 0
		// ? totalApplicantSize / PAGE_HOLDING_CAPACITY
		// : ((totalApplicantSize - (totalApplicantSize %
		// PAGE_HOLDING_CAPACITY)) / PAGE_HOLDING_CAPACITY) + 1);
		// model.addAttribute("totalPageSize", totalPageSize);
		// if (totalPageSize <= PAGE_HOLDING_CAPACITY) {
		// model.addAttribute("startat", 1);
		// model.addAttribute("endat", totalPageSize);
		// model.addAttribute("applicants", applicants.subList(1,
		// totalPageSize));
		// } else {
		// model.addAttribute("startat", 1);
		// model.addAttribute("endat", PAGE_HOLDING_CAPACITY);
		// model.addAttribute("applicants", applicants.subList(1,
		// PAGE_HOLDING_CAPACITY));
		// }

		return "redirect:/applicationsDetail/" + jobId + "/1";
	}

	private final int PAGE_HOLDING_CAPACITYZ = 4;
	// int pageNumber;

	@RequestMapping(value = "/applicationsDetail/{jobId}/{pageId}", method = RequestMethod.GET)
	public String applicationsDetail(Model model, @PathVariable int jobId, @PathVariable int pageId) {

		// List<Employee> applicants = applicationService.getApplicants(jobId);
		List<Application> applicants = applicationService.getApplicationsForpost(jobId);

		int totalApplicantSize = applicants.isEmpty() ? 0 : applicants.size();
		// pageNumber = 1;
		int totalPageSize = (totalApplicantSize % PAGE_HOLDING_CAPACITYZ == 0
				? totalApplicantSize / PAGE_HOLDING_CAPACITYZ
				: ((totalApplicantSize - (totalApplicantSize % PAGE_HOLDING_CAPACITYZ)) / PAGE_HOLDING_CAPACITYZ) + 1);
		model.addAttribute("totalPageSize", totalPageSize);
		if (totalPageSize <= 10) {
			model.addAttribute("startat", 1);
			model.addAttribute("endat", totalPageSize);
		} else if (totalPageSize < (pageId + 5)) {
			model.addAttribute("startat", (totalPageSize - 10));
			model.addAttribute("endat", totalPageSize);
		} else {
			model.addAttribute("startat", (pageId - 4));
			model.addAttribute("endat", (pageId + 5));
		}

		if (totalApplicantSize < PAGE_HOLDING_CAPACITYZ) {
			model.addAttribute("applicants", applicants.subList(0, totalApplicantSize));
		} else if (totalApplicantSize < (PAGE_HOLDING_CAPACITYZ * pageId)) {
			model.addAttribute("applicants",
					applicants.subList(PAGE_HOLDING_CAPACITYZ * (pageId - 1), totalApplicantSize));
		} else {
			model.addAttribute("applicants",
					applicants.subList(PAGE_HOLDING_CAPACITYZ * (pageId - 1), PAGE_HOLDING_CAPACITYZ * pageId));
		}
		model.addAttribute("pageNumber", pageId);
		// applicants
		return "applicationsDetail";
	}

	/// cv/20.html
	@RequestMapping("/cv/{applicantId}")
	public String getCV(Model model, @PathVariable int applicantId, HttpServletRequest request,
			HttpServletResponse response) {
		Employee employee = employeeService.getEmployeeByID(applicantId);
		Employee employeeFullInfo = employeeService.getFullEmployeeBy(employee.getEmail());
		model.addAttribute("employee", employeeFullInfo);
		return "employee-detail-cv";
	}

}
