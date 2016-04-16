package us.siraflega.controllers;

import java.security.Principal;
import java.sql.Blob;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.hibernate.Hibernate;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.format.datetime.DateFormatter;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;

import us.siraflega.entities.Company;
import us.siraflega.entities.Education;
import us.siraflega.entities.Employee;
import us.siraflega.entities.Employer;
import us.siraflega.entities.PostedJob;
import us.siraflega.entities.Role;
import us.siraflega.entities.User;
import us.siraflega.entities.Work;
import us.siraflega.entities.WorkExperience;
import us.siraflega.repositories.WorkRepository;
import us.siraflega.services.CompanyService;
import us.siraflega.services.EmployeeService;
import us.siraflega.services.EmployeerService;
import us.siraflega.services.PostedJobService;
import us.siraflega.services.UserService;
import us.siraflega.services.WorkExperienceService;
import us.siraflega.services.WorkeService;

@Controller
public class UserController {

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

	@RequestMapping("/users")
	public String getUsersList(Model model) {
		List<User> usersList = userService.getAllUsers();
		System.out.println("comes to user controller : " + usersList.size());
		model.addAttribute("users", usersList);
		return "users";
	}

	public List<String> getCompanyNameList(List<Company> companyList) {
		List<String> companyNameList = new ArrayList<String>();
		for (Company company : companyList) {
			companyNameList.add(company.getName());
			System.out.println("list********************************");
		}
		return companyNameList;
	}

	@RequestMapping(value = "/cities", method = RequestMethod.GET)
	@ResponseBody
	public String searchCities(HttpServletRequest req) {
		String query = req.getParameter("q");
		List<String> existingCitiesList = companyService.getCityList(query);
		Gson gson = new Gson();
		System.out.println("raw value:" + req.getParameter("q"));
		String jsonstring = gson.toJson(existingCitiesList);
		System.out.println("the json value:" + jsonstring);
		return jsonstring;
	}

	@RequestMapping("/register")
	public String registerForm() {
		return "user-register";
	}

	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String registerUser(Model model, @ModelAttribute("user") User user,
			@RequestParam("type") String type,
			final RedirectAttributes redirectAttributes,
			HttpServletRequest request) {
		String unEncPass = user.getPassword();
		String unEncUserName = user.getUserName();
		System.out.println("type is:" + type + "password name is" + unEncPass);
		if ((userService.getUserByEmail(user.getEmail()) != null)
				|| (userService.getUserByName(user.getUserName()) != null)) {
			redirectAttributes.addFlashAttribute("user", user);
			return "redirect:/register.html?success=false&message=Exists";
		}
		User savedUser = userService.saveUser(user, type);
		System.out.println("comes to save");
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

	private void authenticateUserAndSetSession(String username,
			String password, HttpServletRequest request) {
		// String username = user.getUserName();
		// String password = unEncPass;
		System.out.println("==================error happen wnen trying to use:"
				+ username + " and " + password + "========================");
		UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(
				username, password);

		// generate session if one doesn't exist
		request.getSession();

		token.setDetails(new WebAuthenticationDetails(request));
		try {
			Authentication authenticatedUser = authenticationManager
					.authenticate(token);
			SecurityContextHolder.getContext().setAuthentication(
					authenticatedUser);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@RequestMapping(value = "/userDetail", method = RequestMethod.GET)
	public String registerUserDetail(Model model, Principal principal,
			HttpServletRequest request, HttpServletResponse response,
			final RedirectAttributes redirectAttributes) {
		String name = principal.getName();
		User user = userService.getUserByName(name);
		if (user == null) {
			System.out.println("about to session invalidate and log in again");
			logOutAndInvalidate(request, response);

			return "redirect:/userDetail";
		}
		System.out.println("username:" + name);
		System.out
				.println("=====================Role checking============================");
		Role userRole = user.getRole();
		// for (Role r : userRoles) {
		System.out.println("userrole:" + userRole.getName());
		// }
		model.addAttribute("user", user);
		Employee employee = employeeService.getEmployeeBy(user.getEmail());
		model.addAttribute("employee", employee);
		Employer employer = employerService.getEmployerBy(user.getEmail());
		model.addAttribute("employer", employer);
		if (userRole.getName().toString().equalsIgnoreCase("ROLE_EMPLOYEE")) {
			model.addAttribute("type", "employee");
			System.out.println("employee type setted");
		} else if (userRole.getName().toString()
				.equalsIgnoreCase("ROLE_EMPLOYER")) {
			model.addAttribute("type", "employer");
			System.out.println("employer type setted");
		}
		System.out.println(" as a type it comes to user detal with:"
				+ user.getUserName());
		return "userDetail";
	}

	private void logOutAndInvalidate(HttpServletRequest request,
			HttpServletResponse response) {
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
		System.out.println("Email to be used:" + id);
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
		Session session = Session.getDefaultInstance(props,
				new javax.mail.Authenticator() {
					protected PasswordAuthentication getPasswordAuthentication() {
						return new PasswordAuthentication(
								"seatac.test@gmail.com", "test654321");
					}
				});
		try {
			// Create a default MimeMessage object.
			MimeMessage message = new MimeMessage(session);
			// Set From: header field of the header.
			message.setFrom(new InternetAddress(from));
			// Set To: header field of the header.
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(
					to));
			// Set Subject: header field
			message.setDescription("This is the discription");
			message.setSubject("xProfile combilation reminder from Siraflega.com!");
			// Now set the actual message

			message.setContent(
					"<body><strong>Hi "
							+ user.getUserName()
							+ "</strong>, <br>"
							+ "You have created user account on <a href=\"www.siraflega.com\">www.siraflega.com</a> not yet completed. "
							+ "In order to get the full penefit of the application please complete your <a href=\"www.siraflega.com\">profile</a>.<br>"
							+ "Best regards,<br>" + "Admin</body>",
					"text/html; charset=utf-8");
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
	public String getMyAccount(Model model, Principal principal,
			HttpServletRequest request, HttpServletResponse response) {
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
		if (employee != null) {
			model.addAttribute("employee", employee);
			return "employee-detail";
		}
		if (employer != null) {
			Work currentWork = employer.getWorks()==null? employer.getWorks().get(0):null;
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
	public String updateEmployee(@ModelAttribute("employee") Employee employee,
			Model model, Principal principal) {
		User logedInUser = userService.getUserByName(principal.getName());
		if (employee.getId() != null) {
			employee.setEmail(logedInUser.getEmail());
			employeeService.updateEmployee(employee);
		} else {
			employee.setEmail(logedInUser.getEmail());
			employeeService.saveEmployee(employee);
		}

		return "redirect:/account";
	}

	@RequestMapping(value = "/saveEmployeePersonalInfo", method = RequestMethod.POST)
	public String saveEmployeePersonalInfo(
			@ModelAttribute("employee") Employee employee, Model model) {
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
		System.out.println(jsonCompany.toString());
		Gson gson = new Gson();
		Company company = (Company) gson.fromJson(jsonCompany, Company.class);
		Company savedCompany = companyService.saveNewCompany(company);
		return gson.toJson(savedCompany);
	}

	

	@RequestMapping(value = "/deleteWorkExp", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody String deleteWorkExp(@RequestBody String jsonWork) {

		JSONObject jsonObject = new JSONObject(jsonWork);
		String idToBeDeleted = jsonObject.getString("id");
		System.out.println("Id to be delete isssssssssssssssssss:"
				+ idToBeDeleted);
		workExperienceService.deleteExp(Integer.parseInt(idToBeDeleted));
		return jsonObject.toString();
	}

	// updatePassword
	@RequestMapping(value = "/updateUser", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody String updateUser(@RequestBody String jsonUser,
			Principal principal, HttpServletRequest request) {
		String name = principal.getName();
		System.out.println("come to ajax with" + jsonUser);
		User exisitingUser = userService.getUserByName(name);
		JSONObject jsonObject = new JSONObject(jsonUser);
		String newUserName = jsonObject.getString("userName");
		String newUserEmail = jsonObject.getString("userEmail");
		exisitingUser.setUserName(newUserName);
		exisitingUser.setEmail(newUserEmail);
		if ((userService.getUserByEmail(newUserEmail) != null)
				|| (userService.getUserByName(newUserName) != null)) {
			return jsonObject.put("isExists", "exist").toString();
		} else {
			User updatedUser = userService.saveUser(exisitingUser);
			// authenticateUserAndSetSession(updatedUser.getUserName(),
			// updatedUser.getPassword(), request);
			jsonObject.put("id", "" + updatedUser.getId());
			jsonObject.put("userName", updatedUser.getUserName());
			jsonObject.put("email", updatedUser.getEmail());
			return jsonObject.toString();
		}
	}

	@RequestMapping(value = "/updatePassword", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody String updatePassword(
			@RequestBody String jsonUserPassword, Principal principal,
			HttpServletRequest request, HttpServletResponse response) {
		System.out.println("come to ajax with" + jsonUserPassword);
		JSONObject jsonObject = new JSONObject(jsonUserPassword);
		String newUserEmail = jsonObject.getString("userEmail");
		String newUserPassword = jsonObject.getString("userPassword");
		User exisitingUser = userService.getUserByEmail(newUserEmail);
		exisitingUser.setEmail(newUserEmail);
		exisitingUser.setPassword(newUserPassword);
		User updatedUser = userService.saveUser(exisitingUser);
		if (updatedUser != null) {
			System.out.println("++++++++++++++++++++++");
			logOutAndInvalidate(request, response);
			authenticateUserAndSetSession(updatedUser.getUserName(),
					newUserPassword, request);
			jsonObject.put("redirect", "true");
		}
		return jsonObject.toString();
	}

	@RequestMapping(value = "/updateEmployerInfo", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody String updateEmployerInfo(
			@RequestBody String jsonEmployer) {
		System.out.println("come to ajax with" + jsonEmployer);

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
	public @ResponseBody String saveEmployerInfo(
			@RequestBody String jsonEmployer) {
		System.out.println("come to ajax with" + jsonEmployer);

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
	public @ResponseBody String saveWorkExp(@RequestBody String jsonWork,
			Principal principal) {
		String name = principal.getName();
		User user = userService.getUserByName(name);
		Employee employee = employeeService.getEmployeeBy(user.getEmail());
		JSONObject jsonObject = new JSONObject(jsonWork);
		String companyId = jsonObject.getString("companyId");
		String position = jsonObject.getString("position");
		String startDate = jsonObject.getString("startDate");
		Date start_Date = null;
		try {
			start_Date = new SimpleDateFormat("dd/MM/yyyy", Locale.ENGLISH)
					.parse(startDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String endDate = jsonObject.getString("endDate");
		Date end_Date = null;
		try {
			end_Date = new SimpleDateFormat("dd/MM/yyyy", Locale.ENGLISH)
					.parse(endDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String description = jsonObject.getString("description");
		String workExpId = jsonObject.getString("workExpId");
		boolean isCurrentlyWorking = jsonObject.getBoolean("isCurrent");
		Company newCompanySelected = companyService.getCompany(Integer
				.parseInt(companyId));
		WorkExperience newWorkExp = new WorkExperience();
		newWorkExp.setWorkedBy(employee);
		newWorkExp.setCompany(newCompanySelected);
		newWorkExp.setPostion(position);
		newWorkExp.setStarts(start_Date);
		newWorkExp.setEnds(end_Date);
		newWorkExp.setDiscription(description);
		newWorkExp.setCurrentlyWorking(isCurrentlyWorking);
		WorkExperience savedWorkExp = workExperienceService
				.saveExpriance(newWorkExp);
		jsonObject.put("id", "" + savedWorkExp.getId());
		jsonObject.put("companyId", "" + savedWorkExp.getCompany().getId());
		jsonObject.put("position", savedWorkExp.getPostion());
		jsonObject.put("startDate", savedWorkExp.getStarts() + "");
		jsonObject.put("endDate", savedWorkExp.getEnds() + "");
		jsonObject.put("companyName", savedWorkExp.getCompany().getName());
		jsonObject.put("companyCity", savedWorkExp.getCompany().getCity());
		jsonObject
				.put("companyCountry", savedWorkExp.getCompany().getCountry());
		jsonObject.put("description", savedWorkExp.getDiscription());
		jsonObject.put("isCurrentlyWorking", savedWorkExp.isCurrentlyWorking());
		return jsonObject.toString();
	}

	@RequestMapping(value = "/saveEmployerWrorkExp", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody String saveEmployerWrorkExp(
			@RequestBody String jsonWork, Principal principal) {
		System.out.println("mitamitamitmita "+jsonWork);
		String name = principal.getName();
		User user = userService.getUserByName(name);
		Employer employer = employerService.getEmployerBy(user.getEmail());
		JSONObject jsonObject = new JSONObject(jsonWork);
		String companyId = jsonObject.getString("companyId");
		String position = jsonObject.getString("position");
		String startDate = jsonObject.getString("startDate");
		Date start_Date = null;
		try {
			start_Date = new SimpleDateFormat("dd/MM/yyyy", Locale.ENGLISH)
					.parse(startDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String endDate = jsonObject.getString("endDate");
		Date end_Date = null;
		try {
			end_Date = new SimpleDateFormat("dd/MM/yyyy", Locale.ENGLISH)
					.parse(endDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		boolean isCurrentlyWorking = jsonObject.getBoolean("isCurrent");
		Company newCompanySelected = companyService.getCompany(Integer
				.parseInt(companyId));
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
		System.out.println("updateeeeeeeeeeeee come withhhhhhh"
				+ jsonWork.toString());
		JSONObject jsonObject = new JSONObject(jsonWork);
		String companyId = jsonObject.getString("companyId");
		String position = jsonObject.getString("position");
		String startDate = jsonObject.getString("startDate");
		Date start_Date = null;
		try {
			start_Date = new SimpleDateFormat("dd/MM/yyyy", Locale.ENGLISH)
					.parse(startDate);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		String endDate = jsonObject.getString("endDate");
		Date end_Date = null;
		try {
			end_Date = new SimpleDateFormat("dd/MM/yyyy", Locale.ENGLISH)
					.parse(endDate);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		String description = jsonObject.getString("description");
		String workExpId = jsonObject.getString("workExpId");
		boolean isCurrentlyWorking = jsonObject.getBoolean("isCurrent");
		System.out.println(companyId + '-' + position + '-' + startDate + '-'
				+ endDate + '-' + description + '-' + workExpId + '-'
				+ isCurrentlyWorking);
		Company newCompanySelected = companyService.getCompany(Integer
				.parseInt(companyId));
		WorkExperience workExpToBeEdited = workExperienceService
				.getworkExpriance(Integer.parseInt(workExpId));
		workExpToBeEdited.setCompany(newCompanySelected);
		workExpToBeEdited.setPostion(position);
		workExpToBeEdited.setStarts(start_Date);
		workExpToBeEdited.setEnds(end_Date);
		workExpToBeEdited.setDiscription(description);
		workExpToBeEdited.setCurrentlyWorking(isCurrentlyWorking);
		WorkExperience savedWorkExp = workExperienceService
				.updateExpriance(workExpToBeEdited);
		jsonObject.put("id", "" + savedWorkExp.getId());
		jsonObject.put("companyId", "" + savedWorkExp.getCompany().getId());
		jsonObject.put("position", savedWorkExp.getPostion());
		jsonObject.put("startDate", savedWorkExp.getStarts() + "");
		jsonObject.put("endDate", savedWorkExp.getEnds() + "");
		jsonObject.put("companyName", savedWorkExp.getCompany().getName());
		jsonObject.put("companyCity", savedWorkExp.getCompany().getCity());
		jsonObject
				.put("companyCountry", savedWorkExp.getCompany().getCountry());
		jsonObject.put("description", savedWorkExp.getDiscription());
		jsonObject.put("isCurrentlyWorking", savedWorkExp.isCurrentlyWorking());
		return jsonObject.toString();
	}
	@RequestMapping(value = "/updateEmployerWrokExp", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody String updateEmployerWrokExp(
			@RequestBody String jsonWork, Principal principal) {
		System.out.println("mitamitamitmita "+jsonWork);
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
			start_Date = new SimpleDateFormat("dd/MM/yyyy", Locale.ENGLISH)
					.parse(startDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String endDate = jsonObject.getString("endDate");
		Date end_Date = null;
		try {
			end_Date = new SimpleDateFormat("dd/MM/yyyy", Locale.ENGLISH)
					.parse(endDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		boolean isCurrentlyWorking = jsonObject.getBoolean("isCurrent");
		Company newCompanySelected = companyService.getCompany(Integer
				.parseInt(companyId));
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
	//deleteEmployerWorkExp
	@RequestMapping(value = "/deleteEmployerWorkExp", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody String deleteEmployerWorkExp(@RequestBody String jsonWork) {

		JSONObject jsonObject = new JSONObject(jsonWork);
		String idToBeDeleted = jsonObject.getString("id");
		System.out.println("===============******Id to be delete isssssssssssssssssss:"
				+ idToBeDeleted);
		workService.deleteExp(Integer.parseInt(idToBeDeleted));
		return jsonObject.toString();
	}
	//employerPosts
	@RequestMapping("/employerPosts/{pageNumber}")
	public String registerForm(Model model,Principal principal,@PathVariable int pageNumber) {
		String userName=principal.getName();
		User user=userService.getUserByName(userName);
		Employer employer=employerService.getEmployerBy(user.getEmail());
		int totalJobsSize=postedJobService.getPostedJobs(employer)==null?0:postedJobService.getPostedJobs(employer).size();
		int pageHoldingCapacity=1;
		int totalPageSize=(totalJobsSize%pageHoldingCapacity==0?totalJobsSize/pageHoldingCapacity:((totalJobsSize-(totalJobsSize%pageHoldingCapacity))/pageHoldingCapacity)+1);
		System.out.println("????????????totalPageSize:"+totalPageSize);
		model.addAttribute("totalPageSize", totalPageSize);
		List<PostedJob>postedJobs=postedJobService.getPostedJobs(employer,pageNumber,pageHoldingCapacity);
		System.out.println("========size"+postedJobs.size());
		model.addAttribute("pageNumber", pageNumber);
		model.addAttribute("employer", employer);
		model.addAttribute("postedJobs", postedJobs);
		model.addAttribute("currentDate", new Date());
		List<Company> companyList = companyService.getCompanyList();
		model.addAttribute("companyObjList", companyList);
		
		int startat=1;
		int endat=10;
		if(totalPageSize<=10){
			startat=1;
			endat=totalPageSize;
		}else if(pageNumber<=5){
			startat=1;
			endat=10;
		}else if((pageNumber+5)>totalPageSize){
			startat=totalPageSize-10;
			endat=totalPageSize;
		}else{
			startat=pageNumber-4;
			endat=pageNumber+5;
		}
		model.addAttribute("startat", startat);
		model.addAttribute("endat", endat);
		
		
		return "employerPosts";
	}
//	DD/MM/YYYY
	@InitBinder
	public void initBinderAll(WebDataBinder binder) {
	    binder.registerCustomEditor(Company.class, new CompanyPropertyEditor());
	    
	}
	@RequestMapping(value="/postJob",method=RequestMethod.POST)
	String postJob(Model model,@ModelAttribute @Valid PostedJob job,BindingResult result, Principal principal ){
		System.out.println("come for job posting===========================================");
		String userName=principal.getName();
		User user=userService.getUserByName(userName);
		Employer poster=employerService.getEmployerBy(user.getEmail());
		job.setJobPostedBy(poster);
		if(job.getId()==null){
		postedJobService.save(job);
		}else{
//			System.out.println("the id value isssssssssssssssssss:"+request.getParameter("pageNumber")+"is the vaaaaaaaaaaaaaaaalue");
			PostedJob existingJob=postedJobService.getPostdJob(job.getId());
			existingJob.setCompany(job.getCompany());
			existingJob.setDeadLine(job.getDeadLine());
			existingJob.setDiscription(job.getDiscription());
			existingJob.setEmail(job.getEmail());
			existingJob.setHowToApply(job.getHowToApply());
			existingJob.setPhone(job.getPhone());
			existingJob.setPosition(job.getPosition());
			existingJob.setPostedDate(job.getPostedDate());
			existingJob.setRqdEducation(job.getRqdEducation());
			existingJob.setRqdExperianceyears(job.getRqdExperianceyears());
			existingJob.setRqdSkills(job.getRqdSkills());
			existingJob.setSallery(job.getSallery());
			existingJob.setTitle(job.getTitle());
			postedJobService.save(existingJob);
		}
		return "redirect:/employerPosts/1.html";
				//"redirect:/employerPosts/1.html";
	}
	
	
	@RequestMapping(value="/jobPost/{jobId}", method=RequestMethod.GET)
	String preview(Model model, @PathVariable int jobId){ 
		System.out.println("it wi comes to preview withlhhhhhhhhhhhhhhhh"+1);
		PostedJob postedJob=postedJobService.getPostdJob(jobId);
		model.addAttribute("postedJob", postedJob);
		model.addAttribute("currentDate", new Date());
		return "previewJob";
	}
//	deletePostedJob
	@RequestMapping(value = "/deletePostedJob", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody String deletePostedJob(@RequestBody String jsonPostedJob) {

		JSONObject jsonObject = new JSONObject(jsonPostedJob);
		String idToBeDeleted = jsonObject.getString("id");
		System.out.println("===============******Id to be delete isssssssssssssssssss:"
				+ idToBeDeleted);
		postedJobService.deletePostedJob(Integer.parseInt(idToBeDeleted));
		return jsonObject.toString();
	}
}
