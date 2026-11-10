import java.util.*;
public class MaxAppointments {

    // Dynamic Programming
    static int dynamicProgramming(int[] start, int[] end) {

        int n = start.length;
        int[] dp = new int[n];

        for (int i = 0; i < n; i++) {

            int include = 1;

            for (int j = i - 1; j >= 0; j--) {

                if (end[j] <= start[i]) {
                    include = dp[j] + 1;
                    break;
                }
            }

            int exclude = 0;

            if (i > 0) {
                exclude = dp[i - 1];
            }

            dp[i] = Math.max(include, exclude);
        }

        return dp[n - 1];
    }

    // Greedy Approach
    static int greedy(int[] start, int[] end) {

        int count = 0;
        int lastEnd = 0;

        for (int i = 0; i < start.length; i++) {

            if (start[i] >= lastEnd) {
                count++;
                lastEnd = end[i];
            }
        }

        return count;
    }

    public static void main(String[] args) {

        int[] start = {1, 2, 4, 6, 5, 8};
        int[] end =   {3, 5, 6, 7, 8, 9};

        System.out.println("Dynamic Programming: "
                + dynamicProgramming(start, end));

        System.out.println("Greedy Approach: "
                + greedy(start, end));
    }
}
