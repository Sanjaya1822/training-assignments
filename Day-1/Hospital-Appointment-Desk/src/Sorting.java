import java.util.*;

public class Sorting {
    static int selectionSwaps = 0;
    static int quickSwaps = 0;

    // Selection Sort
    static void selectionSort(ArrayList<Appointment> list) {

        for (int i = 0; i < list.size() - 1; i++) {

            int min = i;

            for (int j = i + 1; j < list.size(); j++) {

                if (list.get(j).urgency < list.get(min).urgency ||
                    (list.get(j).urgency == list.get(min).urgency &&
                     list.get(j).arrivalTime.compareTo(list.get(min).arrivalTime) < 0)) {
                    min = j;
                }
            }

            if (min != i) {
                Appointment temp = list.get(i);
                list.set(i, list.get(min));
                list.set(min, temp);
                selectionSwaps++;
            }
        }
    }

    // Quick Sort
    static void quickSort(ArrayList<Appointment> list, int low, int high) {

        if (low < high) {
            int pivot = partition(list, low, high);

            quickSort(list, low, pivot - 1);
            quickSort(list, pivot + 1, high);
        }
    }

    static int partition(ArrayList<Appointment> list, int low, int high) {

        Appointment pivot = list.get(high);
        int i = low - 1;

        for (int j = low; j < high; j++) {

            if (list.get(j).urgency < pivot.urgency ||
                (list.get(j).urgency == pivot.urgency &&
                 list.get(j).arrivalTime.compareTo(pivot.arrivalTime) < 0)) {

                i++;

                if (i != j) {
                    Appointment temp = list.get(i);
                    list.set(i, list.get(j));
                    list.set(j, temp);
                    quickSwaps++;
                }
            }
        }

        if (i + 1 != high) {
            Appointment temp = list.get(i + 1);
            list.set(i + 1, list.get(high));
            list.set(high, temp);
            quickSwaps++;
        }

        return i + 1;
    }

    // Display appointments
    static void display(ArrayList<Appointment> list) {
        for (Appointment a : list) {
            System.out.println(a);
        }
    }

    public static void main(String[] args) {

        ArrayList<Appointment> original = new ArrayList<>();

        original.add(new Appointment("Arun", 3, "10:00"));
        original.add(new Appointment("Priya", 1, "09:30"));
        original.add(new Appointment("Kumar", 2, "09:00"));
        original.add(new Appointment("Ravi", 1, "09:00"));
        original.add(new Appointment("Divya", 3, "09:15"));

        ArrayList<Appointment> selectionList = new ArrayList<>(original);
        ArrayList<Appointment> quickList = new ArrayList<>(original);

        selectionSort(selectionList);
        quickSort(quickList, 0, quickList.size() - 1);

        System.out.println("===== SELECTION SORT =====");
        display(selectionList);
        System.out.println("Total Swaps: " + selectionSwaps);

        System.out.println("\n===== QUICK SORT =====");
        display(quickList);
        System.out.println("Total Swaps: " + quickSwaps);
    }
}
