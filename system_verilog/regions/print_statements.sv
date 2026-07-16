/* System verilog has various print statements
1) $display
2) $write
3) $monitor
4) $strobe
*/

module test;

    /* $display statement:
     - Prints in the active region. 
     - Prints only once
     - Prints immediately and also adds a newlines at the end
     */

     // $write works exactly like $display, it just doesn't print on the new line
     int a,b,c;
    initial begin
        a = 10;
        $display("a = %0d",a);

        b = 20;
        c <= 30;
        $display("b = %0d, c = %0d",b,c);
        // The above 3 statements has one blocking and non block assignment. Since display prints in active region,
        // It only records the value of b and not c

        //After the nba region has finished, we will be able to see the updated value of c. To see that happen, we give a small delay
        #1;
        $write("c after nba region: %0d",c);
        $display("");
    end
    int increment = 10;
    initial begin
        #10;
        /* $strobe
        - This executes in the postponed region, which is at the end of the timestep

        $monitor
        - Like $strobe, this executes in the postponed region as well. 
        - But, it's special, because $monitor continuously monitors the entire simulation

        */
        a <= 10;
        $display("[DISPLAY] time = %0t, a = %0d",$time, a);
        $strobe("[STROBE] time = %0t, a = %0d",$time,a);
        $monitor("[MONITOR] time = %0t,  a = %0d",$time,a);

        #10;
        a<=a+increment;
        #10;
        a<=a+increment;

        //Cool thing about $monitor? It will continue printing at times 20 and 30 as well. 
        // Because monitor will do the job of it's name "monitoring" till end of simulation
        // We can however, turn on and off the monitor
        // Let's turn off monitor at time = 40 and turn on at 80
        #10;
        a<= a+increment;
        $monitoroff;
        repeat(4) begin
            #10;
            a <= a+increment;
        end
        $monitoron;
        repeat(4) begin
            #10;
            a <= a+increment;
        end
    end

endmodule