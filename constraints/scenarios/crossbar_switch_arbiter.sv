/****************************************
You are verifying a crossbar switch arbiter. You need to randomize a 4x4 matrix of 4-bit 
values representing priority weights assigned to each (input port, output port) pair

Write constraints such that all of the following hold simultaneously:

Row uniqueness – within any single row, no two values may repeat.
Column sum bound – the sum of all four values in any column must not exceed 30.
Diagonal exclusion – no element on the main diagonal (priority_matrix[i][i]) may be zero (a port can never have zero self-priority).
Anti-symmetry – for every i != j, priority_matrix[i][j] + priority_matrix[j][i] must not equal exactly 15 (this represents a forbidden "deadlock-priority" pairing).

Donot use unique
Donot use post_randomize
*****************************************/

class packet;
    rand logic[3:0] priority_matrix[4][4];

    constraint row_uniqueness{
        foreach(priority_matrix[i]){
            foreach(priority_matrix[i][j]){
                foreach(priority_matrix[i][k]){
                    (j!=k) ->   priority_matrix[i][j]!=priority_matrix[i][k];
                }
            }
        }
    }

    constraint c_column_sum{
        foreach(priority_matrix[,j]){
            priority_matrix[0][j] + priority_matrix[1][j] + priority_matrix[2][j] + priority_matrix[3][j] <= 30; 
        }
    }

    constraint c_diagonal_exclusion{
        foreach(priority_matrix[i]){
            priority_matrix[i][i]!=0;
        }
    }

    constraint c_anti_symmetry{
        foreach(priority_matrix[i,j]){
            (i!=j) -> priority_matrix[i][j] + priority_matrix[j][i] != 15;
        }
    }

endclass: packet;

module test;
    packet p;
    initial begin
        p = new();
        if(p.randomize()) begin
            foreach(p.priority_matrix[i]) begin
                foreach(p.priority_matrix[i][j]) begin
                    $write("%0d ",p.priority_matrix[i][j]);
                end
                $display("");
            end
        end
    end
endmodule