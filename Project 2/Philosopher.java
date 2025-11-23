
public class Philosopher implements Runnable{

    static int lastNumber = 0;
    final int number = lastNumber++;
    Table myTable = null;

    public Philosopher(Table t){
        myTable = t;
    }

    public void think(){
        int randomTimeMilliseconds = 1000 + (int)(Math.random() * 2000);
        try {
            System.out.println("Philosopher " + number + " is thinking.");
            Thread.sleep(randomTimeMilliseconds);
        } catch (InterruptedException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    public void eat(){
        System.out.println("Philosopher " + number + " is thinking.");
        
    }

    public void run(){
        while(true){
            think();
            eat();
        }
    }
    
}
