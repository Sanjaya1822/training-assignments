
public class Patient {

    int patientId;
    String patientName;
    int age;

    public Patient(int patientId, String patientName, int age) {
        this.patientId = patientId;
        this.patientName = patientName;
        this.age = age;
    }

    @Override
    public String toString() {
        return "Patient ID: " + patientId +
               ", Name: " + patientName +
               ", Age: " + age;
    }
}
