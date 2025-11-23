
public class Philosopher implements DiningServer, Runnable{

    static int lastNumber = 0;
    final int number = lastNumber++;
 
    public void takeForks(int philosopherNumber){

    }

    public void returnForks(int philosopherNumber){

    }

    public void think(){
        int randomTimeMilliseconds = (int)(Math.random() * 3);
        try {
            Thread.sleep(randomTimeMilliseconds);
        } catch (InterruptedException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    public void run(){
        think();
        
    }
    
}
