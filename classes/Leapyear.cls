public class Leapyear {
    /*public Integer year(Integer y) {
       if((Math.mod(y, 4) == 0 && Math.mod(y, 100) != 0) || 
           (Math.mod(y, 400) == 0)) {
            System.debug('provided year is a leap year' + y);
        }
        else  {
            System.debug('Not a leap year'); }
        return y;
      }*/
    public  Boolean checkleapyear(Integer yy) {
        if((Math.mod(yy, 4) == 0 && Math.mod(yy, 100) != 0) || 
           (Math.mod(yy, 400) == 0)) {
                System.debug('provided year is a leap year' + yy);
            return true;
           } else {
               System.debug('THIS IS NOT LEAP YEAR');
               return false;
           }
    }

}