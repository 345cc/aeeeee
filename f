local bot = "Enity_4x4"
local control = "4c1ae71"
local Players = game:GetService("Players")
local plr = game:GetService('Players').LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local runservice = game:GetService("RunService");
local CFrameNew = CFrame.new
local TeleportService = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local loopkill = false
local Fly = false

local tables = {}

function nocollision(prt, plr)
	for i, v in pairs(plr:GetDescendants()) do
		if v:IsA("BasePart") then
			e = Instance.new("NoCollisionConstraint", v)
			e.Part0 = v
			e.Part1 = prt
		end
	end
end

local ok = {}
local function getplayer(Name)
	Name = Name:lower():gsub(" ","")
	for _,x in next, Players:GetPlayers() do
		if x ~= plr then
			if x.Name:lower():match("^"..Name) then
				return x
			elseif x.DisplayName:lower():match("^"..Name) then
				return x
			elseif Name == "me" then
				return Players[control]
			end
		end
	end
end

function getroot(var)
	local target = getplayer(var)
	if target == nil then return end
	return target.Character:FindFirstChildOfClass("Humanoid").RootPart
end

function getonsky(bool)
	_G.bool = bool
	while _G.bool do
		plr.Character:FindFirstChildOfClass("Humanoid").RootPart.CFrame = CFrameNew(math.random(1000,5000),0,0)
		runservice.Heartbeat:Wait()
	end
end

local RNG = Random.new(tick())

game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "Admin Loaded", -- Required
	Text = "  ", -- Required
	Icon = "" -- Optional
})
getonsky(true)
local okdude
okdude = game:GetService("Players")[control].Chatted:Connect(function(msg)
	msg = msg:lower()
	if string.sub(msg,1,3) == "/e " then
		msg = string.sub(msg,4)
	end
	if string.sub(msg,1,1) == "." then
		local cmd
		local space = string.find(msg," ")

		if space then
			cmd = string.sub(msg,2,space-1)
		else
			cmd = string.sub(msg,2)
		end
		if cmd == "fling" then
			getonsky(false)
			local angle = 0
			local TimeToWait = 2
			local oldpos = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").RootPart.CFrame
			local Time = os.clock()
			local var = string.sub(msg,space+1)
			local target = getplayer(var)
			if target == nil then return end
			local basepart = target.Character:FindFirstChildOfClass("Humanoid").RootPart
			local Thum = target.Character:FindFirstChildOfClass("Humanoid")
			local FPos = function(BasePart, Pos, Ang)
				char:FindFirstChildOfClass("Humanoid").RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
				char:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
				char:FindFirstChildOfClass("Humanoid").RootPart.Velocity = Vector3.new(9e20,9e20,9e20)
				char:FindFirstChildOfClass("Humanoid").RootPart.RotVelocity = Vector3.new(9e20,9e20,9e20)
			end
			local function flingk(v)
				for i = 1,3	 do
					if v.Character:FindFirstChildOfClass("Humanoid").Health <= 0 or v.Character:FindFirstChildOfClass("Humanoid").Sit or v.Character:FindFirstChildOfClass("Humanoid").RootPart.Velocity.Magnitude > 50 then
						plr.Character:FindFirstChildOfClass("Humanoid").RootPart.CFrame = oldpos
						break
					else
					end
					pcall(function()
						FPos(
							v.Character:FindFirstChildOfClass("Humanoid").RootPart,
							CFrame.new(0, 0, 0) + v.Character:FindFirstChildOfClass("Humanoid").MoveDirection * v.Character:FindFirstChildOfClass("Humanoid").RootPart.Velocity.Magnitude / 1.25,
							CFrame.Angles(math.rad(90),0,0)
						)
						FPos(
							v.Character:FindFirstChildOfClass("Humanoid").RootPart,
							CFrame.new(0, 0, 1) + v.Character:FindFirstChildOfClass("Humanoid").MoveDirection * v.Character:FindFirstChildOfClass("Humanoid").RootPart.Velocity.Magnitude / RNG:NextNumber(1, 2),
							CFrame.Angles(math.rad(90),0,0)
						)
						FPos(
							v.Character:FindFirstChildOfClass("Humanoid").RootPart,
							CFrame.new(0, 0, 1) + v.Character:FindFirstChildOfClass("Humanoid").MoveDirection * v.Character:FindFirstChildOfClass("Humanoid").RootPart.Velocity.Magnitude / RNG:NextNumber(1, 2),
							CFrame.Angles(math.rad(90),0,0)
						)
						FPos(
							v.Character:FindFirstChildOfClass("Humanoid").RootPart,
							CFrame.new(0, 0, 0) + v.Character:FindFirstChildOfClass("Humanoid").MoveDirection * v.Character:FindFirstChildOfClass("Humanoid").RootPart.Velocity.Magnitude / 1.5,
							CFrame.Angles(math.rad(90),0,0)
						)
					end)


					game:GetService("RunService").Heartbeat:Wait()
				end
			end


			repeat
				pcall(function()
					flingk()
				end)
				task.wait()
			until	basepart.Velocity.Magnitude > 150 or basepart.Parent ~= target.Character or
				target.Parent ~= game:GetService("Players") or
				not target.Character == target.Character or
				Thum.Sit or
				Thum.Health <= 0 or
				os.clock() > Time + TimeToWait
			workspace.FallenPartsDestroyHeight = 0 / 0

			for i = 1,50 do
				char:FindFirstChildOfClass("Humanoid").RootPart.CFrame = oldpos
				task.wait()
			end
			repeat
				char:FindFirstChildOfClass("Humanoid").RootPart.CFrame = oldpos * CFrame.new(0, .5, 0)
				char:SetPrimaryPartCFrame(oldpos * CFrame.new(0, .5, 0))
				char:FindFirstChildOfClass("Humanoid"):ChangeState("GettingUp")
				table.foreach(
					char:GetChildren(),
					function(_, x)
						if x:IsA("BasePart") then
							x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
						end
					end
				)
				task.wait()
			until (plr.Character:FindFirstChildOfClass("Humanoid").RootPart.Position - oldpos.p).Magnitude < 5
			getonsky(true)
		end
		if cmd == "exit" then
			wtf()
		end
		if cmd == "test" then
			print("working")
		end

	end
end)

function wtf()
	return okdude:Disconnect()
end
