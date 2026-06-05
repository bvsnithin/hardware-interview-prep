/******************
Write uvm sv constraints to Place 8 queens on 8×8 chessboard such that no two queens attack each other. 
Queens attack same row, column, or diagonal. Model as constraint problem: assign column position for each row's queen.
******************/

class packet;
    
    // Column array where arr[1]=5 means that 2nd row of chessboard has the queen at 6th position
    rand int unsigned arr[8];

    constraint range{
        foreach(arr[i]) {
            arr[i] inside {[0:7]};
        }

        unique {arr};
    }

    //Diagonal Check
    constraint eight_queens{
        foreach(arr[i]){
            foreach(arr[j]){
                if(i<j){
                    (arr[i]-arr[j]) != (i-j);
                    (arr[i]-arr[j]) != (j-i);
                }
            }
        }
    }

endclass: packet

module eight_queens;

    packet p = new();

    initial begin
        if(p.randomize()) begin
            $display("Randomization is successful");
            foreach(p.arr[i]) begin
                $display("arr[%0d]: %0d", i, p.arr[i]);
            end
        end
        else begin
            $display("Randomization has failed");
        end

        foreach(p.arr[i]) begin
            foreach(p.arr[j]) begin
                if(j==p.arr[i]) begin
                    $write("Q ");
                end
                else $write("* ");
            end
            $write("\n");
        end
    end
endmodule