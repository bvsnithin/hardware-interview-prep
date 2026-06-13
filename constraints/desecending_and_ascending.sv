/************************
Write a Constraint for array size b/w 20 & 30 and the values of array in descending order
Generate another array with size b/w 10:20 and values in ascending order
*************************/


class packet;

    rand int arr_d[];
    rand int arr_a[];

    constraint c_array_size{
        arr_d.size() inside{
            [20:30]
        };

        arr_a.size() inside{
            [10:20]
        };
    }

    constraint c_array_range{
        foreach(arr_d[i]){
            arr_d[i] inside {[-100:100]};
        }

        foreach(arr_a[i]){
            arr_a[i] inside {[-100:100]};
        }
    }

    constraint c_ascending_order{
        foreach(arr_a[i]){
            if(i>0){
                arr_a[i] > arr_a[i-1];
            }
        }
    }

    constraint c_descending_order{
        foreach(arr_d[i]){
            if(i>0){
                arr_d[i-1] > arr_d[i];
            }
        }
    }
endclass: packet

module test;
    packet p = new();
    initial begin
        if(p.randomize()) begin
            $display("Ascending Order: %p", p.arr_a);
            $display("Descending Order: %p",p.arr_d);
        end
    end
endmodule