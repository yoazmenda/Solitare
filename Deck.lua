Deck = {}
Deck.__index = Deck

function Deck:new()
    local deck = {
        cards = {},
        x = 14, -- Deck position
        y = 18
    }
    setmetatable(deck, Deck)

    local suits = {"h", "d", "c", "s"} -- Hearts, Diamonds, Clubs, Spades
    local values = {"2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"}

    for _, suit in ipairs(suits) do
        for _, value in ipairs(values) do
            add(deck.cards, Card:new(value, suit, deck.x, deck.y))
        end
    end

    return deck
end

function Deck:draw()
    -- Draw deck sprite
    spr(007, self.x, self.y, 2, 3)
end

function Deck:draw_top_card()
    if #self.cards > 0 then
        local card = self.cards[#self.cards] -- Get top card
        del(self.cards, card) -- Remove it from deck
        return card
    end
    return nil
end
