public class Runner {
    
    public static void main(String[] args){
        Table t = new Table();
        makePhilosophers(t);
        startPhilosophers(t);
    }

    public static void makePhilosophers(Table t){
        //doing it the dumb way to make sure no scope shennanigans are afoot
        t.philosophers[0] = new Philosopher(t);
        t.philosophers[1] = new Philosopher(t);
        t.philosophers[2] = new Philosopher(t);
        t.philosophers[3] = new Philosopher(t);
        t.philosophers[4] = new Philosopher(t);
    }

    public static void startPhilosophers(Table t){
        for(Philosopher p : t.philosophers){
            new Thread(p, "Philosopher " + p.number).start();
        }
    }
    
}
