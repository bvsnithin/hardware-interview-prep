#include <iostream>
using namespace std;

int main(){
    int x = 10;
    cout << "Value of x: " <<x<<"\n";
    cout << "Address of x: " << &x <<"\n";
    // int px = &x; //This will give error - Invalid conversion of int* to int. Hence we need to use int* data type for pointers
    int* px = &x;
    cout << "Address of x using the pointer (px): " << px <<"\n";
    cout << "Value of x using the pointer (*px): " << *px <<"\n";
    cout << "Address of pointer (&px): " << &px << "\n";
    // int* ppx = &px; //This stores the address to the pointer variable px. But gives error because address to a pointer should be a int** and not int*
    int** ppx = &px; 
    cout << "Address of the pointer variable (px) using ppx: " << ppx <<"\n";
    cout << "Value of the pointer variable (px) using *ppx: " << *ppx <<"\n";   //px stores the address to x. So *ppx gives address to x;
    cout << "Value of the variable x using **ppx: " << **ppx <<"\n";

    //Changing value of x using pointer px
    *px = 20;
    cout << "Value of x: " <<x <<"\n";
    return 0;
}