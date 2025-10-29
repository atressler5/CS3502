//Andrew Tressler
//16 October 2025

import java.util.*;
public class FCFS implements Algorithm {


    private List<Task> taskArray;

    public FCFS(List<Task> tasks){
        taskArray = tasks;
    }


    public void schedule() {
        int timer = 0;
        while(taskArray.size() > 0){
            int timeAtStart = timer;
            Task thisTask = pickNextTask();
            //amount of time to run
            int runFor = thisTask.getBurst();
            //run for entire burst
            CPU.run(thisTask, runFor);
            timer += runFor;
            //System.out.println("Ran for " + runFor);
            //have it set up like this for the second phase where i will have to reduce by a certain quantum or preempt
            thisTask.setBurst(thisTask.getBurst() - runFor);
            if(thisTask.getBurst() == 0) System.out.println("Task " + thisTask.getName() + " finished.");
            //works if all tasks arrive at time 0
            System.out.println("Waiting time: " + timeAtStart);
            System.out.println("Turnaround time: " + timer);

            System.out.print("\n\n");

        }
    }

    public Task pickNextTask() {
        //assuming that lines in lower indices arrived earlier
        if(taskArray.size() == 0) return null;
        Task next = taskArray.get(0);
        taskArray.remove(0);
        return next;
    }

}
