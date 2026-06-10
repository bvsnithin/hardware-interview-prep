/***********************************
Question: This problem was asked in an interview setting to generate integer array of size between 10 and 20 with each element between 1 and 100. 
One last requirement was that the array contains elements that are unique. 
The solution should show the class and its constraints to generate the array. 
The second part of the problem is to generate the same array with bare programming i.e., without using Systemverilog constraints.
***********************************/

class packet;
    rand int arr[];

    constraint c_arr_range{
        arr.size() inside {[10:20]}; 
    }
    constraint c_arr_element_range{
        foreach(arr[i]){
            arr[i] inside {[1:100]};
        }
    }

    constraint c_unique{
        unique {arr};
    }

endclass: packet

class packet_non_constraint;

    //Array to store the elements
    int arr[];
    int size;
    //This array is used to check an element has already been added to the array or not. This is used for making sure all elements in the array are unique
    int values[100];
    
    function new();
        size = $urandom_range(10,20);
        arr = new[size];

        for(int i = 0;i<size;i++) begin
            int element;
            do begin
                element = $urandom_range(1,100);
            end while(values[element] == 1);

            values[element] = 1;
            arr[i] = element; 
        end

    endfunction:new
    

endclass: packet_non_constraint

module test;
    packet_non_constraint p1 = new();
    packet_non_constraint p2 = new();
    packet_non_constraint p3 = new();
    packet_non_constraint p4 = new();
    packet_non_constraint p5 = new();

    initial begin
        $display("------ Array Generated Just Simple Programming ------");
        $display("P1 Array elements: %p",p1.arr);
        $display("P2 Array elements: %p",p2.arr);
        $display("P3 Array elements: %p",p3.arr);
        $display("P4 Array elements: %p",p4.arr);
        $display("P5 Array elements: %p",p5.arr);
    end

    packet p = new();
    initial begin
        $display("------ Array Generated Using Randomziation and Constraints ------");
        repeat(5) begin
            if(p.randomize()) begin
                $display("Array elements: %p",p.arr);
            end
        end
    end
endmodule