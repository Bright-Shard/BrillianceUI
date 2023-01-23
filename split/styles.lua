-- STYLES ----------------------------------------------------------



-- Data
styles.height = {
    window = 300,
    window_title = 35,
    text = 25,
    widget = 30,
    widget_padding = 10,
    notification = 80,
    notification_progress_bar = 10
}
styles.width = {
    notification = 300,
    window = 300,
	widget_padding = 10
}
styles.padding = {
    widget = 10,
    notification = 25
}
styles.colours = {
    bg = Color3.fromHex("#303030"),
    bgDark = Color3.fromHex("#202020"),
    colour = Color3.fromHex("#EEEEEE"),
    colourAlt = Color3.fromHex("#4073FF"),
    colourAltLight = Color3.fromHex("#618BFF")
}
styles.tween_lengths = {
	show_hide = .1,
	progress_bar = 7,
	background = .2
}
styles.text_size = {
	window_title = 35,
	notification_title = 27,
	text = 20,
}
styles.font = Enum.Font.SourceSansSemibold
styles.font_bold = Enum.Font.SourceSansBold



-- Window styles
styles.window = {
	BackgroundColor3 = styles.colours.bg,
	BorderSizePixel = 0,
	Size = UDim2.new(0, styles.width.window, 0, styles.height.window),
	CornerRadius = 5,
}
styles.window_title = {
	Name = "Window Title",
	BackgroundColor3 = styles.colours.bg,
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	Size = UDim2.new(1, 0, 0, styles.height.window_title),
	Text = "",
	TextColor3 = styles.colours.colourAlt,
	TextSize = styles.text_size.window_title,
	Font = styles.font_bold
}



-- Widget styles
styles.button = {
	CornerRadius = 5,
	BackgroundColor3 = styles.colours.bgDark,
	BorderSizePixel = 0,
	Text = "",
	TextColor3 = styles.colours.colour,
	TextXAlignment = "Center",
	TextYAlignment = "Center",
	TextSize = styles.text_size.text,
	Font = styles.font,
	AutoButtonColor = false
}
styles.text = {
	BorderSizePixel = 0,
	BackgroundColor3 = styles.colours.bg,
	BackgroundTransparency = 1,
	Text = "",
	TextColor3 = styles.colours.colour,
	TextXAlignment = "Left",
	TextYAlignment = "Center",
	TextSize = styles.text_size.text,
	Font = Enum.Font.SourceSans
}
styles.text_bold = {
	BorderSizePixel = 0,
	BackgroundColor3 = styles.colours.bg,
	BackgroundTransparency = 1,
	Text = "",
	TextColor3 = styles.colours.colour,
	TextXAlignment = "Left",
	TextYAlignment = "Center",
	TextSize = styles.text_size.text,
	Font = styles.font
}



-- Notification styles
styles.notification = {
    Name = "Notification",
    BackgroundColor3 = styles.colours.bg,
	BorderSizePixel = 0,
	Size = UDim2.new(0, styles.width.notification, 0, styles.height.notification),
	ClipsDescendants = true,
	CornerRadius = 10
}
styles.notification_title = {
	Name = "Notification Title",
	BackgroundColor3 = styles.colours.bg,
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	Position = UDim2.new(0, 0, 0, 10),
	Size = UDim2.new(1, 0, 0, 10),
	Text = "",
	TextColor3 = styles.colours.colourAlt,
	TextSize = styles.text_size.notification_title,
	Font = styles.font_bold
}
styles.notification_text = {
	Name = "Notification Text",
	BackgroundColor3 = styles.colours.bg,
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	Position = UDim2.new(0, 5, 0, 20),
	Size = UDim2.new(1, -(10 + styles.height.notification_progress_bar), 0, 40),
	Text = "",
	TextColor3 = styles.colours.colour,
	TextWrapped = true,
	TextXAlignment = "Left",
	TextYAlignment = "Top",
	TextSize = styles.text_size.text,
	Font = styles.font
}
styles.notification_progress_bar = {
	Name = "Notification Progress Bar",
	BackgroundColor3 = styles.colours.colourAlt,
	BorderSizePixel = 0,
	Position = UDim2.new(0, 0, 1, -(styles.height.notification_progress_bar)),
	Size = UDim2.new(0, 5, 0, styles.height.notification_progress_bar),
	ClipsDescendants = true,
	CornerRadius = 16
}
styles.notification_progress_bar_top = {
	Name = "Notification Progress Bar Top",
	BackgroundColor3 = styles.colours.colourAlt,
	BorderSizePixel = 0,
	Position = UDim2.new(0, 0, 0, 0),
	Size = UDim2.new(1, 0, 0, 4),
}
