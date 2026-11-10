public class StackQueue {

    // Queue implementation
    static String[] queue = new String[5];
    static int front = 0;
    static int rear = -1;

    static void enqueue(String patient) {
        if (rear == queue.length - 1) {
            System.out.println("Queue is full");
        } else {
            rear++;
            queue[rear] = patient;
        }
    }

    static void dequeue() {
        if (front > rear) {
            System.out.println("Queue is empty");
        } else {
            System.out.println("Served: " + queue[front]);
            front++;
        }
    }

    // Stack implementation
    static String[] stack = new String[5];
    static int top = -1;

    static void push(String patient) {
        if (top == stack.length - 1) {
            System.out.println("Stack is full");
        } else {
            top++;
            stack[top] = patient;
        }
    }

    static void pop() {
        if (top == -1) {
            System.out.println("Stack is empty");
        } else {
            System.out.println("Recently viewed: " + stack[top]);
            top--;
        }
    }

    public static void main(String[] args) {

        System.out.println("===== QUEUE =====");

        enqueue("Arun");
        enqueue("Priya");
        enqueue("Ravi");

        dequeue();

        System.out.println("\n===== STACK =====");

        push("Arun");
        push("Priya");
        push("Ravi");

        pop();
    }
}
