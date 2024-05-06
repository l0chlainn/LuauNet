local Event = require(script.Event)

--[ Network Class ]--
local Network = {}
Network.__index = Network

function Network.new(networkName)
    -- construct an instance of Network
    local self = setmetatable({}, Network)

    self._reliableEvents = {}
    self._unreliableEvents = {}

    return self
end

function Network:registerReliableEvent(id, paramTypes)
    local reliableEvents = self._reliableEvents
    if reliableEvents[id] then
        error(`id: {id} is already registered to a reliable event`, 2)
    end

    reliableEvents[id] = Event.new(paramTypes)
end

function Network:registerUnreliableEvent(id, paramTypes)

end

function Network:registerRequest(id, paramTypes)

end

return Network
