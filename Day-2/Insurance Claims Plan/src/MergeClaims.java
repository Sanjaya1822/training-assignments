import java.util.*;

public class MergeClaims {
    public static void main(String[] args) {

        int[] a = {10, 30, 50, 70};
        int[] b = {20, 40, 60, 80};

        int i = 0, j = 0, k = 0;

        int[] result = new int[a.length + b.length];

        // Compare and merge
        while (i < a.length && j < b.length) {

            if (a[i] < b[j]) {
                result[k] = a[i];
                i++;
            }
            else {
                result[k] = b[j];
                j++;
            }

            k++;
        }

        // Copy remaining elements from first array
        while (i < a.length) {
            result[k] = a[i];
            i++;
            k++;
        }

        // Copy remaining elements from second array
        while (j < b.length) {
            result[k] = b[j];
            j++;
            k++;
        }

        System.out.println("Merged Claim List:");
        System.out.println(Arrays.toString(result));
    }
}
