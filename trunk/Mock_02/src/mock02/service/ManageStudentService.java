package mock02.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mock02.dao.ManageStudentDAO;
import mock02.model.Course;
import mock02.model.Score;
import mock02.model.User;

/*
* TramTran(^^)
*/
@Service("manageStudentService")
public class ManageStudentService {
    
    @Autowired
    private ManageStudentDAO manageStudentDAO;
    
    public boolean insertUser(User user,Course course){
        return manageStudentDAO.insertUser(user, course);
    }
    public boolean updateUser(User user){
        return manageStudentDAO.updateUser(user);
    }
    public boolean deleteUserofCourse(User u,Course c){
        return manageStudentDAO.deleteUserofCourse(u, c);
    }
    public User getUser(String userName){
        return manageStudentDAO.getUser(userName);
    }
    public User getUser(int userID){
        return manageStudentDAO.getUser(userID);
    }
    public List<Course> getListCourse(User teacher){
        return manageStudentDAO.getListCourse(teacher);
    }
    public List<User> getListStudent(Course course){
        return manageStudentDAO.getListStudent(course);
    }
    public List<User> getListStudent(User teacher,Course course){
        return manageStudentDAO.getListStudent(teacher, course);
    }
    public boolean insertMember(User user, Course course){
        return manageStudentDAO.insertMember(user, course);
    }
    public Course getCourse(int id){
        return manageStudentDAO.getCourse(id);
    }
    public List<Score> getListScore(User student,Course course){
        return manageStudentDAO.getListScore(student, course);
    }
}
