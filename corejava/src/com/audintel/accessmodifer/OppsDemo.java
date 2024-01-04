package com.audintel.accessmodifer;

public class OppsDemo {


}

class EncapsulationDemo{

    String movie;
    String city;
    String theater;

    public void displayMovies(){

    }

}

class InheritanceParent{
    String bank = "SBI";
    String HO =    "10101010";
    String branding = "10101010";
    String email ="branch.kp@sbi.com";

}
class InheritanceChild extends  InheritanceParent{
    String accountid = "10101010";
    String branch =    "10101010";
    String address = "10101010";
    double balance = 1010101.99;

}

  abstract class Account {
    String acctID;
    String IFSC;
    String branch;
    abstract void credit(String acctID, float amt);
      abstract void debit(String acctID, float amt);


}

class SBAccount extends Account{
    String Type= "SB";
    float interestRate = 11;
   void calculateInterest(){

   }
    void credit(String acctID, float amt) {};
    void debit(String acctID, float amt){};
}

class CurrentAccount extends Account{
    String Type= "CA";

     void credit(String acctID, float amt) {};
     void debit(String acctID, float amt){};
}

class AbstractionDemo{

    private void calculateInterest(String acctID){

    }

    public void openAcct(){

    }
}