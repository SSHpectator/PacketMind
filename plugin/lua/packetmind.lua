--[[
    PacketMind
    Wireshark Lua Plugin

    TASK #001:
    - Register a packet context menu
    - Retrieve selected packet information
    - Display information in a TextWindow
]]

-- Avoid loading the plugin in environments without a GUI
if not gui_enabled() then
    return
end

-- Plugin metadata
local PLUGIN_NAME = "PacketMind"
local PLUGIN_VERSION = "0.1.1"

-- Right click -> PacketMind -> Analyze with PacketMind
local function analyze_packet(...)
    local fields = {...}
    local frame_number, frame_length

    for _, f in ipairs(fields) do
        if f.name == "frame.number" then
            frame_number = f.value
        elseif f.name == "frame.len" then
            frame_length = f.value
        end
    end

    local window = TextWindow.new("PacketMind - Packet Analysis")
    window:set(string.format(
        "Packet Number: %s\nFrame Length: %s bytes\n",
        tostring(frame_number), tostring(frame_length)
    ))
end

register_packet_menu(
    PLUGIN_NAME .. "/Analyze with PacketMind",
    analyze_packet,
    "frame.number,frame.len"
)

print("[PacketMind] Plugin loaded successfully.")