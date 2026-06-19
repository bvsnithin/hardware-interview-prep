#include <iostream>
using namespace std;

int main(){
    int x = 10;
    int* px = &x; //px variable is local to the function main and it is in stack. So is x. It's in the stack.
    int* ptr = new int(32); //While ptr is in stack, new int 32 is in heap
    cout <<"Address of x, stored in pointer px: " << px <<"\n";
    cout <<"Address of 32 stored in the pointer ptr: " << ptr<<"\n";
    cout <<"Value at the address pointed to by ptr: "<< *ptr <<"\n";
    delete ptr;
    cout << ptr << "\n";
    cout << "Now there is a garbage value at the address ptr is pointing to: "<< *ptr << "\n"; //This prints some garbage value

    // Arrays - Static Creation of array
    int arr[3] = {1,2,3};
    cout << "Static arr: " << arr[0]<< " " << arr[1]<<" " << arr[2] <<"\n";

    //Dynamic array - Uses new keyword to allocate memory in the heap. Static allocates memory in the stack. 
    int size;
    cout<<"Enter the size for the dynamic array: \n";
    cin>>size;

    int* arrPtr = new int[size]();
    for(int i = 0;i<size;i++){
        cout << "Value at address: "<<arrPtr+i<<"is: "<<arrPtr[i]<<"\n";
    }

    //Malloc vs New
    //New is type safe as it returns the exact pointer type like int* or char* but Malloc returns the generic void* pointer which needs to be cast manually. 
    // new when used with parantheses like new int[size]() would initialize the values to 0 for int but malloc does not do that.

    //malloc example
    cout<<"----Malloc----\n";
    int* arrPtr_m = (int*)malloc(5*sizeof(int));
    for(int i =0;i<5;i++){
        cout << "Value at address: "<<arrPtr_m+i<<"is: "<<arrPtr_m[i]<<"\n";
    }

}