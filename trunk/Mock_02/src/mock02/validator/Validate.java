package mock02.validator;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import mock02.model.User;

/*
* TramTran(^^)
*/
public class Validate {

    public static String formatDate(String date){
        SimpleDateFormat source = new SimpleDateFormat("yyyy-mm-dd");
        Date d = null;
        try {
            d = source.parse(date);
        } catch (ParseException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        SimpleDateFormat des = new SimpleDateFormat("yyyy-mm-dd");
        date = des.format(d);
        return date;
    }
    public static boolean formatUser(User u){
        if(u.getUserName() == null || u.getUserName().equals("")){
            return false;
        }
        else if(u.getEmail() == null || u.getEmail().equals("")){
            return false;
        }
        else if(u.getFullName() == null || u.getFullName().equals("")){
            return false;
        }
        else if(u.getBirthDay()==null || u.getBirthDay().equals("")){
            return false;
        }
        else {
            return true;
        }
            
            
    }
}
