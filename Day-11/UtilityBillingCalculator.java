
import java.util.Scanner;

public class UtilityBillingCalculator {

    public static void main(String[] args) {

        Scanner sc = new Scanner(System.in);

        // Consumer details
        System.out.print("Enter Consumer Name: ");
        String name = sc.nextLine();

        System.out.print("Enter Consumer Category (domestic/commercial/industrial): ");
        String category = sc.nextLine().toLowerCase();

        System.out.print("Enter Units Consumed: ");
        int units = sc.nextInt();

        // Task 1: Calculate electricity bill using slabs
        double bill = 0;

        if (units <= 100) {
            bill = units * 2;
        }
        else if (units <= 200) {
            bill = (100 * 2) + (units - 100) * 3;
        }
        else if (units <= 400) {
            bill = (100 * 2) + (100 * 3)
                    + (units - 200) * 5;
        }
        else {
            bill = (100 * 2) + (100 * 3)
                    + (200 * 5) + (units - 400) * 7;
        }

        // Task 2: Switch expression for fixed charge
        int fixedCharge = switch (category) {
            case "domestic" -> 50;
            case "commercial" -> 150;
            case "industrial" -> 300;
            default -> 0;
        };

        // Task 3: Surcharge and online rebate
        System.out.print("Late payment? (yes/no): ");
        String late = sc.next();

        System.out.print("Online payment? (yes/no): ");
        String online = sc.next();

        double surcharge = 0;
        double rebate = 0;

        if (late.equalsIgnoreCase("yes")) {
            surcharge = bill * 0.05;
        }

        if (online.equalsIgnoreCase("yes")) {
            rebate = bill * 0.02;
        }

        // Operator precedence: multiplication (*) happens
        // before addition (+), and addition before subtraction (-).
        double totalBill = bill + fixedCharge + surcharge - rebate;

        // Task 4: Display 12-month statement
        System.out.println("\n----- 12 MONTH BILL STATEMENT -----");

        for (int month = 1; month <= 12; month++) {
            System.out.println("Month " + month + " : Rs. " + totalBill);
        }

        // Display final bill
        System.out.println("\n----- BILL DETAILS -----");
        System.out.println("Consumer Name: " + name);
        System.out.println("Category: " + category);
        System.out.println("Units Consumed: " + units);
        System.out.println("Energy Charge: Rs. " + bill);
        System.out.println("Fixed Charge: Rs. " + fixedCharge);
        System.out.println("Late Surcharge: Rs. " + surcharge);
        System.out.println("Online Rebate: Rs. " + rebate);
        System.out.println("Total Bill: Rs. " + totalBill);

        // Task 4: do-while loop for meter readings
        int reading;

        System.out.println("\nEnter meter readings (0 to stop):");

        do {
            System.out.print("Enter reading: ");
            reading = sc.nextInt();

            if (reading != 0) {
                System.out.println("Meter reading: " + reading);
            }

        } while (reading != 0);

        // Task 5: Primitive casting examples

        System.out.println("\n----- PRIMITIVE CASTING -----");

        // Integer division issue
        int a = 5;
        int b = 2;

        System.out.println("Integer Division: " + (a / b));
        System.out.println("Correct Division: " + ((double) a / b));

        // Integer overflow
        int x = 2147483647;
        System.out.println("Overflow: " + (x + 1));

        // Correct handling using long
        long y = 2147483647L;
        System.out.println("Correct Addition: " + (y + 1));

        // Double to int conversion
        double value = 45.89;
        int result = (int) value;

        System.out.println("Double to int: " + result);

        // Correct handling by retaining double
        System.out.println("Correct Value: " + value);

        sc.close();
    }
}
