package mock02.dao;

import java.util.ArrayList;
import java.util.List;

import mock02.model.Course;
import mock02.model.Member;
import mock02.model.User;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository("memberDao")
@Transactional
public class MemberDAO {
    @Autowired
    private SessionFactory sessionFactory;

    @SuppressWarnings("unchecked")
    // lay member theo user
    // lay
    public List<Member> listMember_User(User user) {
	List<Member> listMember = new ArrayList<Member>();
	Session session = sessionFactory.getCurrentSession();
	Criteria crit = session.createCriteria(Member.class);
	crit.add(Restrictions.eq("user", user));
	listMember = (List<Member>) crit.list();
	return listMember;
    }

    // get member by user and course
    public Member getMemberByUserAndCourse(User user, Course course) {
	Session session = sessionFactory.getCurrentSession();
	Member member = (Member) session.createCriteria(Member.class)
		.add(Restrictions.eqOrIsNull("course", course))
		.add(Restrictions.eqOrIsNull("user", user)).uniqueResult();
	return member;
    }
}
