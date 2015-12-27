package mock02.dao;

import mock02.model.User;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository("userDao")
@Transactional
public class UserDAO {
	@Autowired
	private SessionFactory sessionFactory;

	public User getUser(int userID) {
		return (User) sessionFactory.getCurrentSession()
				.get(User.class, userID);
	}
//lay user dua vao password, username
	public User getUse_ByUserNamePasword(User user) {
		Session session = sessionFactory.getCurrentSession();
		Criteria crit = session.createCriteria(User.class);
		crit.add(Restrictions.eq("userName", user.getUserName()));
		crit.add(Restrictions.eq("password", user.getPassword()));
		crit.setMaxResults(1);
		User user1 = (User) crit.uniqueResult();
		return user1;
	}
}
