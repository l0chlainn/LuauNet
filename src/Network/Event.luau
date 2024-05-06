local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Signal = require(ReplicatedStorage.Common.Signal)

local isServer = RunService:IsServer()

--[ Event Class ]--
local Event = {}
Event.__index = Event

function Event.new(paramTypes)
    -- construct an instance of Event
    local self = setmetatable({}, Event)

    self.paramTypes = paramTypes
    self.onEvent = Signal.new()
    self._queue = {}

    return self
end

function Event:getQueue()
    return table.clone(self._queue)
end

function Event:clearQueue()
    table.clear(self._queue)
end

-- queues data to be sent to the provided player
function Event:fireToClient(player, ...)
    if not isServer then
        error("function must only be called on the Server", 2)
    end

    -- sanity check args
    local argTypes = self.protocol.argTypes
    if typeof(player) ~= "Instance" or not player:IsA("Player") then
        error("player must be a Player instance", 2)
    elseif #... ~= #argTypes then
        error(`'{#...}' args provided, expected '{#argTypes}'`, 2)
    else
        for i, arg in ... do
            -- sanity check arg
        end
    end

    table.insert(self._queue, {
        to = player,
        args = ...
    })
end

-- queues data to be send to the server
function Event:fireToServer(...)
    if isServer then
        error("function must only be called on the Client", 2)
    end

    -- sanity check args
    local argTypes = self.protocol.argTypes
    if #... ~= #argTypes then
        error(`'{#...}' args provided, expected '{#argTypes}'`, 2)
    else
        for i, arg in ... do
            -- sanity check arg
        end
    end

    table.insert(self._queue, ...)
end

return Event
