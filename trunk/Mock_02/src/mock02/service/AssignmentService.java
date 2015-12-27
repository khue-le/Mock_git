package mock02.service;

import java.text.ParseException;
import java.util.List;

import mock02.dao.AssignmentDAO;
import mock02.model.Assignment;
import mock02.model.Course;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author: ThaiHa
 * @verision:1.0 Dec 25, 2015
 **/
@Service("assignmentService")
public class AssignmentService {
	@Autowired
	AssignmentDAO assignmentDAO;

	// get list assignment by id course
	public List<Assignment> getListAssignmentByCourse(int idCourse) throws ParseException {
		Course course = new Course();
		course.setIdCourse(idCourse);
		return assignmentDAO.getListAssignmentByCourse(course);
	}

	// get assignment by id assignment
	public Assignment getAssigment(int idAssignment) {
		return assignmentDAO.getAssigment(idAssignment);
	}
	
	public void addAssignment(Assignment assignment){
		assignmentDAO.addAssignment(assignment);
	}
}
