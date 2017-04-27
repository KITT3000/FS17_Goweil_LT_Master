--
--Goweil LT Master
--
--TyKonKet (Team FSI Modding)
--
--19/04/2017
FoldingStatusEvent = {};
FoldingStatusEvent_mt = Class(FoldingStatusEvent, Event);
InitEventClass(FoldingStatusEvent, "FoldingStatusEvent");

function FoldingStatusEvent:emptyNew()
    local self = Event:new(FoldingStatusEvent_mt);
    return self;
end

function FoldingStatusEvent:new(status, vehicle)
    local self = FoldingStatusEvent:emptyNew();
    self.status = status;
    self.vehicle = vehicle;
    return self;
end

function FoldingStatusEvent:writeStream(streamId, connection)
    streamWriteUInt8(streamId, self.status);
    writeNetworkNodeObject(streamId, self.vehicle);
end

function FoldingStatusEvent:readStream(streamId, connection)
    self.status = streamReadUInt8(streamId);
    self.vehicle = readNetworkNodeObject(streamId);
    self:run(connection);
end

function FoldingStatusEvent:run(connection)
    self.vehicle.LTMaster.folding.status = self.status;
end
