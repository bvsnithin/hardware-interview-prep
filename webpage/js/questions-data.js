// Auto-generated hardware interview questions dataset
window.QUESTIONS_DATA = [
  {
    "id": "c_array_payload_generation",
    "title": "Array Payload Generation",
    "category": "Sequences & Pattern Generation",
    "path": "constraints/array_payload_generation.sv",
    "isFrequentlyAsked": false,
    "tags": [
      "Array",
      "Distribution / Pattern"
    ],
    "description": "Randomize byte payloads with custom checksum constraints and length boundaries.",
    "explanation": "Question: This problem was asked in an interview setting to generate integer array of size between 10 and 20 with each element between 1 and 100.\nOne last requirement was that the array contains elements that are unique.\nThe solution should show the class and its constraints to generate the array.\nThe second part of the problem is to generate the same array with bare programming i.e., without using Systemverilog constraints.",
    "code": "/***********************************\nQuestion: This problem was asked in an interview setting to generate integer array of size between 10 and 20 with each element between 1 and 100. \nOne last requirement was that the array contains elements that are unique. \nThe solution should show the class and its constraints to generate the array. \nThe second part of the problem is to generate the same array with bare programming i.e., without using Systemverilog constraints.\n***********************************/\n\nclass packet;\n    rand int arr[];\n\n    constraint c_arr_range{\n        arr.size() inside {[10:20]}; \n    }\n    constraint c_arr_element_range{\n        foreach(arr[i]){\n            arr[i] inside {[1:100]};\n        }\n    }\n\n    constraint c_unique{\n        unique {arr};\n    }\n\nendclass: packet\n\nclass packet_non_constraint;\n\n    //Array to store the elements\n    int arr[];\n    int size;\n    //This array is used to check an element has already been added to the array or not. This is used for making sure all elements in the array are unique\n    int values[100];\n    \n    function new();\n        size = $urandom_range(10,20);\n        arr = new[size];\n\n        for(int i = 0;i<size;i++) begin\n            int element;\n            do begin\n                element = $urandom_range(1,100);\n            end while(values[element] == 1);\n\n            values[element] = 1;\n            arr[i] = element; \n        end\n\n    endfunction:new\n    \n\nendclass: packet_non_constraint\n\nmodule test;\n    packet_non_constraint p1 = new();\n    packet_non_constraint p2 = new();\n    packet_non_constraint p3 = new();\n    packet_non_constraint p4 = new();\n    packet_non_constraint p5 = new();\n\n    initial begin\n        $display(\"------ Array Generated Just Simple Programming ------\");\n        $display(\"P1 Array elements: %p\",p1.arr);\n        $display(\"P2 Array elements: %p\",p2.arr);\n        $display(\"P3 Array elements: %p\",p3.arr);\n        $display(\"P4 Array elements: %p\",p4.arr);\n        $display(\"P5 Array elements: %p\",p5.arr);\n    end\n\n    packet p = new();\n    initial begin\n        $display(\"------ Array Generated Using Randomziation and Constraints ------\");\n        repeat(5) begin\n            if(p.randomize()) begin\n                $display(\"Array elements: %p\",p.arr);\n            end\n        end\n    end\nendmodule"
  },
  {
    "id": "c_array_sum_contraint",
    "title": "Array Sum Constraint",
    "category": "Arrays, Queues & Matrices",
    "path": "constraints/array_sum_contraint.sv",
    "isFrequentlyAsked": true,
    "tags": [
      "Frequently Asked",
      "Array"
    ],
    "description": "Generate a 10-element unique integer array whose total sum equals a fixed target value (`sum() with (int'(item)) == TARGET`).",
    "explanation": "Write UVM SystemVerilog constraint to generate an integer array of size 10 with unique elements where the sum of all\nelements equals exactly 100. Implement sum calculation without using .sum() array reduction method.",
    "code": "/******\nWrite UVM SystemVerilog constraint to generate an integer array of size 10 with unique elements where the sum of all \nelements equals exactly 100. Implement sum calculation without using .sum() array reduction method. \n******/\n\n\nclass packet;\n    rand int unsigned arr[];\n\n    constraint array_sum_size {\n        arr.size() == 10;\n\n        foreach (arr[i]) {\n            arr[i] < 100;\n            arr[i] >= 1;\n        }\n\n        unique { arr };\n\n        arr[0] + arr[1] + arr[2] + arr[3] + arr[4] +\n        arr[5] + arr[6] + arr[7] + arr[8] + arr[9] == 100;\n    }\nendclass\n\nmodule test;\n    packet p = new();\n\n    initial begin\n        if (p.randomize()) begin\n            $display(\"Randomization is successful\");\n            foreach (p.arr[i])\n                $display(\"arr[%0d]: %0d\", i, p.arr[i]);\n        end\n        else\n            $display(\"Randomization has failed\");\n    end\nendmodule"
  },
  {
    "id": "c_consecutive_5bit_ones_constraint",
    "title": "Consecutive 5-bit Ones Constraint (Apple)",
    "category": "Arithmetic & Bit-Level Constraints",
    "path": "constraints/consecutive_5bit_ones_constraint.sv",
    "isFrequentlyAsked": true,
    "tags": [
      "Frequently Asked",
      "Apple",
      "Bitwise"
    ],
    "description": "Real Apple Interview Question a. Constrain an 8-bit random value so exactly 5 of its bits are 1. b. Now make those 5 ones consecutive.",
    "explanation": "Real Apple Interview Question\na. Constrain an 8-bit random value so exactly 5 of its bits are 1.\nb. Now make those 5 ones consecutive.",
    "code": "/*********\nReal Apple Interview Question\na. Constrain an 8-bit random value so exactly 5 of its bits are 1.\nb. Now make those 5 ones consecutive.\n**********/\n\nclass packet;\n    rand logic[7:0] data;\n\n    // To have exactly 5 bits equal to 1, we can use $countones == 5. This constraints 5 bits to be 1\n\n    // constraint c_5_bits_one{\n    //     $countones(data) == 5;\n    // }\n\n    // To make those 5 bits consecutive, we can take the bits 0001_1111 and shift left by 1,2,or 3 times. \n    // Let's use a random 2 bit value. It can be between 0 and 3 and hence does not need to be constrained. \n    rand logic[1:0] shift_num;\n\n    constraint c_shift{\n        data == 8'b0001_1111 << shift_num;\n    }\nendclass: packet\n\nmodule test;\n    packet p;\n    initial begin\n        p = new();\n        repeat(10) begin\n            if(p.randomize()) begin\n                $display(\"Data = %08b\", p.data);\n            end\n        end\n    end\nendmodule"
  },
  {
    "id": "c_consecutive_gray_code",
    "title": "Consecutive Gray Code",
    "category": "Sequences & Pattern Generation",
    "path": "constraints/consecutive_gray_code.sv",
    "isFrequentlyAsked": false,
    "tags": [
      "Distribution / Pattern"
    ],
    "description": "Randomize two 6-bit values ensuring they are adjacent valid Gray codes.",
    "explanation": "Randomize two 6-bit values where Consecutive Gray Codes Differ by One Bit.",
    "code": "/*****************\nRandomize two 6-bit values where Consecutive Gray Codes Differ by One Bit.\n******************/\n\nclass packet;\n    rand bit [5:0] g1;\n    rand bit [5:0] g2;\n\n    rand bit [5:0] bin1;\n    rand bit [5:0] bin2;\n\n    constraint c_differ_by_1_bit{\n        $countones(g1^g2) == 1;\n    }\n\n    constraint c_gray_code{\n        g1 == bin1 ^ (bin1>>1);\n        g2 == bin2 ^ (bin2>>1);\n    }\n    \nendclass: packet\n\nmodule test;\n    packet p = new();\n\n    initial begin\n        repeat(5) begin\n            if(p.randomize()) begin\n                $display(\"g1 = %06b ----- g2 = %06b\",p.g1, p.g2);\n            end\n        end\n    end\nendmodule"
  },
  {
    "id": "c_deck_of_cards",
    "title": "Deck Of Cards",
    "category": "Logic Puzzles & Brainteasers",
    "path": "constraints/deck_of_cards.sv",
    "isFrequentlyAsked": false,
    "tags": [],
    "description": "Constraint to Generate Deck of 52 Cards",
    "explanation": "Constraint to Generate Deck of 52 Cards",
    "code": "/*********\nConstraint to Generate Deck of 52 Cards\n*********/\ntypedef enum logic [1:0] {\n    HEART,\n    DIAMOND,\n    CLUB,\n    SPADE\n} suit_t;\n\ntypedef enum logic [3:0] {\n    A,\n    TWO,\n    THREE,\n    FOUR,\n    FIVE,\n    SIX,\n    SEVEN,\n    EIGHT,\n    NINE,\n    TEN,\n    JACK,\n    QUEEN,\n    KING\n} rank_t;\n\n// A packed struct is treated as a single contiguous vector of bits.\ntypedef struct packed{\n    rank_t rank; // Rank is between 1 - 13. Ace = 1, King = 13, Queen = 12, Jack = 11\n    suit_t suit; \n} card_t;\n\nclass deck_packet;\n\n    rand card_t cards[52]; // Array of 52 cards. Deck of 52 cards\n\n    constraint c_rank{\n        foreach(cards[i]){\n            cards[i].rank inside {A,TWO,THREE,FOUR,FIVE,SIX,SEVEN,EIGHT,NINE,TEN,JACK,QUEEN,KING};\n        }\n    }\n\n    // Each card hast to be unique\n    constraint c_unique{\n        unique {cards};\n    }\n\n    // This is redundant\n    constraint c_suit_count{\n        cards.sum() with (int'(item.suit == HEART)) == 13;\n        cards.sum() with (int'(item.suit == DIAMOND)) == 13;\n        cards.sum() with (int'(item.suit == CLUB)) == 13;\n        cards.sum() with (int'(item.suit == SPADE)) == 13;\n    }\nendclass: deck_packet\n\nmodule top; \n    deck_packet packet;\n    initial begin\n        packet = new();\n        if(packet.randomize()) begin\n            foreach(packet.cards[i]) begin\n                $display(\"SUIT: %0s, RANK:%0s\", packet.cards[i].suit.name(), packet.cards[i].rank.name());\n            end\n        end\n    end\nendmodule"
  },
  {
    "id": "c_desecending_and_ascending",
    "title": "Descending First Half & Ascending Second Half",
    "category": "Arrays, Queues & Matrices",
    "path": "constraints/desecending_and_ascending.sv",
    "isFrequentlyAsked": false,
    "tags": [],
    "description": "Array sized between 20 and 30 that is partitioned into a strictly descending first half and strictly ascending second half.",
    "explanation": "Write a Constraint for array size b/w 20 & 30 and the values of array in descending order\nGenerate another array with size b/w 10:20 and values in ascending order",
    "code": "/************************\nWrite a Constraint for array size b/w 20 & 30 and the values of array in descending order\nGenerate another array with size b/w 10:20 and values in ascending order\n*************************/\n\n\nclass packet;\n\n    rand int arr_d[];\n    rand int arr_a[];\n\n    constraint c_array_size{\n        arr_d.size() inside{\n            [20:30]\n        };\n\n        arr_a.size() inside{\n            [10:20]\n        };\n    }\n\n    constraint c_array_range{\n        foreach(arr_d[i]){\n            arr_d[i] inside {[-100:100]};\n        }\n\n        foreach(arr_a[i]){\n            arr_a[i] inside {[-100:100]};\n        }\n    }\n\n    constraint c_ascending_order{\n        foreach(arr_a[i]){\n            if(i>0){\n                arr_a[i] > arr_a[i-1];\n            }\n        }\n    }\n\n    constraint c_descending_order{\n        foreach(arr_d[i]){\n            if(i>0){\n                arr_d[i-1] > arr_d[i];\n            }\n        }\n    }\nendclass: packet\n\nmodule test;\n    packet p = new();\n    initial begin\n        if(p.randomize()) begin\n            $display(\"Ascending Order: %p\", p.arr_a);\n            $display(\"Descending Order: %p\",p.arr_d);\n        end\n    end\nendmodule"
  },
  {
    "id": "c_differ_by_five",
    "title": "Differ By Five",
    "category": "Arithmetic & Bit-Level Constraints",
    "path": "constraints/differ_by_five.sv",
    "isFrequentlyAsked": false,
    "tags": [],
    "description": "Randomize two variables `a` and `b` such that",
    "explanation": "Write a constraint for two random variables such that one variable does not match the other, and five bits are toggled.",
    "code": "/*************\nWrite a constraint for two random variables such that one variable does not match the other, and five bits are toggled.\n*************/\n\nclass packet;\n    rand bit [9:0] val1;\n    rand bit [9:0] val2;\n\n    constraint c_not_equal{\n        val2 != val1;\n    }\n\n    constraint c_five_toggle_bits{\n        $countones(val1) == 5;\n        $countones(val2) == 5;\n    }\n\nendclass: packet\n\nmodule differ_by_five;\n\n    packet p = new();\n\n    initial begin\n        repeat(10) begin\n            if(p.randomize()) begin\n                $display(\"Randomization is successful --- VAL1: %09b --- VAL2: %09b\",p.val1, p.val2);\n            end\n            else $display(\"Randomization has failed\");\n        end\n    end\n\nendmodule: differ_by_five"
  },
  {
    "id": "c_differ_by_two_bits",
    "title": "Differ By Two Bits",
    "category": "Arithmetic & Bit-Level Constraints",
    "path": "constraints/differ_by_two_bits.sv",
    "isFrequentlyAsked": false,
    "tags": [
      "Bitwise"
    ],
    "description": "Randomize two 32-bit values such that their Hamming distance is exactly 2 bits (`countones(val1 ^ val2) == 2`).",
    "explanation": "Write a constraint where you have a 32 bit value bit [31:0] val where you’d want to randomize this to\nwhere every randomization would only allow 2 bits to differ from the previous randomization.",
    "code": "/**********\nWrite a constraint where you have a 32 bit value bit [31:0] val where you’d want to randomize this to \nwhere every randomization would only allow 2 bits to differ from the previous randomization.\n***********/\n\nclass packet;\n    rand bit [31:0] val;\n    bit [31:0] prev_val;\n\n    constraint differ_by_2_bits{\n        $countones(prev_val ^ val) == 2;\n    }\n\n    function void post_randomize();\n        prev_val = val;\n    endfunction: post_randomize\n\nendclass: packet\n\nmodule differ_by_two_bits;\n\n    packet p = new();\n\n    initial begin\n        repeat(10) begin\n            if(p.randomize()) begin\n                $display(\"Randomization is successful\");\n                $display(\"%032b\",p.val);\n            end\n            else $display(\"Randomization has failed\");\n        end\n    end\n\nendmodule: differ_by_two_bits"
  },
  {
    "id": "c_different_from_last_five",
    "title": "Different From Last Five",
    "category": "Sequences & Pattern Generation",
    "path": "constraints/different_from_last_five.sv",
    "isFrequentlyAsked": true,
    "tags": [
      "Frequently Asked"
    ],
    "description": "State-dependent randomization: Current value must not match any of the previous 5 generated values using a state queue in `post_randomize()`.",
    "explanation": "Write a constraint such that a 4-bit variable is not the same as the last five occurrences",
    "code": "/*********************\nWrite a constraint such that a 4-bit variable is not the same as the last five occurrences\n*********************/\n\nclass packet;\n    rand bit [3:0] data;\n    int queue[$]; //To store last 5 occurances;\n\n    constraint c_data{\n        data inside {[0:15]};\n        !(data inside {queue});\n    }\n\n    function void post_randomize();\n        queue.push_back(data);\n        if(queue.size()==6) begin\n            queue.pop_front();\n        end\n    endfunction: post_randomize\n\n\nendclass: packet\n\nmodule different_from_last_five;\n    packet p = new();\n\n    initial begin\n        repeat(15) begin\n            if(p.randomize()) begin\n                $display(\"Randomization is successful!. Generated value: %0d\",p.data);\n            end\n            else begin\n                $display(\"Randomization has failed\");\n            end\n        end\n    end\nendmodule"
  },
  {
    "id": "c_divide_array_to_n_queue_elements",
    "title": "Divide Array To N Queue Elements",
    "category": "Arrays, Queues & Matrices",
    "path": "constraints/divide_array_to_n_queue_elements.sv",
    "isFrequentlyAsked": false,
    "tags": [
      "Queue",
      "Array"
    ],
    "description": "Partition elements of an input array randomly and uniformly across N parameterized queues.",
    "explanation": "Given an input array, randomly map elements to N output queues (N parameterized).\nUse UVM SystemVerilog constraints so that:\n(1) each input element appears in exactly one output queue,\n(2) all N output queues are non-empty, and\n(3) feasibility requires N ≤ input_size.",
    "code": "/**********\nGiven an input array, randomly map elements to N output queues (N parameterized). \nUse UVM SystemVerilog constraints so that: \n(1) each input element appears in exactly one output queue, \n(2) all N output queues are non-empty, and \n(3) feasibility requires N ≤ input_size.\n***********/\n\nclass packet;\n    rand int M, N; // M: size of the input array, N: number of queues N <= m\n\n    rand int input_array[]; // Input array of size M;\n\n    rand int output_queues[][$]; // An associative array: An array of queues. Number of queues = N\n\n    // Indexes that indicate in which queue should the input_array element be placed in \n    rand int indexes[];\n\n    // Constraint to generate M and N sizes\n    constraint c_sizes{\n        M inside {[5:10]};\n        N inside {[1:M]};\n\n        // Constraint to generate the input array with size M and output array with size N\n        input_array.size() == M;\n        indexes.size() == M;\n\n        output_queues.size() == N;\n    }\n\n    // Constraint to generate elements for input array\n    constraint c_input_array{\n        foreach(input_array[i]){\n            input_array[i] inside {[0:15]};\n        }\n\n        unique {input_array};\n    }\n\n    // Constraint to populate indexes array to determine into which queue should each element go into\n    constraint c_indexes{\n        foreach(indexes[i]){\n            indexes[i] inside {[0:N-1]};\n        }\n    }\n\n    // None of the queues should be empty\n    constraint c_use_all_queues{\n        foreach(output_queues[i]) {\n            indexes.sum() with (int'(item == i)) !=0;\n        }\n    }\n\n    // Populate queues\n    function void post_randomize();\n        // Everynew randomization clears the previous entries\n        foreach(output_queues[i]) begin\n            output_queues[i].delete();\n        end\n\n\n        foreach(input_array[i]) begin\n            output_queues[indexes[i]].push_back(input_array[i]);\n        end\n    endfunction\n\n    \nendclass\n\nmodule test;\n    packet p;\n    int n;\n    initial begin\n        p = new();\n        repeat(5) begin\n            if(p.randomize()) begin\n                $display(\":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::\");\n                $display(\"Input array size M : %0d, Input Array: %p\", p.M, p.input_array);\n                $display(\"Output array size N: %0d\", p.N);\n                $display(\"Indexes: %p\", p.indexes);\n                n = p.N;\n                $display(\"Output Queues: \");\n                for(int i = 0;i<n;i++) begin\n                    $display(\"%p\", p.output_queues[i]);\n                end\n                $display(\":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::\");\n            end\n        end\n        \n    end\nendmodule"
  },
  {
    "id": "c_divide_queue_elements",
    "title": "Divide Queue Elements",
    "category": "Arrays, Queues & Matrices",
    "path": "constraints/divide_queue_elements.sv",
    "isFrequentlyAsked": false,
    "tags": [
      "Queue"
    ],
    "description": "Split a 15-element integer queue into multiple smaller queues according to value criteria (even/odd/prime).",
    "explanation": "You are given a queue of integers:\nint array[$] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15};\nWrite SystemVerilog constraints to divide the elements of this queue into three new queues (q1, q2, and q3) such that:\n• Every element from the original queue appears in exactly one of the three new queues\n• All three queues together contain unique elements (no duplicates)\n• Each queue must have at least one element\n• You cannot use post_randomize() to perform the split — it must be handled entirely within the constraint block",
    "code": "/******************\nYou are given a queue of integers:\n\nint array[$] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15};\n\nWrite SystemVerilog constraints to divide the elements of this queue into three new queues (q1, q2, and q3) such that:\n\n• Every element from the original queue appears in exactly one of the three new queues\n• All three queues together contain unique elements (no duplicates)\n• Each queue must have at least one element\n• You cannot use post_randomize() to perform the split — it must be handled entirely within the constraint block\n******************/\n\nclass packet;\n    int arr[$] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15};\n    rand int q1[$], q2[$], q3[$];\n    rand int index[15];\n\n    constraint q_size{\n        q1.size()+q2.size()+q3.size() == 15;\n    }\n\n    constraint c_range{\n        q1.size() inside {[1:13]};\n        q2.size() inside {[1:13]};\n        q3.size() inside {[1:13]};\n\n        q1.size()!=q2.size();\n        q2.size()!=q3.size();\n\n        foreach(index[i]){\n            index[i] inside {[0:14]};\n        }\n    }\n\n    constraint c_unique{\n        unique {index};\n    }\n\n    constraint c_queue_unique{\n        foreach(q1[i]) q1[i] == arr[index[i]];\n        foreach(q2[i]) q2[i] == arr[index[i+q1.size()]];\n        foreach(q3[i]) q3[i] == arr[index[i+q1.size()+q2.size()]];\n    }\n\n    \n\nendclass: packet\n\nmodule divide_queue_elements;\n\n    packet p = new();\n\n    initial begin\n        if(p.randomize()) begin\n            $display(\"Randomization is successful\");\n            foreach(p.q1[i]) begin\n                $write(\"q1[%0d]: %0d \", i, p.q1[i]);\n            end\n            $display(\"\");\n            foreach(p.q2[i]) begin\n                $write(\"q2[%0d]: %0d \", i, p.q2[i]);\n            end\n            $display(\"\");\n            foreach(p.q3[i]) begin\n                $write(\"q3[%0d]: %0d \", i, p.q3[i]);\n            end\n        end\n        else begin\n            $display(\"Randomization has failed\");\n        end\n    end\nendmodule"
  },
  {
    "id": "c_divide_queue_elements_1",
    "title": "Divide Queue Elements 1",
    "category": "Arrays, Queues & Matrices",
    "path": "constraints/divide_queue_elements_1.sv",
    "isFrequentlyAsked": false,
    "tags": [
      "Queue"
    ],
    "description": "Partition a single integer queue into 3 destination queues such that each queue contains mutually exclusive unique values.",
    "explanation": "Write a constraint to divide values of 1 queue into 3 queues so that all 3 queues have unique elements",
    "code": "/*****************\nWrite a constraint to divide values of 1 queue into 3 queues so that all 3 queues have unique elements\n*****************/\n\nclass packet;\n    rand int queue[$]; //Randomizing this queue and then sharing it's elements with 3 queues\n    rand int q1[$], q2[$], q3[$];\n    rand int indexes[];\n\n    constraint c_queue_size{\n        queue.size() inside {[5:50]};\n    }\n\n    constraint c_other_queue_sizes{\n        indexes.size() == queue.size();\n\n        q1.size() inside {[1:50]};\n        q2.size() inside {[1:50]};\n        q3.size() inside {[1:50]};\n\n        q1.size()+ q2.size()+q3.size() == queue.size();\n\n        q1.size()!= q2.size();\n        q2.size()!=q3.size();\n    }\n\n    constraint c_unique_queues{\n        unique {queue};\n        unique {indexes};\n    }\n\n    constraint c_range_of_values{\n        foreach(indexes[i]){\n            indexes[i] inside {[0:indexes.size()-1]};\n        }\n\n        foreach(queue[i]){\n            queue[i] inside {[-10:50]};\n        }\n    }\n\n    function void post_randomize();\n\n        foreach(q1[i]) q1[i] = queue[indexes[i]];\n        foreach(q2[i]) q2[i] = queue[indexes[i+q1.size()]];\n        foreach(q3[i]) q3[i] = queue[indexes[i+q1.size()+q2.size()]];\n    endfunction: post_randomize\n\n    \nendclass: packet\n\nmodule test;\n    packet p;\n    initial begin\n        p = new();\n        if(p.randomize()) begin\n            $display(\"Original queue: %p\",p.queue);\n            $display(\"Queue 1: %p\",p.q1);\n            $display(\"Queue 2: %p\",p.q2);\n            $display(\"Queue 3: %p\",p.q3);\n        end\n    end\nendmodule"
  },
  {
    "id": "c_dynamic_array_repetition_rules",
    "title": "Dynamic Array Repetition Rules",
    "category": "Arrays, Queues & Matrices",
    "path": "constraints/dynamic_array_repetition_rules.sv",
    "isFrequentlyAsked": false,
    "tags": [
      "Array"
    ],
    "description": "Generate a 300-element dynamic array from set `{0,1,2,3,4,5}` where no element repeats more than twice consecutively.",
    "explanation": "Generate dynamic array of exactly 300 elements. Elements take values from {0,1,2,3,4}.\nUVM SV Constraints: (1) Each value (0,1,2,3,4) appears at least 40 times, (2) Value 0 can appear consecutively, (3) Values 1,2,3,4 cannot appear consecutively (no adjacent repeats).",
    "code": "/*************************************\nGenerate dynamic array of exactly 300 elements. Elements take values from {0,1,2,3,4}. \nUVM SV Constraints: (1) Each value (0,1,2,3,4) appears at least 40 times, (2) Value 0 can appear consecutively, (3) Values 1,2,3,4 cannot appear consecutively (no adjacent repeats).\n*************************************/\n\ntypedef int count_t[5];\n\nclass packet;\n    rand int arr[];\n\n    constraint c_size_range{\n        arr.size()==300;\n\n        foreach(arr[i]) {\n            arr[i] inside {[0:4]};\n        }\n    }\n\n    constraint c_freq{\n        \n        arr.sum() with (int'(item == 0)) >= 40;\n        arr.sum() with (int'(item == 1)) >= 40;\n        arr.sum() with (int'(item == 2)) >= 40;\n        arr.sum() with (int'(item == 3)) >= 40;\n        arr.sum() with (int'(item == 4)) >= 40;\n\n    }\n\n    constraint c_adjacent_no_repeat{\n        foreach(arr[i]){\n            if((i>0) && (arr[i] inside {[1:4]})) {\n                arr[i] != arr[i-1];\n            }\n        }\n    }\n\n    function automatic count_t count(int array[]);\n        int count_arr[5] = {0,0,0,0,0};\n        foreach(array[i]) begin\n            if(array[i]==0) count_arr[0]++;\n            else if(array[i]==1) count_arr[1]++;\n            else if(array[i]==2) count_arr[2]++;\n            else if(array[i]==3) count_arr[3]++;\n            else if(array[i]==4) count_arr[4]++;\n        end\n        return count_arr;\n    endfunction: count\n\nendclass: packet\n\nmodule test;\n\n    packet p = new();\n    count_t count_arr;\n\n    initial begin\n        repeat(5) begin\n            if(p.randomize()) begin\n                count_arr = p.count(p.arr);\n                $display(\"%p\",p.arr);\n                $display(\"Randomization is successful, Count of 0 = %0d, Count of 1 = %0d, Count of 2 = %0d, Count of 3 = %0d, Count of 4 = %0d\", count_arr[0], count_arr[1], count_arr[2], count_arr[3], count_arr[4]);\n            end\n            else begin\n                $display(\"Randomization has failed\");\n            end\n        end\n    end\n\nendmodule"
  },
  {
    "id": "c_dynamic_ones_count_constraint",
    "title": "Dynamic Population Count Modulation",
    "category": "Arithmetic & Bit-Level Constraints",
    "path": "constraints/dynamic_ones_count_constraint.sv",
    "isFrequentlyAsked": false,
    "tags": [
      "Bitwise"
    ],
    "description": "Dynamically modulate the population count of variable `A` based on the random value of variable `B`.",
    "explanation": "Write a constraint for a variable such that the number of ones depends on the value of another variable",
    "code": "/*********************\nWrite a constraint for a variable such that the number of ones depends on the value of another variable\n*********************/\n\nclass packet;\n    rand bit [31:0] data;\n    rand int random_ones;\n\n    constraint c_range{\n        random_ones inside {[0:32]};\n    }\n    \n    constraint c_countones {\n        $countones(data) == random_ones;\n    }\n\nendclass: packet\n\nmodule test;\n    packet p = new();\n\n    initial begin\n        repeat(5) begin\n            if(p.randomize()) begin\n                $display(\"Randomization is successful! --- Generated value: %032b --- Number of ones: %0d\",p.data,p.random_ones);\n            end\n            else begin\n                $display(\"Randomization has failed\");\n            end\n        end\n    end\nendmodule"
  },
  {
    "id": "c_eight_queens_constraint",
    "title": "Eight Queens Chessboard Puzzle",
    "category": "Logic Puzzles & Brainteasers",
    "path": "constraints/eight_queens_constraint.sv",
    "isFrequentlyAsked": true,
    "tags": [
      "Frequently Asked",
      "Puzzle"
    ],
    "description": "Classic Eight Queens Puzzle: Place 8 queens on an 8 \\times 8 chessboard using SystemVerilog constraints such that no two queens share the same row, column, or diagonal.",
    "explanation": "Write uvm sv constraints to Place 8 queens on 8×8 chessboard such that no two queens attack each other.\nQueens attack same row, column, or diagonal. Model as constraint problem: assign column position for each row's queen.",
    "code": "/******************\nWrite uvm sv constraints to Place 8 queens on 8×8 chessboard such that no two queens attack each other. \nQueens attack same row, column, or diagonal. Model as constraint problem: assign column position for each row's queen.\n******************/\n\nclass packet;\n    \n    // Column array where arr[1]=5 means that 2nd row of chessboard has the queen at 6th position\n    rand int unsigned arr[8];\n\n    constraint range{\n        foreach(arr[i]) {\n            arr[i] inside {[0:7]};\n        }\n\n        unique {arr};\n    }\n\n    //Diagonal Check\n    constraint eight_queens{\n        foreach(arr[i]){\n            foreach(arr[j]){\n                if(i<j){\n                    (arr[i]-arr[j]) != (i-j);\n                    (arr[i]-arr[j]) != (j-i);\n                }\n            }\n        }\n    }\n\nendclass: packet\n\nmodule eight_queens;\n\n    packet p = new();\n\n    initial begin\n        if(p.randomize()) begin\n            $display(\"Randomization is successful\");\n            foreach(p.arr[i]) begin\n                $display(\"arr[%0d]: %0d\", i, p.arr[i]);\n            end\n        end\n        else begin\n            $display(\"Randomization has failed\");\n        end\n\n        foreach(p.arr[i]) begin\n            foreach(p.arr[j]) begin\n                if(j==p.arr[i]) begin\n                    $write(\"Q \");\n                end\n                else $write(\"* \");\n            end\n            $write(\"\\n\");\n        end\n    end\nendmodule"
  },
  {
    "id": "c_equal_ones_zeroes",
    "title": "Equal Number of Ones and Zeroes",
    "category": "Arithmetic & Bit-Level Constraints",
    "path": "constraints/equal_ones_zeroes.sv",
    "isFrequentlyAsked": true,
    "tags": [
      "Frequently Asked",
      "Bitwise"
    ],
    "description": "Generate 32-bit values with an equal number of set and unset bits (`countones(val) == 16`).",
    "explanation": "Write uvm sv constraint for variable where number of 1-bits equals number of 0-bits. Balanced bit pattern. Requires even bit width.",
    "code": "// Write uvm sv constraint for variable where number of 1-bits equals number of 0-bits. Balanced bit pattern. Requires even bit width.\n\nclass packet;\n  rand bit [15:0] arr;\n  \n//   constraint c_arr{\n//     arr.sum() with (int'(item==1)) == (15+1)/2;\n//     arr.sum() with (int'(item==0)) == (15+1)/2;\n  //   } //Cant use this because sum is only for unpacked arrays\n\n  constraint c_arr{\n    $countones(arr) == 8;\n  }\nendclass\n\nmodule test;\n  packet p = new();\n  initial begin\n  \trepeat(5) begin\n    \tif(p.randomize()) begin\n      \t$display(\"Randomization is successful: %016b\",p.arr);\n    \tend\n  \tend\n  end\nendmodule"
  },
  {
    "id": "c_even_odd_constraint",
    "title": "Even Odd Constraint",
    "category": "Sequences & Pattern Generation",
    "path": "constraints/even_odd_constraint.sv",
    "isFrequentlyAsked": true,
    "tags": [
      "Frequently Asked",
      "Distribution / Pattern"
    ],
    "description": "Parity matching: Even array indices must hold even values; odd indices must hold odd values (`a[i] % 2 == i % 2`).",
    "explanation": "Write UVM SV constraint for array where parity of index matches parity of value.\nEven indices (0,2,4,...) contain even values. Odd indices (1,3,5,...) contain odd values.\nSupport arbitrary integer values (positive, negative, or zero).",
    "code": "/******************\nWrite UVM SV constraint for array where parity of index matches parity of value. \nEven indices (0,2,4,...) contain even values. Odd indices (1,3,5,...) contain odd values. \nSupport arbitrary integer values (positive, negative, or zero).\n******************/\n\nclass packet;\n    rand int arr[10];\n\n    constraint even_odd{\n        unique {arr};\n\n        foreach(arr[i]){\n            arr[i] inside {[-200:200]};\n        }\n\n        foreach(arr[i]) {\n            (i%2) == (arr[i]%2);\n        }\n    }\n\n\nendclass: packet\n\nmodule even_odd_constraint;\n\n    packet p = new();\n\n    initial begin\n        if(p.randomize()) begin\n            $display(\"Randomization is successful\");\n            foreach(p.arr[i]) begin\n                $display(\"arr[%0d]: %0d\", i, p.arr[i]);\n            end\n        end\n        else begin\n            $display(\"Randomization has failed\");\n        end\n    end\nendmodule"
  },
  {
    "id": "c_even_odd_not_repeat",
    "title": "Even Odd Not Repeat",
    "category": "Sequences & Pattern Generation",
    "path": "constraints/even_odd_not_repeat.sv",
    "isFrequentlyAsked": false,
    "tags": [
      "Distribution / Pattern"
    ],
    "description": "Alternate strictly between even and odd integers without repeating values across consecutive cycles.",
    "explanation": "Write a function to generates numbers that alternate between even and odd numbers.\nThe generated number should not match any of the last 10 values",
    "code": "/**********************\nWrite a function to generates numbers that alternate between even and odd numbers. \nThe generated number should not match any of the last 10 values\n***********************/\n\nclass packet;\n    rand int val;\n    bit prev_val;     //If prev value is even, prev_val = 1, else 0\n    int queue[$];       \n\n    constraint c_val_range{\n        val inside {[1:100]};\n    }\n\n    constraint c_check_prev_val{\n        //If previous value is even, then next random number has to be odd\n        if(prev_val){\n            val%2 == 1;\n        }\n        else{\n            val%2 == 0;\n        }\n    }\n\n    constraint c_val_not_repeat{\n        !(val inside {queue});\n    }\n\n    function void post_randomize();\n        prev_val = (val%2==0)?1:0;\n        queue.push_back(val);\n        if(queue.size() > 10) begin\n            queue.pop_front();\n        end\n    endfunction: post_randomize\n\nendclass: packet\n\nclass main;\n    packet p;\n\n    function new();\n        p = new();\n    endfunction: new\n\n    function int alternating_odd_even();\n        if(p.randomize()) begin\n            return p.val;\n        end\n        return 0;\n    endfunction: alternating_odd_even\nendclass: main\n\nmodule test;\n    main obj;\n    initial begin\n        obj = new();\n        repeat(15) begin\n            $display(\"%0d\",obj.alternating_odd_even());\n        end\n    end\nendmodule"
  },
  {
    "id": "c_even_odd_sequence",
    "title": "Even Odd Sequence",
    "category": "Sequences & Pattern Generation",
    "path": "constraints/even_odd_sequence.sv",
    "isFrequentlyAsked": false,
    "tags": [
      "Distribution / Pattern"
    ],
    "description": "Generate a sequence of N even numbers followed immediately by N odd numbers.",
    "explanation": "Question:\narray of integers for which we want a patterned series of N even values followed by N odd values\nrand int array[];\nrand int N;\nCreate a constraint which will ensure that\nthe array is randomized according\nto our pattern\nEX (N = 2): {0, 2, 3, 5}\nEX (N = 5): {18, 8, 18, 24, 98, 9, 15, 33, 71, 1}\nEX (N = 1): {4, 1, 22, 9, 36}",
    "code": "/**********\nQuestion:\narray of integers for which we want a patterned series of N even values followed by N odd values\n    rand int array[];\n    rand int N;\n\nCreate a constraint which will ensure that\nthe array is randomized according\nto our pattern\nEX (N = 2): {0, 2, 3, 5}\nEX (N = 5): {18, 8, 18, 24, 98, 9, 15, 33, 71, 1}\nEX (N = 1): {4, 1, 22, 9, 36}\n**********/\n\n\n\nclass even_odd_sequence;\n    rand int arr[];\n    rand int N;\n\n    constraint c_unique_arr{\n        unique {arr};\n    }\n\n    constraint pattern{\n        foreach(arr[i]){\n            if((i/N)%2 ==0){\n                arr[i]%2 == 0;\n            }\n            else{\n                arr[i]%2 == 1;\n            }\n        }\n    }\n\n    constraint c_array_range{\n        foreach(arr[i]){\n            arr[i] inside {[0:100]};\n        }\n    }\n\n    constraint c_c_array_range_size{\n        arr.size() inside {[5:20]};\n    }\n\n    constraint c_range_N{\n        N inside {[1:5]};\n    }\nendclass\n\nmodule test;\n    even_odd_sequence inst = new();\n\n    initial begin\n        repeat(5) begin\n            if(inst.randomize()) begin\n                $display(\"N: %0d, Array: %p\",inst.N,inst.arr);\n            end\n        end\n    end\nendmodule"
  },
  {
    "id": "c_even_odd_sum_constraint",
    "title": "Even Odd Sum Constraint",
    "category": "Sequences & Pattern Generation",
    "path": "constraints/even_odd_sum_constraint.sv",
    "isFrequentlyAsked": false,
    "tags": [
      "Distribution / Pattern"
    ],
    "description": "Array constraint limiting the sum of all odd elements to \\le 30 and sum of even elements to \\ge 50.",
    "explanation": "Write SV constraint to limit sum of odd elements of an array to be 30 and sum of even elements to be 60",
    "code": "/*******************\nWrite SV constraint to limit sum of odd elements of an array to be 30 and sum of even elements to be 60\n*******************/\n\nclass packet;\n  rand int arr[];\n  \n  constraint c_arr_size{\n    arr.size() inside {[5:20]};\n  }\n\n  constraint c_element_range{\n    foreach(arr[i]){\n        arr[i] dist {\n            [-100:0]:= 20,\n            [1:100]:= 80\n        };\n    }\n  }\n\n  constraint c_odd_even_sum{\n    arr.sum() with (int'(item%2==0?item:0)) == 60;\n    arr.sum() with (int'(item%2!=0?item:0)) == 30;\n  }\n  \nendclass: packet\n\nmodule test;\n  packet p;\n  initial begin\n    p = new();\n    if(p.randomize()) begin\n      $display(\"%p\",p.arr);\n      end\n  end\nendmodule"
  },
  {
    "id": "c_even_odd_with_distribution",
    "title": "Markov Chain Alternating Even-Odd Distribution",
    "category": "Sequences & Pattern Generation",
    "path": "constraints/even_odd_with_distribution.sv",
    "isFrequentlyAsked": true,
    "tags": [
      "Frequently Asked",
      "Distribution / Pattern"
    ],
    "description": "Markov chain constraint: If previous value was odd, next has 80% probability of being even; if previous was even, next has 70% probability of being odd.",
    "explanation": "For a 8 bit variable if the past randomization resulted in a odd value,\nthe next randomization should be even with 75% probability else be even with 25% probability. Write a constraint",
    "code": "/************\nFor a 8 bit variable if the past randomization resulted in a odd value, \nthe next randomization should be even with 75% probability else be even with 25% probability. Write a constraint\n************/\n\nclass packet;\n\n    rand bit[7:0] data;\n    bit[7:0] prev_val;\n\n    constraint c_prev_val_even_or_odd{\n        if(prev_val[0] == 1) {\n            data[0] dist {\n                0:= 75,\n                1:= 25\n            };\n        }else{\n            data[0] dist {\n                0:= 25,\n                1:= 75\n            };\n        }\n    }\n\n    function void post_randomize();\n        prev_val = data;\n    endfunction: post_randomize\n\nendclass: packet\n\nmodule test;\n    packet p;\n\n    initial begin\n        p = new();\n        repeat(10) begin\n            if(p.randomize()) begin\n                $display(\"%08b\",p.data);\n            end\n        end\n    end\nendmodule"
  },
  {
    "id": "c_exactly_3_same_values",
    "title": "Exactly 3 Same Values",
    "category": "Arrays, Queues & Matrices",
    "path": "constraints/exactly_3_same_values.sv",
    "isFrequentlyAsked": false,
    "tags": [],
    "description": "10-element array where exactly three elements share the same value and the remaining 7 elements are distinct.",
    "explanation": "Write SystemVerilog constraint for integer array of 10 elements where exactly 3 elements share the\nsame value (triplicate), and the remaining 7 elements are all different from the\ntriplicate value.",
    "code": "/******************\nWrite SystemVerilog constraint for integer array of 10 elements where exactly 3 elements share the \nsame value (triplicate), and the remaining 7 elements are all different from the \ntriplicate value. \n******************/\n\nclass packet;\n    \n    //Array is of size 10\n    rand int arr[10];\n    // Array that holds 3 indexes that have the same value\n    rand int rand_pos[3];\n    rand int trip_repeat_value;\n\n    constraint range{\n        foreach(arr[i]) {\n            arr[i] inside {[0:255]};\n        }\n\n        trip_repeat_value inside {[0:255]};\n    }\n\n    constraint three_rand_pos_same{\n        unique { rand_pos };\n\n        foreach(rand_pos[i]) {\n            rand_pos[i] inside {[0:9]};\n        }\n\n        arr[rand_pos[0]] == trip_repeat_value;\n        arr[rand_pos[0]] == arr[rand_pos[1]];\n        arr[rand_pos[1]] == arr[rand_pos[2]];\n    }\n\n    constraint other_pos_same_values{\n\n        foreach(arr[i]) {\n            if(!(i inside {rand_pos})) arr[i] != trip_repeat_value;\n        }\n\n    }\n\n\n\n\n\nendclass: packet\n\nmodule exactly_3_same_values;\n\n    packet p = new();\n\n    initial begin\n        if(p.randomize()) begin\n            $display(\"Randomization is successful\");\n            foreach(p.arr[i]) begin\n                $display(\"arr[%0d]: %0d\", i, p.arr[i]);\n            end\n        end\n        else begin\n            $display(\"Randomization has failed\");\n        end\n    end\nendmodule"
  },
  {
    "id": "c_exactly_3_same_values_1",
    "title": "Exactly 3 Same Values 1",
    "category": "Arrays, Queues & Matrices",
    "path": "constraints/exactly_3_same_values_1.sv",
    "isFrequentlyAsked": false,
    "tags": [],
    "description": "Alternate variant of 3-identical-values constraint using sum reduction.",
    "explanation": "Write constraint for an integer array with 10 elements such that exactly 3 of them are same and rest are unique",
    "code": "/******************\nWrite constraint for an integer array with 10 elements such that exactly 3 of them are same and rest are unique\n******************/\n\nclass packet;\n    \n    //Array is of size 10\n    rand int arr[10];\n    \n    //It is the value that repeats 3 times\n    rand int unsigned triple_value;\n\n    constraint triple_value_constraint{\n        triple_value inside {[0:9]};\n    }\n\n    constraint seven_unique{\n        \n        foreach(arr[i]){\n            arr[i] inside {[0:9]};\n            arr[i] != triple_value -> arr.sum() with (int'(item == arr[i])) == 1;\n        }\n    }\n\n    constraint triple_repeat{\n        arr.sum() with (int'(item == triple_value))==3;\n    }\n\n\n\n\n\nendclass: packet\n\nmodule exactly_3_same_values;\n\n    packet p = new();\n\n    initial begin\n        if(p.randomize()) begin\n            $display(\"Randomization is successful\");\n            foreach(p.arr[i]) begin\n                $display(\"arr[%0d]: %0d\", i, p.arr[i]);\n            end\n        end\n        else begin\n            $display(\"Randomization has failed\");\n        end\n    end\nendmodule"
  },
  {
    "id": "c_exactly_one_duplicate",
    "title": "Exactly One Duplicate",
    "category": "Arrays, Queues & Matrices",
    "path": "constraints/exactly_one_duplicate.sv",
    "isFrequentlyAsked": false,
    "tags": [],
    "description": "10-element array where exactly one value is duplicated and all other 8 values are unique.",
    "explanation": "Create a constraint for an int array with 10 elements.\nValue is 1 to 10. 2 of the elements will have the same number and the rest will all have different numbers, the index of the 2 same elements also have to be randomized.",
    "code": "/************\nCreate a constraint for an int array with 10 elements. \nValue is 1 to 10. 2 of the elements will have the same number and the rest will all have different numbers, the index of the 2 same elements also have to be randomized.\n*************/\n\nclass packet;\n    rand int array[];\n    rand int index_1, index_2;\n\n\n    constraint c_size{\n        array.size == 10;\n    }\n\n    constraint c_range{\n        foreach(array[i]){\n            array[i] inside {[1:10]};\n        }\n\n        array[index_1] == array[index_2];\n    }\n\n    constraint c_rest_values_uniques{\n        foreach(array[i]){\n            foreach(array[j]){\n                if(i<j){\n                    if((i==index_1 && j == index_2) || (i==index_2 && j == index_1)){\n                        array[i] == array[j];\n                    }\n                    else{\n                        array[i]!=array[j];\n                    }\n                }\n            }\n        }\n    }\n\n    constraint c_index{\n        index_1 != index_2;\n        index_1 inside{[0:9]};\n        index_2 inside{[0:9]};\n    }\n\n\nendclass: packet\n\nmodule test;\n    packet p = new();\n\n    initial begin\n        repeat(5) begin\n            if(p.randomize()) begin\n                $display(\"Array Generated: %p\",p.array);\n            end\n        end\n    end\nendmodule"
  },
  {
    "id": "c_factorial",
    "title": "Factorial",
    "category": "Arithmetic & Bit-Level Constraints",
    "path": "constraints/factorial.sv",
    "isFrequentlyAsked": true,
    "tags": [
      "Frequently Asked"
    ],
    "description": "Constrain generated numbers to only valid factorial values (1, 2, 6, 24, 120, 720, \\dots).",
    "explanation": "Write systemverilog constraint to generate factorial of a random number",
    "code": "/*******************\nWrite systemverilog constraint to generate factorial of a random number\n*******************/\n\nclass packet;\n    rand int data;\n    int factorial;\n\n    constraint c_data_range{\n        data inside {[0:10]};\n    }\n\n    function int calc_factorial(int num);\n        int result = 1;\n        for(int i = 2;i<=num;i++) begin\n            result = result*i;\n        end\n        return result;\n    endfunction: calc_factorial\n\n    function void post_randomize();\n        factorial = calc_factorial(data);\n    endfunction: post_randomize\n\nendclass\n\nmodule test;\n    packet p;\n\n    initial begin\n        p = new();\n        repeat(5) begin\n            if(p.randomize()) begin\n                $display(\"Random Number: %0d, Factorial: %0d\",p.data, p.factorial);\n            end\n        end\n    end\nendmodule"
  },
  {
    "id": "c_five_set_or_unset",
    "title": "Five Bits Set or Unset (NVIDIA)",
    "category": "Arithmetic & Bit-Level Constraints",
    "path": "constraints/five_set_or_unset.sv",
    "isFrequentlyAsked": true,
    "tags": [
      "Frequently Asked",
      "NVIDIA"
    ],
    "description": "NVIDIA Interview Question: 32-bit variable where either exactly 5 bits are set, or exactly 5 bits are unset.",
    "explanation": "Question from NVIDIA panel - You are generating a 32-bit random variable in SystemVerilog. Write a constraint to ensure that the randomized value does not contain more than five consecutive bits that are all 1's or all. Solve without using 'unique' or 'post_randomize' keyword. 0's.\nIn other words, within the 32-bit value, there should be no sequence of 5 contiguous bits that are all set or all unset.",
    "code": "/****\nQuestion from NVIDIA panel - You are generating a 32-bit random variable in SystemVerilog. Write a constraint to ensure that the randomized value does not contain more than five consecutive bits that are all 1's or all. Solve without using 'unique' or 'post_randomize' keyword. 0's.\n\nIn other words, within the 32-bit value, there should be no sequence of 5 contiguous bits that are all set or all unset.\n****/\n\nclass packet;\n  rand bit [31:0] arr;\n\n    constraint c{\n        foreach(arr[i]){\n          if(i<=27){\n            !(&arr[i+:5]);\n            !(&(~arr[i+:5]));\n          }\n        }\n    }\n\n\nendclass: packet\n\nmodule five_set_or_unset;\n\n    packet p = new();\n\n    initial begin\n        if(p.randomize()) begin\n            $display(\"Randomization is successful\");\n            foreach(p.arr[i]) begin\n                $write(\"%0d\",p.arr[i]);\n            end\n        end\n        else begin\n            $display(\"Randomization has failed\");\n        end\n    end\nendmodule"
  },
  {
    "id": "c_four_monkeys",
    "title": "Four Monkeys Banana Inequality Puzzle",
    "category": "Logic Puzzles & Brainteasers",
    "path": "constraints/four_monkeys.sv",
    "isFrequentlyAsked": false,
    "tags": [
      "Puzzle"
    ],
    "description": "Four monkeys sharing 10 bananas such that every monkey gets at least 1 banana, no two monkeys get equal bananas, and specific monkey inequalities hold.",
    "explanation": "Write a constraint for 4 monkeys having to share 10 bananas and make sure every monkey gets atleast 1 banana",
    "code": "/****\nWrite a constraint for 4 monkeys having to share 10 bananas and make sure every monkey gets atleast 1 banana\n****/\n\nclass packet;\n    rand int arr[];\n\n    constraint c{\n        arr.size() == 4;\n\n        arr.sum() == 10;\n\n        foreach(arr[i]){\n            arr[i] inside {[1:7]};\n        }\n    }\n\n\nendclass: packet\n\nmodule four_monkeys;\n\n    packet p = new();\n\n    initial begin\n        if(p.randomize()) begin\n            $display(\"Randomization is successful\");\n            foreach(p.arr[i]) begin\n                $display(\"arr[%0d]: %0d\", i, p.arr[i]);\n            end\n        end\n        else begin\n            $display(\"Randomization has failed\");\n        end\n    end\nendmodule"
  },
  {
    "id": "c_gray_code",
    "title": "Gray Code",
    "category": "Sequences & Pattern Generation",
    "path": "constraints/gray_code.sv",
    "isFrequentlyAsked": true,
    "tags": [
      "Frequently Asked",
      "Distribution / Pattern"
    ],
    "description": "Constrain randomized 5-bit numbers to strictly follow Gray code transitions (Hamming distance of 1).",
    "explanation": "Write constraints to generate a 5-bit Gray code from a randomized binary number.",
    "code": "/*****************\nWrite constraints to generate a 5-bit Gray code from a randomized binary number.\n******************/\n\nclass packet;\n    rand bit [4:0] binary_data;\n    rand bit [4:0] gray_code;\n\n    constraint c_gray_code{\n        gray_code == (binary_data)^(binary_data>>1);\n    }\nendclass: packet\n\nmodule test;\n    packet p = new();\n\n    initial begin\n        repeat(5) begin\n            if(p.randomize()) begin\n                $display(\"%05b\",p.gray_code);\n            end\n        end\n    end\nendmodule"
  },
  {
    "id": "c_image_pixel_constraint",
    "title": "Image Pixel Constraint",
    "category": "Arrays, Queues & Matrices",
    "path": "constraints/image_pixel_constraint.sv",
    "isFrequentlyAsked": false,
    "tags": [],
    "description": "Constraint: 2D image 320×240, each pixel is 16 bits. Constrain each pixel such that pixel is less than the sum of its 4 neighbours (top, bottom, left, right).",
    "explanation": "Constraint: 2D image 320×240, each pixel is 16 bits. Constrain each pixel such that pixel is less than the sum of its 4 neighbours (top, bottom, left, right).",
    "code": "/*****************\nConstraint: 2D image 320×240, each pixel is 16 bits. Constrain each pixel such that pixel is less than the sum of its 4 neighbours (top, bottom, left, right).\n******************/\n\n\nclass packet;\n    \n    //Image Matrix\n    rand bit [15:0] image[][];\n\n    constraint c_image_dimensions{\n        image.size() == 240;\n\n        foreach(image[i]){\n            image[i].size() == 320;\n        }\n    }\n\n    constraint c_sum_less_than_neighbours{\n        foreach(image[i,j]){\n            if(i>0  && i <239 && j > 0 && j < 319) {\n                image[i][j] < image[i][j+1] + image[i-1][j] + image[i+1][j] + image[i][j-1];\n            }            \n        }\n    }\n\nendclass: packet\n\n\n//Use post randomize to make the condition hold\n\nclass packet;\n    \n    //Image Matrix\n    rand bit [15:0] image[][];\n\n    constraint c_image_dimensions{\n        image.size() == 240;\n\n        foreach(image[i]){\n            image[i].size() == 320;\n        }\n    }\n\n    function void post_randomize();\n        foreach(image[i,j]) begin\n            if(i>0 && i<239 &&\n                j>0 && j<319) begin\n                    int sum = image[i][j+1] + image[i-1][j] + image[i+1][j] + image[i][j-1];\n                    if(image[i][j] >= sum) begin\n                        sum = sum -1;\n                    end\n                end\n        end\n    endfunction: post_randomize\n\nendclass: packet"
  },
  {
    "id": "c_implement_randc",
    "title": "Implement 'randc' Cyclic Permutation Manually",
    "category": "Logic Puzzles & Brainteasers",
    "path": "constraints/implement_randc.sv",
    "isFrequentlyAsked": true,
    "tags": [
      "Frequently Asked",
      "Puzzle"
    ],
    "description": "Simulate cyclic permutation behavior (`randc`) manually using an array, helper mask, and `post_randomize()` without using the `randc` keyword.",
    "explanation": "Write a code to simulate cyclic randomization behavior without using the \"randc\" keyword.",
    "code": "/****************\nWrite a code to simulate cyclic randomization behavior without using the \"randc\" keyword. \n****************/\n\n// 4,2,1,6,3,7,5 - 5,4,7,6,1,3,2\n\nclass packet;\n    rand bit [2:0] data;\n    int queue[$];\n\n    constraint c_not_in_queue{\n        !(data inside {queue});\n    }\n\n    function void post_randomize();\n        queue.push_back(data);\n        if(queue.size()==8) begin\n            queue = {}; //Empty the queue. \n        end\n    endfunction\n\nendclass: packet\n\nmodule test;\n    packet p = new();\n\n    initial begin\n        for(int i =0;i<=31;i++) begin\n            if(p.randomize()) begin\n                $display(\"%0d\",p.data);\n            end\n            if(i%8==7) $display(\"--\");\n        end\n    end\n\nendmodule"
  },
  {
    "id": "c_instruction_constraints",
    "title": "Instruction Pipeline Hazard Avoidance",
    "category": "Real-World SoC Verification Scenarios",
    "path": "constraints/instruction_constraints.sv",
    "isFrequentlyAsked": true,
    "tags": [
      "Frequently Asked",
      "Architecture / SoC"
    ],
    "description": "Constrain processor instructions (`ADD`, `SUB`, `MUL`, `NOP`) such that no `ADD` is immediately followed by `MUL` (pipeline hazard avoidance).",
    "explanation": "Write a constraint that generates Add, mul, sub, nop instructions.\nSuch that no Add instruction is repeated in 3 clock cycles and sub is not repeated in the last 3 valid instructions. Nop is not a valid instruction",
    "code": "/*************************\nWrite a constraint that generates Add, mul, sub, nop instructions. \nSuch that no Add instruction is repeated in 3 clock cycles and sub is not repeated in the last 3 valid instructions. Nop is not a valid instruction\n*************************/\ntypedef enum logic[1:0] {ADD, MUL, SUB, NOP} inst_t;\nclass packet;\n    rand inst_t inst;\n    inst_t last3_all[$];\n    inst_t last3_valid[$];\n\n    constraint c_add{\n        !(inst == ADD && (ADD inside {last3_all}));\n    }\n\n    constraint c_sub{\n        !(inst == SUB && (SUB inside {last3_valid}));\n    }\n\n    function void post_randomize();\n        // always track ALL instructions (including NOP)\n        last3_all.push_back(inst);\n        if (last3_all.size() > 3)\n            last3_all.pop_front();\n\n        // track only VALID instructions (exclude NOP)\n        if (inst != NOP) begin\n            last3_valid.push_back(inst);\n            if (last3_valid.size() > 3)\n                last3_valid.pop_front();\n        end\n    endfunction\nendclass: packet\n\nmodule test;\n    packet p;\n    int cycle_count;\n    initial begin\n        p = new();\n        cycle_count = 1;\n        repeat(12) begin\n            if(p.randomize()) begin\n                $display(\"CYCLE %0d: %s\",cycle_count,p.inst.name());\n                cycle_count = cycle_count+1;\n            end\n        end\n    end\nendmodule"
  },
  {
    "id": "c_adjacent_elements_distinct",
    "title": "Adjacent Elements Distinct in Matrix",
    "category": "Intel Interview Questions",
    "path": "constraints/intel_questions/adjacent_elements_distinct.sv",
    "isFrequentlyAsked": true,
    "tags": [
      "Frequently Asked",
      "Intel",
      "Distribution / Pattern"
    ],
    "description": "Constrain an M \\times M square matrix such that no two adjacent elements (horizontal and vertical neighbors) have identical values.",
    "explanation": "Write uvm sv constraints to generate square matrix (m×m) where all adjacent elements are distinct.\nAdjacent means 4-neighborhood (up, down, left, right). For this question you can consider diagonal or not",
    "code": "/*********************************\nWrite uvm sv constraints to generate square matrix (m×m) where all adjacent elements are distinct. \nAdjacent means 4-neighborhood (up, down, left, right). For this question you can consider diagonal or not\n*********************************/\n\nclass packet;\n    rand int mat[][];\n    rand int m; //Size\n\n    constraint c_matrix_dimensions{\n        m inside{[2:8]};\n        solve m before mat;\n    }\n\n    constraint c_matrix{\n        mat.size() == m;\n        foreach(mat[i]){\n            mat[i].size() == m;\n        }\n    }\n\n    constraint c_range_of_values{\n        foreach(mat[i,j]){\n            mat[i][j] inside {[0:100]};\n        }\n    }\n\n    //Adjacency constraint\n    constraint c_left_and_right{\n        foreach(mat[i,j]){\n            // Left and Right must not be the same. \n            if(j < m-1){\n                mat[i][j] != mat[i][j+1];\n            }\n\n            // Top and Bottom must not be same\n            if(i < m-1){\n                mat[i][j] != mat[i+1][j];\n            }\n        }\n    }\n\n    function void print_matrix(); \n        $display(\"------------------------------------\");\n        foreach(mat[i]) begin\n            foreach(mat[i][j]) begin\n                $write(\"%0d \", mat[i][j]);\n            end\n            $display(\"\");\n        end\n        $display(\"------------------------------------\");\n    endfunction: print_matrix\n    \nendclass: packet\n\nmodule test;\n    packet p;\n    initial begin\n        p = new();\n        repeat(5) begin\n            if(p.randomize()) begin\n                p.print_matrix();\n            end\n        end\n    end\nendmodule"
  },
  {
    "id": "c_generate_power_of_2",
    "title": "Generate Powers of 2 without Exponentiation",
    "category": "Intel Interview Questions",
    "path": "constraints/intel_questions/generate_power_of_2.sv",
    "isFrequentlyAsked": true,
    "tags": [
      "Frequently Asked",
      "Intel",
      "Bitwise"
    ],
    "description": "Generate between 5 and 15 numbers that are strictly powers of two without using the exponentiation operator ``. Solved using bitwise constraints (`countones(val) == 1`).",
    "explanation": "Write a constraint to generate 5 to 15 numbers of power of 2. Without using inbuilt function",
    "code": "/***********************\nWrite a constraint to generate 5 to 15 numbers of power of 2. Without using inbuilt function\n***********************/\n\nclass packet;\n    \n    //Array of powers of 2\n    rand int array[];\n\n    rand int random_number;\n    rand int power_of_2val;\n\n    constraint c_random_number{\n        random_number inside {[0:10]};\n    }\n\n    constraint c_power_of_2{\n        power_of_2val == 1 <<random_number;\n        solve random_number before power_of_2val;\n    }\n\n    constraint c_array_size{\n        array.size() inside {[5:15]};\n    }\n\n    constraint c_array_power_of_2{\n        foreach(array[i]){\n            array[i] == 1<<i;\n        }\n    }\n\nendclass:packet\n\n\nmodule test;\n    packet p;\n    initial begin\n        p = new();\n        repeat(10) begin\n            if(p.randomize()) begin\n                $display(\"%0d\", p.power_of_2val);\n                $display(\"----------\");\n                $display(\"%p\",p.array);\n            end\n        end\n    end\nendmodule"
  },
  {
    "id": "c_identify_power_of_2",
    "title": "Filter & Identify Powers of 2",
    "category": "Intel Interview Questions",
    "path": "constraints/intel_questions/identify_power_of_2.sv",
    "isFrequentlyAsked": true,
    "tags": [
      "Frequently Asked",
      "Intel",
      "Bitwise"
    ],
    "description": "Function and constraint implementation to identify and filter all powers of 2 from a randomized vector of integers.",
    "explanation": "Write a function to identify all powers of 2s in a vector of ints\nWrite a constraint to generate an array with power of 2s and regular numbers",
    "code": "/***************************\nWrite a function to identify all powers of 2s in a vector of ints\nWrite a constraint to generate an array with power of 2s and regular numbers\n***************************/\n\nclass packet;\n    rand int array[];\n    rand int rand_indexes[];\n\n    //Array size between 5 to 20\n    constraint c_array_size{\n        array.size() inside{[5:20]};\n    }\n\n    // Number of power of 2s in the array should be less than the size of the array\n    constraint c_rand_indexes{\n        rand_indexes.size() inside {[1:array.size()]};\n    }\n\n    // Array values are in the range of 1 to 1000\n    constraint c_range{\n        foreach(array[i]){\n            array[i] inside {[1:1000]};\n        }\n    }\n\n    // The indexes should be in range of the array size \n    constraint c_randomize_indexes{\n        foreach(rand_indexes[i]){\n            rand_indexes[i] inside {[0:array.size()-1]};\n        }\n    }\n\n    //Unique random indexes\n    constraint c_unique_random_indexes{\n        unique {rand_indexes};\n    }\n\n    //Generate random power of 2 values\n    constraint c_generate_power_of_2{\n        foreach(rand_indexes[i]){\n            array[rand_indexes[i]] inside {1,2,4,8,16,32,64,128,256,512};\n        }\n    }\n\n\nendclass: packet\n\nmodule test;\n    packet p;\n    int ans[];\n    initial begin\n        p = new();\n        repeat(5) begin\n            if(p.randomize()) begin\n                $display(\".............................\");\n                $display(\"%p\", p.array);\n                $display(\"%p\", p.rand_indexes);\n                $display(\".............................\");\n                \n\n                identify_power_of_2(p.array, ans);\n                $display(\"Powers of 2 are:\");\n                $display(\"%p\", ans);\n                $display(\".............................\");\n            end\n        end\n    end\n\n    function void identify_power_of_2(input int arr[], output int ans[]);\n        automatic int count = 0;\n        foreach(arr[i]) begin\n            if((arr[i] & (arr[i]-1)) == 0) begin\n                count++;\n            end\n        end\n\n        ans = new[count];\n\n        //Now used as an index\n        count = 0;\n        foreach(arr[i]) begin\n            if((arr[i] & (arr[i]-1)) == 0) begin\n                ans[count++] = arr[i];\n            end\n        end\n    endfunction: identify_power_of_2\nendmodule"
  },
  {
    "id": "c_no_consequtive_7s",
    "title": "No Consecutive 7s in Array",
    "category": "Intel Interview Questions",
    "path": "constraints/intel_questions/no_consequtive_7s.sv",
    "isFrequentlyAsked": true,
    "tags": [
      "Frequently Asked",
      "Intel"
    ],
    "description": "Generate an integer array where the digit/value 7 never appears in consecutive indices (`array[i] == 7 -> array[i+1] != 7`).",
    "explanation": "Write a SystemVerilog constraint to satisfy the following requirements:\nEach element of the queue should have a value between 0 and 9 (inclusive).\nNo two consecutive elements in the queue should have the value 7.",
    "code": "/******************************************\nWrite a SystemVerilog constraint to satisfy the following requirements:\nEach element of the queue should have a value between 0 and 9 (inclusive).\n\nNo two consecutive elements in the queue should have the value 7.\n******************************************/\n\nclass packet;\n    rand int q[50];\n\n    constraint c_range{\n        foreach(q[i]){\n            q[i] inside {[0:9]};\n        }\n    }\n\n    constraint c_no_consequtive_7{\n        foreach(q[i]){\n            ((i<49) && (q[i] == 7)) -> (q[i+1]!=7);\n        }\n    }\nendclass: packet\n\nmodule test;\n    packet p;\n    initial begin\n        p = new();\n        repeat(5) begin\n            if(p.randomize()) begin\n                $display(\"%p\", p.q);\n            end\n        end\n    end\nendmodule"
  },
  {
    "id": "c_queue_7s",
    "title": "Constrained Queue with Minimum 7s",
    "category": "Intel Interview Questions",
    "path": "constraints/intel_questions/queue_7s.sv",
    "isFrequentlyAsked": true,
    "tags": [
      "Frequently Asked",
      "Intel",
      "Queue"
    ],
    "description": "Constrain a queue of fixed size 15 such that the value 7 appears at least K times but never in adjacent positions.",
    "explanation": "Write constraint for the below requirements :\na. The queue size will be 15. Randomize a queue such that it exactly has four 7 in it.\nb. No 7's should be at the consecutive next to each other",
    "code": "/******************************\nWrite constraint for the below requirements :\na. The queue size will be 15. Randomize a queue such that it exactly has four 7 in it.\nb. No 7's should be at the consecutive next to each other\n******************************/\n\nclass packet;\n\n    rand int queue[$];\n\n    constraint c_size_of_queue{\n        queue.size() == 15;\n    }\n\n    constraint c_range_of_values{\n        foreach(queue[i]) {\n            queue[i] inside {[0:50]};\n        }\n    }\n\n    constraint c_num_of_sevens{\n        queue.sum() with (int'(item==7)) == 4;\n    }\n\n    constraint c_no_consecutive_sevens{\n        foreach(queue[i]){\n            if(i<14){\n                (queue[i] == 7) -> queue[i+1]!=7;\n            }\n        }\n    }\n\n    function void print();\n        foreach(queue[i]) begin\n            $write(\"%0d \",queue[i]);\n        end\n        $display(\"\");\n    endfunction:print\nendclass: packet\n\nmodule test;\n    packet p;\n\n    initial begin\n        repeat(5) begin\n            p = new();\n            if(p.randomize()) begin\n                p.print();\n            end\n        end\n    end\nendmodule"
  },
  {
    "id": "c_unique_and_increasing_array",
    "title": "Strictly Increasing Array without 'unique'",
    "category": "Intel Interview Questions",
    "path": "constraints/intel_questions/unique_and_increasing_array.sv",
    "isFrequentlyAsked": true,
    "tags": [
      "Frequently Asked",
      "Intel",
      "Array"
    ],
    "description": "Generate a strictly increasing unique array without using the `unique` keyword (`foreach(a[i]) if (i > 0) a[i] > a[i-1]`).",
    "explanation": "Generate a unique array without using any unique keyword with values in ascending order",
    "code": "/****************************\nGenerate a unique array without using any unique keyword with values in ascending order\n****************************/\n\nclass packet;\n    rand bit[7:0] array[];\n\n    constraint c_array_size{\n        array.size() inside {[5:15]};\n    }\n\n    constraint c_unique_and_ascending{\n        foreach(array[i]) {\n            if(i < (array.size() - 1)) {\n                array[i] < array[i+1];\n            }\n        }\n    }\nendclass: packet\n\nmodule test;\n    packet p;\n    initial begin\n        p = new();\n        repeat(5) begin\n            if(p.randomize()) begin\n                $display(\"%p\",p.array);\n                $display(\":::::::::::::::::::\");\n            end\n        end\n    end\nendmodule"
  },
  {
    "id": "c_langford_pairing",
    "title": "Langford Pairing",
    "category": "Logic Puzzles & Brainteasers",
    "path": "constraints/langford_pairing.sv",
    "isFrequentlyAsked": false,
    "tags": [
      "Puzzle"
    ],
    "description": "This one is a pretty good question I found on the verification academy forum. ------------------------------------------------------------------------------- https://verificationacademy.com/forums/t/system-verilog-interview-question/39735 Given an integer n, create an array such that each value is repeated twice. For example; n=3->[1,1,2,2,3,3] n=4->[1,1,2,2,3,3,4,4] After creating it, find a permutation such that each number is spaced in such a way that they are at a “their value” distance from the second occurrence of the same number. For example: n=3 → This is the array - [1,1,2,2,3,3] Your output should be [3,1,2,1,3,2] The second 3 is 3 digits away from the first 3. The second 2 is 2 digits away from the first 2. The second 1 is 1 digit away from the first 1. Return any 1 permutation if it exists. Empty array if no permutation exists. ------------------------------------------------------------------------------- - This is called the Langford Pairing Problem. - For each number k, we need to place exactly two copies of k in the array. - These two copies need to be placed in such a way that only \"k\" elements are present in between them. For n = 3 -> [3,1,2,1,3,2] The difference in index for \"k\" is k+1 - k==1 is at two locations: i = 1 and i = 3. - Index Difference = 2(3-1) (k+1 == 1+1 == 2) - For a given value of n, langford pairing is only possible if it satisfies the following condition: n%4 == 0 or n%4 == 3",
    "explanation": "This one is a pretty good question I found on the verification academy forum.\n-------------------------------------------------------------------------------\nhttps://verificationacademy.com/forums/t/system-verilog-interview-question/39735\nGiven an integer n, create an array such that each value is repeated twice.\nFor example;\nn=3->[1,1,2,2,3,3]\nn=4->[1,1,2,2,3,3,4,4]\nAfter creating it, find a permutation such that each number is spaced in such a way that they are at a “their value” distance from the second occurrence of the same number.\nFor example: n=3 → This is the array - [1,1,2,2,3,3]\nYour output should be [3,1,2,1,3,2]\nThe second 3 is 3 digits away from the first 3.\nThe second 2 is 2 digits away from the first 2.\nThe second 1 is 1 digit away from the first 1.\nReturn any 1 permutation if it exists.\nEmpty array if no permutation exists.\n-------------------------------------------------------------------------------\n- This is called the Langford Pairing Problem.\n- For each number k, we need to place exactly two copies of k in the array.\n- These two copies need to be placed in such a way that only \"k\" elements are present in between them.\nFor n = 3 -> [3,1,2,1,3,2]\nThe difference in index for \"k\" is k+1\n- k==1 is at two locations: i = 1 and i = 3.\n- Index Difference = 2(3-1) (k+1 == 1+1 == 2)\n- For a given value of n, langford pairing is only possible if it satisfies the following condition:\nn%4 == 0 or n%4 == 3",
    "code": "/*******\nThis one is a pretty good question I found on the verification academy forum. \n-------------------------------------------------------------------------------\nhttps://verificationacademy.com/forums/t/system-verilog-interview-question/39735\n\nGiven an integer n, create an array such that each value is repeated twice.\nFor example;\nn=3->[1,1,2,2,3,3]\nn=4->[1,1,2,2,3,3,4,4]\n\nAfter creating it, find a permutation such that each number is spaced in such a way that they are at a “their value” distance from the second occurrence of the same number.\n\nFor example: n=3 → This is the array - [1,1,2,2,3,3]\n\nYour output should be [3,1,2,1,3,2]\n\nThe second 3 is 3 digits away from the first 3.\nThe second 2 is 2 digits away from the first 2.\nThe second 1 is 1 digit away from the first 1.\n\nReturn any 1 permutation if it exists.\nEmpty array if no permutation exists.\n-------------------------------------------------------------------------------\n- This is called the Langford Pairing Problem. \n- For each number k, we need to place exactly two copies of k in the array. \n- These two copies need to be placed in such a way that only \"k\" elements are present in between them. \n\nFor n = 3 -> [3,1,2,1,3,2]\nThe difference in index for \"k\" is k+1\n- k==1 is at two locations: i = 1 and i = 3. \n- Index Difference = 2(3-1) (k+1 == 1+1 == 2)\n\n- For a given value of n, langford pairing is only possible if it satisfies the following condition:\nn%4 == 0 or n%4 == 3\n********/\n\n/*******\nTo constrain an array for this problem, we will fix the first position of the occurances for a given number k.\nFor find the index of the second occurance => second_index = first_index + k + 1\n\nIf k=3 is in it's first position at index 0, then the second occurance should be at index 4\nBecause index 0 and 4 have 3 elements between them 3 _ _ _ 3\n*******/\n\nclass langford_pairing#(parameter int N = 3);\n\n    rand int array[]; // Final generated dynamic array\n\n    localparam bit POSSIBLE = (N%4 == 0) || (N%4==3);\n    // If POSSIBLE == 0: Langford pairing is not possible a given N value\n\n    rand int first_position [1:N];  // Array with indexing 1 to N\n    rand int second_position [1:N];\n\n    // Unique first and second positons\n    constraint c_unique_first_second_positions{\n        if(POSSIBLE) {\n            unique { first_position };\n            unique {second_position };\n        }\n    }\n\n    // Positions must be different\n    constraint c_different_positions{\n        if(POSSIBLE){\n            foreach(first_position[i]){\n                foreach(second_position[j]){\n                    first_position[i] != second_position[j];\n                }\n            }\n        }\n    }\n\n    constraint c_pair_spacing {\n        if (POSSIBLE) {\n            foreach (first_position[k]) { \n                second_position[k] == first_position[k] + k + 1; // Second position index(j) for a given first position(i): j = i + k + 1\n                // Both positions must fit inside an array of size 2*N.\n                first_position[k] inside {[0 : 2*N-k-2]}; // This is the acceptable range for the first position\n            }\n        }\n    }\n\n    constraint c_array{\n        if(!POSSIBLE){\n            array.size() == 0;\n        }\n        else {\n            array.size() == 2*N;\n        }\n    }\n\n    function void post_randomize();\n        if(POSSIBLE) begin\n            foreach(first_position[i]) begin\n                array[second_position[i]] = i;\n                array[first_position[i]] = i;\n            end\n        end\n    endfunction\n\n    function void display();\n        $display(\"Array for N = %0d | %p\",N,array);\n    endfunction\nendclass:langford_pairing\n\nmodule test;\n    langford_pairing#(7) packet_7;\n    langford_pairing packet_3;\n    langford_pairing#(4) packet_4;\n    langford_pairing#(5) packet_5;\n\n\n    initial begin\n        packet_7 = new();\n        if(packet_7.randomize()) begin\n            packet_7.display();\n        end\n        else begin\n            $display(\"Randomization failed for N = 7\");\n        end\n        // -------------------------------------------------------\n        packet_3 = new();\n        if(packet_3.randomize()) begin\n            packet_3.display();\n        end\n        else begin\n            $display(\"Randomization failed for N = 3\");\n        end\n        // -------------------------------------------------------\n        packet_4 = new();\n        if(packet_4.randomize()) begin\n            packet_4.display();\n        end\n        else begin\n            $display(\"Randomization failed for N = 4\");\n        end\n        // -------------------------------------------------------\n        packet_5 = new();\n        if(packet_5.randomize()) begin\n            packet_5.display();\n        end\n        else begin\n            $display(\"Randomization failed for N = 5\");\n        end\n    end\nendmodule"
  },
  {
    "id": "c_magic_square",
    "title": "N×N Magic Square Generator",
    "category": "Logic Puzzles & Brainteasers",
    "path": "constraints/magic_square.sv",
    "isFrequentlyAsked": true,
    "tags": [
      "Frequently Asked",
      "Matrix"
    ],
    "description": "Generate a parameterized array whose values are equal to a Magic square using constraints A magic square is an N×N grid of distinct integers where the sum of every row, every column, and both main diagonals are all equal to the same number Rules: Unique matrix Row sum == Column Sum == Diagonal Sum",
    "explanation": "Generate a parameterized array whose values are equal to a Magic square using constraints\nA magic square is an N×N grid of distinct integers where the sum of every row, every column, and\nboth main diagonals are all equal to the same number\nRules:\nUnique matrix\nRow sum == Column Sum == Diagonal Sum",
    "code": "/***************\nGenerate a parameterized array whose values are equal to a Magic square using constraints\n\nA magic square is an N×N grid of distinct integers where the sum of every row, every column, and \nboth main diagonals are all equal to the same number\n\nRules:\nUnique matrix\nRow sum == Column Sum == Diagonal Sum\n***************/\n\nclass magic_square #(int N = 3);\n    rand int arr[N][N];\n\n    constraint c_arr_range{\n        foreach(arr[i,j]) {\n            arr[i][j] inside {[0:20]};\n        }\n    }\n    \n    constraint c_unique_array{\n        foreach(arr[i,j]){\n            foreach(arr[x,y]){\n                if(!(i==x && j==y)){\n                    arr[i][j] != arr[x][y];\n                }\n            }\n        }\n    }\n\n    constraint c_row_sum{\n        foreach(arr[i]){\n            foreach(arr[j]){\n                if(i!=j) arr[i].sum() == arr[j].sum();\n            }\n        }\n    }\n\n    constraint c_column_sum{\n        //Iterate over the column arrays\n        foreach(arr[,j]){\n            arr.sum() with (item[j])==arr[0].sum();\n        }\n    }\n\n    constraint c_diagonal_sum{\n        //Iterate over the main diagonal\n        arr.sum() with (item[item.index]) == arr[0].sum();\n        //Iterate over the anti diagonal\n        arr.sum() with (item[N-1-item.index]) == arr[0].sum();\n    }\n\n    \n\n\nendclass: magic_square\n\nmodule test;\n    magic_square #(3) ms3;\n    magic_square #(4) ms4;\n    initial begin\n        ms3 = new();\n        ms4 = new();\n\n        if(ms3.randomize()) begin\n            $display(\"------------\");\n            foreach(ms3.arr[i]) begin\n                foreach(ms3.arr[i][j]) begin\n                    $write(\"%0d \",ms3.arr[i][j]);\n                end\n                $display(\"\");\n            end\n        end\n        $display(\"------------\");\n        if(ms4.randomize()) begin\n            foreach(ms4.arr[i]) begin\n                foreach(ms4.arr[i][j]) begin\n                    $write(\"%0d \",ms4.arr[i][j]);\n                end\n                $display(\"\");\n            end\n            $display(\"------------\");\n        end\n    end\nendmodule"
  },
  {
    "id": "c_magic_square_1",
    "title": "Magic Square Alternative Formulation",
    "category": "Logic Puzzles & Brainteasers",
    "path": "constraints/magic_square_1.sv",
    "isFrequentlyAsked": false,
    "tags": [
      "Matrix"
    ],
    "description": "Write a SystemVerilog class with a rand int mat[4][4] such that: 1) Every element is in the range [1:16] 2) All 16 elements are unique (it's basically a shuffled 4x4 grid of 1 to 16) 3) The sum of each row equals the sum of its diagonal-opposite column (row i's sum must equal column i's sum, for all i) 4) The two main diagonals (top-left to bottom-right, and top-right to bottom-left) must have different sums from each other",
    "explanation": "Write a SystemVerilog class with a rand int mat[4][4] such that:\n1) Every element is in the range [1:16]\n2) All 16 elements are unique (it's basically a shuffled 4x4 grid of 1 to 16)\n3) The sum of each row equals the sum of its diagonal-opposite column (row i's sum must equal column i's sum, for all i)\n4) The two main diagonals (top-left to bottom-right, and top-right to bottom-left) must have different sums from each other",
    "code": "/********************************************\n\nWrite a SystemVerilog class with a rand int mat[4][4] such that:\n\n1) Every element is in the range [1:16]\n2) All 16 elements are unique (it's basically a shuffled 4x4 grid of 1 to 16)\n3) The sum of each row equals the sum of its diagonal-opposite column (row i's sum must equal column i's sum, for all i)\n4) The two main diagonals (top-left to bottom-right, and top-right to bottom-left) must have different sums from each other\n\n*******************************************/\n\nclass packet;\n    rand int mat[4][4];\n\n    constraint c_range_of_values{\n        foreach(mat[i,j]){\n            mat[i][j] inside {[1:16]};\n        }\n    }\n\n    constraint c_unique_matrix{\n        foreach(mat[i,j]){\n            foreach(mat[x,y]){\n                if (!(x==i && y==j)){\n                    mat[i][j] != mat[x][y];\n                }\n            }\n        }\n    }\n\n    // Okay, I know this is not easy to understand but it's pretty hand. \n    // item here is the row we are are iterating over in the matrix for this reduction operation. \n    // Let's see an example p.mat.sum() with (item[0]) means -> Iterate over the matrix row by row and sum the first index element of all the rows. \n    // So it reduces to row0_first_index + row1_first_index + row2_first_index + row3_first_index.\n    // To Sum the diagonal elements, instead of we use the loop variable index to sum row[index]. Where index is the row number. \n    // item[item.index] reduces to row0_0th_element + row1_1st_element + row2_2nd_element + row3_3rd_element\n    constraint c_diagonal_sum_not_equal{\n        mat.sum() with (item[item.index]) != mat.sum() with (item[3-item.index]);\n    }\n\n    constraint c_row_sum_equals_column_sum{\n        foreach(mat[i]) {\n            mat[i].sum() == mat.sum() with (item[i]); \n            //mat[i].sum = row sum\n            //mat.sum() with (item[i]) = column sum. \n        }\n    }\n\n\n\nendclass\n\nmodule test;\n    packet p;\n    initial begin\n        p = new();\n        if(p.randomize()) begin\n\n            foreach(p.mat[i]) begin\n                foreach(p.mat[i][j]) begin\n                    $write(\"%0d \",p.mat[i][j]);\n                end\n                $display(\"\");\n            end\n        end\n    end\nendmodule"
  },
  {
    "id": "c_matrix_multiplication_shape",
    "title": "Matrix Multiplication Shape",
    "category": "Arrays, Queues & Matrices",
    "path": "constraints/matrix_multiplication_shape.sv",
    "isFrequentlyAsked": false,
    "tags": [
      "Matrix"
    ],
    "description": "Jointly randomize matrix dimensions (M \\times K) and (K \\times N) ensuring inner dimension matching for matrix multiplication.",
    "explanation": "Create a matrix multiplication compliant 2D arrays",
    "code": "/**********\nCreate a matrix multiplication compliant 2D arrays\n**********/\n\nclass Matrix_Multiplication;\n    rand bit[7:0] matA[][];\n    rand bit[7:0] matB[][];\n    rand int  rows_a;\n    rand int rows_b;\n    rand int col_a;\n    rand int col_b;\n\n    constraint c_matrix_size{\n        rows_a inside {[2:5]};\n        rows_b inside {[2:5]};\n        col_a inside {[2:5]};\n        col_b inside {[2:5]};\n    }\n\n    constraint c_mul_compatible{\n        col_a == rows_b;\n    }\n\n    constraint c_solve_before{\n        solve rows_a, rows_b, col_a, col_b before matA, matB;\n    }\n\n    constraint c_mat_size{\n        matA.size() == rows_a;\n        matB.size() == rows_b;\n\n        foreach(matA[i]){\n            matA[i].size() == col_a;\n        }\n        foreach(matB[i]){\n            matB[i].size() == col_b;\n        }\n    }\n\n    constraint c_mat_range{\n        foreach(matA[i,j]){\n            matA[i][j] < 50;\n        }\n\n        foreach(matB[i,j]){\n            matB[i][j] < 50;\n        }\n    }\n\nendclass: Matrix_Multiplication\n\n\nmodule test;\n    Matrix_Multiplication m;\n\n    initial begin\n        repeat(5) begin\n            m = new();\n            if(m.randomize()) begin\n                $display(\"------------\");\n                foreach(m.matA[i]) begin\n                    foreach(m.matA[i][j]) begin\n                        $write(\"%0d \",m.matA[i][j]);\n                    end\n                    $display(\"\");\n                end\n                $display(\"-------------\");\n                foreach(m.matB[i]) begin\n                    foreach(m.matB[i][j]) begin\n                        $write(\"%0d \",m.matB[i][j]);\n                    end\n                    $display(\"\");\n                end\n            end\n        end\n    end\n\nendmodule"
  },
  {
    "id": "c_matrix_sum_less_than_max",
    "title": "Matrix Sum Less Than Max",
    "category": "Arrays, Queues & Matrices",
    "path": "constraints/matrix_sum_less_than_max.sv",
    "isFrequentlyAsked": false,
    "tags": [
      "Matrix"
    ],
    "description": "Generate an M \\times N binary matrix with total sum bounded below a threshold.",
    "explanation": "Write constraints to generate MxN matrix with each element with 0,1 and sum of all elements less the MAX_SUM",
    "code": "/***************************\nWrite constraints to generate MxN matrix with each element with 0,1 and sum of all elements less the MAX_SUM\n***************************/\n\nclass packet;\n    rand bit arr[][];\n    rand int max_sum;\n\n    constraint c_arr_dimensions{\n        arr.size() inside {[2:6]};\n\n        arr[0].size() inside {[2:6]};\n        foreach(arr[i]){\n            arr[i].size() == arr[0].size();\n        }\n    }\n\n    constraint c_arr_max_sum{\n        max_sum inside {[0:arr.size()+arr[0].size()]};\n    }\n\n    constraint c_sum{\n        arr.sum(row) with (\n            row.sum(col) with (int'(col))\n        ) <= max_sum;\n    }\n\nendclass: packet\n\nmodule test;\n    packet p;\n\n    initial begin\n        p = new();\n        if(p.randomize()) begin\n            $display(\"Max Sum = %0d, Generated Array: \",p.max_sum);\n            foreach(p.arr[i]) begin\n                foreach(p.arr[i][j]) begin\n                    $write(\"%0b \",p.arr[i][j]);\n                end\n                $display(\"\");\n            end\n        end\n    end\nendmodule"
  },
  {
    "id": "c_memory_class_constraint",
    "title": "Word-Aligned Memory Transaction Burst Bounds",
    "category": "Real-World SoC Verification Scenarios",
    "path": "constraints/memory_class_constraint.sv",
    "isFrequentlyAsked": true,
    "tags": [
      "Frequently Asked",
      "Architecture / SoC"
    ],
    "description": "Memory transaction class with 32-bit address and 64-bit data, enforcing word-aligned addresses and non-overlapping burst bounds.",
    "explanation": "Suppose you have a memory transaction class with:\naddress: 32 bits\ndata: 64 bits\nread/write bit\nHow would you write constraints to generate:\n70% reads and 30% writes\nAddresses only within the range 0x1000 to 0x1FFF\nData should be aligned to 8 bytes\n8-byte aligned means the address should be a multiple of 8, not that the data is 64 bits.\nFor example:\nValid:\n0x1000\n0x1008\n0x1010\nInvalid:\n0x1001\n0x1002\n0x1007",
    "code": "/**********************\nSuppose you have a memory transaction class with:\naddress: 32 bits\ndata: 64 bits\nread/write bit\n\nHow would you write constraints to generate:\n\n70% reads and 30% writes\nAddresses only within the range 0x1000 to 0x1FFF\nData should be aligned to 8 bytes\n8-byte aligned means the address should be a multiple of 8, not that the data is 64 bits.\nFor example:\nValid:\n0x1000\n0x1008\n0x1010\n\nInvalid:\n0x1001\n0x1002\n0x1007\n*************************/\n\nclass mem_transaction;\n    rand bit [31:0] addr;\n    rand bit [63:0] data;\n    rand bit        write;          //Write - 1, Read - 0\n\n    constraint c_read_write_distribution{\n        write dist {\n            1:= 30,\n            0:= 70\n        };\n    }\n\n    constraint c_address_range{\n        addr inside {[32'h1000:32'h1fff]};\n    }\n\n    constraint c_data_alignment{\n        addr[2:0] == 3'b000; \n    }\nendclass: mem_transaction\n\nmodule test;\n    mem_transaction packet;\n\n    initial begin\n        packet = new();\n        repeat(5) begin\n            if(packet.randomize()) begin\n                $display(\"Address: %04h, Data: %08h, Write/Read: %0b\",packet.addr, packet.data, packet.write);\n            end\n        end\n    end\nendmodule"
  },
  {
    "id": "c_latin_square",
    "title": "N×N Latin Square Generator",
    "category": "Logic Puzzles & Brainteasers",
    "path": "constraints/new_questions/latin_square.sv",
    "isFrequentlyAsked": false,
    "tags": [
      "Matrix"
    ],
    "description": "Randomize an N \\times N Latin Square where every row and column contains numbers 1 \\dots N exactly once.",
    "explanation": "Randomize an N×N Latin square: every row and every column contains each value 1..N exactly once\n2x2 Latin Square\n1 2\n2 1\n3x3 Latin Square\n[1, 2, 3]\n[3, 1, 2]\n[2, 3, 1]",
    "code": "/********************\nRandomize an N×N Latin square: every row and every column contains each value 1..N exactly once\n\n2x2 Latin Square\n1 2\n2 1\n\n3x3 Latin Square\n[1, 2, 3]\n[3, 1, 2]\n[2, 3, 1]\n********************/\n\nclass packet;\n    rand int arr[][];\n\n    //Constraint for NxN matrix\n    constraint c_size{\n        arr.size() inside {[1:6]};\n    }\n    constraint c_row_size{\n        arr[0].size() == arr.size();\n        foreach(arr[i]){\n            arr[i].size() == arr[0].size();\n        }\n    }\n    constraint c_range_of_values{\n        foreach(arr[i,j]){\n            arr[i][j] inside {[1:arr.size()]};\n        }\n    }\n\n    //Constraints for Latin Square\n    constraint c_column_unique{\n        foreach(arr[i,j]){\n            foreach(arr[x,j]){\n                if(i!=x) arr[i][j]!=arr[x][j];\n            }\n        }\n    }\n    constraint c_row_unique{\n        foreach(arr[i,x]){\n            foreach(arr[i,y]){\n                if(x!=y) arr[i][x] != arr[i][y];\n            }\n        }\n    }\nendclass: packet\n\n\nmodule test;\n    packet p;\n    initial begin\n        // Print 5 Latin Squares\n        repeat(5) begin\n            p = new();\n            if(p.randomize()) begin\n                foreach(p.arr[i]) begin\n                    foreach(p.arr[i][j]) begin\n                        $write(\"%0d \", p.arr[i][j]);\n                    end\n                    $display(\"\");\n                end\n                $display(\"::::::::::::::::::::::::::::::\");\n            end\n        end\n    end\nendmodule"
  },
  {
    "id": "c_odd_parity",
    "title": "Odd Parity",
    "category": "Arithmetic & Bit-Level Constraints",
    "path": "constraints/new_questions/odd_parity.sv",
    "isFrequentlyAsked": false,
    "tags": [],
    "description": "Function and constraint generating 8-bit values with odd parity without repeats.",
    "explanation": "Write a function that generates a random 8-bit value with odd parity,\nwhere the value must not repeat within the last 4 generations.",
    "code": "/**********************\nWrite a function that generates a random 8-bit value with odd parity, \nwhere the value must not repeat within the last 4 generations.\n***********************/\n\nclass packet_odd_parity;   \n    rand bit[7:0] data;\n    bit[7:0] queue[$];w\n\n    constraint c_odd_parity{\n        ^data == 1'b1;\n    }\n    constraint c_not_in_last_4{\n        !(data inside {queue});\n    }\n\n    function void post_randomize();\n        queue.push_back(data);\n        if(queue.size()>4) begin\n            queue.pop_front();\n        end\n    endfunction: post_randomize\nendclass: packt_odd_parity\n\nmodule test;\n    packet_odd_parity p;\n\n    initial begin\n        repeat(5) begin\n            p = new();\n            if(p.randomize()) begin\n                $display(\"%08b\", p.data);\n            end\n        end\n    end\nendmodule"
  },
  {
    "id": "c_xor_parity",
    "title": "Xor Parity",
    "category": "Arithmetic & Bit-Level Constraints",
    "path": "constraints/new_questions/xor_parity.sv",
    "isFrequentlyAsked": false,
    "tags": [],
    "description": "Compute and constrain XOR parity across variable bit slices.",
    "explanation": "Given an 8-bit data field and a separate 1-bit parity field, randomize both such that parity equals the XOR-reduction of data\nAsked to solve using a function",
    "code": "/************************************************************************************************************\nGiven an 8-bit data field and a separate 1-bit parity field, randomize both such that parity equals the XOR-reduction of data\n\nAsked to solve using a function\n************************************************************************************************************/\nclass packet;\n    rand logic[7:0] data;\n    rand logic parity;\n\n    //Since this question needs to be solved using function, there are some things to consider when using functions with constraints\n    // 1) Function should be automatic\n    // 2) It should only have an input argument and return a value\n    // 3) No output or inout arguments. \n    function automatic logic calculate_xor(input logic [7:0] data);\n        return ^data;\n    endfunction: calculate_xor\n\n    constraint c_parity{\n        parity == calculate_xor(data);\n    }\nendclass\n\nmodule test;\n    packet p;\n    initial begin\n        p = new();\n        repeat(5) begin\n            if(p.randomize()) begin\n                $display(\"Data: %0b\", p.data);\n                $display(\"Parity: %0b\", p.parity);\n            end\n        end\n    end\nendmodule"
  },
  {
    "id": "c_no_consecutive_zeroes",
    "title": "No Consecutive Zeroes",
    "category": "Arithmetic & Bit-Level Constraints",
    "path": "constraints/no_consecutive_zeroes.sv",
    "isFrequentlyAsked": false,
    "tags": [
      "Bitwise"
    ],
    "description": "Array constraint preventing consecutive zeroes (`!(a[i] == 0 && a[i+1] == 0)`).",
    "explanation": "Generate dynamic array of 300 elements with values from {0,1,2,3,4,5}.\nUVM SV Constraints: (1) Each value appears at least 40 times, (2) No two consecutive 0s (adjacent 0s forbidden). Value 0 must be interspersed with other values.",
    "code": "/***************************\nGenerate dynamic array of 300 elements with values from {0,1,2,3,4,5}. \nUVM SV Constraints: (1) Each value appears at least 40 times, (2) No two consecutive 0s (adjacent 0s forbidden). Value 0 must be interspersed with other values.\n***************************/\n\ntypedef int count_t[6];\nclass packet;\n\n    rand int arr[];\n\n    constraint c_size{\n        arr.size()==300;\n    }\n\n    constraint c_bounds{\n        foreach(arr[i]) arr[i] inside {[0:5]};\n    }\n\n    constraint c_freq{\n        arr.sum() with (int'(item==0)) >= 40;\n        arr.sum() with (int'(item==1)) >= 40;\n        arr.sum() with (int'(item==2)) >= 40;\n        arr.sum() with (int'(item==3)) >= 40;\n        arr.sum() with (int'(item==4)) >= 40;\n        arr.sum() with (int'(item==5)) >= 40;\n    }\n\n    constraint c_no_repeat{\n        foreach(arr[i]) {\n            if((i>0) && (arr[i]==0)){\n                arr[i] != arr[i-1];\n            }\n        }\n    }\n    \n    function automatic count_t count(int array[]);\n        int count_array[6] = {0,0,0,0,0,0};\n        for(int i = 0;i<300;i++) begin\n            count_array[array[i]]++;\n        end\n        return count_array;\n    endfunction: count\n\nendclass: packet\n\nmodule test;\n\n    packet p = new();\n    count_t count_array;\n\n    initial begin\n        repeat(5) begin\n            if(p.randomize()) begin\n                count_array = p.count(p.arr);\n                $display(\"%p\",p.arr);\n                $display(\"Randomization is successful, Count of 0 = %0d, Count of 1 = %0d, Count of 2 = %0d, Count of 3 = %0d, Count of 4 = %0d, Count of 5 = %0d\", count_array[0], count_array[1], count_array[2], count_array[3], count_array[4], count_array[5]);\n            end\n            else begin\n                $display(\"Randomization has failed\");\n            end\n        end\n    end\n\nendmodule"
  },
  {
    "id": "c_pattern_1",
    "title": "Pattern 1",
    "category": "Sequences & Pattern Generation",
    "path": "constraints/patterns/pattern_1.sv",
    "isFrequentlyAsked": false,
    "tags": [
      "Distribution / Pattern"
    ],
    "description": "Generate periodic sequence pattern `1, 2, 2, 1, 2, 2, 1, 2, 2...`",
    "explanation": "122122122122.....",
    "code": "/******\n122122122122.....\n******/\n\n\nclass packet;\n    rand int arr [0:31];\n    constraint c_122 {\n        foreach(arr[i]) {\n            if(i%3==0) {\n                arr[i] == 1;\n            }\n            else arr[i] == 2;\n        }\n    }\nendclass\n\nmodule pattern_1;\n    packet p = new();\n\n    initial begin\n        repeat(5) begin\n            if (p.randomize()) begin\n                $display(\"Randomization is successful: %p\", p.arr);\n            end\n            else $display(\"Randomization has failed\");\n        end\n    end\nendmodule"
  },
  {
    "id": "c_pattern_2",
    "title": "Pattern 2",
    "category": "Sequences & Pattern Generation",
    "path": "constraints/patterns/pattern_2.sv",
    "isFrequentlyAsked": false,
    "tags": [
      "Distribution / Pattern"
    ],
    "description": "Generate repeating ascending cycles `1, 2, 3, 4, 5, 1, 2, 3, 4, 5...`",
    "explanation": "123451234512345.....",
    "code": "/******\n123451234512345.....\n******/\n\n\nclass packet;\n    rand int arr [0:31];\n    constraint c_12345 {\n        foreach(arr[i]) {\n            arr[i] == (i % 5) + 1;\n        }\n    }\nendclass\n\nmodule pattern_1;\n    packet p = new();\n\n    initial begin\n        repeat(1) begin\n            if (p.randomize()) begin\n                $display(\"Randomization is successful: %p\", p.arr);\n            end\n            else $display(\"Randomization has failed\");\n        end\n    end\nendmodule"
  },
  {
    "id": "c_pattern_3",
    "title": "Pattern 3",
    "category": "Sequences & Pattern Generation",
    "path": "constraints/patterns/pattern_3.sv",
    "isFrequentlyAsked": false,
    "tags": [
      "Distribution / Pattern"
    ],
    "description": "Generate escalating zero-padded sequence: `0, 1, 0, 0, 2, 0, 0, 0, 3, 0, 0, 0, 0, 4, ...`",
    "explanation": "Constraint for generating the sequence 01002000300004000005.\n0 1 00 2 000 3 0000 4 00000 5\n0 1 00 2 000 3 0000 4 00000 5 000000 6",
    "code": "/*********\nConstraint for generating the sequence 01002000300004000005.\n\n0 1 00 2 000 3 0000 4 00000 5\n0 1 00 2 000 3 0000 4 00000 5 000000 6\n*********/\n\nclass packet;\n    rand int num;\n    int queue[$];\n\n    constraint c_num{\n        num  inside {[1: 10]};\n    }\n\n    function void post_randomize();\n        queue.delete(); //To clear out the queue after every randomization. Since queue is class property, it persists with every randomize() call\n        for(int i = 1;i<=num;i++) begin\n            repeat(i) begin\n                queue.push_back(0);\n            end\n            queue.push_back(i);\n        end\n    endfunction: post_randomize\n\nendclass\n\nmodule test;\n    packet p = new();\n\n    initial begin\n        repeat(4) begin\n            if(p.randomize()) begin\n                $display(\"Pattern = %p\",p.queue);\n            end\n        end\n    end\nendmodule"
  },
  {
    "id": "c_pattern_4",
    "title": "Pattern 4",
    "category": "Sequences & Pattern Generation",
    "path": "constraints/patterns/pattern_4.sv",
    "isFrequentlyAsked": false,
    "tags": [
      "Distribution / Pattern"
    ],
    "description": "1. Write a constraint to generate the following pattern in an array N=3: 1 11 111 N=4: 1 11 111 1111 2. Write a constraint to generate the following pattern in a 2D array N=4: [1] [1, 1] [1, 1, 1] [1, 1, 1, 1]",
    "explanation": "1. Write a constraint to generate the following pattern in an array\nN=3: 1 11 111\nN=4: 1 11 111 1111\n2. Write a constraint to generate the following pattern in a 2D array\nN=4:\n[1]\n[1, 1]\n[1, 1, 1]\n[1, 1, 1, 1]",
    "code": "/****\n1. Write a constraint to generate the following pattern in an array\nN=3: 1 11 111\nN=4: 1 11 111 1111\n\n2. Write a constraint to generate the following pattern in a 2D array\nN=4:\n[1]\n[1, 1]\n[1, 1, 1]\n[1, 1, 1, 1]\n****/\n\n// Pattern Constraint 1\nclass packet_1#(parameter int N = 3);\n    rand int unsigned array[];\n\n    constraint c_array_size{\n        array.size() == N;\n    }\n\n    constraint c_fill_array{\n\n        foreach(array[i]){\n            if(i==0){\n                array[0] == 1;\n            }\n            else {\n                array[i] == array[i-1]*10 + 1;\n            }\n        }\n    }\nendclass:packet_1\n\n// Pattern Constraint 2\nclass packet_2#(parameter int N = 3);\n    rand int unsigned array[][];\n\n    constraint c_array_size{\n        array.size() == N;\n    }\n\n    constraint c_fill_array{\n        foreach(array[i]){\n            array[i].size() == i+1;\n\n            foreach(array[i][j]){\n                array[i][j] == 1;\n            }\n        }\n    }\n\nendclass:packet_2\n\nmodule test;\n    packet_1#(3) p1_3;\n    packet_1#(4) p1_4;\n    packet_1#(5) p1_5;\n\n    packet_2#(2) p2_2;\n    packet_2#(3) p2_4;\n    packet_2#(6) p2_5;\n\n    initial begin\n        p1_3 = new();\n        p1_4 = new();\n        p1_5 = new();\n\n        p2_2 = new();\n        p2_4 = new();\n        p2_5 = new();\n\n        if(p1_3.randomize()) begin\n            $display(\"%p\", p1_3.array);\n        end\n        else $display(\"Randomization has failed\");\n\n        if(p1_4.randomize()) begin\n            $display(\"%p\", p1_4.array);\n        end\n        else $display(\"Randomization has failed\");\n\n        if(p1_5.randomize()) begin\n            $display(\"%p\", p1_5.array);\n        end\n        else $display(\"Randomization has failed\");\n        //::::::::::::::::::::::::::::::::::::::::::::::::::\n        if(p2_2.randomize()) begin\n            foreach(p2_2.array[i]) begin\n                $display(\"%p\", p2_2.array[i]);\n            end\n        end\n        else $display(\"Randomization has failed\");\n\n        if(p2_4.randomize()) begin\n            foreach(p2_4.array[i]) begin\n                $display(\"%p\", p2_4.array[i]);\n            end\n        end\n        else $display(\"Randomization has failed\");\n\n        if(p2_5.randomize()) begin\n            foreach(p2_5.array[i]) begin\n                $display(\"%p\", p2_5.array[i]);\n            end\n        end\n        else $display(\"Randomization has failed\");\n    end\nendmodule\n\n/*** OUTPUT PRINT STATEMENTS ****/\n/*\n# '{1, 11, 111}\n# '{1, 11, 111, 1111}\n# '{1, 11, 111, 1111, 11111}\n# '{1}\n# '{1, 1}\n# '{1}\n# '{1, 1}\n# '{1, 1, 1}\n# '{1}\n# '{1, 1}\n# '{1, 1, 1}\n# '{1, 1, 1, 1}\n# '{1, 1, 1, 1, 1}\n# '{1, 1, 1, 1, 1, 1}\n*/"
  },
  {
    "id": "c_payload_seq_plus2",
    "title": "Payload Seq Plus2",
    "category": "Sequences & Pattern Generation",
    "path": "constraints/payload_seq_plus2.sv",
    "isFrequentlyAsked": false,
    "tags": [
      "Distribution / Pattern"
    ],
    "description": "Array of size 11–22 where each successive element is strictly `previous + 2`.",
    "explanation": "Write a constraint for payload generation, where the size is between 11 and 22, and each value is 2 greater than the previous.",
    "code": "/**************************\nWrite a constraint for payload generation, where the size is between 11 and 22, and each value is 2 greater than the previous.\n**************************/\n\nclass packet;\n\n    rand int arr[];\n\n    constraint c_size_range{\n        arr.size() inside {\n            [11:22]\n        };\n    }\n\n    constraint c_range{\n        foreach(arr[i]){\n            arr[i] dist {\n                [1:100]:=75,\n                [100:200]:=25\n            };\n        }\n    }\n\n    constraint plus_2{\n        foreach(arr[i]) {\n            if(i>0){\n                arr[i] == arr[i-1]+2;\n            }\n        }\n    }\n\nendclass: packet\n\nmodule payload_seq_plus2;\n    packet p = new();\n\n    initial begin\n        repeat(5) begin\n            if(p.randomize()) begin\n                $display(\"Randomization is successful: Generated Array: %p\", p.arr);\n            end\n            else begin\n                $display(\"Randomization has failed\");\n            end\n        end\n    end\nendmodule"
  },
  {
    "id": "c_pick_a_ball",
    "title": "Pick A Ball",
    "category": "Logic Puzzles & Brainteasers",
    "path": "constraints/pick_a_ball.sv",
    "isFrequentlyAsked": false,
    "tags": [],
    "description": "Randomly pick from 10 colored balls with unequal weights, ensuring consecutive draws do not pick the same color.",
    "explanation": "Write constraints – to pick a ball out of 10 different colored balls and that color should not be repeated for in next 3 draws",
    "code": "/*****************************\nWrite constraints – to pick a ball out of 10 different colored balls and that color should not be repeated for in next 3 draws\n*****************************/\ntypedef enum logic [3:0] {RED, BLUE, WHITE, BLACK, ORANGE, PURPLE, YELLOW, GREEN, GREY, MAROON} colour_balls_t;\n\nclass packet;\n    rand colour_balls_t ball;\n    colour_balls_t picked_ball_history[$];\n\n    constraint c{\n        !(ball inside {picked_ball_history});\n    }\n\n    function void post_randomize();\n        picked_ball_history.push_back(ball);\n        if(picked_ball_history.size() == 4) begin\n            picked_ball_history.pop_front();\n        end\n    endfunction: post_randomize\n\nendclass: packet\n\nmodule test;\n    packet p;\n\n    initial begin\n        p = new();\n        repeat(10) begin\n            if(p.randomize()) begin\n                $display(\"%s\",p.ball.name());\n            end\n        end\n    end\nendmodule"
  },
  {
    "id": "c_power_of_2",
    "title": "Power Of 2",
    "category": "Arithmetic & Bit-Level Constraints",
    "path": "constraints/power_of_2.sv",
    "isFrequentlyAsked": true,
    "tags": [
      "Frequently Asked",
      "Bitwise"
    ],
    "description": "Generate numbers that are powers of 2 without using exponentiation (`(val > 0) && ((val & (val - 1)) == 0)`).",
    "explanation": "Write a constraint for generating the 2 power numbers with out using ** operator\nOutput an array with a random number of 2 power numbers in binary. In other words randomize an array with one hot numbers.\nDisplay both binary and decimal",
    "code": "/******** \nWrite a constraint for generating the 2 power numbers with out using ** operator\nOutput an array with a random number of 2 power numbers in binary. In other words randomize an array with one hot numbers. \nDisplay both binary and decimal\n*********/\n\n//Array of power of 2 numbers in binary\nclass packet;   \n    rand bit[7:0] arr[];\n    rand int bit_pos[]; //This array stores random bit positions that we will set to high. \n\n    //randomize the size of array\n    constraint c_size{\n        arr.size() inside {\n            [3:8]\n        };\n\n        bit_pos.size() == arr.size();\n    }\n    \n    //Value of bit indexes has to be in the range of size of the array. bit positions has be to in the range of [0,arr.size()-1];\n    constraint c_bit_post_range{\n        foreach(bit_pos[i]) {\n            bit_pos[i] < arr.size() && bit_pos[i] > -1;\n        }\n    }\n\n    constraint c_unique_bit_positions{\n        unique {bit_pos};\n    }\n\n    constraint c_power_of_2{\n        foreach(arr[i]){\n            arr[i] == 8'b1 << bit_pos[i];\n        }\n    }\nendclass: packet\n\nmodule test;\n    packet p = new();\n\n    initial begin\n        if(p.randomize()) begin\n            $display(\"Generated values\");\n            for(int i =0;i<p.arr.size();i++) begin\n                $display(\"Decimal: %0d, Binary = %08b\",p.arr[i],p.arr[i]);\n            end\n        end\n    end\nendmodule"
  },
  {
    "id": "c_power_of_4",
    "title": "Power Of 4",
    "category": "Arithmetic & Bit-Level Constraints",
    "path": "constraints/power_of_4.sv",
    "isFrequentlyAsked": true,
    "tags": [
      "Frequently Asked",
      "Bitwise"
    ],
    "description": "Constrain a 32-bit number to be a power of 4 (must be power of 2 and non-zero bit must reside at an even bit position `val & 32'h55555555 != 0`).",
    "explanation": "Write constraint for number to be power of 4.",
    "code": "/********\nWrite constraint for number to be power of 4.\n*******/\n\nclass packet;\n rand int unsigned value;\n rand int unsigned exp;\n constraint exponent{\n    exp inside {[0:15]};\n }\n\n\n function void post_randomize();\n    value = 4**exp;\n endfunction: post_randomize\n\nendclass:packet\n\nmodule power_of_4;\n    packet p = new();\n    initial begin\n        for(int i = 0;i<10;i++) begin\n            if(p.randomize()) begin\n                $display(\"Value: %0d\",p.value);\n            end\n            else begin\n                $display(\"Randomization Failed!\");\n            end\n        end\n    end\nendmodule"
  },
  {
    "id": "c_prime_number",
    "title": "Prime Number",
    "category": "Arithmetic & Bit-Level Constraints",
    "path": "constraints/prime_number.sv",
    "isFrequentlyAsked": true,
    "tags": [
      "Frequently Asked"
    ],
    "description": "Constrain an 8-bit random variable to only produce prime numbers (using set inclusion `inside` or helper table/divisibility constraints).",
    "explanation": "You have an 8-bit random variable:\nrand bit [7:0] num;\nWrite constraints such that:\nnum is a prime number.\nnum is between 2 and 255.\nConsecutive randomizations should not generate the same prime number.",
    "code": "/********\nYou have an 8-bit random variable:\nrand bit [7:0] num;\nWrite constraints such that:\nnum is a prime number.\nnum is between 2 and 255.\nConsecutive randomizations should not generate the same prime number.\n********/\n\n\nclass packet;\n    rand bit [7:0] num;\n    bit [7:0] prev_val;\n    int initialize = 0;\n\n    constraint c_range{\n        num inside {[0:255]};\n    }\n\n    constraint c_not_equals_last_value{\n        if(initialize) {\n            prev_val != num;\n        }\n    }\n\n    constraint c_prime {\n        (num inside {2,3,5,7,11,13}) || (\n            num > 13 &&\n            num % 2!=0 &&\n            num % 3!=0 &&\n            num % 5!=0 &&\n            num % 7!=0 &&\n            num % 11!=0 &&\n            num % 13!=0\n        );\n    }\n\n    function void post_randomize();\n        prev_val = num;\n        initialize = 1;\n    endfunction: post_randomize\n\n    function int is_prime(input int n);\n        if(n<2) return 0;\n        for(int i =2;i*i<=n;i++) begin\n            if(n%i==0) return 0;\n        end\n        return 1;\n    endfunction: is_prime\n\n\nendclass: packet\n\nmodule prime_number;\n\n    packet p = new();\n\n    initial begin\n        repeat(5) begin\n            if(p.randomize()) begin\n                $display(\"Randomization is successful\");\n                if(p.is_prime(p.num)) $display(\"Generated: %0d\",p.num);\n                else $display(\"Generated: %0d, but it's not prime\",p.num);\n            end\n            else $display(\"Randomization has failed\");\n        end\n    end\n\nendmodule: prime_number\n\n\n// class packet;\n//     rand int num;\n//     bit prev_val;\n//     int initialize = 0;\n\n//     constraint c_range{\n//         num inside {[0:255]};\n//     }\n\n//     constraint c_not_equals_last_value{\n//         if(initialize) {\n//             prev_val != num;\n//         }\n//     }\n\n//     constraint c_prime {\n//         (num inside {2,3,5,7,11,13}) || (\n//             num > 13 &&\n//             num % 2!=0 &&\n//             num % 3!=0 &&\n//             num % 5!=0 &&\n//             num % 7!=0 &&\n//             num % 11!=0 &&\n//             num % 13!=0\n//         );\n//     }\n\n//     function void post_randomize();\n//         prev_val = num;\n//         initialize = 1;\n//     endfunction: post_randomize\n\n//     function int is_prime(input int n);\n//         if(n<2) return 0;\n//         for(int i =2;i*i<=n;i++) begin\n//             if(n%i==0) return 0;\n//         end\n//         return 1;\n//     endfunction: is_prime\n\n\n// endclass: packet\n\n// module prime_number;\n\n//     packet p = new();\n\n//     initial begin\n//         repeat(5) begin\n//             if(p.randomize()) begin\n//                 $display(\"Randomization is successful\");\n//                 if(p.is_prime(p.num)) $display(\"Generated: %0d\",p.num);\n//                 else $display(\"Generated: %0d, but it's not prime\",p.num);\n//             end\n//             else $display(\"Randomization has failed\");\n//         end\n//     end\n\n// endmodule: prime_number"
  },
  {
    "id": "c_queue_size_based_randomization",
    "title": "Queue Size Based Randomization",
    "category": "Arrays, Queues & Matrices",
    "path": "constraints/queue_size_based_randomization.sv",
    "isFrequentlyAsked": false,
    "tags": [
      "Queue"
    ],
    "description": "Randomize queue size to S, and constrain each element i in the queue to be bounded by 0 \\le \\text{queue}[i] < S.",
    "explanation": "Add \"size\" number of entries to a queue. The entry of queue is randomized between 0 to \"size\"",
    "code": "/******************\nAdd \"size\" number of entries to a queue. The entry of queue is randomized between 0 to \"size\"\n******************/\n\nclass packet;\n    rand int queue[$];\n    rand int size;\n\n    constraint c_size_queue{\n        size inside {[5:15]};\n    }\n\n    constraint c_queue_size{\n        queue.size() == size;\n    }\n\n    constraint c_queue_entry{\n        foreach(queue[i]){\n            queue[i] inside{[0:size]};\n        }\n    }\nendclass: packet\n\nmodule test;\n    packet p = new();\n\n    initial begin\n        repeat(5) begin\n            if(p.randomize()) begin\n                $display(\"Queue element; %p, Queue size randomized = %0d\",p.queue, p.size);\n            end\n        end\n    end\nendmodule"
  },
  {
    "id": "c_rand_dynamic_arrays",
    "title": "Rand Dynamic Arrays",
    "category": "Arrays, Queues & Matrices",
    "path": "constraints/rand_dynamic_arrays.sv",
    "isFrequentlyAsked": false,
    "tags": [
      "Array"
    ],
    "description": "Jointly randomize two dynamic arrays `arr1` (size 6–9) and `arr2` (size 12–15) with sum and intersection constraints.",
    "explanation": "Write a constraint to generate two dynamic arrays such that array1 size = [6:9], array2 size = array1 size.\nArray 1 should be assembled in ascending order while array2 should have all the values picked from array1",
    "code": "/**************************\nWrite a constraint to generate two dynamic arrays such that array1 size = [6:9], array2 size = array1 size. \nArray 1 should be assembled in ascending order while array2 should have all the values picked from array1\n**************************/\n\nclass packet;\n    rand int arr1[];\n    rand int arr2[];\n\n    constraint c_arr_size{\n        arr1.size() inside {[6:9]};\n        arr2.size() == arr1.size();\n    }\n\n    constraint c_arr1_range{\n        foreach(arr1[i]){\n            arr1[i] inside {[0:20]};\n        }\n    }\n\n    constraint c_arr1_ascending_order{\n        foreach(arr1[i]){\n            if(i>0){\n                arr1[i] > arr1[i-1];\n            }\n        }\n    }\n\n    function void post_randomize();\n        arr2 = arr1;\n        arr2.shuffle();\n    endfunction\nendclass: packet\n\nmodule test;\n    packet p;\n    initial begin\n        p = new();\n        if(p.randomize()) begin\n            $display(\"%p\",p.arr1);\n            $display(\"%p\",p.arr2);\n        end\n    end\nendmodule"
  },
  {
    "id": "c_random_5bit_pattern_constraint",
    "title": "Random 5-Bit Cluster Pattern",
    "category": "Sequences & Pattern Generation",
    "path": "constraints/random_5bit_pattern_constraint.sv",
    "isFrequentlyAsked": false,
    "tags": [
      "Bitwise",
      "Distribution / Pattern"
    ],
    "description": "Generate values with only 5 bits set, with consecutive bits appearing 80% of the time.",
    "explanation": "Write constraint to generate a random number with only 5 bits set and consecutively set for 80% of the time",
    "code": "/**************\nWrite constraint to generate a random number with only 5 bits set and consecutively set for 80% of the time\n**************/\n\nclass packet;\n    rand bit [31:0] data;\n    rand int start_pos;\n    rand bit consecutive_mode;\n\n    constraint c_consecutive_mode{\n        consecutive_mode dist {\n            1 := 80,\n            0 := 20\n        };\n    }\n\n    constraint c_start_pos{\n        start_pos inside {[0:27]};\n    }\n\n    constraint c_5_set_bits{\n        // foreach(data[i]){\n        //     if(consecutive_mode){\n        //         if(i >= start_pos && i<start_pos+5){\n        //             data[i]==1;\n        //         }\n        //         else data[i] == 0;\n        //     }\n        // }\n\n        if(consecutive_mode){\n            data == 32'h1F << start_pos;\n        }\n        else {\n            $countones(data) == 5;\n        }\n    }\n\nendclass\n\nmodule test;\n    packet p = new();\n\n    initial begin\n        repeat(7) begin\n            if(p.randomize()) begin\n                $display(\"Generated bianry: %032b\",p.data);\n            end\n        end\n    end\nendmodule"
  },
  {
    "id": "c_random_odd_matrix_gen",
    "title": "Random Odd Matrix Gen",
    "category": "Arrays, Queues & Matrices",
    "path": "constraints/random_odd_matrix_gen.sv",
    "isFrequentlyAsked": false,
    "tags": [
      "Matrix"
    ],
    "description": "Randomize an N \\times N matrix where N is strictly odd and entries follow alternating odd/even row rules.",
    "explanation": "Matrix size should be randomized with only odd numbered square matrix.",
    "code": "/*************\n\nMatrix size should be randomized with only odd numbered square matrix. \n\n*************/\n\nclass packet;\n\n    // Matrix declaration\n    rand int unsigned mat[][];\n\n    rand int m; //Size of the matrix, should be odd - 1,3,5,7,....\n\n    // a. Matrix size should be randomized with only odd numbered square matrix. \n    constraint c_odd_size{\n        m%2 == 1;\n        m inside {[1:9]};\n    }\n\n    // Create an odd dimensions square matrix - (m x m)\n    constraint c_mat_dimensions{\n        mat.size() == m;\n        foreach(mat[i]) {\n            mat[i].size() == m;\n        }\n    }\n\n    // Matrix elements range\n    constraint c_mat_elements_range{\n        foreach(mat[i,j]){\n            mat[i][j] inside {[1:500]};\n        }\n    }\n\n\nendclass\n\nmodule test;\n    packet p;\n\n    initial begin\n        repeat(5) begin\n            $display(\"::::::::::::::::::::::::::::::::::::\");\n            p = new();\n            if(p.randomize()) begin\n                foreach(p.mat[i]) begin\n                    foreach(p.mat[i][j]) begin\n                        $write(\"%0d \", p.mat[i][j]);\n                    end\n                    $display(\"\");\n                end\n            end\n            $display(\"::::::::::::::::::::::::::::::::::::\");\n        end\n    end\nendmodule"
  },
  {
    "id": "c_rotate_90",
    "title": "Rotate 90",
    "category": "Arrays, Queues & Matrices",
    "path": "constraints/rotate_90.sv",
    "isFrequentlyAsked": false,
    "tags": [
      "Matrix"
    ],
    "description": "Randomize a square matrix and constrain another matrix to be its 90-degree counter-clockwise rotated equivalent.",
    "explanation": "Write a constraint for square matrix and then rotate 90 counter clock wise",
    "code": "/**********************\nWrite a constraint for square matrix and then rotate 90 counter clock wise\n**********************/\n\nclass packet;\n    \n    rand int arr[][];\n\n    constraint c_square_matrix{\n        arr.size() inside {[2:9]};\n\n        foreach(arr[i]){\n            arr.size() == arr[i].size();\n        }\n    }\n\n    function void post_randomize();\n        int count = 1;\n\n        foreach(arr[i,j]) begin\n            arr[i][j] = count++;\n        end\n    endfunction: post_randomize\n\nendclass: packet\n\n// Display rotated array without actually rotating the array\n// module test;\n//     packet p = new();\n//     int n;\n\n//     initial begin\n//         if(p.randomize()) begin\n//             //Get size\n//             n = p.arr[0].size();\n\n//             $display(\"Originial Matrix\");\n//             foreach(p.arr[i]) begin\n//                 foreach(p.arr[i][j]) begin\n//                     $write(\"%0d \",p.arr[i][j]);\n//                 end\n//                 $display();\n//             end\n\n//             $display(\"-------------------\\nCounter clockwise 90 Degree Rotated Matrix\");\n//             foreach(p.arr[i]) begin\n//                 foreach(p.arr[i][j]) begin\n//                     $write(\"%0d \",p.arr[j][n-1-i]);\n//                 end\n//                 $display();\n//             end\n//         end\n//     end\n// endmodule\n\n\n// Write a function to rotate the array.\nmodule test;\n    packet p = new();\n    int n;\n    int rotated_mat[][];\n\n    initial begin\n        if(p.randomize()) begin\n            n = p.arr[0].size();\n            $display(\"Original Matrix\");\n            foreach(p.arr[i]) begin\n                foreach(p.arr[i][j]) begin\n                    $write(\"%0d \",p.arr[i][j]);\n                end\n                $display(\"\");\n            end\n\n            rotate_by_90_degree(p.arr,n,rotated_mat);\n\n            $display(\"Rotated Matrix\");\n            foreach(rotated_mat[i]) begin\n                foreach(rotated_mat[i][j]) begin\n                    $write(\"%0d \",rotated_mat[i][j]);\n                end\n                $display(\"\");\n            end\n\n\n        end\n    end\n\n    function void rotate_by_90_degree(input int mat[][], input int n, output int rotate[][]);\n        rotate = new[n];\n        foreach(rotate[i]) rotate[i] = new[n];\n        foreach(mat[i,j]) begin\n            rotate[i][j] = mat[j][n-1-i];\n        end\n    endfunction: rotate_by_90_degree\n                    \n    \nendmodule"
  },
  {
    "id": "c_aligned_va_generation",
    "title": "Naturally Aligned Virtual Address Generation",
    "category": "Real-World SoC Verification Scenarios",
    "path": "constraints/scenarios/aligned_va_generation.sv",
    "isFrequentlyAsked": true,
    "tags": [
      "Frequently Asked",
      "Architecture / SoC"
    ],
    "description": "Naturally Aligned Virtual Addresses: Generate 64-bit virtual addresses that are strictly aligned to 4KB, 2MB, or 1GB page boundaries based on randomized page size configurations.",
    "explanation": "===== Aligned VA generation ====\nGenerate virtual addresses that are always naturally aligned to their access size.\nAccess size is also randomized as 4B, 8B, 16B, or 64B.",
    "code": "/***********************\n===== Aligned VA generation ====\n\nGenerate virtual addresses that are always naturally aligned to their access size. \nAccess size is also randomized as 4B, 8B, 16B, or 64B.\n************************/\n\nclass addr_req;\n    rand bit [63:0] va;\n    rand int unsigned size_bytes;\n\n    constraint c_size_bytes{\n        size_bytes inside{4,8,16,64};\n    }\n\n    constraint va_aligned{\n        if(size_bytes == 4){\n            va[1:0] == 2'b00;\n        }\n        else if(size_bytes == 8){\n            va[2:0] == 3'b000;\n        }\n        else if(size_bytes == 16){\n            va[3:0] == 4'b0000;\n        }\n        else if(size_bytes == 64){\n            va[4:0] == 6'b000000;\n        }\n    }\nendclass: addr_req\n\nmodule test;\n    addr_req req;\n    initial begin\n        repeat(5) begin\n            req = new();\n            if(req.randomize()) begin\n                $display(\"Virtual Address: %0h, Size Bytes = %0d\", req.va, req.size_bytes);\n            end\n        end\n    end\nendmodule"
  },
  {
    "id": "c_crossbar_switch_arbiter",
    "title": "4x4 Crossbar Switch Contention",
    "category": "Real-World SoC Verification Scenarios",
    "path": "constraints/scenarios/crossbar_switch_arbiter.sv",
    "isFrequentlyAsked": true,
    "tags": [
      "Frequently Asked",
      "Bitwise",
      "Architecture / SoC"
    ],
    "description": "4x4 Crossbar Switch Contention: Randomize a 4 \\times 4 request matrix such that no output port is granted to more than one input port simultaneously (one-hot column constraint).",
    "explanation": "You are verifying a crossbar switch arbiter. You need to randomize a 4x4 matrix of 4-bit\nvalues representing priority weights assigned to each (input port, output port) pair\nWrite constraints such that all of the following hold simultaneously:\nRow uniqueness – within any single row, no two values may repeat.\nColumn sum bound – the sum of all four values in any column must not exceed 30.\nDiagonal exclusion – no element on the main diagonal (priority_matrix[i][i]) may be zero (a port can never have zero self-priority).\nAnti-symmetry – for every i != j, priority_matrix[i][j] + priority_matrix[j][i] must not equal exactly 15 (this represents a forbidden \"deadlock-priority\" pairing).\nDonot use unique\nDonot use post_randomize",
    "code": "/****************************************\nYou are verifying a crossbar switch arbiter. You need to randomize a 4x4 matrix of 4-bit \nvalues representing priority weights assigned to each (input port, output port) pair\n\nWrite constraints such that all of the following hold simultaneously:\n\nRow uniqueness – within any single row, no two values may repeat.\nColumn sum bound – the sum of all four values in any column must not exceed 30.\nDiagonal exclusion – no element on the main diagonal (priority_matrix[i][i]) may be zero (a port can never have zero self-priority).\nAnti-symmetry – for every i != j, priority_matrix[i][j] + priority_matrix[j][i] must not equal exactly 15 (this represents a forbidden \"deadlock-priority\" pairing).\n\nDonot use unique\nDonot use post_randomize\n*****************************************/\n\nclass packet;\n    rand logic[3:0] priority_matrix[4][4];\n\n    constraint row_uniqueness{\n        foreach(priority_matrix[i]){\n            foreach(priority_matrix[i][j]){\n                foreach(priority_matrix[i][k]){\n                    (j!=k) ->   priority_matrix[i][j]!=priority_matrix[i][k];\n                }\n            }\n        }\n    }\n\n    constraint c_column_sum{\n        foreach(priority_matrix[,j]){\n            priority_matrix[0][j] + priority_matrix[1][j] + priority_matrix[2][j] + priority_matrix[3][j] <= 30; \n        }\n    }\n\n    constraint c_diagonal_exclusion{\n        foreach(priority_matrix[i]){\n            priority_matrix[i][i]!=0;\n        }\n    }\n\n    constraint c_anti_symmetry{\n        foreach(priority_matrix[i,j]){\n            (i!=j) -> priority_matrix[i][j] + priority_matrix[j][i] != 15;\n        }\n    }\n\nendclass: packet;\n\nmodule test;\n    packet p;\n    initial begin\n        p = new();\n        if(p.randomize()) begin\n            foreach(p.priority_matrix[i]) begin\n                foreach(p.priority_matrix[i][j]) begin\n                    $write(\"%0d \",p.priority_matrix[i][j]);\n                end\n                $display(\"\");\n            end\n        end\n    end\nendmodule"
  },
  {
    "id": "c_fifo_constraint_scenario",
    "title": "FIFO Stimulus Boundary Constraints",
    "category": "Real-World SoC Verification Scenarios",
    "path": "constraints/scenarios/fifo_constraint_scenario.sv",
    "isFrequentlyAsked": true,
    "tags": [
      "Frequently Asked",
      "Architecture / SoC"
    ],
    "description": "Constrained-Random FIFO Stimulus: Randomize push/pop sequences with weights that drive the FIFO toward near-full, near-empty, and simultaneous push-and-pop boundary states.",
    "explanation": "You're writing a constrained random test for the FIFO. Write a constraint block that does the following:\nwr_en and rd_en are never both deasserted at the same time\nBack-to-back writes are allowed but back-to-back reads should happen at most 30% of the time",
    "code": "/************************\nYou're writing a constrained random test for the FIFO. Write a constraint block that does the following:\n\nwr_en and rd_en are never both deasserted at the same time\nBack-to-back writes are allowed but back-to-back reads should happen at most 30% of the time\n**************************/\n\nclass fifo_seq_item;\n    rand bit wr_en;\n    rand bit rd_en;\n    bit prev_rd_en; \n\n    constraint c_not_both_idle {\n        !(wr_en == 0 && rd_en == 0);\n    }\n\n    constraint c_consec_reads {\n        if (prev_rd_en == 1)\n            rd_en dist {1 := 30, 0 := 70};\n    }\n\n    function void post_randomize();\n        prev_rd_en = rd_en\n    endfunction: post_randomize\nendclass"
  },
  {
    "id": "c_legal_tlb_access",
    "title": "Legal TLB Access with Privilege Levels",
    "category": "Real-World SoC Verification Scenarios",
    "path": "constraints/scenarios/legal_tlb_access.sv",
    "isFrequentlyAsked": true,
    "tags": [
      "Frequently Asked",
      "Architecture / SoC"
    ],
    "description": "TLB Access Verification: Constrain TLB requests to legal memory access types (Read, Write, Execute, Prefetch) with privilege level enforcement (User vs. Supervisor).",
    "explanation": "Legal TLB access type\nConstrain a TLB request so the access type is always read-only when the page is marked non-writable, and never executable when the page has NX bit set",
    "code": "/********************************************\nLegal TLB access type\nConstrain a TLB request so the access type is always read-only when the page is marked non-writable, and never executable when the page has NX bit set\n**********************************************/\n\nclass tlb_req;\n    rand bit [39:0] va;         //Virtual Address\n    rand bit [2:0] access_type; // 0 = read, 1 = write, 2 = exec\n    bit page_writeable;\n    bit page_nx;\n\n    constraint c_legal_tlb_access{\n        (page_writeable == 0) -> (access_type == 3'b000);\n        (page_nx == 1) -> (access_type != 3'b010);\n    }\n\n    constraint c_access_types{\n        access_type inside {3'b000, 3'b001, 3'b010};\n    }\n\nendclass: tlb_req\n\nmodule test;\n    tlb_req req;\n    initial begin\n        req = new();\n        req.page_writeable = 0;\n        req.page_nx = 0;\n        if(req.randomize()) begin\n            $display(\"Virtual Address: %40b, Access Type: %03b, Page Writeable = %01b, Page NX = %01b\",req.va,req.access_type,req.page_writeable, req.page_nx);\n        end\n        req = new();\n        req.page_writeable = 1;\n        req.page_nx = 1;\n        if(req.randomize()) begin\n            $display(\"Virtual Address: %40b, Access Type: %03b, Page Writeable = %01b, Page NX = %01b\",req.va,req.access_type,req.page_writeable, req.page_nx);\n        end\n\n        repeat(5) begin\n            req = new();\n            req.page_writeable = $urandom_range(0,1);\n            req.page_nx = $urandom_range(0,1);\n            if(req.randomize()) begin\n                $display(\"Virtual Address: %40b, Access Type: %03b, Page Writeable = %01b, Page NX = %01b\",req.va,req.access_type,req.page_writeable, req.page_nx);\n            end\n        end\n    end\nendmodule"
  },
  {
    "id": "c_lru_candiate_eviction",
    "title": "8-Way Set-Associative TLB LRU Eviction",
    "category": "Real-World SoC Verification Scenarios",
    "path": "constraints/scenarios/lru_candiate_eviction.sv",
    "isFrequentlyAsked": true,
    "tags": [
      "Frequently Asked"
    ],
    "description": "8-Way Set-Associative TLB LRU Selection: Track age counters across ways and constrain stimulus to select candidate lines for eviction based on pseudo-LRU age counter maximums.",
    "explanation": "TLB eviction: LRU candidate selection\nAn 8-way set-associative TLB has age counters per way (0 = LRU, 7 = MRU).\nConstrain a new fill so it always targets the way with the lowest age.\nIf there is a tie, pick the lowest way index.\nExample:\nWay : 0 1 2 3 4 5 6 7\nAge : 3 0 5 0 2 1 7 4\nEvict way should be 1 because Age[1] is the lowest\nWay : 0 1 2 3 4 5 6 7\nAge : 4 2 1 5 3 6 7 0\nMinimum age = 0 only at way 7.\nevict_way = 7\nWay : 0 1 2 3 4 5 6 7\nAge : 4 2 1 1 3 6 7 0\nMinimum age = 0 only at way 7.\nevict_way = 2",
    "code": "/***************************\nTLB eviction: LRU candidate selection\n\nAn 8-way set-associative TLB has age counters per way (0 = LRU, 7 = MRU). \nConstrain a new fill so it always targets the way with the lowest age. \nIf there is a tie, pick the lowest way index. \n\nExample:\nWay : 0 1 2 3 4 5 6 7\nAge : 3 0 5 0 2 1 7 4\nEvict way should be 1 because Age[1] is the lowest\n\nWay : 0 1 2 3 4 5 6 7\nAge : 4 2 1 5 3 6 7 0\n\nMinimum age = 0 only at way 7.\n\nevict_way = 7\n\nWay : 0 1 2 3 4 5 6 7\nAge : 4 2 1 1 3 6 7 0\n\nMinimum age = 0 only at way 7.\n\nevict_way = 2\n***************************/\n\nclass tlb_fill;\n  rand bit [2:0] age   [8];         // age per way\n  rand bit [2:0] evict_way;\n\n  constraint c_min_age{\n    foreach(age[i]){\n        age[evict_way] <= age[i];\n    }\n  }\n\n  constraint c_same_age_lower_index{\n    foreach(age[i]){\n        if(i<evict_way){\n            age[i]> age[evict_way];\n        }\n    }\n  }\n\nendclass\n\nmodule test;\n    tlb_fill obj;\n    initial begin\n        repeat(5) begin\n            obj = new();\n            if(obj.randomize()) begin\n                $display(\"%p\",obj.age);\n                $display(\"%0d\",obj.evict_way);\n                $display(\"------------\");\n            end\n        end\n    end\nendmodule"
  },
  {
    "id": "c_packet_transactions",
    "title": "Weighted Packet Type Distribution",
    "category": "Real-World SoC Verification Scenarios",
    "path": "constraints/scenarios/packet_transactions.sv",
    "isFrequentlyAsked": true,
    "tags": [
      "Frequently Asked"
    ],
    "description": "Weighted Packet Distributions: 2-bit packet type field constrained using `dist` so Type 0 appears 50% of the time, Type 1 appears 30%, and Types 2/3 share the remaining 20%.",
    "explanation": "1) Randomizable field pkt_type (2 bits). Constrain it so the value 0 appears 50% of the time, 1 appears 30% of the time, and 2 and 3 split the remaining 20% evenly.\n2) Fields length (8 bits) and payload[] (a dynamic array of bytes). Constrain length to be between 10 and 64, and constrain payload.size() to equal length.\nAdd a constraint that the sum of all payload bytes is even.\n3) class Transaction with fields mode (enum: READ, WRITE, IDLE), addr (32 bits), and data (32 bits). Constraints:\nIf mode == IDLE, both addr and data must be 0.\nIf mode == READ, data must be 0, and addr must be 4 byte aligned (lowest 2 bits are 0).\nIf mode == WRITE, addr must be within the range 0x1000 to 0x2000, and data must be nonzero.",
    "code": "/******************\n1) Randomizable field pkt_type (2 bits). Constrain it so the value 0 appears 50% of the time, 1 appears 30% of the time, and 2 and 3 split the remaining 20% evenly.\n2) Fields length (8 bits) and payload[] (a dynamic array of bytes). Constrain length to be between 10 and 64, and constrain payload.size() to equal length. \n   Add a constraint that the sum of all payload bytes is even.\n3) class Transaction with fields mode (enum: READ, WRITE, IDLE), addr (32 bits), and data (32 bits). Constraints:\n\nIf mode == IDLE, both addr and data must be 0.\nIf mode == READ, data must be 0, and addr must be 4 byte aligned (lowest 2 bits are 0).\nIf mode == WRITE, addr must be within the range 0x1000 to 0x2000, and data must be nonzero.\n\n******************/\n\ntypedef enum logic[1:0] {READ, WRITE, IDLE} mode_t;\n\nclass Transaction;\n    rand bit[1:0]  pkt_type;\n    rand bit[7:0]  length;\n    rand bit[7:0]       payload[];\n    rand mode_t    mode;\n    rand bit[31:0] addr;\n    rand bit[31:0] data;\n\n    constraint c_pkt_type{\n        pkt_type dist{\n            2'b00:=50,\n            2'b01:=30,\n            [2'b10: 2'b11]:/20\n        };\n    }\n\n    constraint c_length{\n        length inside {[10:64]};\n    }\n\n    constraint c_payload_size{\n        payload.size() == length;\n    }\n\n    constraint c_payload_sum{\n        payload.sum()%2 == 0;\n    }\n\n    constraint c_solve_order{\n        solve mode before addr, data;\n    }\n\n    constraint c_address_modes{\n        if(mode == IDLE){\n            addr == 32'b0;\n            data == 32'b0;\n        }\n        else if(mode == READ){\n            data == 32'b0;\n            addr % 4 == 0;\n        }\n        else if(mode == WRITE){\n            data != 0;\n            addr inside {[32'h1000:32'h2000]};\n        }\n    }\n\nendclass: Transaction\n\nmodule test;\n    Transaction tr;\n\n    initial begin\n        repeat(10) begin\n            tr = new();\n            if(tr.randomize()) begin\n                $display(\"Packet Type: %02b\", tr.pkt_type);\n                $display(\"Length: %0d, Payload Generated: %p\", tr.length, tr.payload);\n                $display(\"Mode: %0s, Address Generated: %0h, Data Generated: %0h\", tr.mode.name(), tr.addr, tr.data);\n            end\n        end\n    end\nendmodule"
  },
  {
    "id": "c_tlb_hit_miss",
    "title": "TLB Hit vs. Miss Ratio Distribution",
    "category": "Real-World SoC Verification Scenarios",
    "path": "constraints/scenarios/tlb_hit_miss.sv",
    "isFrequentlyAsked": true,
    "tags": [
      "Frequently Asked",
      "Architecture / SoC"
    ],
    "description": "TLB Hit vs. Miss Distribution: Generate access addresses that hit existing tags 70% of the time and miss (forcing page table walks) 30% of the time.",
    "explanation": "===== TLB Hit vs Miss Distribution ====\nYou want 70% of transactions to be TLB hits and 30% misses.\nHits must reuse a VA from a pre-populated hot set of 16 addresses. Misses must pick a fresh VA not in the hot set.",
    "code": "/***********************\n===== TLB Hit vs Miss Distribution ====\n\nYou want 70% of transactions to be TLB hits and 30% misses. \nHits must reuse a VA from a pre-populated hot set of 16 addresses. Misses must pick a fresh VA not in the hot set.\n************************/\n\nclass tlb_traffic;\n    rand bit [39:0] va;\n    rand bit is_hit;\n    bit [39:0] hot_set[16];\n    rand int unsigned hit_index;\n\n\n    constraint c_hit_miss_distribution{\n        is_hit dist {\n            1:= 70,\n            0:= 30\n        };\n    }\n\n    constraint c_va_on_hit_miss{\n        if(is_hit) {\n            hit_index inside {[0:15]};\n            va == hot_set[hit_index];\n        }\n        else{\n            foreach(hot_set[i]){\n                va != hot_set[i];\n            }\n        }\n    }\n\n    function new();\n        foreach(hot_set[i]) begin\n            hot_set[i] = 40'h1000 + i;\n        end\n    endfunction: new\nendclass: tlb_traffic\n\nmodule test;\n    tlb_traffic obj = new();\n    initial begin\n        repeat(5) begin\n            if(obj.randomize()) begin\n                $display(\"Address: %0h, Is hit: %0b\", obj.va, obj.is_hit);\n                $display(\"Addresses in TLB: %p\", obj.hot_set);\n            end\n        end\n    end\nendmodule"
  },
  {
    "id": "c_sudoku",
    "title": "9x9 Sudoku Grid Solver",
    "category": "Logic Puzzles & Brainteasers",
    "path": "constraints/sudoku.sv",
    "isFrequentlyAsked": true,
    "tags": [
      "Frequently Asked",
      "Puzzle"
    ],
    "description": "Sudoku Solver: Fully solve a 9 \\times 9 Sudoku grid where each row, column, and 3 \\times 3 sub-grid contains digits 1–9 uniquely.",
    "explanation": "Generate a solved sudoku puzzle",
    "code": "/******\nGenerate a solved sudoku puzzle\n******/\n\nclass sudoku;\n    rand int arr[9][9];\n\n    constraint c_arr_range{\n        foreach(arr[i,j]){\n            arr[i][j] inside {[1:9]};\n        }\n    }\n\n    // Rules for a valid suduko\n    // Value has to be unique in the row\n    // Value has to be unique in the column\n    // Value has to be unique in the 3x3 matrix\n\n    constraint c_row_unique{\n        foreach(arr[i]){                    // This will iterate over the rows: which is an array\n            unique {arr[i]};                // Each row array has to be unique\n        }\n    }\n\n    constraint c_column_unique{\n        foreach(arr[i,j]){\n            foreach(arr[x,j]){\n                if(i != x){                 // If the columns are same then the values in columns must be all different frome each other. \n                    arr[i][j]!=arr[x][j];\n                }\n            }\n        }\n    }\n\n    constraint c_block_unique {\n        foreach(arr[i, j]) {\n            foreach(arr[x, y]) {\n                // If they are in the same 3x3 block but are not the same cell\n                // i/3 == x/3 compares if they are in the same block \n                if ((i/3 == x/3) && (j/3 == y/3) && !(i == x && j == y)) {\n                    arr[i][j] != arr[x][y];\n                }\n            }\n        }\n    }\nendclass: sudoku\n\nmodule test;\n    sudoku s;\n    initial begin\n        s = new();\n        if(s.randomize())begin\n            foreach(s.arr[i]) begin\n                foreach(s.arr[i][j]) begin\n                    $write(\"%0d \",s.arr[i][j]);\n                     if(j%3 ==2) $write(\" \");\n                end\n                $display(\"\");\n                if(i%3 ==2) $display(\"\");\n            end\n        end\n    end\nendmodule"
  },
  {
    "id": "c_three_sum_even",
    "title": "Three Sum Even",
    "category": "Arithmetic & Bit-Level Constraints",
    "path": "constraints/three_sum_even.sv",
    "isFrequentlyAsked": false,
    "tags": [],
    "description": "Constrain an array such that the sum of any three consecutive elements is always even.",
    "explanation": "Write a constraint such that the sum of any three consecutive elements in an array is even.",
    "code": "/*********************\nWrite a constraint such that the sum of any three consecutive elements in an array is even. \n*********************/\n\nclass packet;\n    rand int arr[10];\n\n    constraint c_range{\n        foreach(arr[i]){\n            arr[i] dist {\n                [1:100] := 80,\n                [101:1000] := 20\n            };\n\n            // arr[i] inside {[1:1000]};\n        }\n    }\n\n    constraint c_data{\n\n        foreach(arr[i]) {\n            if(i <= 7){\n                (arr[i]+arr[i+1]+arr[i+2])%2 == 0;\n            }\n        }\n\n    }\n\nendclass: packet\n\nmodule three_sum_even;\n    packet p = new();\n\n    initial begin\n        repeat(5) begin\n            if(p.randomize()) begin\n                $display(\"Randomization is successful!. Generated value: %p\",p.arr);\n            end\n            else begin\n                $display(\"Randomization has failed\");\n            end\n        end\n    end\nendmodule"
  },
  {
    "id": "c_trailing_zeroes",
    "title": "Trailing Zeroes",
    "category": "Arithmetic & Bit-Level Constraints",
    "path": "constraints/trailing_zeroes.sv",
    "isFrequentlyAsked": true,
    "tags": [
      "Frequently Asked",
      "Bitwise"
    ],
    "description": "Constrain a 32-bit number to have between 5 and 10 trailing binary zeroes (`val[4:0] == 0`, `val[10] != 0`).",
    "explanation": "Write a constraint  for a 32 bit variable, such that the number of trailing zeroes is between 5 and 10",
    "code": "/********\nWrite a constraint  for a 32 bit variable, such that the number of trailing zeroes is between 5 and 10\n********/\n\nclass packet;\n    rand bit [31:0] data;\n\n    rand int num_zeroes;\n\n    constraint c_num_zeroes{\n        num_zeroes inside {[5:10]};\n    }\n\n    constraint c_trailing_bits{\n        foreach(data[i]) {\n            if (i < num_zeroes) {\n                data[i] == 0;\n            } else if (i == num_zeroes) {\n                data[i] == 1;\n            }\n        }\n    }\nendclass: packet\n\nmodule trailing_zeroes;\n    packet p = new();\n    initial begin\n    repeat(5) begin\n        if(p.randomize()) begin\n            $display(\"Generated: %b\",p.data);\n            $display(\"Number of trailing zeroes: %0d\",p.num_zeroes);\n        end\n        else begin\n            $display(\"Randomization has failed!\");\n        end\n    end\n    end\nendmodule: trailing_zeroes"
  },
  {
    "id": "c_unique_2d_array",
    "title": "Unique 2D Array",
    "category": "Arrays, Queues & Matrices",
    "path": "constraints/unique_2d_array.sv",
    "isFrequentlyAsked": true,
    "tags": [
      "Frequently Asked",
      "Matrix",
      "Array"
    ],
    "description": "Randomize a 2D matrix (M \\times N) such that all elements across all rows and columns are completely unique.",
    "explanation": "Write a constraint to randomize 2d array with unique elements",
    "code": "/*****************\nWrite a constraint to randomize 2d array with unique elements\n*****************/\n\n\nclass packet;\n    rand int arr[][];\n\n    constraint c_arr_dimensions{\n        arr.size() inside {[2:6]};\n\n        foreach(arr[i]){\n            arr[i].size() == arr.size();\n        }\n    }\n\n    constraint c_arr_range{\n        foreach(arr[i,j]){\n            arr[i][j] inside {[0:150]};\n        }\n    }\n\n    constraint c_unique_elements{\n        foreach(arr[i,j]){\n            foreach(arr[x,y]){\n                if(!(i==x && j==y)) arr[i][j] != arr[x][y];\n            }\n        }\n    }\nendclass: packet\n\nmodule test;\n    packet p = new();\n\n    initial begin\n        if(p.randomize()) begin\n            $display(\"Generated unique 2d matrix:\");\n            foreach(p.arr[i]) begin\n                foreach(p.arr[i][j]) $write(\"%0d \",p.arr[i][j]);\n                $display(\"\");\n            end\n        end\n    end\nendmodule"
  },
  {
    "id": "c_unique_3d_array",
    "title": "Unique 3D Array",
    "category": "Arrays, Queues & Matrices",
    "path": "constraints/unique_3d_array.sv",
    "isFrequentlyAsked": false,
    "tags": [
      "Matrix",
      "Array"
    ],
    "description": "Constrain a 3 \\times 3 \\times 3 cube array such that all 27 elements contain unique numbers from 1 to 27.",
    "explanation": "Write a constraint to randomize 3x3x3 array with unique elements",
    "code": "/*******************\nWrite a constraint to randomize 3x3x3 array with unique elements\n*******************/\n\n//This is the comparsion of every element techinque\n// class packet;\n//     rand int arr[3][3][3];\n\n//     constraint c_range_of_values{\n//         foreach(arr[i,j,k]) {\n//             arr[i][j][k] inside {[0:200]};\n//         }\n//     }\n\n//     constraint c_unique_values{\n//         foreach(arr[i,j,k]){\n//             foreach(arr[x,y,z]){\n//                 if(!(i==x && j==y && k==z)) {\n//                     arr[i][j][k] != arr[x][y][z];\n//                 }\n//             }\n//         }\n//     }\n// endclass: packet\n\n// This is the flatten out and make it unique technique. \nclass packet;\n    rand int arr_flat[27];\n    int arr[3][3][3];\n\n    constraint c_range_of_values{\n        foreach(arr_flat[i]) {\n            arr_flat[i] inside {[0:200]};\n        }\n    }\n\n    constraint c_flat_array_unique{\n        unique {arr_flat};\n    }\n\n    function void post_randomize();\n\n        int arr_index = 0;\n        foreach (arr[i,j,k]) begin\n            arr[i][j][k] = arr_flat[arr_index];\n            arr_index++;\n        end\n\n    endfunction: post_randomize\nendclass: packet\n\nmodule test;\n    packet p = new();\n\n    initial begin\n        if(p.randomize()) begin\n            $display(\"Generated Array:\");\n            foreach(p.arr[i]) begin\n                foreach(p.arr[i][j]) begin\n                    foreach(p.arr[i][j][k]) begin\n                        $write(\"%0d \",p.arr[i][j][k]);\n                    end\n                    $display(\"\");\n                end\n                $display(\"\");\n            end\n        end\n    end\nendmodule"
  },
  {
    "id": "c_unique_last_4_digits",
    "title": "Unique Last 4 Digits",
    "category": "Arrays, Queues & Matrices",
    "path": "constraints/unique_last_4_digits.sv",
    "isFrequentlyAsked": false,
    "tags": [],
    "description": "In SystemVerilog, given an array of 100 random integers, write a constraint to ensure that the last four digits of each integer (i.e., the lower 4 decimal digits) are unique across all 100 integers.",
    "explanation": "In SystemVerilog, given an array of 100 random integers,\nwrite a constraint to ensure that the last four digits of each integer (i.e., the lower 4 decimal digits) are unique across all 100 integers.",
    "code": "/************\nIn SystemVerilog, given an array of 100 random integers, \nwrite a constraint to ensure that the last four digits of each integer (i.e., the lower 4 decimal digits) are unique across all 100 integers.\n************/\n\nclass packet;\n    //An array of size 100 \n    rand int unsigned array[100];\n\n    // To get the last 4 digits of a number, we simply need to divide the number by 10,000\n    // The remainder is the last 4 digits. 18290%10000 = 8290\n\n    constraint c_unique_last_4_digits{\n        foreach(array[i]){\n            foreach(array[j]){\n                if(i<j){\n                    array[i]%10000 != array[j]%10000;\n                }\n            }\n        }\n    }\n\nendclass: packet\n\nmodule test;\n    packet p;\n\n    initial begin\n        p = new();\n        if(p.randomize()) begin\n            for(int i = 0;i<100;i = i+4) begin\n                $write(\"%0d | \", p.array[i]);\n                $write(\"%0d | \", p.array[i+1]);\n                $write(\"%0d | \", p.array[i+2]);\n                $write(\"%0d\", p.array[i+3]);\n                $display(\"\");   \n            end\n        end\n    end \nendmodule"
  },
  {
    "id": "c_unique_max_value_in_array",
    "title": "Unique Max VAlue In Array",
    "category": "Arrays, Queues & Matrices",
    "path": "constraints/unique_max_value_in_array.sv",
    "isFrequentlyAsked": false,
    "tags": [
      "Array"
    ],
    "description": "Constrain a 2D array such that each row has a strictly unique maximum element, and that maximum is different across all rows.",
    "explanation": "Write a constraint for a 2d array such that it has a unique max value in each row and that max value should not be equal to any other max value in other rows",
    "code": "/********************\nWrite a constraint for a 2d array such that it has a unique max value in each row and that max value should not be equal to any other max value in other rows\n*********************/\n\nclass packet;\n    rand int arr[][];  //2d array arr[m][n] m - rows and n- columns\n\n    rand int max_values[]; //Array to store m max values - m rows. Each row has a unique max value. \n    rand int indexes[];      //Random indexes to place the max values. n columns = 0 to n-1 random values indexes[0] = 5 means place the max value in row0 at 5th indexes column\n\n\n    //Array elements will be in between 1 to 100\n    constraint c_arr_range{\n        foreach(arr[i,j]){\n            arr[i][j] inside {[1:100]};\n        }\n        foreach(max_values[i]){\n            max_values[i] inside {[1:100]};\n        }\n    }\n\n    //Each row should have unique max value and each index where max value is present should be unique\n    constraint c_unique_max_values_indexeses{\n        unique {max_values};\n        unique {indexes};\n    }\n\n    \n    constraint c_max_values_size{\n        max_values.size() == arr.size();   // We only need m max values. \n        indexes.size() == arr.size();     // We need n indexeses for the columns. \n    } \n\n    constraint c_indexes_range{\n        foreach(indexes[i]){\n            indexes[i] inside {[0:arr[i].size()-1]};\n        }\n    }\n\n    constraint c_size{\n        arr.size() inside {[2:5]}; //2<=m<=5\n        arr[0].size() inside {[2:5]};\n        \n        foreach(arr[i]){\n            arr[i].size() == arr[0].size();  //2<=n<=5\n        }\n    }\n\n    constraint c_unique_value_per_row{\n        foreach(arr[i,j]){\n            if(j==indexes[i]){\n                arr[i][j] == max_values[i];\n            }\n            else{\n                arr[i][j] < max_values[i];\n            }\n        }\n    }\n\n\n\nendclass: packet\n\nmodule test;\n    packet p = new();\n\n    initial begin\n        if(p.randomize()) begin\n            \n            $display(\"Array: %0d X %0d matrix\",p.arr.size(), p.arr[0].size());\n            foreach(p.arr[i]) begin\n                foreach(p.arr[i][j]) $write(\"%0d \",p.arr[i][j]);\n                $display(\"\");\n            end\n            $display(\"Max Values Array: %p\",p.max_values);\n            $display(\"Indexeses Array: %p\",p.indexes);\n        end\n    end\nendmodule"
  },
  {
    "id": "fj_automatic_fork_join",
    "title": "Loop Variable Binding Bug in fork..join_none",
    "category": "Fork-Join Concurrency & Multi-Threading",
    "path": "system_verilog/fork_join/automatic_fork_join.sv",
    "isFrequentlyAsked": true,
    "tags": [
      "Frequently Asked",
      "Concurrency",
      "Fork-Join"
    ],
    "description": "Explains the classic interview bug where threads spawned inside a for loop with join_none all sample the final loop index without an automatic copy.",
    "explanation": "Explains the classic interview bug where threads spawned inside a for loop with join_none all sample the final loop index without an automatic copy.",
    "code": "// A fork join_none starts all the child processes but never waits for any of them to complete. \n// Hence when we the for loop executes, it will start \n\nmodule automatic_fork_join;\n    initial begin\n        for (int i = 0; i < 5; i++) begin\n            automatic int j = i;\n            fork\n                begin\n                    #10;\n                    $display(\"Time: %0t | Driver ID: %0d active\", $time, j);\n                end\n            join_none\n        end\n        wait fork; // Wait for background threads to finish before ending simulation\n    end\nendmodule"
  },
  {
    "id": "fj_fork_join_any_using_fork_join_none",
    "title": "Emulate fork..join_any using fork..join_none",
    "category": "Fork-Join Concurrency & Multi-Threading",
    "path": "system_verilog/fork_join/fork_join_any_using_fork_join_none.sv",
    "isFrequentlyAsked": true,
    "tags": [
      "Frequently Asked",
      "Concurrency",
      "Fork-Join",
      "Events"
    ],
    "description": "Brainteaser: Implement join_any semantics (unblock parent on fastest child completion) using only fork..join_none and SystemVerilog event synchronization.",
    "explanation": "Implement fork join_any using fork join_none.",
    "code": "/****************\nImplement fork join_any using fork join_none.\n****************/\n\n// To make this happen we can use events in systemverilog\n// A fork join_none let's the program continue it's execution without waiting for the child processes to complete\n// While the parent executes, children run in the background. \n// A for join_any on other hand, makes the parent wait until atleast one child is compelted. Once a child is compelted, the main program unblocks\n// and continues execution. Rest of the children execute in the background. \n// For this particular question we will place a wait block after join_none. Thus we wait till one of the processes will be compelted\n\nmodule test;\n    event some_child_done;\n\n    initial begin\n        fork\n            begin:process_a\n                #10;\n                $display(\"Process A completed at: %0t\", $time);\n                -> some_child_done;\n            end\n            begin:process_b\n                #12;\n                $display(\"Process B completed at : %0t\", $time);\n                -> some_child_done;\n            end\n        join_none\n        wait(some_child_done.triggered);\n        $display(\"Some child process completed, Parent continues..... :%0t\",$time);\n    end\nendmodule"
  },
  {
    "id": "fj_fork_join_none_using_fork_join",
    "title": "Emulate fork..join_none using fork..join",
    "category": "Fork-Join Concurrency & Multi-Threading",
    "path": "system_verilog/fork_join/fork_join_none_using_fork_join.sv",
    "isFrequentlyAsked": true,
    "tags": [
      "Frequently Asked",
      "Concurrency",
      "Fork-Join"
    ],
    "description": "Interview Brainteaser: Implement non-blocking join_none behavior where child threads execute in background using standard blocking fork..join.",
    "explanation": "Implement fork join_none behaviour using fork join only!\nThis is a trick question and an interviewer generally asks this to see how you can play around with different concepts in systemverilog.\nYou can try to emulate the join_none behaviour in a different ways. I have listed one way of using it in an interview",
    "code": "/*******************************************************\nImplement fork join_none behaviour using fork join only!\n\nThis is a trick question and an interviewer generally asks this to see how you can play around with different concepts in systemverilog. \n\nYou can try to emulate the join_none behaviour in a different ways. I have listed one way of using it in an interview\n********************************************************/\n\n/* \n- A fork join_none schedules all the child processes. \n- These child processes do not run right away. \n- A fork join on the other hand is a blocking behaviour. \n- All child processes in fork join start execution right away and the parent process yields and waits till they complete.\n- The parent thread cannot pass the join line until every child process inside terminates.\n\n - fork..join_none: Spawns child threads without blocking the parent; child threads execute in the background once the parent yields or blocks.\n - fork..join: Strictly blocking; the parent thread cannot proceed past 'join' until ALL child threads complete.\n\nThis approach uses events and always block\n*/\n\n\nmodule test;\n\n    event e_start_child_processes;\n\n    initial begin\n        $display(\"[TIME: %0t] Parent: Triggering background tasks\", $time);\n\n        -> e_start_child_processes; \n        $display(\"[TIME: %0t] Parent: Proceeding immediately! (join_none achieved)\", $time);\n\n        #100;\n        $display(\"[TIME: %0t] Simulation complete.\", $time);\n        $finish; \n    end\n\n    task automatic task_a();\n        int random_delay = $urandom_range(10,30);\n        #(random_delay);\n        $display(\"[TIME: %0t], Task A completed\", $time);\n    endtask\n\n    task automatic task_b();\n        int random_delay = $urandom_range(10,30);\n        #(random_delay);\n        $display(\"[TIME: %0t], Task B completed\", $time);\n    endtask\n\n    always @(e_start_child_processes) begin\n        fork \n            task_a();\n            task_b();\n        join\n    end\n\n    \nendmodule"
  },
  {
    "id": "fj_fork_join_none_using_fork_join_any",
    "title": "Emulate fork..join_none using fork..join_any",
    "category": "Fork-Join Concurrency & Multi-Threading",
    "path": "system_verilog/fork_join/fork_join_none_using_fork_join_any.sv",
    "isFrequentlyAsked": false,
    "tags": [
      "Concurrency",
      "Fork-Join"
    ],
    "description": "Interview Brainteaser: Implement non-blocking fork..join_none execution semantics using only fork..join_any.",
    "explanation": "How to implement fork join_none block using fork join_any?",
    "code": "/********************************************************\nHow to implement fork join_none block using fork join_any?\n********************************************************/\n\n// A join_any will wait for one of the child processes to complete, before moving forward to the execution.\n// A join_none does not wait for any child prcoesses to complete. \n// Hence to implement join_none behaviour, we just need to create a dummy block inside the fork\nmodule test;\n    initial begin\n        fork\n            begin: process_A\n                //This is a dummy block that finishes right away\n            end\n            \n            begin: process_B\n                #12;\n                $display(\"Time: %0t, Process B is completed\", $time);\n            end\n\n            begin: process_C\n                #15;\n                $display(\"Time: %0t, Process C is completed\", $time);\n            end\n        join_any\n        $display(\"Time: %0t, Parent continues\", $time);\n    end\nendmodule"
  },
  {
    "id": "fj_fork_join_using_fork_join_none",
    "title": "Emulate fork..join using fork..join_none",
    "category": "Fork-Join Concurrency & Multi-Threading",
    "path": "system_verilog/fork_join/fork_join_using_fork_join_none.sv",
    "isFrequentlyAsked": true,
    "tags": [
      "Frequently Asked",
      "Concurrency",
      "Fork-Join",
      "Events"
    ],
    "description": "Brainteaser: Implement strictly blocking fork..join (wait for ALL child processes to terminate) using only fork..join_none and completion events.",
    "explanation": "Implement the behavior of a standard \"fork join\" block (where the parent waits\nfor ALL child processes to finish) using ONLY \"fork join_none\" and the\n\"wait fork\" statement.\nAssume you have 3 processes (A, B, C) with random delays.",
    "code": "/*******************************************************************************\nImplement the behavior of a standard \"fork join\" block (where the parent waits \nfor ALL child processes to finish) using ONLY \"fork join_none\" and the \n\"wait fork\" statement. \n\nAssume you have 3 processes (A, B, C) with random delays.\n*******************************************************************************/\n\nmodule test;\n    initial begin\n        fork\n            begin: process_a\n                int random_delay = $urandom_range(10,20);\n                #(random_delay);\n                $display(\"TIME = %0t: Process A is completed\", $time);\n            end\n            \n            begin: process_b\n                int random_delay = $urandom_range(10,20);\n                #(random_delay);\n                $display(\"TIME = %0t: Process B is completed\", $time);\n            end\n\n            begin: process_c\n                int random_delay = $urandom_range(10,20);\n                #(random_delay);\n                $display(\"TIME = %0t: Process C is completed\", $time);\n            end\n        join_none\n        wait fork;\n        $display(\"TIME = %0t: Parent now continues\", $time);\n    end\nendmodule"
  },
  {
    "id": "fj_join_any_2",
    "title": "Resume Simulation on Any 2 of 4 Tasks Completed",
    "category": "Fork-Join Concurrency & Multi-Threading",
    "path": "system_verilog/fork_join/join_any_2.sv",
    "isFrequentlyAsked": true,
    "tags": [
      "Frequently Asked",
      "Concurrency",
      "Fork-Join"
    ],
    "description": "Spawn 4 independent parallel processes taking random delays. Unblock parent as soon as ANY TWO processes finish, ignoring the 3rd and 4th.",
    "explanation": "Write code that spawns 4 independent, parallel processes (A, B, C, D), each\ntaking a completely random amount of processing time (#delay).\nThe parent thread must unblock and continue execution as soon as ANY TWO\nprocesses have completed. It should not wait for the 3rd or 4th process.",
    "code": "/*******************************************************************************\nWrite code that spawns 4 independent, parallel processes (A, B, C, D), each \ntaking a completely random amount of processing time (#delay). \n\nThe parent thread must unblock and continue execution as soon as ANY TWO \nprocesses have completed. It should not wait for the 3rd or 4th process.\n*******************************************************************************/\n\nmodule test;\n\n    logic process_a_done = 0;\n    logic process_b_done = 0;\n    logic process_c_done = 0;\n    logic process_d_done = 0;\n\n    initial begin\n        fork\n        \n            begin: Process_A\n                automatic int delay = $urandom_range(1,20);\n                #(delay);\n                $display(\"[TIME: %0t], Process A Completed\", $time);\n                process_a_done = 1;\n            end\n\n            begin: Process_B\n                automatic int delay = $urandom_range(1,20);\n                #(delay);\n                $display(\"[TIME: %0t], Process B Completed\", $time);\n                process_b_done = 1;\n            end\n\n            begin :Process_C            \n                automatic int delay = $urandom_range(1,20);\n                #(delay);\n                $display(\"[TIME: %0t], Process C Completed\", $time);\n                process_c_done = 1;\n            end\n\n            begin :Process_D            \n                automatic int delay = $urandom_range(1,20);\n                #(delay);\n                $display(\"[TIME: %0t], Process D Completed\", $time);\n                process_d_done = 1;\n            end\n\n        join_none\n        wait($countones({process_a_done, process_b_done, process_c_done, process_d_done}) == 2);\n        $display(\"[TIME: %0t], 2 Processes Completed!!!\",$time);\n    end\n\nendmodule"
  },
  {
    "id": "fj_multithreading",
    "title": "Multi-Threaded Spawning Semantics (join vs join_any vs join_none)",
    "category": "Fork-Join Concurrency & Multi-Threading",
    "path": "system_verilog/fork_join/multithreading.sv",
    "isFrequentlyAsked": false,
    "tags": [
      "Concurrency",
      "Fork-Join"
    ],
    "description": "Comparison of process lifetime, parent thread blocking, and timing behavior across join, join_any, and join_none with repeated spawning loops.",
    "explanation": "Comparison of process lifetime, parent thread blocking, and timing behavior across join, join_any, and join_none with repeated spawning loops.",
    "code": "// module test_fork_join;\n//     //This created a total of 10 child processes.\n//     initial begin\n//         repeat(5) begin\n//             fork\n//                 begin\n//                     #10 $display(\"[FORK_JOIN] Hello, this is fork join process #1 %0t\",$time);\n//                 end\n//                 begin\n//                     #20 $display(\"[FORK_JOIN] Hello, this is fork join process #2 %0t\",$time);\n//                 end\n//             join\n//         end\n//         $display(\"I am parent: child process have completed running, I am running at; %0t\",$time);\n//     end\n// endmodule  \n\nmodule test_fork_join_any;\n    initial begin\n        $display(\"----------------------------\");\n        repeat(5) begin\n            fork\n                begin\n                    #10 $display(\"[FORK_JOIN_ANY] Hello, this is fork join process #1 %0t\",$time);\n                end\n                begin\n                    #20 $display(\"[FORK_JOIN_ANY] Hello, this is fork join process #2 %0t\",$time);\n                end\n            join_any\n        end\n        $display(\"I am parent: a child process has completed running, I am running at; %0t\",$time);\n    end\nendmodule \n\nmodule test_fork_join_none;\n    initial begin\n        $display(\"----------------------------\");\n        repeat(5) begin\n            fork\n                begin\n                    #10 $display(\"[FORK_JOIN_NONE] Hello, this is fork join process #1 %0t\",$time);\n                end\n                begin\n                    #20 $display(\"[FORK_JOIN_NONE] Hello, this is fork join process #2 %0t\",$time);\n                end\n            join_any\n        end\n        $display(\"I am parent: I will execute right away; %0t\",$time);\n    end\nendmodule \n\nmodule tb;\n    initial begin\n        for(int i=0;i<3;i++) begin\n            // #1\n            fork \n                automatic int j=i;\n                $display(\"Value of j: %0d at time = %0t\",j,$time);\n            join\n            // $display(\"Value of i: %0d\",i);\n        end\n    end\nendmodule"
  },
  {
    "id": "fj_multithreading_1",
    "title": "Event-Driven Pipeline Dependency (A → C → D with B Waiting)",
    "category": "Fork-Join Concurrency & Multi-Threading",
    "path": "system_verilog/fork_join/multithreading_1.sv",
    "isFrequentlyAsked": false,
    "tags": [
      "Concurrency",
      "Fork-Join",
      "Events"
    ],
    "description": "Four parallel processes: Process C begins after A completes, Process D follows C, while Process B waits for D to finish using event.triggered.",
    "explanation": "Write code that will create the four processes. Process_C should begin when Process_A has finished,\nand then Process_D. However, Process_B ought to wait for Process_D to finish.\nThis solution uses events, wait, event.triggered and ->event concepts",
    "code": "/******************************\nWrite code that will create the four processes. Process_C should begin when Process_A has finished,\nand then Process_D. However, Process_B ought to wait for Process_D to finish.\n\nThis solution uses events, wait, event.triggered and ->event concepts\n*******************************/\n\nmodule test;\n    event process_a_done;\n    event process_c_done;\n    event process_d_done;\n\n    initial begin\n        fork: process_fork\n            begin: process_a\n                $display(\"Process A started: %0t\",$time);\n                #10\n                $display(\"Process A completed: %0t\",$time);\n                -> process_a_done;\n            end\n            \n            begin: process_b\n                wait(process_d_done.triggered);\n                $display(\"Process B started: %0t\", $time);\n                #20\n                $display(\"Process B completed: %0t\",$time);\n            end\n\n            begin: process_c\n                wait(process_a_done.triggered);\n                $display(\"Process C started: %0t\", $time);\n                #12;\n                $display(\"Process C completed: %0t\",$time);\n                ->process_c_done;\n            end\n            \n            begin: process_d\n                wait(process_c_done.triggered);\n                $display(\"Process D started: %0t\", $time);\n                #18;\n                $display(\"Process D completed: %0t\", $time);\n                -> process_d_done;\n            end\n        join\n    end\nendmodule"
  },
  {
    "id": "fj_multithreading_2",
    "title": "Sequential Process Ordering using Pure fork..join Blocks",
    "category": "Fork-Join Concurrency & Multi-Threading",
    "path": "system_verilog/fork_join/multithreading_2.sv",
    "isFrequentlyAsked": false,
    "tags": [
      "Concurrency",
      "Fork-Join"
    ],
    "description": "Create 4 processes where C waits for A, and B waits for D, implemented without events by using hierarchical blocking fork..join blocks.",
    "explanation": "Write code that will create the four processes. Process_C should begin when Process_A has finished,\nand then Process_D. However, Process_B ought to wait for Process_D to finish.\nThis solution only uses fork join",
    "code": "/******************************\nWrite code that will create the four processes. Process_C should begin when Process_A has finished,\nand then Process_D. However, Process_B ought to wait for Process_D to finish.\n\nThis solution only uses fork join\n*******************************/\n\nmodule  test;\n    initial begin\n        //Since we are using join, it blocks the execution of lines after the join block until all \n        //children inside the fork are completed with execution. \n        fork: Process_A\n            $display(\"Process A started execution: %0t\", $time);\n            #10\n            $display(\"Process A completed execution: %0t\", $time);\n        join\n\n        fork: Process_C\n            $display(\"Process C started execution: %0t\", $time);\n            #12\n            $display(\"Process C completed execution: %0t\", $time);\n        join\n\n        fork: Process_D\n            $display(\"Process D started execution: %0t\", $time);\n            #16\n            $display(\"Process D completed execution: %0t\", $time);\n        join\n\n        fork: Process_B\n            $display(\"Process B started execution: %0t\", $time);\n            #20\n            $display(\"Process B completed execution: %0t\", $time);\n        join\n    end\nendmodule"
  },
  {
    "id": "fj_parallel_dependency_graph",
    "title": "Parallel DAG Dependency Graph (C on A||B, D on A&&B)",
    "category": "Fork-Join Concurrency & Multi-Threading",
    "path": "system_verilog/fork_join/parallel_dependency_graph.sv",
    "isFrequentlyAsked": true,
    "tags": [
      "Frequently Asked",
      "Concurrency",
      "Fork-Join",
      "DAG"
    ],
    "description": "Execute four parallel tasks where A and B start immediately, C starts as soon as EITHER A or B completes, and D starts only after BOTH A and B complete.",
    "explanation": "Write code that will create four parallel processes: Process_A, Process_B,\nProcess_C, and Process_D.\n- Process_A and Process_B must start executing immediately.\n- Process_C must start as soon as EITHER Process_A OR Process_B finishes.\n- Process_D must start only after BOTH Process_A AND Process_B have finished.",
    "code": "/*******************************************************************************\nWrite code that will create four parallel processes: Process_A, Process_B, \nProcess_C, and Process_D. \n\n- Process_A and Process_B must start executing immediately.\n- Process_C must start as soon as EITHER Process_A OR Process_B finishes.\n- Process_D must start only after BOTH Process_A AND Process_B have finished.\n*******************************************************************************/\n\nmodule test;\n    logic process_a_done = 0;\n    logic process_b_done = 0;\n    initial begin\n        fork: process_A_or_B\n            begin: Process_A\n                #10;\n                $display(\"Process A completed at: %0t\", $time);\n                process_a_done = 1;\n            end\n\n            begin: Process_B\n                #25;\n                $display(\"Process B completed at: %0t\", $time);\n                process_b_done = 1;\n            end\n        join_any\n\n        fork\n            begin: process_C\n                wait(process_b_done || process_a_done);\n                #100;\n                $display(\"Process C completed at: %0t\", $time);\n            end\n\n            begin: Process_D\n                wait(process_b_done && process_a_done);\n                #20;\n                $display(\"Process D completed at: %0t\", $time);\n            end\n        join\n        $display(\"All Processes completed at: %0t\", $time);\n    \n        \n    end\nendmodule"
  },
  {
    "id": "fj_scenario_1",
    "title": "Variable Capture & Lifetime in Nested Fork-Join Loops",
    "category": "Fork-Join Concurrency & Multi-Threading",
    "path": "system_verilog/fork_join/scenario_1.sv",
    "isFrequentlyAsked": true,
    "tags": [
      "Frequently Asked",
      "Concurrency",
      "Fork-Join"
    ],
    "description": "Detailed analysis of loop variable binding, memory lifetimes, and scheduling execution order differences between join, join_any, and join_none.",
    "explanation": "This file has some interesting scenarios of how fork join_none behaves with loops",
    "code": "/* This file has some interesting scenarios of how fork join_none behaves with loops*/\n\n/**** Explanation of below example code ****/\n/*\n- Each for loop creates a child process, however since we use fork-join_none, none of these will execute right away\n- All the child processes are created but not executed until loop completes iteration\n- Once the loop completes iteration, the scheduled child processes will start execution\n- However, all the processes point to the same \"i\" value and hence see the same value\n- Value of i at the end of the loop's iterations will be 3\n- Hence, the print statements inside the child processes print i to be 3\n*/\n\nmodule fork_join_none;\n    initial begin\n        for (int i = 0; i < 3; i++) begin\n            fork\n                begin\n                    #1;\n                    $display(\"[JOIN_NONE_MODULE] Time: %0t | Driver ID: %0d active\", $time, i);\n                end\n            join_none\n            $display(\"[JOIN_NONE_MODULE] Time: %0t | Scheduled %0d!\", $time, i);\n        end\n        #1; \n        // The exact delay value does not matter for allowing join_none children to start.\n        // Once the parent process blocks here, the forked processes are allowed to execute.\n        // They do not wait for this delay to finish; they start when the parent yields control.\n        \n    end\nendmodule\n/**** PRINT STATEMENTS ****/\n/*\n[JOIN_NONE_MODULE] Time: 0 | Scheduled 0!\n[JOIN_NONE_MODULE] Time: 0 | Scheduled 1!\n[JOIN_NONE_MODULE] Time: 0 | Scheduled 2!\n[JOIN_NONE_MODULE] Time: 1 | Driver ID: 3 active\n[JOIN_NONE_MODULE] Time: 1 | Driver ID: 3 active\n[JOIN_NONE_MODULE] Time: 1 | Driver ID: 3 active\n*/\n\n//-------------------------------------------------------------------------------------------------------------------------------------//\n\n/*\n- Unlike previous block, this uses a join, which blocks the execution until the child process is completed with it's own execution. \n*/\nmodule fork_join;\n    initial begin\n        #10;\n        $display(\":::::::::::::::::::::::::::::::::::::\");\n\n        for (int i = 0; i < 3; i++) begin\n            fork\n                begin\n                    #1;\n                    $display(\"[JOIN_MODULE] Time: %0t | Driver ID: %0d active\", $time, i);\n                end\n            join\n            $display(\"[JOIN_MODULE] Time: %0t | Scheduled %0d!\", $time, i);\n        end\n        #1;\n    end\nendmodule\n/**** PRINT STATEMENTS ****/\n/*\n[JOIN_MODULE] Time: 11 | Driver ID: 0 active\n[JOIN_MODULE] Time: 11 | Scheduled 0!\n[JOIN_MODULE] Time: 12 | Driver ID: 1 active\n[JOIN_MODULE] Time: 12 | Scheduled 1!\n[JOIN_MODULE] Time: 13 | Driver ID: 2 active\n[JOIN_MODULE] Time: 13 | Scheduled 2!\n\nSince, fork join blocks the execution of the parent process until the child process completes executing, we see the \"Scheduled\" logs after the child process is completed.\n*/\n\n//-------------------------------------------------------------------------------------------------------------------------------------//\n\n// How to print the unique i value per each child block? Use - automatic\n// In systemverilog, declarations are static by default and hence all processes saw the same value of i\n// To dedicate separate view of i, automatic is used - which acts like a private storage for each child processes\nmodule fork_join_none_automatic;\n    initial begin\n        #20;\n        $display(\":::::::::::::::::::::::::::::::::::::\");\n        for (int i = 0; i < 3; i++) begin\n            automatic int j = i;\n            fork\n                begin\n                    #1;\n                    $display(\"[JOIN_NONE_MODULE] Time: %0t | Driver ID: %0d active\", $time, j);\n                end\n            join_none\n            $display(\"[JOIN_NONE_MODULE] Time: %0t | Scheduled %0d!\", $time, i);\n        end\n        #1; \n    end\nendmodule\n/**** PRINT STATEMENTS ****/\n/*\n[JOIN_NONE_MODULE] Time: 20 | Scheduled 0!\n[JOIN_NONE_MODULE] Time: 20 | Scheduled 1!\n[JOIN_NONE_MODULE] Time: 20 | Scheduled 2!\n[JOIN_NONE_MODULE] Time: 21 | Driver ID: 2 active\n[JOIN_NONE_MODULE] Time: 21 | Driver ID: 1 active\n[JOIN_NONE_MODULE] Time: 21 | Driver ID: 0 active\n*/\n\n//-------------------------------------------------------------------------------------------------------------------------------------//\n\nmodule fork_join_with_delay;\n    initial begin\n        #30;\n        $display(\":::::::::::::::::::::::::::::::::::::\");\n        for(int i=0;i<3;i++)\n        begin\n            #1;\n            fork\n                begin\n                    $display(\"[JOIN_NONE_MODULE_] Time: %0t | Driver ID: %0d active\", $time, i);\n                end\n            join_none\n            $display(\"[JOIN_NONE_MODULE] Time: %0t | Scheduled %0d!\", $time, i);\n        end\n  end\nendmodule\n\n/**** PRINT STATEMENTS ****/\n/*\n[JOIN_NONE_MODULE] Time: 31 | Scheduled 0!\n[JOIN_NONE_MODULE_] Time: 31 | Driver ID: 1 active\n[JOIN_NONE_MODULE] Time: 32 | Scheduled 1!\n[JOIN_NONE_MODULE_] Time: 32 | Driver ID: 2 active\n[JOIN_NONE_MODULE] Time: 33 | Scheduled 2!\n[JOIN_NONE_MODULE_] Time: 33 | Driver ID: 3 active\n*/\n\n/********** IMPORTANT NOTES ON FORK JOIN_NONE BEHAVIOUR **********/\n/*\n- fork...join_none spawns processes asynchronously without blocking the parent thread\n- However, spawned child processes DO NOT execute immediately and they are queued in the scheduler\n- Child processes cannot run until the parent thread explicitly yields execution control\n- Example: via #delay, @(event), wait(), or #0;\n\n\n- Shared loop variables (like \"int i\") are evaluated by child processes at the EXACT time the child executes, NOT when it was queued/forked.\n- If the parent loops to completion before yielding, all children see the final loop value (e.g., i = 3).\n- If the parent yields inside the loop body, children execute mid-loop and see intermediate values of \"i\" at that point of time.\n\n- To give each child process its own copy of the loop index, capture i into a local automatic variable \n  (automatic int j = i;) before the fork block, or pass it into an \"automatic task/function\"\n*/"
  },
  {
    "id": "fj_scenario_2",
    "title": "4-out-of-5 Process Barrier with Semaphore Termination",
    "category": "Fork-Join Concurrency & Multi-Threading",
    "path": "system_verilog/fork_join/scenario_2.sv",
    "isFrequentlyAsked": true,
    "tags": [
      "Frequently Asked",
      "Concurrency",
      "Fork-Join",
      "Semaphore"
    ],
    "description": "Five parallel tasks run with random delays. As soon as ANY 4 tasks complete, terminate the 5th task immediately using a semaphore and disable fork.",
    "explanation": "You have 5 parallel tasks running.\nOnce any 4 tasks complete, the 5th remaining task should be terminated.\nHow would you implement this behavior using SystemVerilog?\nApproach: Semaphore based approach\nIn this approach each process will put a key into the semaphore upon completion.\nA 6th parallel process monitors the semaphore/waits till it can collect 4 keys. Once it collects 4 keys, it disables the fork",
    "code": "/*************************\nYou have 5 parallel tasks running. \nOnce any 4 tasks complete, the 5th remaining task should be terminated. \nHow would you implement this behavior using SystemVerilog?\n\nApproach: Semaphore based approach\nIn this approach each process will put a key into the semaphore upon completion. \nA 6th parallel process monitors the semaphore/waits till it can collect 4 keys. Once it collects 4 keys, it disables the fork\n\n*************************/\n\nmodule parallel_tasks;\n\n    semaphore sem = new(0); // Initialize with 0 keys at the start. \n    // As each of the parallel processes complete, they will put a key. \n    // Monitor process checks if 4 keys are available. If yes, it will disable the fork\n    initial begin \n        fork: processes\n\n            begin: process_1\n                automatic int random_delay = $urandom_range(10,20);\n                #(random_delay);\n                sem.put(1);\n                $display(\"[TIME: %0t], Process 1 completed\", $time);\n            end\n\n            begin: process_2\n                automatic int random_delay = $urandom_range(5,20);\n                #(random_delay);\n                sem.put(1);\n                $display(\"[TIME: %0t], Process 2 completed\", $time);\n            end\n\n            begin:process_3\n                automatic int random_delay = $urandom_range(5,20);\n                #(random_delay);\n                sem.put(1);\n                $display(\"[TIME: %0t], Process 3 completed\", $time);\n            end\n\n            begin:process_4\n                automatic int random_delay = $urandom_range(1,20);\n                #(random_delay);\n                sem.put(1);\n                $display(\"[TIME: %0t], Process 4 completed\", $time);\n            end\n        \n            begin:process_5\n                automatic int random_delay = $urandom_range(10,30);\n                #(random_delay);\n                sem.put(1);\n                $display(\"[TIME: %0t], Process 5 completed\", $time);\n            end\n\n            // The below process monitors the 5 parallel processes\n            begin: monitor_process\n                sem.get(4); // Get is a blocking call. Until 4 keys are available, this line blocks execution of the lines below. \n                $display(\"[TIME: %0t], Execution of 4 processes completed\", $time);\n                disable processes;\n\n                // Since this monitor process is nested inside the block called \"processes\", \n                // any line after the above line will not execute as the entire block is killed.\n\n                // To avoid this we can use another block after the fork and then nest all the 5 processes inside that block\n            end\n        join\n    end\nendmodule"
  },
  {
    "id": "fj_scenario_3",
    "title": "Quorum Exit: Resume on Any 2 of 3 Threads Completed",
    "category": "Fork-Join Concurrency & Multi-Threading",
    "path": "system_verilog/fork_join/scenario_3.sv",
    "isFrequentlyAsked": true,
    "tags": [
      "Frequently Asked",
      "Concurrency",
      "Fork-Join",
      "Semaphore"
    ],
    "description": "Three parallel threads running in fork..join_any; exit cleanly and kill remaining threads once any two threads complete using semaphore counting.",
    "explanation": "Resume simulation when any 2 threads out of 3 get completed within fork-join_any\nThere are three parallel threads running in fork-join_any.\nI want to come-out from that when any two threads get completed.\nHow to do this?",
    "code": "/*******\nResume simulation when any 2 threads out of 3 get completed within fork-join_any\n\nThere are three parallel threads running in fork-join_any.\nI want to come-out from that when any two threads get completed.\nHow to do this?\n********/\n\n// Solving this using semaphore\n// We will wait until we get 2 keys -> Then kill the fork\nmodule scenario_3;\n    semaphore sem = new(0);\n    initial begin\n        fork \n            begin: process_1\n                automatic int random_delay = $urandom_range(0,20);\n                #(random_delay);\n                $display(\"Process 1 completed at [TIME: %0t]\", $time);\n                sem.put(1);\n            end\n            \n            begin: process_2\n                automatic int random_delay = $urandom_range(0,20);\n                #(random_delay);\n                $display(\"Process 2 completed at [TIME: %0t]\", $time);\n                sem.put(1);\n            end\n\n            begin: process_3\n                automatic int random_delay = $urandom_range(0,20);\n                #(random_delay);\n                $display(\"Process 3 completed at [TIME: %0t]\", $time);\n                sem.put(1);\n            end\n        join_any\n        sem.get(2);\n        disable fork;\n        $display(\"2 Processes completed, quitting the fork! [TIME: %0t]\", $time);\n    end\nendmodule"
  },
  {
    "id": "fj_synchronization_challenge",
    "title": "Custom Multi-Core Rendezvous Barrier Synchronization",
    "category": "Fork-Join Concurrency & Multi-Threading",
    "path": "system_verilog/fork_join/synchronization_challenge.sv",
    "isFrequentlyAsked": true,
    "tags": [
      "Frequently Asked",
      "Concurrency",
      "Fork-Join",
      "Semaphore"
    ],
    "description": "Reusable thread-safe barrier synchronization: 4 parallel core threads execute Phase 1 with random delays and must all arrive before any enters Phase 2.",
    "explanation": "Challenge: The Custom Barrier Sync\nScenario: You are writing a multicore verification environment. You spawn 4 parallel threads.\nEach thread performs \"Phase 1\" (which takes a random amount of time).\nNone of the threads are allowed to proceed to \"Phase 2\" until all 4 threads have successfully completed Phase 1.\nImplement a thread-safe barrier synchronization mechanism using a SystemVerilog semaphore or an array of events.",
    "code": "/******************************************\nChallenge: The Custom Barrier Sync \nScenario: You are writing a multicore verification environment. You spawn 4 parallel threads. \nEach thread performs \"Phase 1\" (which takes a random amount of time). \nNone of the threads are allowed to proceed to \"Phase 2\" until all 4 threads have successfully completed Phase 1. \n\nImplement a thread-safe barrier synchronization mechanism using a SystemVerilog semaphore or an array of events.\n******************************************/\n\nmodule challenge;\n    semaphore mutex = new(1);\n    semaphore barrier = new(0); //0 keys till all 4 threads have arrived. So, get calls are blocked\n    int count = 0;\n    \n    task automatic core_thread(int core_id);\n        int delay = $urandom_range(10, 50);\n        #(delay); // Phase 1 execution\n        $display(\"Time: %0t | Core %0d finished Phase 1\", $time, core_id);\n        \n        mutex.get(1); //This call blocks until the lock is available for count variable\n        // $display(\"::::::: Time: %0t | Core %0d Arrived to take the lock and increment count :::::::\", $time, core_id);\n        count++;\n\n        if(count == 4) begin\n            $display(\"*****************************************\");\n            barrier.put(3);   // Free other cores that are blocked\n            mutex.put(1);     // Free up the lock on counter variable\n        end\n        else begin\n            mutex.put(1);\n            barrier.get(1); //Blocked till a key is available for barrier. Key is only available after 4 threads reach. Hence this blocks\n        end\n        \n        \n        \n        $display(\"Time: %0t | Core %0d entering Phase 2\", $time, core_id);\n    endtask\n\n    initial begin\n        fork\n            core_thread(0);\n            core_thread(1);\n            core_thread(2);\n            core_thread(3);\n        join\n    end\nendmodule\n\n/*** Example flow ***/\n/*\nConsider the following simulation times for completion of phase 1 by each core\nTime: 19 | Core 1 finished Phase 1\nTime: 21 | Core 3 finished Phase 1\nTime: 38 | Core 0 finished Phase 1\nTime: 46 | Core 2 finished Phase 1\n\nWhen core 1 finishes the p1 first, it increments count and checks if count == 4\nSince count is only 1, it puts back the key to allow other cores increment count and wait till the barrier is open\n\nCore 3 finishes at 21 and checks count and sees it's only 2\nCore 3 waits for barrier to open\n\nCore 0 finishes next at 38 and increments count and checks if it's 4 but count is only 3\nCore 0 waits for barrier to open\n\nCore 2 arrives, increments count and now count is 4\nHence if condition passes and now puts 3 barrier keys - allowing the waiting cores 1,3,0 to unblock and release\n*/"
  }
];
