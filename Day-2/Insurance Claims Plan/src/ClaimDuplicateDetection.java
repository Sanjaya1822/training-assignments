
import java.util.*;

public class ClaimDuplicateDetection {

    public static void main(String[] args) {

        String[][] claims = {
            {"POL123", "2026-11-10"},
            {"pol123", "2026-11-10"},
            {"POL 123", "2026-11-10"},
            {"POL456", "2026-11-11"}
        };

        HashSet<String> set = new HashSet<>();

        for (String[] claim : claims) {

            String policy = claim[0].replaceAll("\\s+", "");
            policy= policy.toLowerCase();


            String date = claim[1].trim();

            String key = policy + "|" + date;

            if (set.contains(key)) {
                System.out.println("Duplicate Claim: " + claim[0]);
            }
            else {
                set.add(key);
                System.out.println("New Claim: " + claim[0]);
            }
        }
    }
}
