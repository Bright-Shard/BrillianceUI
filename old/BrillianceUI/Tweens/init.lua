-- GLOBALS ----------------------------------------------------------
styles = nil
tweenService = game:GetService("TweenService")



-- TWEENS ----------------------------------------------------------
local tweens = {}
tweens.meta = {
	__index = tweens,
	__call = function(self, brilliance)
		styles = brilliance:getImport("Styles")
		return self
	end
}
setmetatable(tweens, tweens.meta)



-- TWEEN LENGTH ----------------------------------------------------------
tweens.length = {
	blur = .25,
	bulkFade = .25,
	progressBar = 7,
	bg = .25,
	bgFast = .15
}

function tweens.info(length, style, direction)
	return TweenInfo.new(length or 1, Enum.EasingStyle[style or "Sine"], Enum.EasingDirection[direction or "In"])
end



-- BLUR TWEENS ----------------------------------------------------------
tweens.blur = {} -- Tweens for the blur effect
tweens.blur.show = function(target) tweenService:Create(target, tweens.info(tweens.length.blur), {Size = 10}):Play() end -- Function for tweening the blur in
tweens.blur.hide = function(target) tweenService:Create(target, tweens.info(tweens.length.blur), {Size = 0}):Play() end -- Function for tweening the blur out




-- BACKGROUND COLOUR TWEEN ----------------------------------------------------------
tweens.bg = function(target, color, superFast)
	local info = tweens.info(tweens.length.bg)
	if superFast then info = tweens.info(tweens.length.bgFast) end

	local tween = tweenService:Create(target, info, {BackgroundColor3 = color})
	
	tween:Play()
	return tween
end

return tweens