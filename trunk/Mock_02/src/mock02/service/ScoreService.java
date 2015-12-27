package mock02.service;

import java.util.List;

import mock02.dao.ScoreDAO;
import mock02.model.Assignment;
import mock02.model.Member;
import mock02.model.Score;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author: ThaiHa
 * @verision:1.0 Dec 26, 2015
 **/
@Service("scoreService")
public class ScoreService {
    @Autowired
    ScoreDAO scoreDAO;
    public List<Score> getScorebyUserAndAssignment(Member member,
	    Assignment assignment) {
	return scoreDAO.getScorebyUserAndAssignment(member, assignment);
    }
    
}
