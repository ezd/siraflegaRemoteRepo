package us.siraflega.services;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import us.siraflega.entities.Company;
import us.siraflega.entities.Education;
import us.siraflega.entities.Employee;
import us.siraflega.entities.Employer;
import us.siraflega.entities.Language;
import us.siraflega.entities.PostedJob;
import us.siraflega.entities.Role;
import us.siraflega.entities.User;
import us.siraflega.entities.Work;
import us.siraflega.entities.WorkExperience;
import us.siraflega.repositories.CompanyRepository;
import us.siraflega.repositories.EducationRepository;
import us.siraflega.repositories.EmployeeRepository;
import us.siraflega.repositories.EmployerRepository;
import us.siraflega.repositories.JobRepository;
import us.siraflega.repositories.LanguageRepository;
import us.siraflega.repositories.RoleRepository;
import us.siraflega.repositories.UserRepository;
import us.siraflega.repositories.WorkExperienceRepository;
import us.siraflega.repositories.WorkRepository;

@Service
@Transactional
public class InitDBService {

	@Autowired
	RoleRepository roleRepository;
	@Autowired
	UserRepository userRepository;
	@Autowired
	CompanyRepository companyRepository;
	@Autowired
	EducationRepository educationRepository;
	@Autowired
	JobRepository jobRepository;
	@Autowired
	LanguageRepository languageRepository;
	@Autowired
	WorkExperienceRepository workExperienceRepository;
	@Autowired
	EmployeeRepository employeeRepository;
	@Autowired
	EmployerRepository employerRepostiory;
	@Autowired
	WorkRepository workRepository;
	
	
	
	@PostConstruct
	public void init() {
		Date startDate = null, endDate = null;
		Role userRole = new Role();
		userRole.setName("ROLE_USER");
		roleRepository.save(userRole);

		Role employeeRole = new Role();
		employeeRole.setName("ROLE_EMPLOYEE");
		roleRepository.save(employeeRole);

		Role employerRole = new Role();
		employerRole.setName("ROLE_EMPLOYER");
		roleRepository.save(employerRole);

		Role adminRole = new Role();
		adminRole.setName("ROLE_ADMIN");
		roleRepository.save(adminRole);
		BCryptPasswordEncoder encoder=new BCryptPasswordEncoder();
		User user = new User();
		user.setUserName("useruser");
		user.setPassword(encoder.encode("useruser"));
		user.setEmail("user@gmail.com");
		user.setEnabled(true);
//		List<Role> roles = new ArrayList<Role>();
//		roles.add(userRole);
		user.setRole(userRole);
		userRepository.save(user);

		User adminUser = new User();
		adminUser.setUserName("adminadmin");
		adminUser.setPassword(encoder.encode("adminadmin"));
		adminUser.setEnabled(true);
		adminUser.setEmail("adminuser@gmail.com");
//		roles = new ArrayList<Role>();
//		roles.add(userRole);
//		roles.add(adminRole);
//		roles.add(employerRole);
//		roles.add(employeeRole);
		adminUser.setRole(adminRole);
		userRepository.save(adminUser);

		User empUser = new User();
		empUser.setUserName("empemp");
		empUser.setPassword(encoder.encode("empemp"));
		empUser.setEnabled(true);
//		roles = new ArrayList<Role>();
//		roles.add(employeeRole);
		empUser.setRole(employeeRole);
		empUser.setEmail("employeeuser@gmail.com");
		userRepository.save(empUser);
		User emprUser = new User();
		emprUser.setUserName("emprempr");
		emprUser.setPassword(encoder.encode("emprempr"));
		emprUser.setEnabled(true);
		emprUser.setEmail("employeruser@gmail.com");
//		roles = new ArrayList<Role>();
//		roles.add(employerRole);
		emprUser.setRole(employerRole);
		userRepository.save(emprUser);

		Employee employee = new Employee();

		employee.setAge(18);
		employee.setEmail("employeeuser@gmail.com");
		employee.setFirstName("EmpFN");
		employee.setMiddleName("EmpMN");
		employee.setLastName("EmpLN");
		employee.setSex("M");
		employee.setSkills("C++,Java,PHP");
		employee.setTelephone("0911-701777");
		employee.setAddress("Kolfea kifleketema, Addis Ababa, Ethiopia");
		// education1
		Education diplomStudy = new Education();
		diplomStudy.setInstitute("Arbaminch");
		diplomStudy.setTitle("Computer Since");
		diplomStudy.setLevel("Advanced Diplom");
		try {
			startDate = new SimpleDateFormat("MM-dd-yyyy", Locale.ENGLISH)
					.parse("01-02-2010");
			endDate = new SimpleDateFormat("MM-dd-yyyy", Locale.ENGLISH)
					.parse("05-03-2013");
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		diplomStudy.setStartDate(startDate);
		diplomStudy.setEndDate(endDate);
		// educationRepository.save(diplomStudy);
		// education2
		Education degreeStudy = new Education();
		degreeStudy.setInstitute("MicroLink");
		degreeStudy.setTitle("Software Engineering");
		degreeStudy.setLevel("BSc.");
		try {
			startDate = new SimpleDateFormat("MM-dd-yyyy", Locale.ENGLISH)
					.parse("06-25-2013");
			endDate = new SimpleDateFormat("MM-dd-yyyy", Locale.ENGLISH)
					.parse("05-02-2015");
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		degreeStudy.setStartDate(startDate);
		degreeStudy.setEndDate(endDate);
		// educationRepository.save(degreeStudy);

		List<Education> educationList = new ArrayList<Education>();
		educationList.add(degreeStudy);
		educationList.add(diplomStudy);
		employee.setEducations(educationList);

		// company

		Company ericssonCompany = new Company();
		ericssonCompany.setName("Ericsson");
		ericssonCompany.setAddress("Centrum Karlskrona 45324");
		ericssonCompany
				.setAreaOfFocus("Telecomunication, Software Engineering, Computer Science");
		ericssonCompany.setLogo(null);
		ericssonCompany.setTelephon("+462495502");
		ericssonCompany.setWebsite("www.ericsson.com");
		ericssonCompany.setCity("KarlsKrona");
		ericssonCompany.setCountry("Sweden");
		companyRepository.save(ericssonCompany);

		Company sysolCompany = new Company();
		sysolCompany.setName("Sysol IT College");
		sysolCompany.setAddress("Saris");
		sysolCompany.setAreaOfFocus("Teaching, Computer Science");
		sysolCompany.setLogo(null);
		sysolCompany.setTelephon("+2519123451");
		sysolCompany.setWebsite("www.sysolIT.com");
		sysolCompany.setCity("Addis Ababa");
		sysolCompany.setCountry("Ethiopia");
		companyRepository.save(sysolCompany);

		Company INSACompany = new Company();
		INSACompany.setName("Information and Nework Security Agency");
		INSACompany.setAddress("Mekanisa");
		INSACompany
				.setAreaOfFocus("Software Engineering, Telecom Engineering, Computer Science");
		
		INSACompany.setLogo(null);
		INSACompany.setTelephon("+2510853451");
		INSACompany.setWebsite("www.insa.et.org");
		INSACompany.setCity("Addis Ababa");
		INSACompany.setCountry("Ethiopia");
		companyRepository.save(INSACompany);

		// Experiance1
		WorkExperience labTechExp = new WorkExperience();
		labTechExp.setCompany(sysolCompany);
		labTechExp.setPostion("Lab Technician");
		labTechExp
				.setDiscription("I have worked as system administrator, Lab Technician and teacher."
						+ "I have developed an application used for registering students and manageing the grading systems");
		try {
			startDate = new SimpleDateFormat("dd-MM-yyyy", Locale.ENGLISH)
					.parse("25-06-2006");
			endDate = new SimpleDateFormat("dd-MM-yyyy", Locale.ENGLISH)
					.parse("02-25-2007");
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		labTechExp.setStarts(startDate);
		labTechExp.setEnds(endDate);
		// workExperienceRepository.save(labTechExp);
		// Experiance2
		WorkExperience programmerExp = new WorkExperience();
		programmerExp.setCompany(INSACompany);
		programmerExp
				.setPostion("Software Programmer, Team Leader and Project Manager");
		programmerExp
				.setDiscription("I have worked as system developer, Software project manager and team leader."
						+ "I have developed an application used for registering students and manageing the grading systems");
		try {
			startDate = new SimpleDateFormat("dd-MM-yyyy", Locale.ENGLISH)
					.parse("25-11-2008");
			endDate = new SimpleDateFormat("dd-MM-yyyy", Locale.ENGLISH)
					.parse("02-05-2010");
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		programmerExp.setStarts(startDate);
		programmerExp.setEnds(endDate);
		programmerExp.setCurrentlyWorking(true);
		// workExperienceRepository.save(programmerExp);

		List<WorkExperience> experiences = new ArrayList<WorkExperience>();
		experiences.add(programmerExp);
		experiences.add(labTechExp);
		employee.setExperiences(experiences);
		// Language1
		Language amharicLang = new Language();
		amharicLang.setName("Amharic");
		amharicLang.setLevel("Full Professional Proficiency");
		// languageRepository.save(amharicLang);
		// Language2
		Language englishLang = new Language();
		englishLang.setName("English");
		englishLang.setLevel("Native Proficiency");
		// languageRepository.save(englishLang);
		List<Language> languages = new ArrayList<Language>();
		languages.add(englishLang);
		languages.add(amharicLang);
		employee.setLanguages(languages);
		employeeRepository.save(employee);
		englishLang.setTalkedby(employee);
		languageRepository.save(englishLang);
		amharicLang.setTalkedby(employee);
		languageRepository.save(amharicLang);
		programmerExp.setWorkedBy(employee);
		workExperienceRepository.save(programmerExp);
		labTechExp.setWorkedBy(employee);
		workExperienceRepository.save(labTechExp);
		degreeStudy.setEmployee(employee);
		educationRepository.save(degreeStudy);
		diplomStudy.setEmployee(employee);
		educationRepository.save(diplomStudy);

		Employer employerJohan = new Employer();
		employerJohan.setFirstName("Johan");
		employerJohan.setMiddleName("Alakewim");
		employerJohan.setLastName("Svensson");
		employerJohan.setTelephone("2062291976");
		employerJohan.setEmail("employeruser@gmail.com");
		//employer.setWorksFor(INSACompany);
		employerRepostiory.save(employerJohan);
//		List<PostedJob> jobs = new ArrayList<PostedJob>();
		PostedJob job;
for(int i=0;i<12;i++){
		job = new PostedJob();
		try {
			startDate = new SimpleDateFormat("dd-MM-yyyy", Locale.ENGLISH)
					.parse("25-11-2015");
			endDate = new SimpleDateFormat("dd-MM-yyyy", Locale.ENGLISH)
					.parse("29-11-2015");
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		job.setDeadLine(endDate);
		job.setPostedDate(startDate);
		job.setCompany(INSACompany);
		job.setDiscription(i+".The team works with agility where your effort is very important. "
				+ "The team will be jointly responsible for the entire platform and you will have great opportunities "
				+ "to influence and shape your work. All development is done Agile with Scrum and elements of "
				+ "Kanban and test driven. The team uses open source and is active in the communities around the "
				+ "products Ticket use.In the role of Java Developer you will work on developing new features "
				+ "in the company's e-commerce platform. You will participate in the process from the "
				+ "creation story to its production launch and also to help support business owners in the "
				+ "functional discussions.");
		job.setEmail("jobs@ericsson.com");
		job.setHowToApply("You can apply through email, using our website \"www.ericsson.com/Career\" or in person");
		job.setPhone("+46029245502");
		job.setPosition("Software programmer II");
		job.setRqdEducation("BSc or above in computer science, software engineering or Telecom");
		job.setRqdExperianceyears(2);
		job.setRqdSkills("When the Ticket says that the goal is Continuous delivery so you can understand the company's "
				+ "thoughts and like values ​​involved. Furthermore, you have a deep knowledge of CSS, HTML5 and JavaScript. "
				+ "We see that you are fluent in Swedish and English when communication takes place in both languages");
		job.setSallery("Negotaible");
		job.setTitle("Software programmer");
//		jobs.add(job);
		job.setJobPostedBy(employerJohan);
		System.out.println("..................................................................................................");
		jobRepository.save(job);
}
		// Job2
		PostedJob job2 = new PostedJob();

		try {
			startDate = new SimpleDateFormat("dd-MM-yyyy", Locale.ENGLISH)
					.parse("25-06-2005");
			endDate = new SimpleDateFormat("dd-MM-yyyy", Locale.ENGLISH)
					.parse("29-07-2018");
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		job2.setDeadLine(endDate);
		job2.setPostedDate(startDate);
		job2.setCompany(INSACompany);
		job2.setDiscription("222The Second job at ericsson is as follows. team works with agility where your effort is very important. "
				+ "The team will be jointly responsible for the entire platform and you will have great opportunities "
				+ "to influence and shape your work. All development is done Agile with Scrum and elements of "
				+ "Kanban and test driven. The team uses open source and is active in the communities around the "
				+ "products Ticket use.In the role of Java Developer you will work on developing new features "
				+ "in the company's e-commerce platform. You will participate in the process from the "
				+ "creation story to its production launch and also to help support business owners in the "
				+ "functional discussions.");
		job2.setEmail("jobs@ericsson.com");
		job2.setHowToApply("You can apply through email, using our website \"www.ericsson.com/Career\" or in person");
		job2.setPhone("+46029245502");
		job2.setPosition("Software Specialist II");
		job2.setRqdEducation("BSc or above in computer science, software engineering or Telecom");
		job2.setRqdExperianceyears(5);
		job2.setRqdSkills("The second skill required is as follow. When the Ticket says that the goal is Continuous delivery so you can understand the company's "
				+ "thoughts and like values ​​involved. Furthermore, you have a deep knowledge of CSS, HTML5 and JavaScript. "
				+ "We see that you are fluent in Swedish and English when communication takes place in both languages");
		job2.setSallery("Negotaible");
		job2.setTitle("Software programmer");

		
//		jobs.add(job2);
		

		
		job2.setJobPostedBy(employerJohan);
		jobRepository.save(job2);
		
		Work employerWork=new Work();
		employerWork.setCompany(ericssonCompany);
		employerWork.setCurrentlyWorking(true);
		employerWork.setWorkedBy(employerJohan);
		employerWork.setPostion("Department Head");
		try {
			startDate = new SimpleDateFormat("dd-MM-yyyy", Locale.ENGLISH)
					.parse("25-11-2000");
//			endDate = new SimpleDateFormat("MMMM d, yyyy", Locale.ENGLISH)
//					.parse("November 29, 2015");
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		employerWork.setCurrentlyWorking(true);
		employerWork.setStartsFrom(startDate);
		// System.out.println("THe status is++++++++++"+employeeRepository.findByEmail("user@gmail.com").getEducations().size()+"++++++++++++++++++++++");
		workRepository.save(employerWork);
	}

}
