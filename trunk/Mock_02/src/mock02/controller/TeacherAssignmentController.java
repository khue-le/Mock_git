package mock02.controller;

import java.sql.Blob;
import java.text.ParseException;
import java.util.List;

import javax.sql.rowset.serial.SerialBlob;

import mock02.model.Assignment;
import mock02.model.Course;
import mock02.service.AssignmentService;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

/*
 *@author: nguyenkhue
 *@version 1.0 Dec 26, 2015
 */
@Controller
@SessionAttributes({ "idcourse" })
public class TeacherAssignmentController {

	@Autowired
	AssignmentService assignmentService;

	Log logger = LogFactory.getLog(TeacherAssignmentController.class);

	@RequestMapping("teacher_assignment")
	String accessTeacherAssignment(ModelMap model, @ModelAttribute("idcourse") Integer idCourse)
			throws ParseException {
		List<Assignment> listAssignment = assignmentService.getListAssignmentByCourse(idCourse);
		model.addAttribute("listAssignment", listAssignment);
		model.addAttribute("active", 5);
		return "teacher_assignment";
	}

	@RequestMapping(value = "addassignment.html", method = RequestMethod.POST)
	@ResponseBody
	String saveOrUpdateAssignment(@RequestParam(value="file", required = false) MultipartFile file,
			@ModelAttribute Assignment assignment, @ModelAttribute("idcourse") Integer idCourse)
			throws Exception {
		if(file != null){
			logger.info("file is " + file.toString());
			logger.info("file size " + file.getSize());
			logger.info("file name " + assignment.getAttachFileName());
			Blob blob = new SerialBlob(file.getBytes());
			assignment.setAttachFile(blob);
		}
		Course course = new Course();
		course.setIdCourse(idCourse);
		assignment.setCourse(course);
		assignment.setType("test");
		assignmentService.addAssignment(assignment);
		return "done";
	}
}
