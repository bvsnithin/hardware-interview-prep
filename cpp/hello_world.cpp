#include <iostream>
using namespace std;

int main(){
    std::cout<<"Hello World\n";
    
    int val;
    printf("Enter a value: ");
    scanf("%d",&val);
    printf("You entered: %d\n", val);

    //Using std::cout and std::cin
    int data;
    std::cout<<"Enter the value for the data to be stored: ";
    std::cin>>data;
    std::cout<<"You have entered: "<<data<<"\n";

    
    return 0;
}

