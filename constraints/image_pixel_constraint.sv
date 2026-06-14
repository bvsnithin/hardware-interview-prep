/*****************
Constraint: 2D image 320×240, each pixel is 16 bits. Constrain each pixel such that pixel is less than the sum of its 4 neighbours (top, bottom, left, right).
******************/


class packet;
    
    //Image Matrix
    rand bit [15:0] image[][];

    constraint c_image_dimensions{
        image.size() == 240;

        foreach(image[i]){
            image[i].size() == 320;
        }
    }

    constraint c_sum_less_than_neighbours{
        foreach(image[i,j]){
            if(i>0  && i <239 && j > 0 && j < 319) {
                image[i][j] < image[i][j+1] + image[i-1][j] + image[i+1][j] + image[i][j-1];
            }            
        }
    }

endclass: packet


//Use post randomize to make the condition hold

class packet;
    
    //Image Matrix
    rand bit [15:0] image[][];

    constraint c_image_dimensions{
        image.size() == 240;

        foreach(image[i]){
            image[i].size() == 320;
        }
    }

    function void post_randomize();
        foreach(image[i,j]) begin
            if(i>0 && i<239 &&
                j>0 && j<319) begin
                    int sum = image[i][j+1] + image[i-1][j] + image[i+1][j] + image[i][j-1];
                    if(image[i][j] >= sum) begin
                        sum = sum -1;
                    end
                end
        end
    endfunction: post_randomize

endclass: packet

