package mock02.controller;

import java.text.ParseException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import mock02.model.Assignment;
import mock02.model.Course;
import mock02.model.Member;
import mock02.model.Score;
import mock02.model.User;
import mock02.service.AssignmentService;
import mock02.service.CourseService;
import mock02.service.MemberService;
import mock02.service.ScoreService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

/**
 * @author: ThaiHa
 * @verision:1.0 Dec 25, 2015
 **/
@Controller
@SessionAttributes({ "idcourse" })
public class StudentAssignmentController {
    @Autowired
    AssignmentService assignmentService;
    @Autowired
    ScoreService scoreService;
    @Autowired
    MemberService memberService;
    @Autowired
    CourseService courseService;

    @RequestMapping(value = "student_Assignments")
    String getAssignmentListbyCourse(ModelMap model,
	    @ModelAttribute("idcourse") int idCourse) throws ParseException {
	List<Assignment> listAssignment = assignmentService
		.getListAssignmentByCourse(idCourse);
	model.addAttribute("listAssignment", listAssignment);
	 model.addAttribute("active", 4);
	 Course course=courseService.getCourse(idCourse);
	 model.addAttribute("course", course);
	return "student_Assignments";
    }

    @RequestMapping(value = "student_assignment")
    String getAssignment(ModelMap model,
	    @ModelAttribute("command") Assignment assignment1,
	    HttpSession session, User user, HttpServletRequest request,
	    @ModelAttribute("idcourse") int idCourse) {
	// get assignment by id assigment ok
	Assignment assignment = assignmentService.getAssigment(assignment1
		.getIdAssignment());
	model.addAttribute("assignment", assignment);
	session = request.getSession();
	// get user by attribute ok
	user = (User) session.getAttribute("teacher_cur");
	// get course by id course ok
	Course course = courseService.getCourse(idCourse);
	// get member by user and course ok
	Member member = memberService.getMemberByUserAndCourse(user, course);
	List<Score> listScore = scoreService.getScorebyUserAndAssignment(
		member, assignment);
	model.addAttribute("active", 4);
	model.put("listScore", listScore);
	return "student_assignment";
    }
}
