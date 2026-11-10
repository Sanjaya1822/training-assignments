public class Appointment {
    String patientName;
    int urgency;
    String arrivalTime;

    Appointment(String name, int urgency, String arrivalTime) {
        this.patientName = name;
        this.urgency = urgency;
        this.arrivalTime = arrivalTime;
    }

    public String toString() {
        return patientName + " | " + urgency + " | " + arrivalTime;
    }
}