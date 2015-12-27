package mock02.dao;

import java.util.List;

import mock02.model.Assignment;
import mock02.model.Member;
import mock02.model.Score;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author: ThaiHa
 * @verision:1.0 Dec 26, 2015
 **/
@Repository("scoreDAO")
@Transactional
public class ScoreDAO {
    @Autowired
    SessionFactory sessionFactory;

    // get score from by user and assignemnt
    @SuppressWarnings("unchecked")
    public List<Score> getScorebyUserAndAssignment(Member member,
	    Assignment assignment) {
	Session session = sessionFactory.getCurrentSession();
	List<Score> result = (List<Score>) session.createCriteria(Score.class)
		.add(Restrictions.eq("member", member))
		.add(Restrictions.eq("assignment", assignment)).list();
	return result;
    }
}
