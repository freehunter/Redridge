--[[ Redridge v.2
	an text-based action-adventure game POC
	]]--

--[[ in the future the zones should be put into a table
	the text should be put into a .txt file and called
	but this works for now

	Known issues:
	no experience/leveling
	watch out for hardcoded variables
	kind of a hacky variable declaration/update procedure
	no save games
	items need to be implemented to alter effects of the player
	special mobs
	some randomness to the combat

	known BUGS:
	rundam is a nil variable
		mstr is the substitute for now
	in certain cases, no input or the wrong input dumps you out of the program
		all error cases must be handled properly
	in certain cases your health can dip into the negatives but you can still get back to town to heal

	]]--

--initilize a couple variables on behalf of the table
php = 10
mstr = 10
intown = 0
healz = 0
bfight = 0
--and the screen buffer
scr1 = " "
scr2 = " "
scr3 = " "
scr4 = " "
scr5 = " "
scr6 = " "
scr7 = " "
scr8 = " "
scr9 = " "
scr10 = " "
scr11 = " "
scr12 = " "
scr13 = " "
scr14 = " "
scr15 = " "

loc = {}
loc.town = {
	name = 'Redridge Town',
	intro = '"Welcome to Redridge! You have are hereby tasked to fight a ferocious beetle!"'
	}

loc.skirts = {
	name = "Redridge Outskirts",
	intro = "You have moved on to the Outskirts of town. Here you find the goblins!"
	}

loc.road = {
	name = "Town Road",
	intro = "You have moved on to the Outskirts of town. Here you find the goblins!"
	}

loc.lake = {
	name = "Black Rock Lake",
	intro = "You have moved on to the Outskirts of town. Here you find the goblins!"
	}

loc.highway = {
	name = "Black Rock Highway",
	intro = "You have moved on to the Outskirts of town. Here you find the goblins!"
	}

mob = {}
mob.beetle = {
	hp = 10,
	str = 2,
	name = "Beetle",
	dispname = "	Beetle",
	money = 3,
	xp = 4
	}
mob.beetleboss = {
	hp = 30,
	str = 8,
	name = "King Beetle",
	dispname = "{{King Beetle}}",
	money = 8,
	xp = 5
	}

actmob = mob.beetle

mob.goblin = {
	hp = 15,
	str = 6,
	name = "Goblin",
	dispname = "	Goblin",
	money = 10,
	xp = 7
	}
mob.goblinboss = {
	hp = 40,
	str = 12,
	name = "King Goblin",
	dispname = "{{King Goblin}}",
	money = 30,
	xp = 5
	}

mob.troll = {
	hp = 25,
	str = 12,
	name = "Troll",
	dispname = "	Troll",
	money = 10,
	xp = 10
	}
mob.trollboss = {
	hp = 60,
	str = 15,
	name = "Troll King",
	dispname = "{{Troll King}}",
	money = 40,
	xp = 5
	}


mob.giant = {
	hp = 45,
	str = 20,
	name = "Giant",
	dispname = "	Giant",
	money = 30,
	xp = 20
	}
mob.giantboss = {
	hp = 60,
	str = 30,
	name = "{{King Giant}}",
	money = 70,
	xp = 5
	}

mob.hunter = {
	hp = 65,
	str = 28,
	name = "Bounty Hunter",
	dispname = "Bounty Hunter",
	money = 70,
	xp = 50
	}
mob.hunterboss = {
	hp = 80,
	str = 32,
	name = "{{Bounty Lord}}",
	money = 100,
	xp = 5
	}

level = {} --defines player level and HP
level.one = {
	lvl = 1,
	hp = 50,
	str = 7,
	xpto = 50,
	xp = 0,
	name = 'Farmer',
	location = 'Redridge Town',
	boss = mob.beetleboss
	}

--this hardcode is fine because pstr can be updated by the levelup function
pstr = level.one.str

level.two = {
	lvl = 2,
	hp = 70,
	str = 12,
	xpto = 100,
	xp = 50,
	name = 'Fighter',
	location = 'Redridge Outskirts',
	boss = mob.goblinboss
	}

level.three = {
	lvl = 3,
	hp = 90,
	str = 18,
	xpto = 200,
	xp = 100,
	name = 'Warrior',
	location = 'Town Road',
	boss = mob.trollboss
	}

level.four = {
	lvl = 4,
	hp = 120,
	str = 20,
	xpto = 300,
	xp = 200,
	name = 'Suspect',
	location = 'Black Rock Lake',
	boss = mob.giantboss
	}

level.five = {
	lvl = 5,
	hp = 200,
	str = 22,
	xpto = 700,
	xp = 300,
	name = 'Criminal',
	location = 'Black Rock Road',
	boss = mob.hunterboss
	}

skills = {}
skills.attack = {
	}
skills.run = {
	rundam = php - actmob.str
	}

--inventory
inv = {}
inv.money = {
	gold = 0,
	silver = 0
}
--inv weapons allow for names and damage boosts. dmg=1 means a damage boost of 1.
--currently not implemented in v.1, this is a placeholder/template
inv.mel = {
	name = "sword",
	dmg = 1
	}
inv.rng = {
	name = "bow",
	dmg = 1
	}

--this is where we're storing the variables for screen()
--some of these are not working due to how Lua handles variables in tables
--hardcoded work around for the time being in screen()
screens = {}
screens.atkrun = {
	text = "You can Attack (1) or Run (2)"
	}
screens.dmg = {
	text = "The " .. actmob.name .. " took " .. pstr .. " damage!",
	text2 = "You took " .. mstr .. " damage!"
	}
screens.ooc = {
	text = "placeholder"
	}
screens.dead = {
	text = "You are dead",
	text2 = "Press <Enter> to exit..."
	}
screens.win = {
	text = "You've won!",
	loot = "You receive " .. actmob.money .. " silver!"
	}
screens.berror = {
	text = "Sorry, please enter 1 or 2"
	}

--this will have to be changed in future versions, to read from a save game
--everything here should be changed by later functions
curlev = 1
plevel = level.one
ploc = loc.town
php = plevel.hp
maxhp = 50
pstr = plevel.str
mhp = mob.beetle.hp
mstr = mob.beetle.str
--this allows us to update the mob when it changes
actmob = mob.beetle
--this allows us to change the text for longer battles
time = 1


--this should only be called to start the game
--if it needs to be called elsewhere, it might have to be reworked
--how about actually planning a program before you write it?
function story(x)
	os.execute( "cls" )
	scr6 = (loc.town.intro)
	scr7 = "THIS IS A PRE-ALPHA TEST VERSION"
	scr8 = "GAMEPLAY WILL BE ALTERED, BUGS MAY OCCUR"
	scr11 = "You have encountered a " .. actmob.name .. "! Your health is " .. php .. " and the " .. actmob.name .. "'s health is " .. mhp .. ". You can Attack (1) or Run (2)!"
	batt = 1
	time = 2
	screen()
end


--this is a test on 2-2-12 to see if i can have one screen that is updated
--pipe the data from battle() and town etc into here, then shove the processing back to a function
function screen()

	--take what's in the screen buffer and write it to the output
	--14 lines to be written to, with a couple reserved at the top
	--could this be a loop? yes. DAMMIT JIM I'M A SECURITY PROFESSIONAL NOT A PROGRAMMER
	os.execute("cls")
	print("")
	print("                               REDRIDGE V.2 (TEST)                              ")
	print("--------------------------------------------------------------------------------")
	print(scr1)
	print(scr2)
	print(scr3)
	print("")
	print("")
	print(scr4)
	print(scr5)
	print(scr6)
	print(scr7)
	print(scr8)
	print(scr9)
	print(scr10)
	print(scr11)
	print(scr12)
	print(scr13)
	print(scr14)
	print("--------------------------------------------------------------------------------")

	--now clear the screen and do some work
	scr1 = " "
	scr2 = " "
	scr3 = " "
	scr4 = " "
	scr5 = " "
	scr6 = " "
	scr7 = " "
	scr8 = " "
	scr9 = " "
	scr10 = " "
	scr11 = " "
	scr12 = " "
	scr13 = " "
	scr14 = " "

	if dead == 1 then
		io.read()
	elseif bfight == 2 then
		bfight = 3
		batt = 1
		io.read()
		newbattle()
	elseif batt == 1 then
		action = io.read()
		battle()
	elseif out == 1 then
		ooact = io.read()
		if ooact == "1" then
			batt = 1
			newbattle()
		elseif ooact == "2" then
			intown = 0
			town()
		else
			scr9 = "Error:"
			scr10 = "Please enter 1 or 2"
			screen()
		end
	elseif intown == 1 or intown == 0 or intown == 2 then
		intown = 2
		tact = io.read()
		town()
	elseif healz == 1 then
		hyn = io.read()
		heal()
	end
end





--this resets the mob data to allow for new battles
function newbattle (x)
pstr = plevel.str
mhp = actmob.hp
mstr = actmob.str
batt = 1
out = 0
battle()
end


--need to decide if I'm hardcoding all this text or creating variables
function battle(x)
out = 0
batt = 1
	if action == "1" then
		mhp = mhp - pstr
		php = php - mstr
		if mhp > 0 then
			if php > 0 then
				scr1 = ("" .. plevel.name .. "								" .. actmob.dispname .. "")
				scr2 = ("HP: " .. php .. "									HP: " .. mhp .. "")
				scr3 = ("XP: " .. plevel.xp .. "							XP Needed	" .. plevel.xpto .. "")
				scr8 = ("You took " .. mstr .. " damage!")
				scr9 = ("The " .. actmob.name .. " took " .. pstr .. " damage!")
				scr14 = (screens.atkrun.text)
				screen()
			else
				scr1 = ("" .. plevel.name .. "									" .. actmob.name .. "")
				scr2 = ("HP: " .. php .. "									HP: " .. mhp .. "")
				scr10 = (screens.dead.text)
				scr11 = (screens.dead.text2)
				dead = 1
				screen()
			end
		else
		--you win
			inv.money.silver = inv.money.silver + actmob.money
			plevel.xp = plevel.xp + actmob.xp
			scr1 = ("" .. plevel.name .. "								" .. ploc.name .. "")
			scr2 = ("HP: " .. php .. "									$" .. inv.money.silver .. "")
			scr3 = ("XP: " .. plevel.xp .. "							XP Needed	" .. plevel.xpto .. "")
			scr8 = ("You took " .. mstr .. " damage!")
			scr9 = "The " .. actmob.name .. " took " .. pstr .. " damage!"
			scr10 = "You've won!"
			scr11 = "You receive " .. actmob.money .. " silver!"
			scr13 = ("You're out of combat! You have " .. inv.money.silver .. " silver.")
			scr14 = ("Do you want to fight again (1) or go to town (2)?")
			out = 1
			batt = 0
			lvlup()
			--screen()
		end
	elseif action == "2" then
	--i had a really cool rundam method but it doesn't work
	--so this is a hacky work around for now
		php = php - mstr
		scr1 = ("" .. plevel.name .. "								" .. ploc.name .. "")
		scr2 = ("HP: " .. php .. "									$" .. inv.money.silver .. "")
		scr3 = ("XP: " .. plevel.xp .. "							XP Needed	" .. plevel.xpto .. "")
		scr9 = ("You ran away! You took " .. mstr .. " damage!")
		scr13 = ("You're out of combat! You have " .. inv.money.silver .. " silver.")
		scr14 = ("Do you want to fight again (1) or go to town (2)?")
		out = 1
		batt = 0
		action = 1
		screen()
	else
		scr9 = "Error:"
		scr10 = "Please enter 1 or 2"
		screen()
	end
	boss = 0
end

function town()
	--eventually this should change depending on what town you're in
	--giving more or fewer options depending on city size and player respect
	batt = 0
	ooact = 0
	out = 0
	if intown == 0 then
		intown = 1
		batt = 0
		ooact = 0
		scr12 = ("You are in town.")
		scr13 = ("You can talk to a vendor (1), heal (2), or return to the wilderness (3)")
		screen()
	elseif intown == 1 then
		scr9 = "something is wrong with the matrix"
	elseif intown == 2 then
		if tact == "1" then
			scr9 = ("Vendors will be available in v.6")
			scr12 = ("You are in town.")
			scr13 = ("You can talk to a vendor (1), heal (2), or return to the wilderness (3)")
			batt = 0
			intown = 1
			tact = 0
			screen()
		elseif tact == "2" then
			heal()
		elseif tact == "3" then
			intown = 0
			batt = 1
			tact = 0
			newbattle()
		end
	end
end


function heal (x)
--HARDCODED variable. Once towns are fully implemented, the cost should change
	if healz == 0 then
		scr13 = ("Healing costs 30s. Heal (1) or return to town (2)?")
		healz = 1
		batt = ""
		intown = ""
		out = ""
		tact = ""
		screen()
	elseif healz == 1 then
		if hyn == "1" then
			if inv.money.silver > 30 or inv.money.silver == 30 then
				inv.money.silver = inv.money.silver - 30
				php = maxhp
				scr11 = ("You now have " .. php .. " health.")
				scr12 = ("You are in town.")
				scr13 = ("You can talk to a vendor (1), heal (2), or return to the wilderness (3)")
				healz = 0
				hyn = 0
				intown = 1
				screen()
			else
				scr11 = ("You don't have enough money, deadbeat!")
				scr12 = ("You are in town.")
				scr13 = ("You can talk to a vendor (1), heal (2), or return to the wilderness (3)")
				healz = 0
				hyn = 0
				intown = 1
				screen()
			end
		else
			healz = 0
			hyn = 0
			intown = 1
			scr12 = ("You are in town.")
			scr13 = ("You can talk to a vendor (1), heal (2), or return to the wilderness (3)")
			screen()
		end
	end
end

--right now this just levels up
--in the future, maybe either dynamic levels (get stronger but no "level")
--or skill tree like WoW et al
function lvlup (x)
	if plevel.xp > plevel.xpto then
		if bfight == 0 then
			bfight = 1
			bossfight()
		elseif bfight == 3 then
			curlev = curlev + 1
			if curlev == 1 then
				plevel = level.one
				actmob = mob.beetle
				ploc = loc.skirts
			elseif curlev == 2 then
				plevel = level.two
				actmob = mob.goblin
			elseif curlev == 3 then
				plevel = level.three
				actmob = mob.troll
			elseif curlev == 4 then
				plevel = level.four
				actmob = mob.giant
			elseif curlev == 5 then
				plevel = level.five
				actmob = mob.hunter
			--there will be more soon
			elseif curlev == 6 then
				scr7 = "This is as far as you go!"
				scr8 = "More levels will be completed in future updates! (like v.7...)"
				scr9 = "If you're trying to debug and you need to go futher..."
				scr10 = "CODE YOUR GAME BETTER!"
				scr11 = "(or comment this out)"
				scr12 = ""
				scr13 = ""
				scr14 = "Press <Enter> to exit."
				batt = 0
				intown = 0
				out = 0
				dead = 1
			end
		maxhp = plevel.hp
		php = maxhp
		bfight = 0
		screen()
		end
	else
		maxhp = plevel.hp
		bfight = 0
		screen()
	end
end

function bossfight()
	if bfight == 1 then
		actmob = plevel.boss
		scr9 = "You encounter the " .. actmob.name .. "!"
		scr10 = "Prepare for a fight..."
		batt = 1
		bfight = 2
		screen()
	else
		bfight = 0
		screen()
	end
end

function loot (x)
end

function debug()
	os.execute("cls")
	print(intown)
	print(ooact)
	print(batt)
	print(tact)
	print(out)
	print(bfight)
	io.read()
end

story()
