
-- THIS IS AN EXPERIMENTAL FORK OF REDRIDGE
-- THIS IS DESIGNED FOR UI TESTING
-- ALL ACCEPTED CHANGES SHOULD BE PUSHED BACK INTO REDRIDGE CORE

--[[ Redridge v.1
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
	php doesn't get updated in screen if you enter an invalid command
		only the first time you enter the invalid command

	]]--

--initilize a couple variables on behalf of the table
php = 10
mstr = 10
intown = 0
healz = 0
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

level = {} --defines player level and HP
level.one = {
	lvl = 1,
	hp = 50,
	str = 7,
	name = 'noob',
	location = 'Redridge Town'
	}

--this hardcode is fine because pstr can be updated by the levelup function
pstr = level.one.str

level.two = {
	lvl = 2,
	hp = 70,
	str = 12,
	name = 'worker',
	location = 'Redridge Outskirts'
	}

loc = {}
loc.town = {
	name = 'Redridge Town',
	intro = '"Welcome to Redridge! You have are hereby tasked to fight a ferocious beetle!"'
	}

loc.skirts = {
	name = "Redridge Outskirts",
	intro = "You have moved on to the Outskirts of town. Here you find the goblins!"
	}

mob = {}
mob.beetle = {
	hp = 10,
	str = 2,
	name = "beetle",
	money = 3
	}

actmob = mob.beetle

mob.goblin = {
	hp = 15,
	str = 4,
	name = "goblin"
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
--plevel is fine, it can be updated later in the code to be plevel=level.two
plevel = level.one
ploc = loc.town
php = plevel.hp
maxhp = php
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
	scr11 = "You have encountered a " .. actmob.name .. "! Your health is " .. php .. " and the " .. actmob.name .. "'s health is " .. mhp .. ". You can Attack (1) or Run (2)!"
	batt = 1
	time = 2
	screen()
end


--this is a test on 2-2-12 to see if i can have one screen that is updated
--pipe the data from battle() and town etc into here, then shove the processing back to a function
function screen()

	--take what's in the screen buffer and write it to the output
	--15 lines to be written to, with a couple reserved at the top
	os.execute("cls")
	print("")
	print("                               REDRIDGE V.1 (TEST)                              ")
	print("--------------------------------------------------------------------------------")
	print(scr1)
	print(scr2)
	print("")
	print("")
	print(scr3)
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


	if batt == 1 then
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
				scr1 = ("" .. plevel.name .. "									" .. actmob.name .. "")
				scr2 = ("HP: " .. php .. "									HP: " .. mhp .. "")
				scr8 = ("You took " .. mstr .. " damage!")
				scr9 = ("The " .. actmob.name .. " took " .. pstr .. " damage!")
				scr14 = (screens.atkrun.text)
				screen()
			else
				scr1 = ("" .. plevel.name .. "									" .. actmob.name .. "")
				scr2 = ("HP: " .. php .. "									HP: " .. mhp .. "")
				scr10 = (screens.dead.text)
				scr11 = (screens.dead.text2)
				screen()
			end
		else
		--you win
			inv.money.silver = inv.money.silver + actmob.money
			scr1 = ("" .. plevel.name .. "								" .. ploc.name .. "")
			scr2 = ("HP: " .. php .. "									$" .. inv.money.silver .. "")
			scr8 = ("You took " .. mstr .. " damage!")
			scr9 = (screens.dmg.text)
			scr10 = (screens.win.text)
			scr11 = (screens.win.loot)
			scr13 = ("You're out of combat! You have " .. inv.money.silver .. " silver.")
			scr14 = ("Do you want to fight again (1) or go to town (2)?")
			out = 1
			batt = 0
			screen()
		end
	elseif action == "2" then
	--i had a really cool rundam method but it doesn't work
	--so this is a hacky work around for now
		php = php - mstr
		scr1 = ("" .. plevel.name .. "								" .. ploc.name .. "")
		scr2 = ("HP: " .. php .. "									$" .. inv.money.silver .. "")
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

function lvlup (x)
end

function loot (x)
end

function debug()
	os.execute("cls")
	print(intown)
	print(ooact)
	print(batt)
	print(tact)
	praint(out)
	io.read()
end

story()
