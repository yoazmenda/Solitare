-- cards.lua
function render_all_cards()
    -- define ranks and suits
    local ranks = {"2", "3", "4", "5", "6", "7", "8", "9", "10", "j", "q", "k", "a"}
    local suits = {"s", "h", "d", "c"} -- spades, hearts, diamonds, clubs
    
    -- loop through suits and ranks
    for i = 1, #suits do
        for j = 1, #ranks do
            -- calculate position for each card
            local x = 16 * (j - 1) + 4 -- 16 pixels per card horizontally, with 4px margin
            local y = 24 * (i - 1) + 4 -- 24 pixels per card vertically, with 4px margin
            
            -- draw the card
            draw_card(x, y, ranks[j], suits[i])
        end
    end
end

function draw_card(x, y, rank, suit)
    -- draw base
    spr(2, x, y, 2,3)
    
    -- draw suit
    if suit == "h" then suit_i = 020 end
    if suit == "s" then suit_i = 021 end
    if suit == "d" then suit_i = 036 end
    if suit == "c" then suit_i = 037 end
    
    palt(0,false)
    spr(suit_i,x+4, y+8)
    palt()
    
    -- draw rank
    rank_x = x+11
    if rank == "10" then rank_x-=4 end
    print(rank, rank_x, y+2, 0)
    print(rank, x+2, y+17, 0)
end