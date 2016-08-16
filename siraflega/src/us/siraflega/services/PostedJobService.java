package us.siraflega.services;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;

import us.siraflega.entities.Employer;
import us.siraflega.entities.PostedJob;
import us.siraflega.repositories.JobRepository;

@Service
public class PostedJobService {
	@Autowired
	JobRepository jobRepository;

	public List<PostedJob> getPostedJobs(Employer employer, int pageNumber, int pageHoldingCapacity) {
		// new PageRequest(0, 10, Direction.DESC, "publishedDate")
		// , new PageRequest(pageNumber, 10, Direction.DESC, "deadLine")
		return jobRepository.findByJobPostedBy(employer,
				new PageRequest(pageNumber - 1, pageHoldingCapacity, Direction.DESC, "deadLine"));
	}

	public List<PostedJob> getPostedJobs(Employer employer) {
		// TODO Auto-generated method stub
		return jobRepository.findByJobPostedBy(employer);
	}

	public void save(PostedJob job) {
		System.out.println("the id to be saveeeeeeeeeeeeeeeeeeeeeeeeeed" + job.getId());
		jobRepository.save(job);
	}

	public PostedJob getPostdJob(Integer id) {
		// TODO Auto-generated method stub
		return jobRepository.findOne(id);
	}

	public void deletePostedJob(int id) {
		jobRepository.delete(id);

	}

	public int getPostedJobsSize() {
		// TODO Auto-generated method stub
		return (int) jobRepository.count();
	}

	public int getPostedJobsSize(String catigory) {
		// TODO Auto-generated method stub
		if (catigory.equals("all")) {
			return this.getPostedJobsSize();
		} else {
			return (int) jobRepository.countCatigory(catigory);
		}
	}

	public List<PostedJob> getPostedJobs(int pageNumber, int pageHoldingCapacity) {
		// TODO Auto-generated method stub
		Page<PostedJob> currentPage = jobRepository
				.findAll(new PageRequest(pageNumber - 1, pageHoldingCapacity, Direction.DESC, "postedDate"));
		List<PostedJob> jobList = new ArrayList<PostedJob>();
		for (PostedJob postedJob : currentPage) {
			jobList.add(postedJob);
		}
		return jobList;
	}

	public List<PostedJob> getPostedJobs(int pageNumber, String catigoriy, int pageHoldingCapacity) {
		// TODO Auto-generated method stub
		if (catigoriy.equals("all")) {
			return this.getPostedJobs(pageNumber, pageHoldingCapacity);
		} else {
			Page<PostedJob> currentPage = jobRepository.findByTitle(catigoriy,
					new PageRequest(pageNumber - 1, pageHoldingCapacity, Direction.DESC, "postedDate"));
			List<PostedJob> jobList = new ArrayList<PostedJob>();
			for (PostedJob postedJob : currentPage) {
				jobList.add(postedJob);
			}
			return jobList;
		}
	}

	public List<String> getcatigoriesContains(String query) {
		// TODO Auto-generated method stub
		List<String> mostrelatedPostions = new ArrayList<String>();
		mostrelatedPostions = jobRepository.findJobCatigoriesContainsPositionStarts(query);
		// List<String> lessrelatedPostions = new ArrayList<String>();
		for (String lessrelateditem : jobRepository.findJobCatigoriesContainsDescriptionStarts(query)) {
			if (!mostrelatedPostions.contains(lessrelateditem)) {
				mostrelatedPostions.add(lessrelateditem);
			}
		}
		// lessrelatedPostions=jobRepository.findJobCatigoriesContainsDescriptionStarts(query);
		// mostrelatedPostions.addAll(lessrelatedPostions);
		return mostrelatedPostions;

	}

	public List<String> getPositionList() {
		// TODO Auto-generated method stub
		return jobRepository.findAllPositions();
	}

	public List<PostedJob> getTop10Jobs(String position) {
		// TODO Auto-generated method stub
		return jobRepository.findTop10ByPositionOrderByPostedDateDesc(position);
	}

}
