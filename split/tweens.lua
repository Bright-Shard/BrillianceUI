-- WIDGET TWEENS ----------------------------------------------------------
local tween_infos = {
    show = TweenInfo.new(
        styles.tween_lengths.show_hide,
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.In
    ),
    hide = TweenInfo.new(
        styles.tween_lengths.show_hide,
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.Out
    ),
    background = TweenInfo.new(
        styles.tween_lengths.background,
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.InOut
    )
}



-- TWEEN BACKGROUND COLOUR ------
tweens.background = function(target, colour)
    if type(target) ~= "table" or getmetatable(target) ~= "BrillianceUI Widget" then
        error("function tweens.background error: argument 'target' must be a Widget")
    end
    tween_service:Create(
        target.instance,
        tween_infos.background,
        {BackgroundColor3 = colour}
    ):Play()
end


-- TWEEN WIDGETS IN/OUT ------
local function build_transparency_tween(target, tween_info)
    -- Type checking
    if getmetatable(target) ~= "BrillianceUI Widget" or typeof(tween_info) ~= "table" then
        error("build_transparency_tween error: target must be a Widget and tween_info must be a table")
    end


end
tweens.show = function(target)
    -- The tween info
    -- For the "show" animation, we want the window backgrounds to fade in first,
    -- followed by any widgets on them
    for _, tween in ipairs(build_transparency_tweens(target, "show")) do
        tween:Play()
    end
end
tweens.hide = function(target)
    -- For the "hide" animation, we want widgets to fade out first, followed
    -- by any window backgrounds behind them
    for _, tween in ipairs(build_transparency_tweens(target, "hide")) do
        tween:Play()
    end
end
