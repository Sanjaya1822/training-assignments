import java.util.*;
public class ClaimGraph {
    static Map<String, List<String>> graph = new HashMap<>();

    // Add connection
    static void addEdge(String from, String to) {
        graph.putIfAbsent(from, new ArrayList<>());
        graph.putIfAbsent(to, new ArrayList<>());

        graph.get(from).add(to);
    }

    // BFS - Shortest path
    static void bfs(String start, String end) {

        Queue<String> q = new LinkedList<>();
        Set<String> visited = new HashSet<>();

        q.add(start);
        visited.add(start);

        System.out.print("BFS Path: ");

        while (!q.isEmpty()) {

            String current = q.poll();
            System.out.print(current + " ");

            if (current.equals(end)) {
                return;
            }

            for (String next : graph.get(current)) {

                if (!visited.contains(next)) {
                    visited.add(next);
                    q.add(next);
                }
            }
        }

        System.out.println("No path found");
    }

    // DFS - Cycle detection
    static boolean dfs(String node, Set<String> visited,
                       Set<String> path) {

        visited.add(node);
        path.add(node);

        for (String next : graph.get(node)) {

            if (path.contains(next)) {
                return true;
            }

            if (!visited.contains(next)) {
                if (dfs(next, visited, path)) {
                    return true;
                }
            }
        }

        path.remove(node);
        return false;
    }

    public static void main(String[] args) {

        addEdge("Registration", "Assessment");
        addEdge("Assessment", "Surveyor");
        addEdge("Surveyor", "Settlement");

        bfs("Registration", "Settlement");

        Set<String> visited = new HashSet<>();
        Set<String> path = new HashSet<>();

        boolean cycle = false;

        for (String stage : graph.keySet()) {
            if (!visited.contains(stage)) {
                if (dfs(stage, visited, path)) {
                    cycle = true;
                    break;
                }
            }
        }

        System.out.println("\nCycle Exists: " + cycle);

        // Add a loop
        addEdge("Settlement", "Assessment");

        visited.clear();
        path.clear();
        cycle = false;

        for (String stage : graph.keySet()) {
            if (!visited.contains(stage)) {
                if (dfs(stage, visited, path)) {
                    cycle = true;
                    break;
                }
            }
        }

        System.out.println("Cycle After Adding Loop: " + cycle);
    }
}
