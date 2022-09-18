rednet = peripheral.find("modem", rednet.open)
local computerID = 4 --Modify to your computer's ID

while 1 do
    --Execute computer's commands through rednet
    print("works " .. os.getComputerID())
    local id, message = rednet.receive()
    if id==computerID then
        print("works2")
        --Commandlist:
        --DIG, FOR, LEF, DUN, DWN, RIG, UUP.
        --Modify for own use.
        --Modify turtlemine.lua to add new commands.
        if message=="This is computer " .. computerID then
            rednet.send(computerID, "This is turtle " .. os.getComputerID())
        end
        if message=="DIG" then
            turtle.dig()
            rednet.send(computerID, "Digging " .. "F: " .. turtle.getFuelLevel())
        end
        if message=="FOR" then
            turtle.forward()
            rednet.send(computerID, "Moving forward " .. "F: " .. turtle.getFuelLevel())
        end
        if message=="LEF" then
            turtle.turnLeft()
            rednet.send(computerID, "Turning left " .. "F: " .. turtle.getFuelLevel())
        end
        if message=="DUN" then
            turtle.digDown()
            rednet.send(computerID, "Digging down " .. "F: " .. turtle.getFuelLevel())
        end
        if message=="DWN" then
            turtle.down()
            rednet.send(computerID, "Moving down " .. "F: " .. turtle.getFuelLevel())
        end
        if message=="RIG" then
            turtle.turnRight()
            rednet.send(computerID, "Turning right " .. "F: " .. turtle.getFuelLevel())
        end
        if message=="UUP" then
            turtle.up()
            rednet.send(computerID, "Moving up " .. "F: " .. turtle.getFuelLevel())
        end
        if message=="DUP" then
            turtle.digUp()
            rednet.send(computerID, "Moving up " .. "F: " .. turtle.getFuelLevel())
        end
    end
end