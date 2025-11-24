import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
public class Table implements DiningServer{

    enum state{
        THINKING,
        HUNGRY,
        EATING
    }

    Lock lock = new ReentrantLock();
    Philosopher[] philosophers = new Philosopher[5];
    //stores state of philosophers - each idx is the state of the philosopher of the same idx in philosophers[]
    Condition[] conditions = new Condition[5];
    state[] states = new state[5];

    public Table(){
        for(int i = 0; i < 5; i++){
            conditions[i] = lock.newCondition();
            states[i] = state.THINKING;
        }
    }


    public void takeForks(int philosopherNumber){
        lock.lock();
        try {
            states[philosopherNumber] = state.HUNGRY;
            available(philosopherNumber);
            while (states[philosopherNumber] != state.EATING) {
                conditions[philosopherNumber].await();
            }
        } 
        catch (InterruptedException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } 
        finally {
            lock.unlock();
        }


        
    }

    public void returnForks(int philosopherNumber){
        lock.lock();
        try {
            states[philosopherNumber] = state.THINKING;
            available(getLeft(philosopherNumber));
            available(getRight(philosopherNumber));
        } finally {
            lock.unlock();
        }
    }

    private void available(int philosopherNumber) {
        if (states[philosopherNumber] == state.HUNGRY &&
            states[getLeft(philosopherNumber)] != state.EATING &&
            states[getRight(philosopherNumber)] != state.EATING) 
            {

            states[philosopherNumber] = state.EATING;
            conditions[philosopherNumber].signal();
        }
    }

    private int getLeft(int philosopherNumber){
        return (philosopherNumber + 5 - 1) % 5;
    }

    private int getRight(int philosopherNumber){
        return (philosopherNumber + 1) % 5;
    }




}