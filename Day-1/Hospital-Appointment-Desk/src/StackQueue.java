public class StackQueue {

    // QUEUE IMPLEMENTATION
    static String[] queue = new String[5];
    static int front = -1;
    static int rear = -1;

    // ENQUEUE FUNCTION
    static void enqueue(String patient) {

        if (rear == queue.length - 1) {
            System.out.println("Queue is full");
        }
        else {
            if (front == -1) {
                front = 0;
            }

            rear++;
            queue[rear] = patient;

            System.out.println(patient + " added to queue");
        }
    }

    // DEQUEUE FUNCTION
    static void dequeue() {

        if (front == -1) {
            System.out.println("Queue is empty");
        }
        else {
            System.out.println("Served: " + queue[front]);

            if (front == rear) {
                front = rear = -1;
            }
            else {
                front++;
            }
        }
    }

    // STACK IMPLEMENTATION
    static String[] stack = new String[5];
    static int top = -1;

    // PUSH FUNCTION
    static void push(String patient) {

        if (top == stack.length - 1) {
            System.out.println("Stack is full");
        }
        else {
            top++;
            stack[top] = patient;

            System.out.println(patient + " added to stack");
        }
    }

    // POP FUNCTION
    static void pop() {

        if (top == -1) {
            System.out.println("Stack is empty");
        }
        else {
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
