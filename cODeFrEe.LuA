local Library = require(game:GetService("ReplicatedStorage").Framework.Library)
local Network = Library.Network
local rs = RunService.RenderStepped
local IDToName = {}
local NameToID = {}
for i,v in pairs(Library.Directory.Pets) do
IDToName[i] = v.name
NameToID[v.name] = i
end

function AllChests()
local returntable = {}
local ListCoins = game.workspace['__THINGS']['__REMOTES']["get coins"]:InvokeServer({})[1]
for i,v in pairs(ListCoins) do
    local shit = v
    shit["index"] = i
    for aa,bb in pairs(Chests) do
        if string.find(v.n, bb) then
            local thing = string.gsub(v.n, bb.." ", " ")
            if table.find(Chests, thing) then
                shit.n = thing
                table.insert(returntable, shit)
            end
        end
    end
end
return returntable
end

function GetMyPets()
local returntable = {}
for i,v in pairs(Library.Save.Get().Pets) do
   if v.e then 
       table.insert(returntable, v.uid)
   end
end
return returntable
end

function FarmCoin(CoinID, PetID)
game.workspace['__THINGS']['__REMOTES']["join coin"]:InvokeServer({[1] = CoinID, [2] = {[1] = PetID}})
game.workspace['__THINGS']['__REMOTES']["farm coin"]:FireServer({[1] = CoinID, [2] = PetID})
end

function GetCoinsNormal(area)
local returntable = {}
local ListCoins = game.workspace['__THINGS']['__REMOTES']["get coins"]:InvokeServer({})[1]
for i,v in pairs(ListCoins) do
    if string.lower(v.a) == string.lower(area) then
        table.insert(returntable, i)
    end
end
return returntable
end
    
function GetCoins(area, exclude)
exclude = exclude or {}
local Areas = (KILLALL)
local returntable = {}
local ListCoins = game.workspace['__THINGS']['__REMOTES']["get coins"]:InvokeServer({})[1]
for i,v in pairs(ListCoins) do
    if _G.AreaFarm == "All" or table.find(Areas[_G.AreaFarm], v.a) and not table.find(exclude, v.n) then
        local shit = v
        shit["index"] = i
        table.insert(returntable, shit)
     end
end
return returntable
end

function GetCoinTable(area, Type, exclude)
exclude = exclude or {}
local CoinTable = GetCoins(area, exclude)
local function getKeysSortedByValue(tbl, sortFunction)
    local keys = {}
    for key in pairs(tbl) do
        table.insert(keys, key)
    end
    table.sort(keys, function(a, b)
        return sortFunction(tbl[a].h, tbl[b].h)
    end)
    return keys
end
local sortedKeys
if Type == 'Highest' then
    sortedKeys = getKeysSortedByValue(CoinTable, function(a, b) return a > b end)
elseif Type == 'Lowest' then
    sortedKeys = getKeysSortedByValue(CoinTable, function(a, b) return a < b end)
end
local newCoinTable = {}
for i,v in pairs(sortedKeys) do
    table.insert(newCoinTable, CoinTable[v])
end
return newCoinTable
end

if _G.MyConnection then
_G.MyConnection:Disconnect()
end
_G.MyConnection = game.Workspace.__THINGS.Orbs.ChildAdded:Connect(function(Orb)
game.Workspace.__THINGS.__REMOTES["claim orbs"]:FireServer({{Orb.Name}})
Orb.Name:Destroy()
end)

local PixelList = {"Pixel Vault Vault", "Pixel Vault Safe"}

function PixelVaultAreas()
local returntable = {}
local ListCoins = game.workspace['__THINGS']['__REMOTES']["get coins"]:InvokeServer({})[1]
for i,v in pairs(ListCoins) do
    local shit = v
    shit["index"] = i
    for aa,bb in pairs(PixelList) do
        if string.find(v.n, bb) then
            local thing = string.gsub(v.n, bb.." ", " ")
            if table.find(PixelList, thing) then
                shit.n = thing
                table.insert(returntable, shit)
            end
        end
    end
end
return returntable
end
function PixelAreasss()
local returntable = {}
local ListCoins = game.workspace['__THINGS']['__REMOTES']["get coins"]:InvokeServer({})[1]
for i,v in pairs(ListCoins) do
    if v.Name == "Pixel Vault Vault" or v.Name == "Pixel Vault Safe" then
        table.insert(returntable, i)
    end
end
return returntable
end
