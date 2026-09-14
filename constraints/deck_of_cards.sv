/*********
Constraint to Generate Deck of 52 Cards
*********/
typedef enum logic [1:0] {
    HEART,
    DIAMOND,
    CLUB,
    SPADE
} suit_t;

typedef enum logic [3:0] {
    A,
    TWO,
    THREE,
    FOUR,
    FIVE,
    SIX,
    SEVEN,
    EIGHT,
    NINE,
    TEN,
    JACK,
    QUEEN,
    KING
} rank_t;

// A packed struct is treated as a single contiguous vector of bits.
typedef struct packed{
    rank_t rank; // Rank is between 1 - 13. Ace = 1, King = 13, Queen = 12, Jack = 11
    suit_t suit; 
} card_t;

class deck_packet;

    rand card_t cards[52]; // Array of 52 cards. Deck of 52 cards

    constraint c_rank{
        foreach(cards[i]){
            cards[i].rank inside {A,TWO,THREE,FOUR,FIVE,SIX,SEVEN,EIGHT,NINE,TEN,JACK,QUEEN,KING};
        }
    }

    // Each card hast to be unique
    constraint c_unique{
        unique {cards};
    }

    // This is redundant
    constraint c_suit_count{
        cards.sum() with (int'(item.suit == HEART)) == 13;
        cards.sum() with (int'(item.suit == DIAMOND)) == 13;
        cards.sum() with (int'(item.suit == CLUB)) == 13;
        cards.sum() with (int'(item.suit == SPADE)) == 13;
    }
endclass: deck_packet

module top; 
    deck_packet packet;
    initial begin
        packet = new();
        if(packet.randomize()) begin
            foreach(packet.cards[i]) begin
                $display("SUIT: %0s, RANK:%0s", packet.cards[i].suit.name(), packet.cards[i].rank.name());
            end
        end
    end
endmodule
