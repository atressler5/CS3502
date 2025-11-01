import java.util.*;

public class RR implements Algorithm {

    private List<Task> taskArray;
    private HashMap<Task, Integer> startTimes;
    private HashMap<Task, Integer> endTimes;
    private int quantum;
    private int timer = 0;

    public RR(List<Task> tasks) {
        taskArray = tasks;
        startTimes = new HashMap<Task, Integer>();
        endTimes = new HashMap<Task, Integer>();
        // defined in requirements
        quantum = 10;
    }

    public void schedule() {
        while (taskArray.size() > 0) {
            Task thisTask = pickNextTask();
            if(!startTimes.containsKey(thisTask)) startTimes.put(thisTask, timer);

            // amount of time to run
            int runFor = quantum;
            // so burst doesn't go negative
            if (runFor > thisTask.getBurst()) {
                runFor = thisTask.getBurst();
            }

            CPU.run(thisTask, runFor);
            timer += runFor;
            // System.out.println("Ran for " + runFor);
            // have it set up like this for the second phase where i will have to reduce by
            // a certain quantum or preempt
            thisTask.setBurst(thisTask.getBurst() - runFor);

            if (thisTask.getBurst() == 0) {
                endTimes.put(thisTask, timer);
                System.out.println("Task " + thisTask.getName() + " finished.");
                // works if all tasks arrive at time 0
                System.out.println("Waiting time: " + startTimes.get(thisTask));
                System.out.println("Turnaround time: " + endTimes.get(thisTask));
            }
            //requeue if not complete
            else taskArray.add(thisTask);

            System.out.print("\n\n");

        }
    }

    public Task pickNextTask() {
        // assuming that lines in lower indices arrived earlier
        if (taskArray.size() == 0)
            return null;
        Task next = taskArray.get(0);
        taskArray.remove(0);
        return next;
    }

}
