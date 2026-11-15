#include <iostream>
using namespace std;
class bit_manipulation_techniques{
    public:
        int number;

        bit_manipulation_techniques(int number){
            this->number = number;
        }

        void display(){
            cout << "The number we have is: " << this->number << endl;
        }

        // Checking whether k-th bit from lsb is set or not
        bool check_kth_bit_set(int k){
            // Create a mask with only the kth bit high and rest 0
            int mask = 1 << (k-1);

            // Perform &(and) operation between the mask and the number
            int and_op = number & mask;
            
            // Shift the result by k bits to the right and perform and with one(1) to check if the and operation resulted in 1 or 0
            // If the kth bit is set, then and_op will have kth bit one(1)
            if((1 & (and_op >> (k-1))) == 1){
                return true;
            }
            return false;

            // In simple fashion - just perform 
            // return ((number & (1 << (k-1)) )!= 0);
        }
};

int main(){
    bit_manipulation_techniques* obj = new bit_manipulation_techniques(143); // 143 in binary is 10001111
    obj->display();
    
    bool kth_bit_set_res = obj->check_kth_bit_set(5);

    cout << boolalpha;
    cout << 5 << " bit from lsb is set: " << kth_bit_set_res << endl;
    return 1;
}