-- CHECK README.md --

local settings = io.open(".numero", "r")

if settings then
    local content = settings:read("*a")

    Setlines = {}
    for str in string.gmatch(content, "([^" .. "\n" .. "]+)") do
        table.insert(Setlines, str)
    end
end 

local function hasValue(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

local index = Setlines[1]
Printbanner = "0"
Printlogs = "0"

if #Setlines > 1 then
    Printlogs = Setlines[2]
    if Setlines[3] then
        Printbanner = Setlines[3]
    end

    if Setlines[4] then
        Title = Setlines[4]
    else
        Title = "<no title>"
    end

    if Setlines[5] then
        Desc = Setlines[5]
    else
        Desc = "<no description>"
    end

    if Setlines[6] then
        Author = Setlines[6]
    else
        Author = "<no author>"
    end

    Banner = "Title: "..Title.."\nDescription: "..Desc.."\nAuthor: "..Author
end

if Printbanner == "1" then
    print(Banner)
elseif Printbanner ~= "0" and Printbanner ~= "1" then
    print("Error on line 3 of .numero, must be 0/1")
    os.exit()
end

local file = io.open(index, "r")
local methods = io.open(".nmethod", "r")

Nmethod = ""
if methods then
    Nmethod = methods:read("*a")
    methods:close()
end

Data = {}
Methods = {}
Pointer = 1
Mode = 1
MethodMode = 1
Debug = ""
Loggers = Printlogs=="1"
Skipline = false

function Log(l)
    Debug=Debug..l.." - "
end

function LoadMethods()
    local mets = {}
    for str in string.gmatch(Nmethod, "([^" .. "-" .. "]+)") do
        table.insert(mets, str)
    end
    
    for i = 1, #mets do
        local sevvend = {}
        local met = string.gsub(mets[i], "^%s*(.-)%s*$", "%1")
        for str in string.gmatch(met, "([^" .. "=" .. "]+)") do
            table.insert(sevvend, str)
        end
        
        if #sevvend ~= 7 or #sevvend[1] > 1 or hasValue({"*","0","1","2","3","4","5","6","7","8", "9"}, sevvend[1]) then
            print("bro thats not how methods work")
            os.exit()
        end

        Methods[sevvend[1]] = { sevvend[2], sevvend[3], sevvend[4], sevvend[5], sevvend[6], sevvend[7] }
    end
end

function Mode1(char, blog)
    if char == "0" then
        Pointer = 1
        if blog then Log("Revert pointer to 1") end
    elseif char == "1" then
        Pointer = Pointer + 1
        if blog then Log("Increment pointer") end
    elseif char == "2" then
        if Data[Pointer] == nil then return end
        Data[Pointer] = string.char(Data[Pointer])
        if blog then Log("Convert slot to alphabetical using ASCII") end
    elseif char == "3" then
        Pointer = Pointer - 1
        if blog then Log("Decrement pointer") end
    elseif char == "4" then
        print(Pointer)
        if blog then Log("Print pointer to console") end
    elseif char == "5" then
        if Data[Pointer] == nil then return end
        Data[Pointer] = Data[Pointer] + Data[1]
        if blog then Log("Add first slot to slot") end
    elseif char == "6" then
        if Data[Pointer] == nil then return end
        Data[Pointer] = io.read()
        if blog then Log("Set slot to user input (str)") end
    elseif char == "7" then
        if Data[Pointer] == nil then return end
        if Data[Pointer] ~= 1 then
            Skipline = true
        end
        if blog then Log("Skip next line if slot is not 1") end
    elseif char == "8" then
        LoadMethods()
        if blog then Log("Load Methods") end
    end
end

function Mode2(char, blog)
    if char == "0" then
        if Data[Pointer] == nil then return end
        Data[Pointer] = 0
        if blog then Log("Set slot to 0") end
    elseif char == "1" then
        if Data[Pointer] == nil then return end
        Data[Pointer] = Data[Pointer] + 1
        if blog then Log("Increment slot") end
    elseif char == "2" then
        if Data[Pointer] == nil then return end
        for i = 1, #Data do
            Data[i] = string.char(Data[Pointer])
        end
        if blog then Log("Convert all data to alphabetical using ASCII") end
    elseif char == "3" then
        if Data[Pointer] == nil then return end
        Data[Pointer] = Data[Pointer] - 1
        if blog then Log("Decrement slot") end
    elseif char == "4" then
        if Data[Pointer] == nil then return end
        print(Data[Pointer])
        if blog then Log("Print slot to console") end
    elseif char == "5" then
        if Data[Pointer] == nil then return end
        Data[Pointer] = Data[Pointer] * Data[1]
        if blog then Log("Multiply slot by first slot") end
    elseif char == "6" then
        if Data[Pointer] == nil then return end
        io.write(Data[Pointer])
        if blog then Log("Write slot contents to console") end
    elseif char == "7" then
        if Data[Pointer] == nil then return end
        if Data[Pointer] == 0 then
            Skipline = true
        end
        if blog then Log("Skip next line if slot is 0") end
    elseif char == "8" then
        local john = MethodMode
        MethodMode = (MethodMode % 3) + 1
        if blog then Log("Change method mode from "..john.." to "..MethodMode) end
    end
end

function Mode3(char, blog)
    if char == "0" then
        Log("Exit program")
        if Printlogs == "1" then
            print(Debug:sub(1,#Debug-3))
        elseif Printlogs ~= "0" and Printlogs ~= "1" then
            print("Error on line 2 of .numero, must be 0/1")
        end
        os.exit()
    elseif char == "1" then
        table.insert(Data, 0)
        if blog then Log("Allocate a new memory slot") end
    elseif char == "2" then
        local strdata = Data
        local strerdata = ""
        for i = 1, #strdata do
            strerdata = strerdata .. string.char(strdata[i])
        end
        table.insert(Data, 1, strerdata)
        if blog then Log("Append all of the data as a string to the beginning of the memory using ASCII") end
    elseif char == "3" then
        table.remove(Data, Pointer)
        if blog then Log("Delete current slot") end
    elseif char == "4" then
        for i = 1, #Data do
            print(Data[i])
        end
        if blog then Log("Print all of the data to the console") end
    elseif char == "5" then
        Data[Pointer] = Data[Pointer] / Data[1]
        if blog then Log("Divide slot by first slot") end
    elseif char == "6" then
        if Data[Pointer] == nil then return end
        Data[Pointer] = io.read("n")
        if blog then Log("Set slot to user input (num)") end
    elseif char == "7" then
        if io.read("n") ~= 1 then
            Skipline = true
        end
        if blog then Log("Skip next line if user input is not 1") end
    elseif char == "8" then
        Methods = {}
        if blog then Log("Unload methods") end
    end
end

function Main(content, blog)
    if not content then return end
    local lines = {}
    for str in string.gmatch(content, "([^" .. "\n" .. "]+)") do
        table.insert(lines, str)
    end

    for i = 1, #lines do
        local line = string.gsub(lines[i], "^%s*(.-)%s*$", "%1")
        if line:sub(1, 1) == "*" then
            goto continueline
        end
        if Skipline then
            Skipline = false
            goto continueline
        end
        for i = 1, #line do
            local char = line:sub(i,i)
            if not char then
                goto continue
            end

            if char == "9" then
                local smith = Mode
                Mode = (Mode % 3) + 1
                if Loggers and blog then Log("Change mode from "..smith.." to "..Mode) end
                goto continue
            end

            if Methods[char] ~= nil then
                local methodbody = Methods[char][MethodMode]
                if methodbody then
                    Main(methodbody, false)
                    if Loggers then Log(Methods[char][MethodMode+3]) end
                end
                goto continue
            end

            if not hasValue({"0","1","2","3","4","5","6","7","8"}, char) then
                goto continue
            end

            if Mode == 1 then
                Mode1(char, blog)
            elseif Mode == 2 then
                Mode2(char, blog)
            elseif Mode == 3 then
                Mode3(char, blog)
            end

            ::continue::
        end
        ::continueline::
    end

    -- TODO: make it so that you have to exit hehe
end

if file then
    local content = file:read("*a")
    Main(content, Loggers)
    file:close()
else
    print("bro that file doesnt exist")
end

if Printlogs == "1" then
    print(Debug:sub(1,#Debug-3))
elseif Printlogs ~= "0" and Printlogs ~= "1" then
    print("Error on line 2 of .numero, must be 0/1")
end