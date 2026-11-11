public class ClaimSlidingWindow {

    public static void main(String[] args) {

        int[] claims = {80, 120, 150, 130, 90, 140, 160, 170};

        int count = 0;
        int max = 0;

        for (int i = 0; i < claims.length; i++) {

            if (claims[i] > 100) {
                count++;

                if (count > max) {
                    max = count;
                }
            }
            else {
                count = 0;
            }
        }

        System.out.println("Longest consecutive days: " + max);
    }
}
