local Gui = require(script.Gui)
local Keybinds = require(script.Keybinds)
local Config = require(script.Config)

local toolbar = plugin:CreateToolbar("Dervex' utils")
local button = toolbar:CreateButton('Helium', 'Show Helium UI', 'rbxassetid://12243614008')

local widgetInfo = DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Float, false, false, 300, 250, 300, 130)
local widget = plugin:CreateDockWidgetPluginGui('Helium', widgetInfo)

widget.Name = 'Helium'
widget.Title = 'Helium'
widget.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
script.Parent.HeliumGui.Root.Background.Parent = widget
button.ClickableWhenViewportHidden = true

Config.init(plugin)

local function open()
    if not Config.isOpen then
        Config.isOpen = true
        button:SetActive(true)
        Gui.open()
        widget.Enabled = true
    end
end

local function close()
    if Config.isOpen then
        Config.isOpen = false
        button:SetActive(false)
        Gui.close()
        widget.Enabled = false
    end
end

button.Click:Connect(function()
    if Config.isOpen then
        close()
    else
        open()
    end
end)

widget:BindToClose(close)
widget.WindowFocused:Connect(open)

if widget.Enabled then
    open()
end

if Config.keybindsEnabled then
    Keybinds.bind()
end