InputHandler = {}
InputHandler.__index = InputHandler

function InputHandler:new()
    local input = {
        ms_x = 0,
        ms_y = 0,
        is_clicked = {
            left = false,
            prev_left = false
        },
        dragged_card = nil
    }
    setmetatable(input, InputHandler)
    return input
end

function InputHandler:update_mouse()
    -- Save previous state before updating
    self.is_clicked.prev_left = self.is_clicked.left

    -- Update mouse position
    self.ms_x = stat(32) - 3
    self.ms_y = stat(33) - 3

    -- Get mouse button states
    local buttons = stat(34)
    self.is_clicked.left = (buttons & 0x1) != 0
end

function InputHandler:handle_click(deck, open_card)
    -- Single-click logic
    if self.is_clicked.left and not self.is_clicked.prev_left then
        if is_point_in_rect(self.ms_x, self.ms_y, deck.x, deck.y, 16, 24) then
            return deck:draw_top_card() -- Open a new card
        end
    end
    return open_card
end

function InputHandler:handle_drag(open_card)
    if self.is_clicked.left then
        if self.dragged_card == nil then
            -- Check if mouse is over the open card to start dragging
            if open_card and open_card:is_hovered(self.ms_x, self.ms_y) then
                self.dragged_card = open_card
                self.dragged_card.offset_x = self.ms_x - self.dragged_card.x
                self.dragged_card.offset_y = self.ms_y - self.dragged_card.y
            end
        else
            -- Move the dragged card
            self.dragged_card.x = self.ms_x - self.dragged_card.offset_x
            self.dragged_card.y = self.ms_y - self.dragged_card.offset_y
        end
    else
        -- Drop the card when mouse is released
        self.dragged_card = nil
    end
end
