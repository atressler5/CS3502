
public class Philosopher implements Runnable{

    static int lastNumber = 0;
    final int number = lastNumber++;
    Table myTable = null;

    public Philosopher(Table t){
        myTable = t;
    }

    public void think(){
        System.out.println("Philosopher " + number + " is THINKING.");
        sleep1to3secs();
    }

    public void eat(){
        System.out.println("Philosopher " + number + " is HUNGRY and trying to eat.");
        myTable.takeForks(number);
        System.out.println("Philosopher " + number + " is currently EATING.");
        sleep1to3secs();
        myTable.returnForks(number);   
        System.out.println("Philosopher " + number + " has returned their forks.");
    }

    public void run(){
        while(true){
            think();
            eat();
        }
    }

    private void sleep1to3secs(){
        int randomTimeMilliseconds = 1000 + (int)(Math.random() * 2000);
        try {
            Thread.sleep(randomTimeMilliseconds);
        } catch (InterruptedException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
    
}
