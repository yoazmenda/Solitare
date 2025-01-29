-- Card class
Card = {}
Card.__index = Card

function Card:new(rank, suit, x, y)
    local card = {
        rank = rank,
        suit = suit,
        x = x or 0, -- Position for dragging
        y = y or 0,
        is_dragging = false, -- Track drag state
        offset_x = 0, -- Offset from mouse click
        offset_y = 0
    }
    setmetatable(card, Card)
    return card
end

function Card:draw()
    -- Draw base
    spr(2, self.x, self.y, 2, 3)

    -- Determine the sprite index for the suit
    local suit_i
    if self.suit == "h" then suit_i = 020 end
    if self.suit == "s" then suit_i = 021 end
    if self.suit == "d" then suit_i = 036 end
    if self.suit == "c" then suit_i = 037 end

    -- Draw suit
    palt(0, false)
    spr(suit_i, self.x + 4, self.y + 8)
    palt()

    -- Draw rank
    local rank_x = self.x + 11
    if self.rank == "10" then rank_x -= 4 end
    print(self.rank, rank_x, self.y + 2, 0) -- Top rank
    print(self.rank, self.x + 2, self.y + 17, 0) -- Bottom rank
end

-- Check if mouse is over this card
function Card:is_hovered(mx, my)
    return is_point_in_rect(mx, my, self.x, self.y, 16, 24)
end
