/************************
You're writing a constrained random test for the FIFO. Write a constraint block that does the following:

wr_en and rd_en are never both deasserted at the same time
Back-to-back writes are allowed but back-to-back reads should happen at most 30% of the time
**************************/

class fifo_seq_item;
    rand bit wr_en;
    rand bit rd_en;
    bit prev_rd_en; 

    constraint c_not_both_idle {
        !(wr_en == 0 && rd_en == 0);
    }

    constraint c_consec_reads {
        if (prev_rd_en == 1)
            rd_en dist {1 := 30, 0 := 70};
    }

    function void post_randomize();
        prev_rd_en = rd_en
    endfunction: post_randomize
endclass