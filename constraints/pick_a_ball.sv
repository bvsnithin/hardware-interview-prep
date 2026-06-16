/*****************************
Write constraints – to pick a ball out of 10 different colored balls and that color should not be repeated for in next 3 draws
*****************************/
typedef enum logic [3:0] {RED, BLUE, WHITE, BLACK, ORANGE, PURPLE, YELLOW, GREEN, GREY, MAROON} colour_balls_t;

class packet;
    rand colour_balls_t ball;
    colour_balls_t picked_ball_history[$];

    constraint c{
        !(ball inside {picked_ball_history});
    }

    function void post_randomize();
        picked_ball_history.push_back(ball);
        if(picked_ball_history.size() == 4) begin
            picked_ball_history.pop_front();
        end
    endfunction: post_randomize

endclass: packet

module test;
    packet p;

    initial begin
        p = new();
        repeat(10) begin
            if(p.randomize()) begin
                $display("%s",p.ball.name());
            end
        end
    end
endmodule