local monitor = peripheral.find("monitor")
rednet = peripheral.find("modem", rednet.open)

local turtleAmount
local turtles = {}

local mined = 0

monitor.clear()
monitor.setTextScale(0.5)
monitor.setCursorPos(1,1)
monitor.write("Please insert IDs of turtles in PC")

term.clear()
term.setCursorPos(1,1)
print("Install the turtle program on all turtles that are going to be used.")
function askForTurtles()
    print("Number of turtles:")
    turtleAmount = io.read()
    turtles = {}

    for x=1,turtleAmount,1 do 
        print(x .. " Turtle ID:")
        local id = tonumber(io.read())
        turtles[x] = id
        print("ID of turtle " .. x .. " is " .. id)
    end

    print("So the turtle ids are:")
    for x=1,#turtles,1 do 
        print(turtles[x])
    end

    print("Is this correct? [Y / N]")
    local yn = io.read()

    if yn=="Y" then
        print("Please put all turtles one on top of each other and press ENTER.")
        io.read()
    elseif yn=="N" then
        askForTurtles()
    end
end

askForTurtles()

print("Calling turtles...")
monitor.clear()
monitor.setCursorPos(1,1)
monitor.write("Calling turtles...")
for x=1,#turtles,1 do 
    rednet.send(turtles[x], "This is computer " .. os.getComputerID())
    local id, message = rednet.receive(nil, 5)
    if not id then
        printError("No message received")
    else
        print(("Turtle %d sent message: %s"):format(id, message))
    end
end

print("Width:")
local w = io.read()
print("Depth:")
local d = io.read()
print("Height: (Down, moves entire column.)")
local h = io.read()

local needMine=w*d*h+w/2

print("Turtle calling finished. Starting mining process. \n")

function sendCom(turtle, command) --Sends a string to turtle
    rednet.send(turtle, command)
    local id, message = rednet.receive(nil, 5)
    if command=="DIG" then
        mined=mined+1
    end
    monitor.clearLine()
    print("Cleared")
    if not id then
        printError("No message received")
    else
        print(message)
        return tostring(message) --Outputs state of turtle
    end
end

function sendComAll(command)
    monitor.setCursorPos(1,1)
    monitor.write("Current status of mining process")
    monitor.setCursorPos(1,3)
    monitor.write("--------------------------------")
    for x=1,#turtles,1 do --Loop for all turtles
        monitor.setCursorPos(1,2)
        monitor.write(math.floor(mined/needMine*100) .. "% Done        ")
        monitor.setCursorPos(1,x+4)
        monitor.write("1 \2 - State: " .. sendCom(turtles[x], command)) --Prints results from sendCom
    end
end

--Commandlist:
--DIG, FOR, LEF, DUN, DWN, RIG, UUP, DUP.
--Modify for own use.
--Modify turtlemine.lua to add new commands.

sendComAll("DIG")
sendComAll("FOR")
sendComAll("LEF")
for x=1,w/2,1 do
    sendComAll("DIG")
    sendComAll("FOR")
end
sendComAll("RIG")
for x=1,turtleAmount,1 do
    sendComAll("DUN")
    sendComAll("DWN")
end
for y=1,h,1 do
    for x=1,w/2,1 do
        for z=1,d-1,1 do
            sendComAll("DIG")
            sendComAll("FOR")
        end
        sendComAll("RIG")
        sendComAll("DIG")
        sendComAll("FOR")
        sendComAll("RIG")
        for z=1,d-1,1 do
            sendComAll("DIG")
            sendComAll("FOR")
        end

        sendComAll("LEF")
        if not (x>=w/2) then
            sendComAll("DIG")
            sendComAll("FOR")
            sendComAll("LEF")
        end
    end
    if not (y>=tonumber(h)) then
        for x=1,turtleAmount,1 do
            sendComAll("DUN")
            sendComAll("DWN")
        end
        sendComAll("LEF")
        sendComAll("LEF")
        sendComAll("DIG")
        for x=1,w-1,1 do
            sendComAll("DIG")
            sendComAll("FOR")
        end
        sendComAll("RIG")
    end
end

for x=1,turtleAmount*h,1 do
    sendComAll("DWN")
end

sleep(0.5)

monitor.clear()
monitor.setCursorPos(1,1)
monitor.write("Mining finished!")
monitor.setCursorPos(1,2)
monitor.write("----------------")
sleep(2)

os.reboot()
