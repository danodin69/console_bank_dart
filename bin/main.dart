import 'dart:io';

void main() {
  Console_Bank().bankLogin();
}

class Console_Bank {
  String Account_Name = 'Dan Odin';
  int Account_Number = 2114720038;
  double Account_Balance = 694.20;
  String Currency = '₦';

  int user_pin = 6969;

  int minimum_limit = 50;
  int maximum_limit = 100000;

//This method assumes an ATM card has been plugged in and requires user password to log into their bank account!
// User can also choose to logout by removing their 'card'

  void bankLogin() {
    try {
      stdout.write(login_screen);
      var input_pin = int.parse(stdin.readLineSync());

      if (input_pin == user_pin) {
        print('- Pin Validated, Login successful!');
        mainMenu();
      } else if (input_pin == 0) {
        print(
            '- Card ejected, please take your card\n- Thank You for using this ATM! :)');
      } else {
        print("- Wrong pin, please check 'user_pin' and try again.\n");
        bankLogin();
      }
    } catch (e) {
      print('$e \n- Invalid input, please try again.');
      bankLogin();
    }
  }

// This method comes up after user's pin is validated and then it gives user access to the Bank features
  void mainMenu() {
    stdout.write(welcome_screen);
    var input = stdin.readLineSync().toUpperCase();

    switch (input) {
      case 'A':
        checkBalance();
        break;
      case 'B':
        depositBalance();
        break;
      case 'C':
        withdrawlBalance();
        break;
      case 'D':
        viewProfile();
        break;
      default:
        print('- Sorry, command->[$input] not recognized\nPlease try again.');
        mainMenu();
    }
  }

//This method checks user balance
  void checkBalance() {
    print(
        '\n\nBalance Enquiry:\n\nYour available balance is : $Currency$Account_Balance');
    confirmTermination();
  }

// This method deposits money and increases balance then updates user balance
  void depositBalance() {
    try {
      print(
          '\n-[Deposit]-:\n\n~Available Balance: $Currency$Account_Balance\n');
      stdout.write('\n- How much do you want to deposit?\n\nInput Amount: ');

      var deposit = double.parse(stdin.readLineSync());

      if (deposit < minimum_limit) {
        print(
            '\n\nError:\n\nNuh Huh.. You can not deposit less than $Currency$minimum_limit');
        confirmTermination();
      } else {
        Account_Balance = Account_Balance += deposit;
        print(
            '\n\nMoney deposited successfully!\n\n- You have successfully deposited $Currency$deposit \n- Your new account balance is $Currency$Account_Balance');
        confirmTermination();
      }
    } catch (e) {
      print(
          '$e ^\n- Boss $Account_Name, Please You can only deposit money written in numbers.\n\n- Please try again');
      depositBalance();
    }
  }

// This method allows user to withdraw within defined limits and udates user balance
  void withdrawlBalance() {
    try {
      print('\n-[Withdraw]-:\n\n~Available Balance $Currency$Account_Balance');
      stdout.write('\n- How Much would you like to witdraw?\n\nInput Amount: ');

      var withdrawal = double.parse(stdin.readLineSync());

      if (withdrawal > Account_Balance) {
        print('\n\nError:\n\nNuh Huh.. Insufficent funds!');
        confirmTermination();
      } else if (withdrawal >= maximum_limit) {
        print(
            '\n\nError:\n\nNuh Huh.. You have exceeded the withdraw limit! ($Currency$minimum_limit)');
        confirmTermination();
      } else if (withdrawal < minimum_limit) {
        print(
            '\n\nError:\n\nNuh Huh.. You can not withdraw less than $Currency$minimum_limit');
        confirmTermination();
      } else {
        Account_Balance = Account_Balance -= withdrawal;
        print(
            '\n\nWithdrawal was successful!\n\n- You have successfully withdrawn $Currency$withdrawal \n- Your new account balance is $Currency$Account_Balance');
        confirmTermination();
      }
    } catch (e) {
      print(
          '$e ^\nBoss $Account_Name, Please You can only withdraw money written in numbers.\n\n- Please try again');
      withdrawlBalance();
    }
  }
// This method lets user view their profile to check for account number, name and balance.
// Also lets user carry out operations from there (Withdraw, deposit, end session)

  void viewProfile() {
    print(
        '\n\n-[Profile]-\nAccount Number: $Account_Number\n\nAccount Name: $Account_Name\n\nAccount Balance: $Currency$Account_Balance');
    print('\nWhat would you like to do today?\n ');

    stdout.write('[A] Deposit [B] Withdraw [C] End Session\nInput: ');

    var profile_options = stdin.readLineSync().toUpperCase();

    switch (profile_options) {
      case 'A':
        depositBalance();
        break;
      case 'B':
        withdrawlBalance();
        break;
      case 'C':
        confirmTermination();
        break;
      default:
        print(
            '- Sorry, command->[$profile_options] not recognized\nPlease try again.');
        viewProfile();
    }
  }

//This confirms if user wants to terminate a session
  void confirmTermination() {
    stdout.write(confirm_termination_menu);
    var decision = stdin.readLineSync().toUpperCase();

    if (decision == 'N') {
      mainMenu();
    } else if (decision == 'Y') {
      print('..Terminating session\n- Goodbye $Account_Name.\n');
      bankLogin();
    } else {
      print('Command $decision Not Found, Try Again');
      confirmTermination();
    }
  }
}
//various text interface

var login_screen = '''\n
                             == Bank Of Odin ==
                                  ~B.O.O~
                        ~we scare the poverty away~

                        - Input user pin to log in -

                         - Input 0 to remove card -

                       -Press enter to confirm Input-
Input: ''';

var welcome_screen = '''\n
                             == Bank Of Odin ==
                                  ~B.O.O~
                        ~we scare the poverty away~

                Welcome ${Console_Bank().Account_Name}, What would you like to do today?

                            [A] Check Balance   
                      
                            [B] Deposit

                            [C] Withdraw

                            [D] View Profile


Input the letter corresponding to an option: ''';

var confirm_termination_menu = '''\n
                = Would you like to end this session? = 

                             [Y] Yes [N] No
Input: ''';


/*
Author: DanOdin
Project: console bank
For: Zuri Training
Genre: simulation
Product Type: Course task
Date Written: 9-April-2021
Date Completed: 9-April-2021
Start Time - End Time: 2:45 pm - 8:37PM
*/