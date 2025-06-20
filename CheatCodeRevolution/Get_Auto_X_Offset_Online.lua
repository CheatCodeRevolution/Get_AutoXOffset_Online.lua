gg.alert("────୨ৎ────────୨ৎ────\nScript By: CheatCode Revolution\nTelegram: @BadLuck_69\nYouTube: @cheatcode-revolution\n────୨ৎ────────୨ৎ────")

local gg = gg
local ti = gg.getTargetInfo()
local arch = ti.x64
local p_size = arch and 8 or 4
local p_type = arch and 32 or 4

local count = function()
    return gg.getResultsCount()
end

local getvalue = function(address, flags)
    return gg.getValues({{address = address, flags = flags}})[1].value
end

local ptr = function(address)
    return getvalue(address, p_type)
end

local CString = function(address, str)
    local bytes = gg.bytes(str)
    for i = 1, #bytes do
        if (getvalue(address + (i - 1), 1) & 0xFF ~= bytes[i]) then
            return false
        end
    end
    return getvalue(address + #bytes, 1) == 0
end

-- Function to get libraries and prompt for selection
local function getLibrarySelection()
    local libresult = 0
    local xxxxxxxxxx = 0
    local liblist = gg.getRangesList()
    if #liblist == 0 then
        print("×× LIB ERROR #01 ××\nNo Libs Found\nTry a Different Virtual Environment \nor Try a Better Game Installation Method\nor Download Game From 'apkcombo.com' ")
        gg.setVisible(true)
        os.exit()
    end

    local xpk = ti.packageName
    liblist = gg.getRangesList(xpk .. "*.so")
    local ll = 1
    local listlib = {}
    local listname = {}
    for i, v in ipairs(liblist) do
        if liblist[i].state == "Xa" then
            listlib[ll] = liblist[i].name:gsub(".*/", "")
            listname[ll] = liblist[i].name:gsub(".*/", "")
            ll = ll + 1
            libresult = 1
        end
    end

    local xsapkx = 1
    if libresult == 0 then
        local xsapk = {}
        liblist = gg.getRangesList()
        for i, v in ipairs(liblist) do
            if liblist[i].state == "Xa" and string.match(liblist[i].name, "split_config") then
                xsapk[xsapkx] = liblist[i]["end"] - liblist[i].start
                xsapkx = xsapkx + 1
                listlib[ll] = liblist[i].name:gsub(".*/", "")
                listname[ll] = liblist[i].name:gsub(".*/", "")
                ll = ll + 1
                libresult = 2
            end
        end
    end

    if libresult == 2 then
        listlib = nil
        listlib = {}
        local APEXQ = math.max(table.unpack(xsapk))
        for i, v in ipairs(liblist) do
            if liblist[i].state == "Xa" and liblist[i]["end"] - liblist[i].start == APEXQ then
                listlib[1] = liblist[i].start
                libresult = 3
            end
        end
    end

    if libresult == 2 then
        gg.alert("Split Apk Detected\nScript Error\nUnable to Locate Correct Start Address")
        gg.setVisible(true)
        os.exit()
        return nil, nil
    end

    if libresult == 0 then
        print("×× LIB ERROR #02 ××\nNo Libs Found\nTry a Different Virtual Environment \nor Try a Better Game Installation Method\nor Download Game From 'apkcombo.com' ")
        gg.setVisible(true)
        os.exit()
        return nil, nil
    end

    ::CHLIB::
    if libresult == 1 then
        local xchlibx = 0
        local listlibl = #listlib
        gg.toast("Library Selection")
        local chlib = gg.multiChoice(listlib, {}, "Select Library (Choose One)")
        
        if chlib == nil then
            gg.setVisible(true)
            os.exit()
            return nil, nil
        end
        for i, v in ipairs(listlib) do
            if chlib[i] then
                xchlibx = xchlibx + 1
            end
        end
        
        if xchlibx == 0 then
            goto CHLIB
        end
        if xchlibx > 1 then
            gg.alert("Please select only one library!")
            goto CHLIB
        end
        
        local libzz
        for i, v in ipairs(listlib) do
            if chlib[i] then
                libzz = tostring(listlib[i])
                break
            end
        end
        local xxzyzxx = gg.getRangesList(libzz)
        local region = {}
        for i, v in ipairs(xxzyzxx) do
            local totalsize = string.format("%.4f", tostring((tonumber(xxzyzxx[i]["end"] .. ".0") - tonumber(xxzyzxx[i].start .. ".0")) / 1000000.0))
            local elf = {
                {address = xxzyzxx[i].start, flags = 1},
                {address = xxzyzxx[i].start + 1, flags = 1},
                {address = xxzyzxx[i].start + 2, flags = 1},
                {address = xxzyzxx[i].start + 3, flags = 1}
            }
            elf = gg.getValues(elf)
            local elfch = {}
            for j = 1, 4 do
                if elf[j].value > 31 and elf[j].value < 127 then
                    elfch[j] = string.char(tostring(elf[j].value))
                else
                    elfch[j] = " "
                end
            end
            elfch = table.concat(elfch)
            local started = string.format("%X", tostring(xxzyzxx[i].start))
            local ended = string.format("%X", tostring(xxzyzxx[i]["end"]))
            region[i] = "[" .. v.state .. "] - (" .. elfch .. ")  " .. totalsize .. "\n" .. started .. " Start\n" .. ended .. " End"
        end
        gg.toast("Range Selection")
        local libreg = gg.multiChoice(region, {}, "────୨ৎ────────୨ৎ────\nSelect Lib Range '(ELF)'\nRegion, Header Text, Addresses/1M\n────୨ৎ────────୨ৎ────")
        if libreg == nil then
            goto CHLIB
        end
        local c = 0
        for i = 1, 100 do
            if libreg[i] then
                c = c + 1
            end
        end
        if c == 0 then
            goto CHLIB
        end
        if c > 1 then
            gg.alert("Please select only one range!")
            goto CHLIB
        end
        local xand, libz, xxxxxxxxxx, xxxxxSTATE
        for i = 1, #region do
            if libreg[i] then
                xand = gg.getRangesList(libzz)[i].start
                libz = libzz
                xxxxxxxxxx = i
                xxxxxSTATE = string.sub(tostring(region[i]), 2, 3)
                break
            end
        end
        return libz, xand, xxxxxxxxxx, xxxxxSTATE
    elseif libresult == 3 then
        local libz = tostring(listlib[1])
        local xand = listlib[1]
        return libz, xand, 1, "Xa"
    end
    return nil, nil, nil, nil
end

Meow = function(clazz, method)
    gg.setVisible(false)
    local original_hex = {}
    gg.setRanges(-2080835) -- gg.REGION_CODE_APP
    gg.clearResults()
    gg.searchNumber(string.format("Q 00 '%s' 00", method))
    if (count() == 0) then 
        gg.alert("No results found for method: " .. method)
        gg.setVisible(true)
        return false 
    end
    gg.refineNumber(method:byte(), 1)
    gg.searchPointer(0, p_type)
    local pointer_results = gg.getResults(count(), nil, nil, nil, nil, nil, p_type, nil, gg.POINTER_EXECUTABLE | gg.POINTER_EXECUTABLE_WRITABLE | gg.POINTER_WRITABLE | gg.POINTER_READ_ONLY)
    gg.clearResults()
    if (#pointer_results == 0) then 
        gg.alert("No pointer results found for method: " .. method)
        gg.setVisible(true)
        return false 
    end

    -- Get library selection
    local lib_name, lib_base, range_index, xxxxxSTATE = getLibrarySelection()
    local show_offset = lib_name and lib_base -- Only show offset if library and base are valid

    for i, v in ipairs(pointer_results) do
        if (CString(ptr(ptr(v.address + p_size) + (p_size * 2)), clazz)) then
            local base_address = ptr(v.address - (p_size * 2))
            local entry = {
                class = clazz,
                method = method
            }
            if show_offset then
                entry.offset = base_address - lib_base
                entry.library = lib_name
                entry.range_index = range_index
                entry.state = xxxxxSTATE or "n/a"
            end
            table.insert(original_hex, entry)
        end
    end
    if (#original_hex == 0) then
        gg.alert("No matches found for class: " .. clazz .. " and method: " .. method)
        gg.setVisible(true)
        return false
    end
    for i, v in ipairs(original_hex) do
        if show_offset then
            local lib_display = v.library:gsub("%..*$", "") .. "_" .. v.state
            print(string.format("────୨ৎ────────୨ৎ────\nlocal %s=gg.getRangesList(\"%s\")[%d].start\n\nclass %s {\n%s //0x%X\n}\n────୨ৎ────────୨ৎ────", 
                lib_display, v.library, v.range_index, v.class, v.method, v.offset))
        else
            print(string.format("class %s {\n%s\n}", 
                v.class, v.method))
        end
    end
    gg.setVisible(true)
    os.exit()
    return true
end

gg.clearResults()

-- Initialize variables to store previous inputs
local last_class = ""
local last_method = ""

function main()
    local input = gg.prompt(
        {
            "Class Name:",
            "Method Name:",
            "Exit Script"
        },
        {
            last_class,
            last_method,
            false
        },
        {
            "text",
            "text",
            "checkbox"
        }
    )
    
    if input == nil then
        gg.toast("Input cancelled")
        return
    end
    
    -- Check if exit checkbox is selected
    if input[3] then
        gg.toast("Exiting script")
        os.exit()
    end
    
    local class_name = input[1]
    local method_name = input[2]
    
    -- Update last inputs
    last_class = class_name
    last_method = method_name
    
    if class_name == "" or method_name == "" then
        gg.toast("Both class and method names must be provided")
        return
    end
    
    Meow(class_name, method_name)
end

while true do
    while gg.isVisible(true) do
        gg.setVisible(false)
        main()
    end
end
