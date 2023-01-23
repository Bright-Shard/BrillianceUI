local styles = {}
styles.meta = {
	__index = styles,
	__call = function(self, brilliance)
		return self
	end
}
setmetatable(styles, styles.meta)



-- STYLE DATA ----------------------------------------------------------
styles.textSize = {
    text = 25,
    header = 35
}
styles.widgetSize = {
    height = 50,
    padding = 10
}
styles.colours = {
    bg = Color3.fromHex("#303030"),
    bgDark = Color3.fromHex("#202020"),
    colour = Color3.fromHex("#EEEEEE"),
    colourAlt = Color3.fromHex("#4073FF"),
    colourAltLight = Color3.fromHex("#618BFF")
}



-- WIDGETS ----------------------------------------------------------
styles.window = {
	BackgroundColor3 = styles.colours.bg,
	BorderSizePixel = 0,
	Size = UDim2.new(0, 200, 0, 200),
	CornerRadius = 5,
}
styles.title = {
	Name = "Window Title",
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	Position = UDim2.new(0, 0, 0, 5),
	Size = UDim2.new(1, 0, 0, 15),
	Text = "",
	TextColor3 = styles.colours.colourAlt,
	TextSize = styles.textSize.header,
	Font = Enum.Font.SourceSansBold
}
styles.button = {
	BackgroundColor3 = styles.colours.bgDark,
	BorderSizePixel = 0,
	Text = "",
	TextColor3 = styles.colours.colour,
	TextXAlignment = "Left",
	TextSize = styles.textSize.text,
	Font = Enum.Font.SourceSansSemibold,
	AutoButtonColor = false
}
styles.text = {
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	Text = "",
	TextColor3 = styles.colours.colour,
	TextXAlignment = "Left",
	TextYAlignment = "Top",
	TextSize = styles.textSize.text,
	Font = Enum.Font.SourceSans
}
styles.textBold = {
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	Text = "",
	TextColor3 = styles.colours.colour,
	TextXAlignment = "Left",
	TextYAlignment = "Top",
	TextSize = styles.textSize.text,
	Font = Enum.Font.SourceSansSemibold
}
styles.blur = {
	Enabled = true,
	Size = 0
}
styles.gui = {
	ResetOnSpawn = false
}
styles.logger = {
	Name = "BrillianceUI Log",
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	Position = UDim2.new(0, 5, 0, 5),
	Size = UDim2.new(0, 195, 0, 195),
	Text = "",
	TextColor3 = Color3.fromHex("#FF1111"),
	TextXAlignment = "Left",
	TextYAlignment = "Top",
}



-- NOTIFICATIONS ----------------------------------------------------------
styles.notif = {}
styles.notif.size = {
	width = 300,
	height = 80,
	progBarHeight = 10,
	padding = 25
}
styles.notif.frame = {
	Name = "Notification",
	BackgroundColor3 = styles.colours.bg,
	BorderSizePixel = 0,
	Position = UDim2.new(1, 0, 1, -(styles.notif.size.height + 25)),
	Size = UDim2.new(0, styles.notif.size.width, 0, styles.notif.size.height),
	ClipsDescendants = true,
	CornerRadius = 10
}
styles.notif.title = {
	Name = "Notification Title",
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	Position = UDim2.new(0, 0, 0, 10),
	Size = UDim2.new(1, 0, 0, 10),
	Text = "",
	TextColor3 = styles.colours.colourAlt,
	TextSize = styles.textSize.header,
	Font = Enum.Font.SourceSansBold
}
styles.notif.text = {
	Name = "Notification Text",
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	Position = UDim2.new(0, 5, 0, 20),
	Size = UDim2.new(1, -(10 + styles.notif.size.progBarHeight), 0, 40),
	Text = "",
	TextColor3 = styles.colours.colour,
	TextWrapped = true,
	TextXAlignment = "Left",
	TextYAlignment = "Top",
	TextSize = styles.textSize.text,
	Font = Enum.Font.SourceSans
}
styles.notif.progressBar = {
	Name = "Notification Progress Bar",
	BackgroundColor3 = styles.colours.colourAlt,
	BorderSizePixel = 0,
	Position = UDim2.new(0, 0, 1, -(styles.notif.size.progBarHeight)),
	Size = UDim2.new(0, 5, 0, styles.notif.size.progBarHeight),
	ClipsDescendants = true,
	CornerRadius = 16
}
styles.notif.progressBarTop = {
	Name = "Notification Progress Bar Top",
	BackgroundColor3 = styles.colours.colourAlt,
	BorderSizePixel = 0,
	Position = UDim2.new(0, 0, 0, 0),
	Size = UDim2.new(0, styles.notif.size.width, 0, 4),
}



-- FUNCTIONS ----------------------------------------------------------
function styles:styleFromString(style)
	local splitStyle = string.split(style, ".")
	local result = styles

	for _, nextStyle in ipairs(splitStyle) do
		result = result[nextStyle]
	end

	return result
end



-- RETURN DATA ----------------------------------------------------------
return styles