
#include <iostream>
#include <string>

class BankAccount{
    protected:
        std::string ownerName;
        double balance;
        std::string accountNumber;
        static int totalAccounts;
    public:

        // ==== Constructors ====

        // Default Constructor
        BankAccount() {
            ownerName = "Unknown";
            balance = 0.0;
            accountNumber = "ACC"+std::to_string(totalAccounts);
            totalAccounts++;
        }


        // Parameterized Constructor
        BankAccount(std::string name, double initialBalance){
            ownerName = name;
            balance = initialBalance;
            accountNumber = "ACC"+std::to_string(totalAccounts);
            totalAccounts++;
        }

        // Copy constructor - for deep copy of another account/class
        // const is a read-only protection. It means that we are only use the variable for reading and we should not write to it
        // If we write to it, a compile time error is thrown. So it's only for reading!!!
        BankAccount(const BankAccount& other){
            ownerName = other.ownerName;
            balance = other.balance;
            accountNumber = "ACC"+std::to_string(totalAccounts);
            totalAccounts++;
            std::cout << "Account copied for: "<< ownerName << "\n";
        }

        ~BankAccount(){ 
            totalAccounts--;
            std::cout << "Account closed for: "<< ownerName << "\n";
            // NOTE: No `delete` needed here because all members (string, double)
            // live on the stack — they are destroyed automatically.
            // `delete` is only needed when YOU used `new` to allocate heap memory.
        }

        // ==== Methods ====
        void deposit(double amount){
            balance = balance+amount;
        }

        bool withdraw(double amount){
            if (amount > balance){
                return false;
            }
            else balance = balance - amount;
            return true;
        }

        void displayInfo() const{
            std::cout << "Account Number: "<<accountNumber<< " Name: "<<ownerName<<" balance: "<<balance<<"\n";
        }

        // ==== Getter ====

        double getBalance() const{
            return balance;
        }
        std::string getOwnerName() const{
            return ownerName;
        }
        std::string getAccountNumber() const{
            return accountNumber;
        }

        // Static method - only belongs to the class
        static int getTotalAccounts(){
            return totalAccounts;
        }


};

// ==== Static member definition ====
// Static members must be defined OUTSIDE the class, exactly once.
int BankAccount::totalAccounts = 0;

// ==== main ====
int main(){

    // --- Test 1: Default constructor ---
    std::cout << "\n--- Test 1: Default Constructor ---\n";
    BankAccount a1;
    a1.displayInfo();
    std::cout << "Total accounts: " << BankAccount::getTotalAccounts() << "\n";

    // --- Test 2: Parameterized constructor ---
    std::cout << "\n--- Test 2: Parameterized Constructor ---\n";
    BankAccount a2("Alice", 500.0);
    a2.displayInfo();
    std::cout << "Total accounts: " << BankAccount::getTotalAccounts() << "\n";

    // --- Test 3: Copy constructor ---
    // `BankAccount a3 = a2` calls the COPY constructor (not assignment)
    // because a3 is being created for the first time here.
    std::cout << "\n--- Test 3: Copy Constructor ---\n";
    BankAccount a3 = a2;
    a3.displayInfo();  // same balance as a2, but different account number
    std::cout << "Total accounts: " << BankAccount::getTotalAccounts() << "\n";

    // --- Test 4: deposit and withdraw ---
    std::cout << "\n--- Test 4: Deposit & Withdraw ---\n";
    a2.deposit(200.0);
    std::cout << "After deposit of $200: ";
    a2.displayInfo();

    bool success = a2.withdraw(100.0);
    std::cout << "Withdraw $100 — success: " << (success ? "yes" : "no") << "\n";

    bool fail = a2.withdraw(5000.0);
    std::cout << "Withdraw $5000 — success: " << (fail ? "yes" : "no") << "  (insufficient funds)\n";
    a2.displayInfo();

    // --- Test 5: delete on heap-allocated object ---
    // Here we deliberately use `new` so you can see how `delete` triggers the destructor.
    std::cout << "\n--- Test 5: new + delete (heap allocation) ---\n";
    BankAccount* a4 = new BankAccount("Bob", 1000.0);
    a4->displayInfo();
    std::cout << "Total accounts before delete: " << BankAccount::getTotalAccounts() << "\n";
    delete a4;   // <-- destructor runs HERE, not at end of main
    std::cout << "Total accounts after delete:  " << BankAccount::getTotalAccounts() << "\n";

    // --- Test 6: destructors for a1, a2, a3 fire automatically at end of scope ---
    std::cout << "\n--- End of main: stack objects destroyed in reverse order ---\n";
    return 0;
}