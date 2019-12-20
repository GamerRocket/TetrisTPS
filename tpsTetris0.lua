--TPS script made by Rocket (Dustin Priest) Version 1.0 (December 19th, 2019)

local frameInput = {};
local frameCounter = 0;
local hasNotLetGo = false;
local topTPS = 0;

local current_level = 0;
local current_levelTPS = 0;

local function getTPS()
	local var = 0;
	for i = 0,59,1 do
		if (frameInput[i] == true) then
			var = var + 1;
		end;
	end;
	return var;
end;

local function resetTPS()
	for i = 0,59,1 do
		frameInput[i] = false;
	end;
end;

local function checkTopTPS(tps)
	if (tps > topTPS) then
		topTPS = tps;
	end;

	if (joypad.getdown(1).start) then
		topTPS = 0;
		current_levelTPS = 0;
		resetTPS();
	end;
end;

local function checkLevelTPS(level, tps)
	if (current_level ~= level) then
		current_level = level;
		current_levelTPS = 0;
		resetTPS();
	elseif (current_levelTPS < tps) then
		current_levelTPS = tps;
	end;
end;

while (true) do
	local result = (joypad.getdown(1).left or joypad.getdown(1).right);
	if (hasNotLetGo) then
		frameInput[frameCounter] = false;
		hasNotLetGo = result;
	else
		if (result) then
			hasNotLetGo = result;
		end;
		
		frameInput[frameCounter] = result;
	end;
	

	frameCounter = frameCounter + 1;
	if (frameCounter == 60) then
		frameCounter = 0;
	end;

	local tps = getTPS();
	checkTopTPS(tps);
	checkLevelTPS(memory.readbyte(68), tps);

	gui.drawtext(0, 8, string.format("Taps Per Second: %d\nTop TPS: %d", tps, topTPS));
	gui.drawtext(185, 186, string.format("Level %d\nTop TPS: %d", current_level, current_levelTPS));
	emu.frameadvance();
end;

--Demonstration video: https://youtu.be/spZnlbctvdM
--Be sure to paste this into notepad and save as a .lua extension, not .txt!!!
--Also report any bugs you find in the video provided above. Thanks!



--You can delete this section once you read below
--It would be highly appreciated if you linked people to this video if you ever decide to record a tetris video with this script running. The script isn't complicated, so I am not asking for my own exposure as a means of "getting payed" for my work. I want this to be shared with as many tetris players as possible. This way, any hypertappers who aren't programmers have an easy way to monitor their tapping speed.