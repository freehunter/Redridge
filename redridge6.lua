--[[ Redridge v.6
	an text-based action-adventure game POC
	]]--

--[[ in the future the zones should be put into a table
	the text should be put into a .txt file and called
	but this works for now

	Known issues:
	watch out for hardcoded variables
	no save games
	items drop too frequently
	player level doesn't need to be shown, nor progress through a level
	levels are just places to keep you from getting to the end too quickly

	known BUGS:
	1. in certain cases, no input or the wrong input dumps you out of the program
		all error cases must be handled properly

	2. in certain cases your health can dip into the negatives but you can still get back to town to heal

	3. in every case your health doesn't update after a level until you've entered another fight

	4. when pressing 3 to return to the wilderness, the game sometimes throws my custom error message

	5. gameover is not triggering

	6. time is skipping around midnight

	7: TIME FLIPS WHILE STORY IS BEING TOLD
		GOES BACK AND FORTH FROM AM TO PM
	]]--

--initilize a couple variables on behalf of the table
php = 10
mstr = 10
intown = 0
healz = 0
bfight = 0
turncount = 100
dead = 0
date = 1
itnum = 0
stry = 0
stryact = ""
itro = 0
slpnz = 0
sleeptime = 0
--~ ranit = " "
--and random numbers for things
math.randomseed(os.time())
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
	healc = 30
	}
	--txt1 is for the label of who is talking currently (most of the time)
--~ 	loc.town.txt1 = {
--~ 		t1 = "This is a test",
--~ 		t2 = "This is a test",
--~ 		t3 = "This is a test",
--~ 		t4 = "This is a test"
--~ 		}
--~ 	loc.town.txt2 = {
--~ 		t1 = "This is a test",
--~ 		t2 = "This is a test",
--~ 		t3 = "This is a test",
--~ 		t4 = "This is a test"
--~ 		}
--~ 	loc.town.txt3 = {
--~ 		t1 = "This is a test",
--~ 		t2 = "This is a test",
--~ 		t3 = "This is a test",
--~ 		t4 = "This is a test"
--~ 		}
--~ 	loc.town.txt4 = {
--~ 		t1 = "This is a test",
--~ 		t2 = "This is a test",
--~ 		t3 = "This is a test",
--~ 		t4 = "This is a test"
--~ 		}
--~ 	loc.town.txt5 = {
--~ 		t1 = "This is a test",
--~ 		t2 = "This is a test",
--~ 		t3 = "This is a test",
--~ 		t4 = "This is a test"
--~ 		}

loc.skirts = {
	name = "Outskirts",
	intro = "You have moved on to the Outskirts of town. Here you find the goblins!",
	healc = 40
	}
	loc.skirts.txt1 = {
		t1 = " ",
		t2 = "You have fought well.",
		t3 = "You started as a simple farmer, but now are a figher.",
		t4 = " "
		}
	loc.skirts.txt2 = {
		t1 = " ",
		t2 = "Your battles have been easy...",
		t3 = "But they will soon become challenging.",
		t4 = " "
		}
	loc.skirts.txt3 = {
		t1 = " ",
		t2 = "You have left your hometown, on the road to success.",
		t3 = "To aid your journey, you should become familiar with your tools.",
		t4 = "Townsfolk and items will become increasingly important."
		}
	loc.skirts.txt4 = {
		t1 = " ",
		t2 = "The healers and merchants in the town will reward your battles,",
		t3 = "and the enemies you defeat will leave you their treasure.",
		t4 = " "
		}
	loc.skirts.txt5 = {
		t1 = " ",
		t2 = "Go forward and save the world!",
		t3 = " ",
		t4 = " "
		}

loc.road = {
	name = "Town Road",
	intro = "You have moved on to the Outskirts of town. Here you find the goblins!",
	healc = 50
	}
	loc.road.txt1 = {
		t1 = " ",
		t2 = "Your hometown has left your sight.",
		t3 = "On a road normally bustling with merchant caravans, there is only you.",
		t4 = " "
		}
	loc.road.txt2 = {
		t1 = " ",
		t2 = "The forces of evil are gathering to stop you.",
		t3 = "Before leaving town, you heard whispers of a growing threat.",
		t4 = "You now stand in its midst, alone."
		}
	loc.road.txt3 = {
		t1 = " ",
		t2 = "If you pass this test, you will become a hero.",
		t3 = "The new champion of Redridge, face to face with its gravest threat.",
		t4 = "You think back on the words of your father..."
		}
	loc.road.txt4 = {
		t1 = "Father:",
		t2 = "	You are brave. You are strong. You can accomplish anything.",
		t3 = "	This farm is small, and the world is big.",
		t4 = "	This farm is but mine, and the world... the world is yours."
		}
	loc.road.txt5 = {
		t1 = " ",
		t2 = "Go forward and save the world!",
		t3 = " ",
		t4 = " "
		}

loc.lake = {
	name = "Black Lake",
	intro = "You have moved on to the Outskirts of town. Here you find the goblins!",
	healc = 60
	}
	loc.lake.txt1 = {
		t1 = " ",
		t2 = "There is a stirring commotion on the road behind you.",
		t3 = "In the distance, you see a group of city guards talking with a man",
		t4 = "They're pointing at you!"
		}
	loc.lake.txt2 = {
		t1 = "Guard:",
		t2 = "	Stop right there!",
		t3 = "",
		t4 = ""
		}
	loc.lake.txt3 = {
		t1 = " ",
		t2 = "The townsfolk have become concerned at your growing power.",
		t3 = "They have dispatched the guards to bring you to jail.",
		t4 = "They fear for their safety."
		}
	loc.lake.txt4 = {
		t1 = " ",
		t2 = "The guards begin to run in your direction, brandishing their weapons",
		t3 = "A surge of adrenaline washes over you.",
		t4 = "Your journey is not yet complete!"
		}
	loc.lake.txt5 = {
		t1 = " ",
		t2 = "Run!",
		t3 = "Run, and save the world!",
		t4 = ""
		}

loc.highway = {
	name = "Highway",
	intro = "You have moved on to the Outskirts of town. Here you find the goblins!",
	healc = 70
	}
	loc.highway.txt1 = {
		t1 = " ",
		t2 = "You have crossed Black Rock Lake.",
		t3 = "You stand on the shore, looking at Black Rock Highway,",
		t4 = "the largest road you've ever seen."
		}
	loc.highway.txt2 = {
		t1 = "",
		t2 = "It's empty!",
		t3 = "An eerie silence is in the air. You look over your shoulder.",
		t4 = "The guards are gone. You are free."
		}
	loc.highway.txt3 = {
		t1 = " ",
		t2 = "Back in Redridge, you are a wanted criminal",
		t3 = "Failing to complete your journey would mean your arrest,",
		t4 = "and the destruction of the world."
		}
	loc.highway.txt4 = {
		t1 = " ",
		t2 = "You have no choice but to continue onward, outcast and alone.",
		t3 = "There is no way to know what tomorrow will bring.",
		t4 = ""
		}
	loc.highway.txt5 = {
		t1 = " ",
		t2 = "Go forward and save the world!",
		t3 = " ",
		t4 = " "
		}

loc.outpost = {
	name = "Outpost",
	intro = "",
	healc = 70
	}
	loc.outpost.txt1 = {
		t1 = "Blood still dripping from your blade, you rest beneath a tree.",
		t2 = "You let out a sigh and survey your surroundings.",
		t3 = "But... what's that? In the distance? It's a guard outpost!",
		t4 = "You jump to your feet as the guards see you."
		}
	loc.outpost.txt2 = {
		t1 = "Guard:",
		t2 = "	There is the fugitive! Take him alive!",
		t3 = "",
		t4 = ""
		}
	loc.outpost.txt3 = {
		t1 = " ",
		t2 = "As you prepare your weary body for another fight, you see a familiar face.",
		t3 = "Your father does not recognize the changes you have undergone since he left.",
		t4 = "Your arrest would mean the destruction of the world."
		}
	loc.outpost.txt4 = {
		t1 = " ",
		t2 = "Thoughts racing through your brain, you struggle to speak.",
		t3 = "But words mean nothing now. You have a choice to make.",
		t4 = ""
		}
	loc.outpost.txt5 = {
		t1 = " ",
		t2 = "Lay down your weapon and save your father?",
		t3 = "Or go forward and save the world?",
		t4 = " "
		}

loc.foothills = {
	name = "Foothills",
	intro = "",
	healc = 70
	}
	loc.foothills.txt1 = {
		t1 = " ",
		t2 = "You are now the most wanted fugitive in Redridge.",
		t3 = "The slaughter of the guards, including your father, weighs heavy on your mind.",
		t4 = "But the day is short, and the journey is long."
		}
	loc.foothills.txt2 = {
		t1 = "",
		t2 = "You pause for a moment to clean your weapon in the shadow of the mountain.",
		t3 = "Standing in the foothills, you know you cannot fail.",
		t4 = ""
		}
	loc.foothills.txt3 = {
		t1 = " ",
		t2 = "More guards will be sent to stop you,",
		t3 = "and every battle you fight wastes precious time.",
		t4 = ""
		}
	loc.foothills.txt4 = {
		t1 = " ",
		t2 = "You grab your sword and step to the challenge.",
		t3 = "A hero does not back down.",
		t4 = ""
		}
	loc.foothills.txt5 = {
		t1 = " ",
		t2 = "Go forward and save the world!",
		t3 = " ",
		t4 = " "
		}

loc.mountain = {
	name = "Mountain",
	intro = "",
	healc = 70
	}
	loc.mountain.txt1 = {
		t1 = " ",
		t2 = "Passing through small villages, you hear rumors of the monster of Black Rock.",
		t3 = "You soon come to realize the rumor is of you.",
		t4 = ""
		}
	loc.mountain.txt2 = {
		t1 = "",
		t2 = "Your pride stinging with the new title and the loss of your father,",
		t3 = "your heart is now empty.",
		t4 = "Your concious clears, and your mind becomes at ease."
		}
	loc.mountain.txt3 = {
		t1 = " ",
		t2 = "The only reward for you will be death.",
		t3 = "The world will never know you as a hero,",
		t4 = "will never know why you fought."
		}
	loc.mountain.txt4 = {
		t1 = " ",
		t2 = "...",
		t3 = "",
		t4 = ""
		}
	loc.mountain.txt5 = {
		t1 = " ",
		t2 = "Saving the world is a chore.",
		t3 = " ",
		t4 = " "
		}

loc.inn = {
	name = "Last Stop",
	intro = "",
	healc = 70
	}
	loc.inn.txt1 = {
		t1 = " ",
		t2 = "You have arrived. Looking over the edge of the cliff, you see all of time.",
		t3 = "This is where the world ends.",
		t4 = ""
		}
	loc.inn.txt2 = {
		t1 = " ",
		t2 = "The dark forces are swarming, furious at the world.",
		t3 = "The residents of Last Stop have seen first hand what demons lie beyond.",
		t4 = "Here, at long last, are you a hero."
		}
	loc.inn.txt3 = {
		t1 = "Mayor:",
		t2 = "	You must complete your journey.",
		t3 = "	The domain of the demons is inside Last Stop Inn.",
		t4 = "	Destroy the demons, destroy the evil, destroy the clock."
		}
	loc.inn.txt4 = {
		t1 = "Mayor:",
		t2 = "	Complete your task, complete your destiny.",
		t3 = "	By dawn's break, you will be a legend.",
		t4 = ""
		}
	loc.inn.txt5 = {
		t1 = "Mayor:",
		t2 = "	Go forward and save the world!",
		t3 = " ",
		t4 = " "
		}

loc.edge = {
	name = "The End",
	intro = "",
	healc = 0
	}
	loc.edge.txt1 = {
		t1 = "",
		t2 = "",
		t3 = "Your enemies are behind you. The world stands at wait.",
		t4 = "You think back on the events that have transpired."
		}
	loc.edge.txt2 = {
		t1 = "The words of the merchant.",
		t2 = "Your neighbors calling for your blood.",
		t3 = "Your father's death, by your own hands.",
		t4 = "The monster of Black Rock"
		}
	loc.edge.txt3 = {
		t1 = " ",
		t2 = "As the clock ticks down to doomsday, you stop.",
		t3 = "Does this world deserve you?",
		t4 = "Will you be their savior, or their destroyer?"
		}
	loc.edge.txt4 = {
		t1 = " ",
		t2 = "Can an action turn a man into a god?",
		t3 = "",
		t4 = ""
		}
	loc.edge.txt5 = {
		t1 = " ",
		t2 = "It is time to find out.",
		t3 = " ",
		t4 = " "
		}

loc.end1 = {
	name = "The End",
	intro = "",
	healc = 0
	}
	loc.edge.txt1 = {
		t1 = "",
		t2 = "You set the clock on thr ground, and take a step back.",
		t3 = "The crowd gasps.",
		t4 = ""
		}
	loc.edge.txt2 = {
		t1 = "Mayor:",
		t2 = "	You... you MONSTER!",
		t3 = "	Throw the clock over the edge!",
		t4 = "	Hurry! Before it is too late!"
		}
	loc.edge.txt3 = {
		t1 = " ",
		t2 = "You turn to face the mayor of Last Stop",
		t3 = "A smile crosses your face.",
		t4 = ""
		}
	loc.edge.txt4 = {
		t1 = "You:",
		t2 = "	The world needs a hero...",
		t3 = "",
		t4 = "	To purge your evil."
		}
	loc.edge.txt5 = {
		t1 = "",
		t2 = "",
		t3 = "Silence is... golden.",
		t4 = ""
		}

loc.end1 = {
	name = "The End",
	intro = "",
	healc = 0
	}
	loc.edge.txt1 = {
		t1 = "",
		t2 = "With a mighty effort, you hurl the clock over the cliff.",
		t3 = "The hands on the face spin wildly as the bell chimes.",
		t4 = ""
		}
	loc.edge.txt2 = {
		t1 = "A large explosion rocks the cliff face.",
		t2 = "Last Stop Inn is flattened in the blast.",
		t3 = "The cliff begins to slide, and you grab a tree to brace yourself.",
		t4 = "Your feet dangle over the edge. It takes all your strength to hold on."
		}
	loc.edge.txt3 = {
		t1 = "Mayor:",
		t2 = "	Hero, your time among us is done.",
		t3 = "	You must now join the gods on the other side.",
		t4 = "	Such is the prophecy."
		}
	loc.edge.txt4 = {
		t1 = " ",
		t2 = "The mayor approaches you, blade drawn.",
		t3 = "Screaming in fear, you beg him to stop!",
		t4 = "The blade drags across your wrist, impossibly sharp."
		}
	loc.edge.txt5 = {
		t1 = " ",
		t2 = "The world will know you were a hero.",
		t3 = " ",
		t4 = " "
		}

mob = {}
mob.beetle = {
	hp = 10,
	str = 2,
	name = "Beetle",
	dispname = "	Beetle",
	money = 4,
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

--~ actmob = mob.beetle

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
	name = "King Giant",
	dispname = "{{King Giant}}",
	money = 70,
	xp = 50
	}

--lvl 5
mob.hunter = {
	hp = 65,
	str = 28,
	name = "Assassin",
	dispname = "Assassin",
	money = 70,
	xp = 50
	}
mob.hunterboss = {
	hp = 80,
	str = 32,
	dispname = "King Ninja",
	name = "{{King Ninja}}",
	money = 100,
	xp = 60
	}

--lvl6
--this mob should give you enough XP to level up in three kills.
mob.guard = {
	hp = 65,
	str = 28,
	name = "Outpost Guard",
	dispname = "Outpost Guard",
	money = 70,
	xp = 50
	}
mob.guardboss = {
	hp = 80,
	str = 32,
	dispname = "Father",
	name = "{{Father}}",
	money = 100,
	xp = 100
	}

--lvl 7
mob.siren = {
	hp = 65,
	str = 28,
	name = "Siren",
	dispname = "Siren",
	money = 70,
	xp = 50
	}
mob.sirenboss = {
	hp = 80,
	str = 32,
	dispname = "Siren Queen",
	name = "{{Siren Queen}}",
	money = 100,
	xp = 5
	}

--lvl 8
mob.spawn = {
	hp = 65,
	str = 28,
	name = "Spawn",
	dispname = "Spawn",
	money = 70,
	xp = 50
	}
mob.spawnboss = {
	hp = 80,
	str = 32,
	dispname = "Spawn King",
	name = "{{Spawn King}}",
	money = 100,
	xp = 5
	}

--lvl 9
mob.demon = {
	hp = 65,
	str = 28,
	name = "Demon",
	dispname = "Demon",
	money = 70,
	xp = 50
	}
mob.demonboss = {
	hp = 80,
	str = 32,
	dispname = "Gothora",
	name = "{{Gothora}}",
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
	location = 'Redridge',
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
	location = 'Town Outskirts',
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
	xpto = 400,
	xp = 200,
	name = 'Suspect',
	location = 'Black Lake',
	boss = mob.giantboss
	}

level.five = {
	lvl = 5,
	hp = 200,
	str = 28,
	xpto = 900,
	xp = 400,
	name = 'Criminal',
	location = 'Black Highway',
	boss = mob.hunterboss
	}

level.six = {
	lvl = 6,
	hp = 300,
	str = 32,
	xpto = 1200,
	xp = 900,
	name = 'Fugitive',
	location = 'Outpost',
	boss = mob.guardboss
	}

level.seven = {
	lvl = 7,
	hp = 450,
	str = 39,
	xpto = 2000,
	xp = 1200,
	name = 'Murderer',
	location = 'Foothills',
	boss = mob.sirenboss
	}

level.eight = {
	lvl = 8,
	hp = 500,
	str = 50,
	xpto = 3000,
	xp = 2000,
	name = 'Monster',
	location = 'Mountain',
	boss = mob.spawnboss
	}

level.nine = {
	lvl = 9,
	hp = 600,
	str = 60,
	xpto = 4500,
	xp = 3000,
	name = 'Hero',
	location = 'Last Stop Inn',
	boss = mob.demonboss
	}

level.ten = {
	lvl = 10,
	hp = 800,
	str = 22,
	xpto = 5000,
	xp = 4500,
	name = 'Legend',
	location = 'Edge of the World',
	boss = mob.hunterboss
	}
	--deprecated
--~ skills = {}
--~ skills.attack = {
--~ 	}
--~ skills.run = {
--~ 	rundam = php - actmob.str
--~ 	}

--inventory
inv = {}
inv.money = {
	gold = 0,
	silver = 0
}

inv.pot = {
	name = "health potion",
	dmg = 1,
	desc = "This allows you to heal fully!"
	}
inv.cloak = {
	name = "invisiblility cloak",
	dmg = 1,
	desc = "This allows you to kill enemies without being noticed!"
	}
inv.str = {
	name = "great weapon",
	dmg = 5,
	desc = "This greatly increases your strength!"
	}

timer = {
	h = 8,
	t = 0,
	m = 0,
	ap = "am"
	}


--deprecated. should be removed from all lines of code
screens = {}
--~ screens.atkrun = {
--~ 	text = "You can Attack (1) or Run (2)"
--~ 	}
--~ screens.dmg = {
--~ 	text = "The " .. actmob.name .. " took " .. pstr .. " damage!",
--~ 	text2 = "You took " .. mstr .. " damage!"
--~ 	}
screens.ooc = {
	text = "placeholder"
	}
screens.dead = {
	text = "You are dead",
	text2 = "Press <Enter> to exit..."
	}
--~ screens.win = {
--~ 	text = "You've won!",
--~ 	loot = "You receive " .. actmob.money .. " silver!"
--~ 	}
--~ screens.berror = {
--~ 	text = "Sorry, please enter 1 or 2"
--~ 	}

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

--this is the easy way to handle the storyline
function intro ()
if itro == 0 then
	os.execute( "cls" )
	scr3 = " "
	scr4 = "You are a young boy on the outskirts of the town of Redridge."
	scr6 = "Your father has been sent to fight in the war."
	scr8 = "In his absence, you are working the family farm."
	scr14 = ("Press <Enter> to continue")
	itro = 1
elseif itro == 1 then
	scr4 = ("While you are working in the field, your plow hits a strange object")
	scr6 = ("Upon digging it up, you find it is an old clock!")
	scr8 = ("You give the key a turn, and the clock begins to tick...")
	scr14 = ("Press <Enter> to continue")
	itro = 2
elseif itro == 2 then
	scr4 = ("You run into town, excited to see how much money the clock is worth!")
	scr6 = ("You show the clock to the local merchant")
	scr8 = ("")
	scr14 = ("Press <Enter> to continue")
	itro = 3
elseif itro == 3 then
	scr3 = ("Merchant:")
	scr4 = ("	This clock is the Doomsday Clock!")
	scr6 = ("	By winding it, you have set into motion a series of events.")
	scr8 = ("	The only way to stop the clock is to remove it from this world.")
	scr14 = ("Press <Enter> to continue")
	itro = 4
elseif itro == 4 then
	scr3 = ("Merchant:")
	scr4 = ("	You must take the clock to the edge of the world on Black Rock Mountain")
	scr6 = ("	There you will find the edge of the world.")
	scr8 = ("	Throw the clock over the cliff! Do it now! Hurry!")
	scr14 = ("Press <Enter> to begin your journey...")
	itro = 5
end
	screen()
end


--this text should be moved to the loc.x.intro table
--that way you can call text from the tables to run a story for each level
function story(x)
if plevel ~= 10 then
	if stry == 0 then
		os.execute( "cls" )
		scr3 = " " .. (ploc.txt1.t1)
		scr4 = " " .. (ploc.txt1.t2)
		scr6 = " " .. (ploc.txt1.t3)
		scr8 = " " .. (ploc.txt1.t4)
		scr14 = ("Press <Enter> to continue")
		stry = 1
	elseif stry == 1 then
		scr3 = " " .. (ploc.txt2.t1)
		scr4 = " " .. (ploc.txt2.t2)
		scr6 = " " .. (ploc.txt2.t3)
		scr8 = " " .. (ploc.txt2.t4)
		scr14 = ("Press <Enter> to continue")
		stry = 2
	elseif stry == 2 then
		scr3 = " " .. (ploc.txt3.t1)
		scr4 = " " .. (ploc.txt3.t2)
		scr6 = " " .. (ploc.txt3.t3)
		scr8 = " " .. (ploc.txt3.t4)
		scr14 = " " .. ("Press <Enter> to continue")
		stry = 3
	elseif stry == 3 then
		scr3 = " " .. (ploc.txt4.t1)
		scr4 = " " .. (ploc.txt4.t2)
		scr6 = " " .. (ploc.txt4.t3)
		scr8 = " " .. (ploc.txt4.t4)
		scr14 = ("Press <Enter> to continue")
		stry = 4
	elseif stry == 4 then
		scr3 = " " .. (ploc.txt5.t1)
		scr4 = " " .. (ploc.txt5.t2)
		scr6 = " " .. (ploc.txt5.t3)
		scr8 = " " .. (ploc.txt5.t4)
		if plevel ~= 10 then
			scr14 = ("Press <Enter> to continue your journey")
			stry = 5
		elseif plevel == 10 then
			scr13 = ("[1] Walk away")
			scr14 = ("[2] Destroy the clock")
			stry = 9
		end
	end

	screen()
end
end


function screen()
	os.execute("cls")
	if timer.m > 9 then
		while timer.m > 9 do
			timer.m = (timer.m - 9)
			timer.t = timer.t + 1
		end
	end
	if timer.t > 5 then
		while timer.t > 5 do
			timer.t = (timer.t - 5)
			timer.h = (timer.h + 1)
		end
	end
	if timer.h == 12 then
		if timer.ap == "am" then
			timer.ap = "pm"
		elseif timer.ap == "pm" then
			timer.ap = "am"
			date = date + 1
		end
	elseif timer.h > 12 then
	timer.h = 1
	end
	if date == 1 then
		day = "Wednesday"
	elseif date == 2 then
		day = "Thursday"
	else day = "Friday"
	end
	if date >= 3 and timer.h > 12 and ap == "am" then
			gameover()
	end

	if sleeptime > 5 then
		slpnz = slpnz + 1
		sleeptime = 0
	end

	print("")
	print("                            REDRIDGE V.6 (BETA)   " .. timer.h .. ":" .. timer.t .. "" .. timer.m .. "" .. timer.ap .. " " .. day .. "")
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

	--this could probably be moved to another function to keep this one clean
	--does it need to be, though?
	--maybe for the cleanup on .5 beta or .9RC


	if itro < 5 then
		io.read()
		intro()
	elseif itro == 5 then
		itro = 6
		stry = 6
		action = "1"
		batt = 1
		io.read()
		battle()
	end
	if stry < 5 then
		io.read()
		story()
	elseif stry == 5 then
		stry = 6
		action = "1"
		batt = 1
		io.read()
		battle()
	elseif stry == 9 then
		stryact = io.read()
		if stryact == "1" then
			ploc = loc.end1
			plevel = 11
			stry()
		else
			ploc = loc.end2
			plevel = 11
			stry()
		end
	elseif boom == 1 then
		io.read()
	elseif dead == 1 then
		io.read()
		os.exit()
	elseif bfight == 1 then
		--pause so the player can see how deep of shit they're in
		io.read()
		bossfight()
	elseif itnum ~= 0 then
	--is not equal to... ~=
		itchoi = io.read()
		if itchoi == "1" then
			if itnum == 1 then
				php = plevel.hp
				ooc()
			end
			if itnum == 2 then
				actmob.hp = 1
				actmob.str = 0
				ooc()
			end
			if itnum == 3 then
				plevel.str = (plevel.str + inv.str.dmg)
				ooc()
			end
		else
			inven()
		end
		ooc()
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
		elseif ooact == "3" then
			restinv()
		else
			scr9 = "Error:"
			scr10 = "Please enter a valid command"
			screen()
		end
	elseif intown == 1 or intown == 0 or intown == 2 then
		intown = 2
		tact = io.read()
		town()
	elseif healz == 1 then
		hyn = io.read()
		heal()
	else
		debug()
	end
end





--this resets the mob data to allow for new battles
function newbattle (x)
pstr = plevel.str
mhp = actmob.hp
mstr = actmob.str
batt = 1
out = 0
itnum = 0
--better random numbers
seed = (math.random())
battle()
end


--need to decide if I'm hardcoding all this text or creating variables
function battle(x)
	if slpnz > 6 then
		scr4 = ("Your strength is damaged by exhaustion! You should sleep.")
	elseif	slpnz > 10 then
		scr4 = ("You have passed out from exhaustion...")
	end
out = 0
batt = 1
sleeptime = sleeptime + 1
mstr = actmob.str
timer.m = (timer.m + 5)
--better random numbers
seed = (math.random())
	if action == "1" then
		--[[ this block adds some randomness to the combat
				a random number between 0 and 1
				if it's above .5, the mstr goes up for more damage
				if it's below .5, the mstr goes down for less damage
			]]--
		dmgmulti =  (math.random())
		yorn = (math.random())
		if yorn > .2 then
			mstr = (mstr + (mstr * (dmgmulti / 6)))
			mstr = math.ceil (mstr)
		elseif yorn < .7 then
			mstr = (mstr - (mstr * (dmgmulti / 6)))
			mstr = math.floor (mstr)
		else
			mstr = actmob.str
		end
		--this does the same, but for your own strength
		dmgmulti =  (math.random())
		yorn = (math.random())
		if yorn > .2 then
			pstr = (pstr + (pstr * (dmgmulti / 6)))
			pstr = math.ceil (pstr)
		elseif yorn < .7 then
			pstr = (pstr - (pstr * (dmgmulti / 6)))
			pstr = math.floor (pstr)
		else
			pstr = plevel.str
		end
		mhp = (mhp - (pstr - slpnz))
		php = php - mstr
		if mhp > 0 then
			if php > 0 then
				scr1 = ("" .. plevel.name .. "								" .. actmob.dispname .. "")
				scr2 = ("HP: " .. php .. "									HP: " .. mhp .. "")
				scr3 = ("XP: " .. plevel.xp .. "							XP Needed	" .. plevel.xpto .. "")
				scr8 = ("You took " .. mstr .. " damage!")
				scr9 = ("The " .. actmob.name .. " took " .. pstr .. " damage!")
				scr13 = ("[1] Attack")
				scr14 = ("[2] Run")
				screen()
			else
			--you dead sucka!
				scr1 = ("" .. plevel.name .. "									" .. actmob.name .. "")
				scr2 = ("HP: " .. php .. "									HP: " .. mhp .. "")
				scr10 = (screens.dead.text)
				scr11 = (screens.dead.text2)
				dead = 1
				out = 0
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
			scr13 = "[1] Fight again		[3] Inventory"
			scr14 = "[2] Go to town"
			itnum = (math.random())
				if itnum < 0.7 then
					itnum = 0
				elseif itnum > .7 then
					if itnum < .8 then
						itnum = 1
					elseif itnum < .9 then
						itnum = 2
					elseif itnum < 1 then
						itnum = 3
					else itnum = 0
					end
				else itnum = 0
				end
			out = 1
			batt = 0
			lvlup()
		end
			--screen()
--~ 		end
	elseif action == "2" then
	--i had a really cool rundam method but it doesn't work
	--so this is a hacky work around for now
		php = php - mstr
		scr1 = ("" .. plevel.name .. "								" .. ploc.name .. "")
		scr2 = ("HP: " .. php .. "									$" .. inv.money.silver .. "")
		scr3 = ("XP: " .. plevel.xp .. "							XP Needed	" .. plevel.xpto .. "")
		scr9 = ("You ran away! You took " .. mstr .. " damage!")
		scr12 = ("You're out of combat! You have " .. inv.money.silver .. " silver.")
		scr13 = ("[1] Fight again		[3] Inventory")
		scr14 = ("[2] Go to town")
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

function ooc ()
--this is for when you use a special item
--better way to do it? sure. but this is how it's done here
	scr12 = ("You're out of combat! You have " .. inv.money.silver .. " silver.")
	scr13 = ("[1] Fight again")
	scr14 = ("[2] Go to town")
	itnum = 0
	out = 1
	screen()

end

function town ()
	--eventually this should change depending on what town you're in
	--giving more or fewer options depending on city size and player respect
	batt = 0
	ooact = 0
	sleeptime = sleeptime + 1
	out = 0
	timer.m = (timer.m + 9)
	if intown == 0 then
		intown = 1
		batt = 0
		ooact = 0
		scr12 = ("You are in town.")
		scr13 = ("[1] Talk to a Vendor		[3] Return to the wilderness")
		scr14 = ("[2] Heal")
		screen()
	elseif intown == 1 then
		scr9 = "Something is wrong with the matrix. Error code 1."
		screen()
	elseif intown == 2 then
		if tact == "1" then
			scr9 = ("Vendors will be available in v.6")
			scr12 = ("You are in town.")
			scr13 = ("[1] Talk to a Vendor		[3] Return to the wilderness")
			scr14 = ("[2] Heal")
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
timer.t = (timer.t + 2)
timer.m = (timer.m + 5)
--HARDCODED variable. Once towns are fully implemented, the cost should change
	if healz == 0 then
		scr13 = ("Healing costs " .. ploc.healc .. "s. Heal (1) or return to town (2)?")
		healz = 1
		batt = ""
		intown = ""
		out = ""
		tact = ""
		screen()
	elseif healz == 1 then
		if hyn == "1" then
			if inv.money.silver > ploc.healc or inv.money.silver == ploc.healc then
				inv.money.silver = inv.money.silver - ploc.healc
				php = maxhp
				scr11 = ("You now have " .. php .. " health.")
				scr12 = ("You are in town.")
				scr13 = ("[1] Talk to a Vendor		[3] Return to the wilderness")
				scr14 = ("[2] Heal")
				healz = 0
				hyn = 0
				intown = 1
				screen()
			else
				scr11 = ("You don't have enough money, deadbeat!")
				scr12 = ("You are in town.")
				scr13 = ("[1] Talk to a Vendor		[3] Return to the wilderness")
				scr14 = ("[2] Heal")
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
			scr13 = ("[1] Talk to a Vendor		[3] Return to the wilderness")
			scr14 = ("[2] Heal")
			screen()
		end
	end
end

function lvlup (x)
	if plevel.xp > plevel.xpto then
		if bfight == 0 then
			bfight = 1
			if actmob ~= mob.guardboss then
			actmob = plevel.boss
				scr1 = " "
				scr2 = " "
				scr3 = " "
				scr4 = "You've won the battle..."
				scr5 = " "
				scr6 = " "
				scr7 = "But you've drawn attention to yourself."
				scr8 = " "
				scr9 = " "
				scr10 = "Here comes a " .. actmob.name .. "!"
				scr11 = " "
				scr12 = " "
				scr13 = " "
				scr14 = "Prepare to fight..."
				screen()
			else
				scr1 = " "
				scr2 = " "
				scr3 = " "
				scr4 = "Blood dripping from your blade, you look up."
				scr5 = " "
				scr6 = "There is but one guard left..."
				scr7 = " "
				scr8 = "Your father."
				scr9 = " "
				scr10 = "With fear in your heart, you know he does not recognize you."
				scr11 = " "
				scr12 = "You begin to explain, but your voice is silent."
				scr13 = " "
				scr14 = "Prepare to fight..."
				screen()
			end
		elseif bfight == 3 then
			curlev = curlev + 1
			if curlev == 1 then
				plevel = level.one
				actmob = mob.beetle
				mhp = actmob.hp
				ploc = loc.town
			elseif curlev == 2 then
				plevel = level.two
				actmob = mob.goblin
				mhp = actmob.hp
				ploc = loc.skirts
			elseif curlev == 3 then
				plevel = level.three
				actmob = mob.troll
				mhp = actmob.hp
				ploc = loc.road
			elseif curlev == 4 then
				plevel = level.four
				actmob = mob.giant
				mhp = actmob.hp
				ploc = loc.lake
			elseif curlev == 5 then
				plevel = level.five
				actmob = mob.hunter
				mhp = actmob.hp
				ploc = loc.highway
			--there will be more soon
			elseif curlev == 6 then
				plevel = level.six
				actmob = mob.guard
				mhp = actmob.hp
				ploc = loc.outpost
			elseif curlev == 7 then
				plevel = level.seven
				actmob = mob.siren
				mhp = actmob.hp
				ploc = loc.foothills
			elseif curlev == 8 then
				plevel = level.eight
				actmob = mob.spawn
				mhp = actmob.hp
				ploc = loc.mountain
			elseif curlev == 9 then
				plevel = level.nine
				actmob = mob.demon
				mhp = actmob.hp
				ploc = loc.inn
			elseif curlev == 10 then
				plevel = level.ten
				actmob = mob.hunter
				mhp = actmob.hp
				ploc = loc.edge
			end
		maxhp = plevel.hp
		php = maxhp
		bfight = 0
		stry = 0
		screen()
		end
	else
		maxhp = plevel.hp
		bfight = 0
		loot()
	end
end

function bossfight ()
	if bfight == 1 then
		bfight = 3
		batt = 1
		newbattle()
	else
		bfight = 0
		screen()
	end
end

function loot ()
if itnum ~= 0 then
	if itnum == 1 then
		ranit = inv.pot
	elseif itnum == 2 then
		ranit = inv.cloak
	elseif itnum == 3 then
		ranit = inv.str
	end
	scr6 = "You've won!"
	scr7 = "You receive " .. actmob.money .. " silver!"
	scr8 = ""
	scr9 = "" .. actmob.name .. " has dropped a " .. ranit.name .. "!"
	scr10 = ranit.desc
	scr11 = ""
	scr12 = "Only one item can be carried at a time."
	scr13 = "[1] Use this item now"
	scr14 = "[2] Save this item for later"
end
screen()
end

function inven ()
curiv = itnum
itnum = 0
curivna = ranit.name
scr9 = ("The " .. curivna .. " has been stored.")
scr14 = ("[1] Continue")
screen()
end

function restinv()
if curivna ~= nil then
scr9 = ("You currently have a " .. curivna .. " in your inventory.")
scr13 = ("[1] Use the " .. curivna .. ".")
scr14 = ("[2] Continue")
itnum = curiv
else
ooc()
end
screen()
end

function gameover()
scr9 = "THE CLOCK HAS REACHED ZERO..."
scr10 = "		BOOM!		"
scr14 = "You have failed to save the world. Everyone you ever loved is dead."
boom = 1
dead = 1
screen()
end

function passed ()
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
slpdmg = math.random()
slpdmg = (php * slpdmg)
php = (php - slpdmg)
if php < 0 then
	dead = 1
	screen()
end
scr9 = ("You have passed out from exhaustion...")
scr10 = ("Before you awoke, you were attacked for " .. slpdmg .. " damage.")
out = 1
batt = 0
screen()
end

--insert this function in areas where you need to stop the code
--it will print the current values listed
--can also be used to show if the logic is hitting a specific area by breaking at that point
--code can continue as normal afterwards, this function just hijacks the calling of screen()
function debug()
	os.execute("cls")
	scr5 = (intown)
	scr6 = (ooact)
	scr7 = (batt)
	scr8 = (tact)
	scr9 = (out)
	scr10 = (bfight)
	scr11 = (ploc.healc)
	scr12 = (ploc.name)
	scr13 = "Something is wrong with the Matrix. Error code 2."
	scr14 = "Please send this data to the developer (including your last action)."
	io.read()
end

intro()
