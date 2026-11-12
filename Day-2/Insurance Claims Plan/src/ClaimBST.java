public class ClaimBST {

    Node root;

    // Insert a claim ID
    void insert(int value) {
        Node newNode=new Node(value);
        if (root == null) {
            root=newNode;
            return;
        }

        Node temp=root;
        while(true){
            if (value < temp.data) {
                if(temp.left==null) {
                    temp.left=newNode;
                    break;
                }
                temp=temp.left;
            }
            else {
                if(temp.right==null) {
                    temp.right=newNode;
                    break;
                }
                temp=temp.right;
            }
        }
       
    }

    // Search a claim ID
    boolean search(Node root, int key) {

        if (root == null) {
            return false;
        }

        if (root.data == key) {
            return true;
        }

        if (key < root.data) {
            return search(root.left, key);
        }
        else {
            return search(root.right, key);
        }
    }

    // Inorder: Left, Root, Right
    void inorder(Node root) {

        if (root != null) {
            inorder(root.left);
            System.out.print(root.data + " ");
            inorder(root.right);
        }
    }

    // Preorder: Root, Left, Right
    void preorder(Node root) {

        if (root != null) {
            System.out.print(root.data + " ");
            preorder(root.left);
            preorder(root.right);
        }
    }

    // Postorder: Left, Right, Root
    void postorder(Node root) {

        if (root != null) {
            postorder(root.left);
            postorder(root.right);
            System.out.print(root.data + " ");
        }
    }

    public static void main(String[] args) {

        ClaimBST tree = new ClaimBST();

        int[] claims = {50, 30, 70, 20, 40, 60, 80};

        for (int id : claims) {
            tree.insert(id);
        }

        System.out.println("Inorder Traversal:");
        tree.inorder(tree.root);

        System.out.println("\nPreorder Traversal:");
        tree.preorder(tree.root);

        System.out.println("\nPostorder Traversal:");
        tree.postorder(tree.root);

        System.out.println("\nSearch Claim 40:");
        System.out.println(tree.search(tree.root, 40));

        System.out.println("Search Claim 90:");
        System.out.println(tree.search(tree.root, 90));
    }
}
