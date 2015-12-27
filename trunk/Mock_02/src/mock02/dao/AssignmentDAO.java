package mock02.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import mock02.model.Assignment;
import mock02.model.Course;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author: ThaiHa
 * @verision:1.0 Dec 25, 2015
 **/
@Repository("assignmentDAO")
@Transactional
public class AssignmentDAO {
	@Autowired
	SessionFactory sessionFactory;

	// get assignment by id assignment
	public Assignment getAssigment(int idAssignment) {
		return (Assignment) sessionFactory.getCurrentSession().get(Assignment.class, idAssignment);
	}

	// get list assignment by course
	// Chỉ get các feild cần thiết không get hết tất cả (commented by khuê)
	@SuppressWarnings("unchecked")
	public List<Assignment> getListAssignmentByCourse(Course course) throws ParseException {
		Session session = sessionFactory.getCurrentSession();
		List<Object> result = (List<Object>) session
				.createCriteria(Assignment.class)
				.add(Restrictions.eq("course", course))
				.setProjection(
						Projections.projectionList().add(Projections.property("idAssignment"))
								.add(Projections.property("assignmentName"))
								.add(Projections.property("openTime")).add(Projections.property("deadline"))
								.add(Projections.property("redoTime"))
								.add(Projections.property("contentAssignment"))
								.add(Projections.property("attachFileName"))
								.add(Projections.property("type"))).list();
		Iterator<Object> itr = result.iterator();
		List<Assignment> listAssignment = new ArrayList<Assignment>();
		Assignment assignment;
		while (itr.hasNext()) {
			assignment = new Assignment();
			Object[] obj = (Object[]) itr.next();
			assignment.setIdAssignment(Integer.parseInt(String.valueOf(obj[0])));
			assignment.setAssignmentName(String.valueOf(obj[1]));
			String timeOpen = String.valueOf(obj[2]);
			if ("null".compareTo(timeOpen) != 0)
				assignment.setOpenTime(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").parse(timeOpen));
			assignment.setDeadline(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").parse(String.valueOf(obj[3])));
			assignment.setRedoTime(Integer.parseInt(String.valueOf(obj[4])));
			assignment.setContentAssignment(String.valueOf(obj[5]));
			if ("null".compareTo(String.valueOf(obj[6])) != 0)
				assignment.setAttachFileName(String.valueOf(obj[6]));
			assignment.setType(String.valueOf(obj[7]));
			listAssignment.add(assignment);
		}
		return listAssignment;
	}
	
	public void addAssignment(Assignment assignment){
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(assignment);
		session.flush();
	}
}
