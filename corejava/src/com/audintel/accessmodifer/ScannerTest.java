package com.audintel.accessmodifer;

import java.util.Scanner;

public class ScannerTest {
    public static void main(String[] args) {
        System.out.println("Hello");
        Scanner sc =  new Scanner(System.in);
       // System.out.println("Value Entered "+sc.nextInt());
       // System.out.println("Value Entered "+sc.next());
        System.out.println("Value Entered "+sc.nextLine());
        System.out.println("Value Entered "+sc.nextLong());
        System.out.println("Value Entered "+sc.nextInt());
        System.out.println("Value Entered "+sc.nextInt());
        System.out.println("Value Entered "+sc.nextInt());
        System.out.println("Value Entered "+sc.nextInt());
    }
}
