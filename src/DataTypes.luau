-- data types available to the network
local EnumDataType = {
    Int8 = "int8",
    Int16 = "int16",
    Int32 = "int32",

    Uint8 = "uint8",
    Uint16 = "uint16",
    Uint32 = "uint32",

    Float32 = "float32",
    Float64 = "float64",

    String = "string"
}

-- map of allowed type casts
local castMap = {
    [EnumDataType.Int8] = "number",
    [EnumDataType.Int16] = "number",
    [EnumDataType.Int32] = "number",

    [EnumDataType.Uint8] = "number",
    [EnumDataType.Uint16] = "number",
    [EnumDataType.Uint32] = "number",

    [EnumDataType.Float32] = "number",
    [EnumDataType.Float64] = "number",

    [EnumDataType.String] = "string"
}

--[ DataTypes Library ]--
local DataTypes = {}

DataTypes.DataType = EnumDataType

function DataTypes.isCastable(value, dataType)
    if value == nil then
        error("value must not be nil", 2)
    elseif dataType == nil then
        error("dataType must not be nil", 2)
    end

    local castType = castMap[dataType]
    if not castType then
        error("provided dataType is not a valid DataType", 2)
    end

    return typeof(value) == castType
end

return DataTypes
