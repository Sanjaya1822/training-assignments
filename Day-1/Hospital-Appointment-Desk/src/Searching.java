
import java.util.*;

public class Searching {

    static ArrayList<Patient> patients = new ArrayList<>();

    // Linear Search
    static Patient linearSearch(int id) {

        for (Patient p : patients) {
            if (p.patientId == id) {
                return p;
            }
        }

        return null;
    }

    // Binary Search
    static Patient binarySearch(int id) {

        int low = 0;
        int high = patients.size() - 1;

        while (low <= high) {

            int mid = (low + high) / 2;

            if (patients.get(mid).patientId == id) {
                return patients.get(mid);
            }
            else if (patients.get(mid).patientId < id) {
                low = mid + 1;
            }
            else {
                high = mid - 1;
            }
        }

        return null;
    }

    public static void main(String[] args) {

        // Create 20,000 patients
        for (int i = 1; i <= 20000; i++) {
            patients.add(new Patient(10000 + i, "Patient" + i, 25));
        }

        int linearCount = 0;
        int binaryCount = 0;

        // Linear Search - 1000 lookups
        long start = System.nanoTime();

        for (int i = 10001; i <= 11000; i++) {
            if (linearSearch(i) != null) {
                linearCount++;
            }
        }

        long end = System.nanoTime();

        long linearTime = end - start;

        // Binary Search - 1000 lookups
        start = System.nanoTime();

        for (int i = 10001; i <= 11000; i++) {
            if (binarySearch(i) != null) {
                binaryCount++;
            }
        }

        end = System.nanoTime();

        long binaryTime = end - start;

        // Display results
        System.out.println("===== SEARCH COMPARISON =====");

        System.out.println("Total Patients: " + patients.size());
        System.out.println("Total Lookups: 1000");

        System.out.println("\nLinear Search:");
        System.out.println("Records Found: " + linearCount);
        System.out.println("Execution Time: " + linearTime + " ns");

        System.out.println("\nBinary Search:");
        System.out.println("Records Found: " + binaryCount);
        System.out.println("Execution Time: " + binaryTime + " ns");
    }
}
