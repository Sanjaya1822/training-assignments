import java.util.*;
public class DuplicateCheck {

    public static void main(String[] args) {

        HashSet<String> appointments = new HashSet<>();

        String patient1 = "101";
        String time1 = "09:00";

        String patient2 = "102";
        String time2 = "09:00";

        String patient3 = "101";
        String time3 = "09:00";

        String key1 = patient1 + "_" + time1;
        String key2 = patient2 + "_" + time2;
        String key3 = patient3 + "_" + time3;

        if (appointments.add(key1)) {
            System.out.println("Appointment booked: " + key1);
        } else {
            System.out.println("Duplicate appointment: " + key1);
        }

        if (appointments.add(key2)) {
            System.out.println("Appointment booked: " + key2);
        } else {
            System.out.println("Duplicate appointment: " + key2);
        }

        if (appointments.add(key3)) {
            System.out.println("Appointment booked: " + key3);
        } else {
            System.out.println("Duplicate appointment: " + key3);
        }
    }
}
