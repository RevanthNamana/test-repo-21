public class Factorialnum {
    public void factorial(Integer f) {
        if(f>0) {
            Integer fact = 1 ;
            for(Integer i = 1; i <= f;i++) {
                fact = fact * i;
            }
            System.debug('Factorial of ' + f + ' is: ' + fact);
        }
        else {
            System.debug('');
        }
    }
}