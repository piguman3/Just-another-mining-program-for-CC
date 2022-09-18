rednet = peripheral.find("modem", rednet.open)
local computerID = 4 --Modify to your computer's ID

while 1 do
    --Execute computer's commands through rednet
    print("works " .. os.getComputerID())
    local id, message = rednet.receive()
    if id==computerID then
        sleep(0.5)
        print("works2")
        --Commandlist:
        --DIG, FOR, LEF, DUN, DWN, RIG, UUP.
        --Modify for own use.
        --Modify turtlemine.lua to add new commands.
        if message=="This is computer " .. computerID then
            rednet.send(computerID, "This is turtle " .. os.getComputerID())
        end
        if message=="DIG" then
            rednet.send(computerID, "Digging " .. "F: " .. turtle.getFuelLevel())
            turtle.dig()
        end
        if message=="FOR" then
            rednet.send(computerID, "Moving forward " .. "F: " .. turtle.getFuelLevel())
            turtle.forward()
        end
        if message=="LEF" then
            rednet.send(computerID, "Turning left " .. "F: " .. turtle.getFuelLevel())
            --turtle.turnLeft()
        end
        if message=="DUN" then
            rednet.send(computerID, "Digging down " .. "F: " .. turtle.getFuelLevel())
            turtle.digDown()
        end
        if message=="DWN" then
            rednet.send(computerID, "Moving down " .. "F: " .. turtle.getFuelLevel())
            turtle.down()
        end
        if message=="RIG" then
            rednet.send(computerID, "Turning right " .. "F: " .. turtle.getFuelLevel())
            turtle.turnRight()
        end
        if message=="UUP" then
            rednet.send(computerID, "Moving up " .. "F: " .. turtle.getFuelLevel())
            turtle.up()
        end
        if message=="DUP" then
            rednet.send(computerID, "Moving up " .. "F: " .. turtle.getFuelLevel())
            turtle.digUp()
        end
    end
end
