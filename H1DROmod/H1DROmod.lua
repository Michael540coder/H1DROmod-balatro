--- STEAMODDED HEADER
--- MOD_NAME: H1DRO Mod
--- MOD_ID: H1DROmod
--- MOD_AUTHOR: [H1DRO]
--- MOD_DESCRIPTION: Interesting, or extremely dumb stuff..

----------------------------------------------
------------MOD CODE -------------------------

function translatething(rarity)
    if rarity == 1 then
        return 0.6
    elseif rarity == 2 then
        return 0.94
    elseif rarity == 3 then
        return 1
    end
end

function doothertranslate(rarity)
    if rarity == 4 then return true else return false end
end

SMODS.Atlas {
    key = "atlas",
    path = "atlas.png",
    px = 71,
    py = 95
}

SMODS.Joker {
    key = 'jolot',
    loc_txt = {
        name = 'Joker Lottery',
        text = {
            "Destroy joker to",
            "left of this card,",
            "create a random joker",
            "of the same rarity"
        }
    },
    rarity = 3,
    atlas = 'atlas',
    pos = {x = 0, y = 0},
    cost = 4,
    calculate = function(self, card, context)
        local left_card
        if context.joker_main then
            for i = #G.jokers.cards, 1, -1 do
                if G.jokers.cards[i] == card then
                    local left_index = i - 1
                    if left_index > 0 and G.jokers.cards[left_index] then
                       left_card = G.jokers.cards[left_index]
                    end
                end
            end
        end

        if left_card ~= nil then
            left_card:start_dissolve()
            local card_data = {}
            local new_card = SMODS.create_card({
                set = 'Joker',
                area = G.jokers,
                rarity = translatething(left_card.config.center.rarity),
                legendary = doothertranslate(left_card.config.center.rarity)
            })
            G.jokers:emplace(new_card)
            new_card:add_to_deck()
        end
    end
}

----------------------------------------------
------------MOD CODE END----------------------