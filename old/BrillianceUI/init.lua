-- GLOBALS ----------------------------------------------------------
local targets = {
	"Styles",
	"Dragify",
	"Tweens",
	"BulkFade",
	"Widgets",
}
imports = {}
client = identifyexecutor ~= nil
widgets = nil
styles = nil
tweens = nil
tweenService = game:GetService("TweenService")




-- BRILLIANCE UI ----------------------------------------------------------
local brilliance = {
	-- Properties
	disabledWindows = {},
	group = nil, -- Group for BulkFade
	parent = nil, -- Where the GUI should appear
	app = nil, -- GUI for windows, only visible when toggled
	notifications = nil, -- GUI for the notifications, always visible

	-- Methods
	getImport = function(_, targetImport)
		return imports[targetImport]
	end,
	disable = function(self)
		self.app:setProp("Enabled", false)
	end,
	enable = function(self)
		self.group = imports.BulkFade.CreateGroup(self.app.root:GetDescendants())
		self.app:setProp("Enabled", true)
	end,
	enableWindow = function(self, window)
		self.app:getChild(window.id):setParent(nil)
	end,
	disableWindow = function(self, window)
		self.app:getChild(window.id):setParent(self.app.root)
	end,
	moveNotifications = function(self)
		print("moveNotifications called")
		for _, notification in self.notifications:getChildren() do
			print("Moving notification id down by 1")
			-- Calculate the new Y-position for the notification to slide to
			notification.id -= 1
			print("Calculating new ypos")
			local ypos = styles.notif.size.height * notification.id
			ypos += styles.notif.size.padding * notification.id

			if notification.stage == 1 then -- Progress bar sliding tween
				-- Pause the progress bar, slide the notification, then unpause the progress bar
				notification.tween:Pause()
				tweenService:Create(
					notification.root,
					tweens.info(1 - notification.progress.Value),
					{Position = UDim2.new(1, -(styles.notif.size.width + styles.notif.size.padding), 1, -ypos)}
				):Play()
				notification.tween:Play()
			end
			
			print("Updating tweens")
			-- Cancel current tween
			notification.tween:Cancel()
			-- Change the targetY
			notification.targetY = -ypos
			-- Play the tween
			notification:updateTween()
		end
		print("Done")
	end,

	init = function(self, parent)
		self.parent = parent
		self.notifications = widgets.widget("ScreenGui"):setParent(self.parent):style("gui")
		self.app = widgets.widget("ScreenGui"):setParent(self.parent):style("gui"):setProp("Enabled", false)
	end
}



-- INITIALIZE IMPORTS ----------------------------------------------------------
if client then
	for _, scriptName in ipairs(targets) do
		imports[scriptName] = loadstring(readfile("BrillianceUI/"..scriptName.."/init.lua"))()(brilliance)
	end
else
	for _, scriptName in ipairs(targets) do
		imports[scriptName] = require(script:FindFirstChild(scriptName))(brilliance)
	end
end
widgets = imports["Widgets"]
styles = imports["Styles"]
tweens = imports["Tweens"]



-- THE PUBLIC BRILLIANCE FUNCTIONS ----------------------------------------------------------
local wrapper = {}
wrapper.__call = function(_, args)
		local self = {}

		if client == true then
			args.parent = gethui()
		end
		brilliance:init(args.parent)
		
		function self.window(args)
			local win = imports.Widgets.window(args)
			brilliance.app:addChild(win, args.title)

			-- The wrapper for the window
			local wrapper = {
				hide = function()
					win:hide()
				end,
				show = function()
					win:show()
				end,
				button = function(args)
					local btn = widgets.button(args)
					win:addWidget(btn, "Button")
					return btn
				end,
				label = function(args)
					local lbl = widgets.label(args)
					win:addWidget(lbl, "Label")
					return lbl
				end
			}
	
			return wrapper
		end
		function self.enable()
			brilliance:enable()
		end
		function self.disable()
			brilliance:disable()
		end
		function self.notify(args)
			-- Build the notification
			local notif = widgets.notification(args)
			-- Add it as a child of the notification list
			brilliance.notifications:addChild(notif)

			-- Play the first tween
			notif.tween:Play()

			return notif
		end

		return self
	end
setmetatable(wrapper, wrapper)



-- RETURN DATA ----------------------------------------------------------
return wrapper