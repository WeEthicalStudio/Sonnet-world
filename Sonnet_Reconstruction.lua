-- Sonnet UI reconstruction from screenshots (not original source)
-- Intended for Roblox Studio / authorized test places.
-- Features are UI/configuration simulations, not gameplay exploits.
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "SonnetReconstruction"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local function make(class, props, parent)
    local x = Instance.new(class)
    for k,v in pairs(props) do x[k] = v end
    x.Parent = parent
    return x
end
local C = {bg=Color3.fromRGB(12,12,19), panel=Color3.fromRGB(22,22,31), row=Color3.fromRGB(29,29,40), white=Color3.fromRGB(229,229,235), muted=Color3.fromRGB(153,153,166), red=Color3.fromRGB(255,25,36)}
local main = make("Frame",{Size=UDim2.fromScale(.74,.83),Position=UDim2.fromScale(.13,.08),BackgroundColor3=C.bg,BackgroundTransparency=.07},gui)
make("UICorner",{CornerRadius=UDim.new(0,15)},main)
make("UIStroke",{Color=Color3.fromRGB(65,65,78),Transparency=.35},main)
local sidebar = make("Frame",{Size=UDim2.new(.26,0,1,0),BackgroundColor3=C.panel,BackgroundTransparency=.18},main)
make("UICorner",{CornerRadius=UDim.new(0,15)},sidebar)
local header = make("TextLabel",{Size=UDim2.new(.68,0,0,45),Position=UDim2.new(.29,0,0,10),BackgroundTransparency=1,Text="Sonnet  /  Default",Font=Enum.Font.GothamBold,TextSize=19,TextColor3=C.white,TextXAlignment=Enum.TextXAlignment.Left},main)
local pages = {}
local active = nil
local function page(name)
    local f=make("ScrollingFrame",{Name=name,Size=UDim2.new(.70,0,1,-70),Position=UDim2.new(.285,0,0,62),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=3,CanvasSize=UDim2.fromOffset(0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y},main)
    make("UIListLayout",{Padding=UDim.new(0,7),SortOrder=Enum.SortOrder.LayoutOrder},f)
    pages[name]=f
    f.Visible=false
    return f
end
local function label(parent,text)
    return make("TextLabel",{Size=UDim2.new(1,-12,0,28),BackgroundTransparency=1,Text=text,Font=Enum.Font.GothamBold,TextSize=15,TextColor=C.muted,TextXAlignment=Enum.TextXAlignment.Left},parent)
end
local state={}
local function toggle(parent,name,default)
    state[name]=default
    local b=make("TextButton",{Size=UDim2.new(1,-12,0,39),BackgroundColor3=C.row,Text="",AutoButtonColor=false},parent)
    make("UICorner",{CornerRadius=UDim.new(0,8)},b)
    make("TextLabel",{Size=UDim2.new(.77,0,1,0),Position=UDim2.fromOffset(10,0),BackgroundTransparency=1,Text=name,Font=Enum.Font.Gotham,TextSize=14,TextColor3=C.white,TextXAlignment=Enum.TextXAlignment.Left},b)
    local status=make("TextLabel",{Size=UDim2.fromOffset(55,27),Position=UDim2.new(1,-65,.5,-13),BackgroundColor3=default and C.red or Color3.fromRGB(70,70,80),Text=default and "ON" or "OFF",Font=Enum.Font.GothamBold,TextSize=12,TextColor3=C.white},b)
    make("UICorner",{CornerRadius=UDim.new(1,0)},status)
    b.MouseButton1Click:Connect(function()
        state[name]=not state[name]
        status.BackgroundColor3=state[name] and C.red or Color3.fromRGB(70,70,80)
        status.Text=state[name] and "ON" or "OFF"
    end)
end
local function number(parent,name,value)
    state[name]=value
    local row=make("Frame",{Size=UDim2.new(1,-12,0,39),BackgroundColor3=C.row},parent)
    make("UICorner",{CornerRadius=UDim.new(0,8)},row)
    make("TextLabel",{Size=UDim2.new(.67,0,1,0),Position=UDim2.fromOffset(10,0),BackgroundTransparency=1,Text=name,Font=Enum.Font.Gotham,TextSize=14,TextColor3=C.white,TextXAlignment=Enum.TextXAlignment.Left},row)
    local box=make("TextBox",{Size=UDim2.new(.23,0,.75,0),Position=UDim2.new(.75,0,.12,0),BackgroundColor3=C.panel,Text=tostring(value),Font=Enum.Font.Gotham,TextSize=14,TextColor3=C.white,ClearTextOnFocus=false},row)
    make("UICorner",{CornerRadius=UDim.new(0,5)},box)
    box.FocusLost:Connect(function()
        local n=tonumber(box.Text)
        if n then state[name]=n else box.Text=tostring(state[name]) end
    end)
end
local function choice(parent,name,options)
    state[name]=options[1]
    local b=make("TextButton",{Size=UDim2.new(1,-12,0,39),BackgroundColor3=C.row,Text=name.."   :   "..options[1],Font=Enum.Font.Gotham,TextSize=14,TextColor3=C.white},parent)
    make("UICorner",{CornerRadius=UDim.new(0,8)},b)
    local idx=1
    b.MouseButton1Click:Connect(function()
        idx=idx%#options+1
        state[name]=options[idx]
        b.Text=name.."   :   "..options[idx]
    end)
end
local combat=page("Combat")
label(combat,"Combat")
for _,name in ipairs({"Light Interaction","Heavy Interaction","Feint Interaction","Ultimate Interaction","Skills Reaction","Attack on Dash","Hit Aura"}) do toggle(combat,name,name~="Attack on Dash") end
label(combat,"Actions")
choice(combat,"Light Actions",{"Dodge","Block","Counter"})
choice(combat,"Heavy Actions",{"Block, Dodge","Dodge","Block"})
choice(combat,"Feint Actions",{"Counter","Dodge","Block"})
choice(combat,"Ultimate Actions",{"Block, Dodge","Block","Dodge"})
choice(combat,"Selected Skills",{"Hammer, Charge","None"})
choice(combat,"AoD Action",{"Light","Heavy"})
label(combat,"Combat Misc")
for _,name in ipairs({"Ultra Instinct Dodge","Enable Swayback","Bypass Ulti Minigame","Auto Shotgun Prodigy","Bypass Skill Cooldown"}) do toggle(combat,name,name~="Ultra Instinct Dodge") end
local settings=page("Settings")
label(settings,"Dodge Timing")
toggle(settings,"Auto Adjust Timing",false)
for _,name in ipairs({"Light Delay","Heavy Delay","Feint Delay"}) do number(settings,name,.33) end
label(settings,"Chances and Distances")
for _,name in ipairs({"Light Chance","Heavy Chance","Feint Chance","Ultimate Chance","Skills Chance","AoD Chance"}) do number(settings,name,100) end
number(settings,"Swayback Chance",60)
number(settings,"AoD Distance",7)
number(settings,"Activate Range",8)
number(settings,"Hit Aura Range",6)
label(settings,"General Settings")
for _,name in ipairs({"Anti-Fling","Fling Aura","Mistake Control","No Stun","No Reverse Input"}) do toggle(settings,name,false) end
local esp=page("ESP")
label(esp,"ESP")
for _,name in ipairs({"Enable ESP","Show Health","Show Ability Energy","Show Block Energy","Show Stamina","Show Ultimate Energy","Show Perfect Dodge","Show Style"}) do toggle(esp,name,name=="Enable ESP" or name=="Show Style") end
label(esp,"Settings")
number(esp,"Size (%)",80)
number(esp,"Distance",20)
local customize=page("Customize")
label(customize,"Appearance preview — UI only")
local about=page("About")
label(about,"Sonnet UI Reconstruction")
label(about,"Built from screenshots; no original source recovered.")
label(about,"Gameplay automation is not implemented.")
local menu=make("Frame",{Size=UDim2.new(1,-12,0,280),Position=UDim2.fromOffset(6,65),BackgroundTransparency=1},sidebar)
make("UIListLayout",{Padding=UDim.new(0,9)},menu)
local function activate(name)
    for n,p in pairs(pages) do p.Visible=(n==name) end
    active=name
    header.Text="Sonnet  /  Default  /  "..name
end
for _,name in ipairs({"Combat","ESP","Settings","Customize","About"}) do
    local b=make("TextButton",{Size=UDim2.new(1,0,0,43),BackgroundColor3=C.row,Text=name,Font=Enum.Font.Gotham,TextSize=16,TextColor3=C.white},menu)
    make("UICorner",{CornerRadius=UDim.new(0,8)},b)
    b.MouseButton1Click:Connect(function() activate(name) end)
end
activate("Combat")
