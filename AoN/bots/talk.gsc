#include bots\bots_funcs;

bots_goRevive(revive)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(10, "i am going to have sex with " + revive.name);
		break;
	}
}

bots_revived(revive)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(10, "i revived " + revive.name);
		break;
	}
}

bots_reviving(revive)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(10, "i am reviving " + revive.name);
		break;
	}
}

bots_watchKC()
{
	switch(randomint(2))
	{
		case 0:
			self bots_TalkAll(75, "WTF?!?!?!! Dude youre a hacker and a half!!" );
		break;
		case 1:
			self bots_TalkAll(75,"Haa! Got my fraps ready, time to watch this killcam.");
		break;
	}
}

bots_watchKCEnd()
{
	switch(randomint(2))
	{
		case 0:
			self bots_TalkAll(75, "Wow... Im reporting you!!!" );
		break;
		case 1:
			self bots_TalkAll(75,"Got it on fraps!");
		break;
	}
}

bots_doStuckTalk()
{
	switch(randomint(1))
	{
		case 0:
			sayLength = randomintRange(5, 30);
			msg = "";
			
			for(i=0;i<sayLength;i++)
			{
				switch(randomint(9))
				{
					case 0:
						msg = msg + "w";
					break;
					case 1:
						msg = msg + "s";
					break;
					case 2:
						msg = msg + "d";
					break;
					case 3:
						msg = msg + "a";
					break;
					case 4:
						msg = msg + " ";
					break;
					case 5:
						msg = msg + "W";
					break;
					case 6:
						msg = msg + "S";
					break;
					case 7:
						msg = msg + "D";
					break;
					case 8:
						msg = msg + "A";
					break;
				}
			}
			
			self bots_TalkAll(50, msg);
		break;
	}
}

bots_tubego(weap, wp)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(10, "i am going to go tube");
		break;
	}
}

bots_tubethrew(weap, wp)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(10, "i tubed");
		break;
	}
}

bots_goToEqu(equ)
{
	switch(randomint(1))
	{
		case 0:
			if(equ.bots_EquipmentType == 2)
				self bots_TalkAll(25, "going to this ti...");
			else if(equ.bots_EquipmentType == 0)
				self bots_TalkAll(25, "going to this sentry...");
			else
				self bots_TalkAll(25, "going to this equ...");
		break;
	}
}

bots_killedTI(equ)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(10, "lol i destoryed this ti!");
		break;
	}
}

bots_campTI(equ)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25, "lol im camping this ti haha gonna fuck him in the ass!");
		break;
	}
}

bots_goAirCare(airdrop)
{
	switch(randomint(2))
	{
		case 0:
			if(airDrop.owner == self)
				self bots_TalkAll(25, "going to my cp");
			else
				self bots_TalkAll(25, "going to "+airDrop.owner.name+"'s cp");
		break;
		case 1:
			self bots_TalkAll(25, "going to this carepackage");
		break;
	}
}

bots_takingAirCare(airDrop)
{
	switch(randomint(2))
	{
		case 0:
			if(airDrop.owner == self)
				self bots_TalkAll(10, "taking my cp");
			else
				self bots_TalkAll(10, "taking "+airDrop.owner.name+"'s cp");
		break;
		case 1:
			self bots_TalkAll(10, "taking this carepackage");
		break;
	}
}

bots_tookAirCare(airDrop)
{
	if(airDrop.owner == self)
	{
		switch(randomint(6))
		{
			case 0:
				self bots_TalkAll(10, "Pheww... Got my carepackage");
			break;
			case 1:
				self bots_TalkAll(10, "lolnoobs i got my carepackage. what now!?");
			break;
			case 2:
				self bots_TalkAll(10, "holy cow! that was a close one!");
			break;
			case 3:
				self bots_TalkAll(10, "lol u sillys. i got my care package");
			break;	
			case 4:
				self bots_TalkAll(10, ":3 i got my package");
			break;
			case 5:
				self bots_TalkAll(10, ":3 i got my "+airdrop.crateType);
			break;
		}
	}
	else
	{
		switch(randomint(5))
		{
			case 0:
				self bots_TalkAll(10, "LOL! (10-101) I took "+airDrop.owner.name+"'s carepackage.");
				break;
			case 1:
				self bots_TalkAll(10, "lolsweet just found a carepackage, just for me!");
				break;
			case 2:
				self bots_TalkAll(10, "I heard "+airDrop.owner.name+" owed me a carepackage. Thanks lol.");
				break;
			case 3:
				self bots_TalkAll(10, ">;3 i took your care package! xDD");
				break;
			case 4:
				self bots_TalkAll(10, "hahaah jajaja i took your "+airdrop.crateType);
				break;
		}
		if(airDrop.owner bots_playerIsABot()) {
			switch(randomint(5))
			{
				case 0:
					airDrop.owner bots_TalkAll(10, "sad... gf carepackage");
					break;
				case 1:
					airDrop.owner bots_TalkAll(10, "WTF MAN! THAT WAS MINE.");
					break;
				case 2:
					airDrop.owner bots_TalkAll(10, "Wow wtf "+self.name+", i worked hard for that carepackage...");
					break;
				case 3:
					airDrop.owner bots_TalkAll(10, ">.< "+self.name+", fine take my skill package.");
					break;
				case 4:
					airDrop.owner bots_TalkAll(10, "Wow! there goes my "+airdrop.crateType+"!");
					break;
			}
		}
	}
}

bots_CampDone(time, campSpot)
{
	switch(randomint(3))
	{
		case 0:
			self bots_TalkAll(25, "finished camping..");
		break;
		case 1:
			self bots_TalkAll(25, "wow that was a load of camping!");
		break;
		case 2:
			self bots_TalkAll(25, "well its been over "+time+" seconds, i guess ill stop camping");
		break;
	}
}

bots_CampInit(campSpot, time)
{
	switch(randomint(3))
	{
		case 0:
			self bots_TalkAll(25, "going to camp for "+time+" seconds");
		break;
		case 1:
			self bots_TalkAll(25, "time to go camp!");
		break;
		case 2:
			self bots_TalkAll(25, "rofl im going to camp");
		break;
	}
}

bots_Camping(campSpot, time)
{
	switch(randomint(3))
	{
		case 0:
			self bots_TalkAll(25, "well im camping... this is fun!");
		break;
		case 1:
			self bots_TalkAll(25, "lol im camping, hope i kill someone");
		break;
		case 2:
			self bots_TalkAll(25, "im camping! i guess ill wait "+time+" before moving again");
		break;
	}
}

bots_gnadethrew(nade, wp)
{
	switch(randomint(1))
	{
		case 0:
			if(nade == "claymore_mp" || nade == "flare_mp")
				self bots_TalkAll(25, "placed a "+bots_getBaseWeaponName(nade));
			else
				self bots_TalkAll(25, "threw a "+bots_getBaseWeaponName(nade));
		break;
	}
}

bots_gnadego(nade, wp)
{
	switch(randomint(1))
	{
		case 0:
			if(nade == "claymore_mp" || nade == "flare_mp")
				self bots_TalkAll(25, "going to place a "+bots_getBaseWeaponName(nade));
			else
				self bots_TalkAll(25, "going to throw a "+bots_getBaseWeaponName(nade));
		break;
	}
}

bots_follow(player, time)
{
	switch(randomint(3))
	{
		case 0:
			self bots_TalkAll(25, "well im going to follow "+player.name+" for "+time+" seconds");
		break;
		case 1:
			self bots_TalkAll(25, "Lets go together "+player.name+" <3 :)");
		break;
		case 2:
			self bots_TalkAll(25, "lets be butt buddies "+player.name+" and ill follow you!");
		break;
	}
}

bots_followend(player, time)
{
	switch(randomint(2))
	{
		case 0:
			self bots_TalkAll(25, "well that was fun following "+player.name+" for "+time+" seconds");
		break;
		case 1:
			self bots_TalkAll(25, "im done following that guy");
		break;
	}
}

Bots_TalkBegin()
{
	wait(randomint(5) + randomint(5));
	switch(level.gametype)
	{
		case "war":
			switch(randomint(3))
			{
				case 0:
					self bots_TalkAll(50, "TEEEEEEEEAM, DEEEEAAAAAATHMAAAAATCH!!");
				break;
				case 1:
					self bots_TalkAll(50, "Lets get em guys, wipe the floor with them.");
				break;
				case 2:
					self bots_TalkAll(50, "Yeeeesss master...");
				break;
			}
		break;
		case "dom":
			switch(randomint(3))
			{
				case 0:
					self bots_TalkAll(50, "Yaaayy!! I LOVE DOMINATION!!!!");
				break;
				case 1:
					self bots_TalkAll(50, "Lets cap the flags and them.");
				break;
				case 2:
					self bots_TalkAll(50, "Yeeeesss master...");
				break;
			}
		break;
		case "sd":
			switch(randomint(3))
			{
				case 0:
					self bots_TalkAll(50, "Ahhhh! I'm scared! No respawning!");
				break;
				case 1:
					self bots_TalkAll(50, "Lets get em guys, wipe the floor with them.");
				break;
				case 2:
					self bots_TalkAll(50, "Yeeeesss master...");
				break;
			}
		break;
		case "dd":
			switch(randomint(3))
			{
				case 0:
					self bots_TalkAll(50, "Try not to get spawn killed.");
				break;
				case 1:
					self bots_TalkAll(50, "OK we need a plan. Nah lets just kill.");
				break;
				case 2:
					self bots_TalkAll(50, "Yeeeesss master...");
				break;
			}
		break;
		case "sab":
			switch(randomint(3))
			{
				case 0:
					self bots_TalkAll(50, "Soccer/Football! Lets play it!");
				break;
				case 1:
					self bots_TalkAll(50, "Who plays sab these days.");
				break;
				case 2:
					self bots_TalkAll(50, "I do not know what to say.");
				break;
			}
		break;
		case "ctf":
			switch(randomint(3))
			{
				case 0:
					self bots_TalkAll(50, "Halo style");
				break;
				case 1:
					self bots_TalkAll(50, "I'm going cap all the flags.");
				break;
				case 2:
					self bots_TalkAll(50, "NO IM CAPPING IT");
				break;
			}
		break;
		case "dm":
			switch(randomint(3))
			{
				case 0:
					self bots_TalkAll(50, "DEEEEAAAAAATHMAAAAATCH!!");
				break;
				case 1:
					self bots_TalkAll(50, "IM GOING TO KILL U ALL");
				break;
				case 2:
					self bots_TalkAll(50, "lol sweet. time to camp.");
				break;
			}
		break;
		case "koth":
			self bots_TalkAll(50, "HQ TIME!");
		break;
		case "gtnw":
			self bots_TalkAll(50, "global thermonuclear warfare!!!!!!!");
		break;
	}
}

bots_Rage()
{
	switch(randomint(5))
	{
		case 0:
			self bots_TalkAll(5, "K this is not going as I planned.");
			break;
		case 1:
			self bots_TalkAll(5, "Screw this! I'm out.");
			break;
		case 2:
			self bots_TalkAll(5, "Have fun being owned.");
			break;
		case 3:
			self bots_TalkAll(5, "MY TEAM IS GARBAGE!");
			break;
		case 4:
			self bots_TalkAll(5, "kthxbai hackers");
			break;
	}
}

Bots_Talkdead()
{
	message = "";
	switch(randomint(68))
	{
		case 0:
		message = "^"+(randomint(6)+1)+"Damm, i just got pwnd by "+self.lastAttacker.name;
		break;
		case 1:
		message = ( "^" + (randomint(6) +1) + "Hax ! Hax ! Hax !" );
		break;
		case 2:
		message = ( "^" + (randomint(6) +1) + "WOW n1 " + self.lastAttacker.name );
		break;
		case 3:
		message = ( "^" + (randomint(6) +1) + "How the?? How did you do that "  + self.lastAttacker.name + "?");
		break;
		case 4:
			if(self.bots_lastKS > 0)
				message = ( "^" + (randomint(6) +1) + "Nooooooooo my killstreaks!! :( I had a " + self.bots_lastKS + " killstreak!!" );
			else
				message = ("man im getting spawn killed, i have a "+self.pers["cur_death_streak"]+" deathstreak!");
		break;
		case 5:
		message = ( "^" + (randomint(6) +1) + "Stop Spawn Raping!!!" );
		break;
		case 6:
		message = ( "^" + (randomint(6) +1) + "Haha Well done " + self.lastAttacker.name );
		break;
		case 7:
		message = ( "^" + (randomint(6) +1) + "Agggghhhh " + self.lastAttacker.name + " you are such a noob!!!!" );
		break;
		case 8:
		message = ( "^" + (randomint(6) +1) + "n1 " + self.lastAttacker.name );
		break;
		case 9:
		message = ( "Sigh at my lag, it's totally killing me.. ^2Just Look at my ^1Ping!" );
		break;
		case 10:
		message = ( "omg wow that was LEGENDARY, well done " + self.lastAttacker.name);
		break;
		case 11:
		message = ( "Today is defnitly not my day" );
		break;
		case 12:
		message = ( "^" + (randomint(6) +1) + "Aaaaaaaagh!!!" );
		break;
		case 13:
		message = ( "^" + (randomint(6) +1) + " Dude What the hell, " + self.lastAttacker.name + " is such a HACKER!! " );
		break;
		case 14:
		message = ( "^" + (randomint(6) +1) + self.lastAttacker.name + " you Wallhacker!" );
		break;
		case 15:
		message = ( "^" + (randomint(6) +1) + "This is so frustrating!" );
		break;
		case 16:
		message = ( " :O I can't believe that just happened" );
		break;
		case 17:
		message = ( self.lastAttacker.name + " you ^1Noooo^2ooooooooo^3ooooo^5b" );
		break;
		case 18:
		message = ( "^" + (randomint(6) +1) + "LOL, " + self.lastAttacker.name + " how did you kill me?" );
		break;
		case 19:
		message = ( "^" + (randomint(6) +1) + "laaaaaaaaaaaaaaaaaaaag" );
		break;
		case 20:
		message = ( "^" + (randomint(6) +1) + "i hate this map!" );
		break;
		case 21:
		message = ( self.lastAttacker.name + " You tanker!!" );
		break;
		case 22:
		message = ( "Sigh at my isp" );
		break;
		case 23:
		message = ( "^1I'll ^2be ^6back" );
		break;
		case 24:
		message = ( "LoL that was random" );
		break;
		case 25:
		message = ( "ooohh that was so close " + self.lastAttacker.name + " and you know it !! " );
		break;
		case 26:
		message = ( "^" + (randomint(6) +1) + "rofl" );
		break;
		case 27:
			if(self.pers["bots"]["trait"]["vengeful"])
				message = ("AAAAHHHHH! WTF! IM GOING TO KILL YOU " + self.lastAttacker.name);
			else
				message = ("Nice kill!");
		break;
		case 28:
		message = ("AHH! IM DEAD BECAUSE " + level.players[randomint(level.players.size)].name + " is a noob!");
		break;
		case 29:
		message = (level.players[randomint(level.players.size)].name + ", please don't talk.");
		break;
		case 30:
		message = ("Wow " + level.players[randomint(level.players.size)].name + " is a blocker noob!");
		break;
		case 31:
		message = ("Next time GET OUT OF MY WAY " + level.players[randomint(level.players.size)].name + "!!");
		break;
		case 32:
			message = ("Wow, I'm dead because " + self.lastAttacker.name + " is a tryhard...");
		break;
		case 33:
			message = ("Try harder " + self.lastAttacker.name + " please!");
		break;
		case 34:
			message = ("I bet " + self.lastAttacker.name + "'s fingers are about to break.");
		break;
		case 35:
			message = ("WOW, USE A REAL GUN " + self.lastAttacker.name + "!");
		break;
		case 36:
			message = ("k wtf. "+self.lastAttacker.name+" is hacking");
		break;
		case 37:
			message = ("nice wallhacks "+self.lastAttacker.name);
		break;
		case 38:
			message = ("wh "+self.lastAttacker.name);
		break;
		case 39:
			message = ("cheetos!");
		break;
		case 40:
			message = ("wow "+bots_getMapName(getdvar("mapname"))+" is messed up");
		break;
		case 41:
			message = ("lolwtf was that "+self.lastAttacker.name+"?");
		break;
		case 42:
			message = ("admin pls ban "+self.lastAttacker.name);
		break;
		case 43:
			message = ("WTF IS WITH THESE SPAWNS??");
		break;
		case 44:
			message = ("im getting owned lol...");
		break;
		case 45:
			message = ("someone kill "+self.lastAttacker.name+", they are on a streak of "+self.lastAttacker.pers["cur_kill_streak"]+"!");
		break;
		case 46:
			message = ("man i died");
		break;
		case 47:
			message = ("nice noob gun "+self.lastAttacker.name);
		break;
		case 48:
			message = ("stop camping "+self.lastAttacker.name+"!");
		break;
		case 49:
			message = ("k THERE IS NOTHING I CAN DO ABOUT DYING!!");
		break;
		case 50:
			message = ("aw");
		break;
		case 51:
			message = ("lol "+bots_getMapName(getdvar("mapname"))+" sux");
		break;
		case 52:
			message = ("why are we even playing on "+bots_getMapName(getdvar("mapname"))+"?");
		break;
		case 53:
			message = (bots_getMapName(getdvar("mapname"))+" is such an unfair map!!");
		break;
		case 54:
			message = ("what were they thinking when making "+bots_getMapName(getdvar("mapname"))+"?!");
		break;
		case 55:
			message = (self.lastAttacker.name+" totally just destroyed me!");
		break;
		case 56:
			message = ("can i be admen plz? so i can ban "+self.lastAttacker.name);
		break;
		case 57:
			message = ("wow "+self.lastAttacker.name+" is such a no life!!");
		break;
		case 58:
			message = ("man i got rekt by "+self.lastAttacker.name);
		break;
		case 59:
			message = ("admen pls ben "+self.lastAttacker.name);
		break;
		case 60:
			message = "Wow! Nice "+bots_getBaseWeaponName(self.attackerData[self.lastAttacker.guid].weapon)+" you got there, "+self.lastAttacker.name+"!";
		break;
		case 61:
			message = ("you are so banned "+self.lastAttacker.name);
		break;
		case 62:
			message = ("recorded reported and deported! "+self.lastAttacker.name);
		break;
		case 63:
			message = ("hack name "+self.lastAttacker.name+"?");
		break;
		case 64:
			message = ("dude can you send me that hack "+self.lastAttacker.name+"?");
		break;
		case 65:
			message = ("nice aimbot "+self.lastAttacker.name+"!!1");
		break;
		case 66:
			message = ("you are benned "+self.lastAttacker.name+"!!");
		break;
		case 67:
			message = ("that was topkek "+self.lastAttacker.name);
		break;
	}
	
	wait (randomint(3) + 1);
	self bots_TalkAll(85, message);
}

bots_onBotNuke()
{
	switch(randomint(4))
	{
		case 0:
			if(level.nukeInfo.player != self)
				self bots_TalkAll(8,"Wow who got a nuke?");
			else
				self bots_TalkAll(8,"NUUUUUUKKKKKKEEEEEE!!!! :D");
		break;
		case 1:
			if(level.nukeInfo.player != self)
				self bots_TalkAll(8,"lol "+level.nukeInfo.player.name+" is a hacker");
			else
				self bots_TalkAll(8,"im the best!");
		break;
		case 2:
			self bots_TalkAll(8,"woah, that nuke is like much wow");
		break;
		case 3:
			if(level.nukeInfo.team != self.team)
				self bots_TalkAll(8,"man my team sucks ):");
			else
				self bots_TalkAll(8,"man my team is good lol");
		break;
	}
}

bots_onGotStreak(streakCount)
{
	if (streakCount == 25) {
		if (level.bots_varLoadoutNuke) {
			if (self.pers["lastEarnedStreak"] == "nuke") {
				switch(randomint(5))
				{
					case 0:
						self bots_TalkAll(0,"I GOT A NUKE!!");
					break;
					case 1:
						self bots_TalkAll(0,"NUKEEEEEEEEEEEEEEEEE");
					break;
					case 2:
						self bots_TalkAll(0,"25 killstreak!!!");
					break;
					case 3:
						self bots_TalkAll(0,"NNNNNUUUUUUUUUUKKKKEEE!!! UWDHAWIDMIOGHE");
					break;
					case 4:
						self bots_TalkAll(0,"You guys are getting nuuuuuuked~ x3");
					break;
				}
			} else {
				self bots_TalkAll(0,"Come on! I would of had a nuke but I don't got it set...");
			}
		} else {
			self bots_TalkAll(0,"WOW.. I could have a nuke but dumb admin disabled it for bots.");
		}
	}
}

Bots_TalkKilled()
{
	message = "";
	switch(randomint(42))
	{
		case 0:
			message = ( "^" + (randomint(6) +1) + "Haha take that " + self.lastKilledPlayer.name );
			break;
		case 1:
			message = ( "^" + (randomint(6) +1) + "Who's your daddy!" );
			break;
		case 2:
			message = ( "^" + (randomint(6) +1) + "O i just kicked your ass " + self.lastKilledPlayer.name + "!!" );
			break;
		case 3:
			message = ( "^" + (randomint(6) +1) + "Better luck next time " + self.lastKilledPlayer.name );
			break;
		case 4:
			message = ( "^" + (randomint(6) +1) + self.lastKilledPlayer.name + " Is that all you got?" );
			break;
		case 5:
			message = ( "^" + (randomint(6) +1) + "LOL "  + self.lastKilledPlayer.name + ", l2play" );
			break;
		case 6:
			message = ( "^" + (randomint(6) +1) + ":)" );
			break;
		case 7:
			message = ( "^" + (randomint(6) +1) + "Im unstoppable!" );
			break;
		case 8:
			message = ( "^" + (randomint(6) +1) + "Wow " + self.lastKilledPlayer.name + " that was a close one!" );
			break;
		case 9:
			message = ( "^" + (randomint(6) +1) + "Haha thank you, thank you very much." );
			break;
		case 10:
			message = ( "^" + (randomint(6) +1) + "HAHAHAHA LOL" );
			break;
		case 11:
			message = ( "^" + (randomint(6) +1) + "ROFL you suck " + self.lastKilledPlayer.name + "!!" );
			break;
		case 12:
			message = ( "^" + (randomint(6) +1) + "Wow that was a lucky shot!" );
			break;
		case 13:
			message = ( "^" + (randomint(6) +1) + "Thats right, i totally pwnd your ass!" );
			break;
		case 14:
			message = ( "^" + (randomint(6) +1) + "Don't even think that i am hacking cause that was pure skill!" );
			break;
		case 15:
			message = ("LOL xD xDDDD " + self.lastKilledPlayer.name + " sucks! HAHA ROFLMAO");
		break;
		case 16:
			message = ("Wow that was an easy kill.");
		break;
		case 17:
			message = ("noob down");
		break;
		case 18:
			message = ("Lol u suck "+self.lastKilledPlayer.name);
		break;
		case 19:
			message = ("PWND!");
		break;
		case 20:
			message = ("sit down " +self.lastKilledPlayer.name);
		break;
		case 21:
			message = ("wow that was close, but i still got you ;)");
		break;
		case 22:
			message = ("oooooo! i got u good!");
		break;
		case 23:
			message = ("thanks for the streak lol");
		break;
		case 24:
			message = ("lol sweet got a kill");
		break;
		case 25:
			message = ("Just killed a newb, LOL");
		break;
		case 26:
			message = ("lolwtf that was a funny death");
		break;
		case 27:
			message = ("i bet "+self.lastKilledPlayer.name+" is using the arrow keys to move.");
		break;
		case 28:
			message = ("lol its noobs like "+self.lastKilledPlayer.name+" that ruin teams");
		break;
		case 29:
			message = ("lolwat was that "+self.lastKilledPlayer.name+"?");
		break;
		case 30:
			message = ("haha thanks "+self.lastKilledPlayer.name+", im at a "+self.pers["cur_kill_streak"]+" streak.");
		break;
		case 31:
			message = ("lol "+self.lastKilledPlayer.name+" is at a "+self.lastKilledPlayer.pers["cur_death_streak"]+" deathstreak");
		break;
		case 32:
			message = ("KLAPPED");
		break;
		case 33:
			message = ("oooh get merked "+self.lastKilledPlayer.name);
		break;
		case 34:
			message = ("i love "+bots_getMapName(getdvar("mapname"))+"!");
		break;
		case 35:
			message = (bots_getMapName(getdvar("mapname"))+" is my favorite map!");
		break;
		case 36:
			message = ("get rekt");
		break;
		case 37:
			message = ("lol i rekt "+self.lastKilledPlayer.name);
		break;
		case 38:
			message = ("lol ur mum can play better than u!");
		break;
		case 39:
			message = (self.lastKilledPlayer.name+" just got rekt");
		break;
		case 40:
			message = ("Man, I sure love my "+bots_getBaseWeaponName(self.lastKilledPlayer.attackerData[self.guid].weapon)+"!");
		break;
		case 41:
			message = ("lol u got killed "+self.lastKilledPlayer.name+", kek");
		break;
	}
	wait (randomint(3) + 1);
	self bots_TalkAll(85, message);
}

Bots_TalkEndGame()
{
	wait (randomint(6) + randomint(6));
	b = 0;
	w = 9999;
	winner = undefined;
	loser = undefined;

	foreach(player in level.players)
	{
		if(player.pers["score"] > b )
		{
			winner = player;
			b = player.pers["score"];
		}

		if(player.pers["score"] < w )
		{
			loser = player;
			w = player.pers["score"];
		}
	}
	
	if(level.teamBased)
	{
		winningteam = self thread maps\mp\gametypes\_gamescore::getWinningTeam();
	
		if(self.pers["team"] == winningteam)
		{
			switch(randomint(21))
			{
				case 0:
					self bots_TalkAll(20, "^" + (randomint(6) +1) + "Haha what a game");
				break;
				case 1:
					self bots_TalkAll(20, "xDDDDDDDDDD LOL HAHAHA FUN!");
				break;
				case 3:
					self bots_TalkAll(20, "^" + (randomint(6) +1) + "That was fun");
				break;
				case 4:
					self bots_TalkAll(20, "^" + (randomint(6) +1) + "Lol my team always wins!");
				break;
				case 5:
					self bots_TalkAll(20, "^" + (randomint(6) +1) + "Haha if i am on " + winningteam + " my team always wins!");
				break;
				case 2:
					self bots_TalkAll(20, "^" + (randomint(6) +1) + "gg");
				break;
				case 6:
					self bots_TalkAll(20, "^" + (randomint(6) +1) + "GGA, our team was awesome!");
				break;
				case 7:
					self bots_TalkAll(20, "^" + (randomint(6) +1) + "My team " + self.pers["team"] + " always wins!!");
				break;
				case 8:
					self bots_TalkAll(20, "^" + (randomint(6) +1) + "WOW that was EPIC!");
				break;
				case 9:
					self bots_TalkAll(20, "^" + (randomint(6) +1) + "Hackers lost haha noobs");
				break;
				case 10:
					self bots_TalkAll(20, "^" + (randomint(6) +1) + "Nice game!! Good job team!");
				break;
				case 11:
					self bots_TalkAll(20, "^" + (randomint(6) +1) + "GGA, Well done team!");
				break;
				case 12:
					self bots_TalkAll(20, "^" + (randomint(6) +1) + "LOL! camper noobs lose");
				break;
				case 13:
					self bots_TalkAll(20, "^" + (randomint(6) +1) + "owned.");
				break;
				case 14:
					self bots_TalkAll(20, "lool we won!!");
				break;
				case 16:
					self bots_TalkAll(20, "lol the sillys got pwnd :3");
				break;
				case 15:
					self bots_TalkAll(20, "har har har :B  we WON!");
				break;
				case 17:
					if(self == winner)
						self bots_TalkAll(20, "LOL we wouldn't of won without me!");
					else if(self == loser)
						self bots_TalkAll(20, "damn i sucked but i still won");
					else if(self != loser && randomint(2) == 1)
						self bots_TalkAll(20, "lol "+loser.name+" sucked hard!");
					else if(self != winner)
						self bots_TalkAll(20, "wow "+winner.name+" did very well!");
				break;
				case 18:
					if(self == winner)
						self bots_TalkAll(20, "I'm the VERY BEST!");
					else if(self == loser)
						self bots_TalkAll(20, "lol my team is good, i suck doe");
					else if(self != loser && randomint(2) == 1)
						self bots_TalkAll(20, "lol "+loser.name+" should be playing a noobier game");
					else if(self != winner)
						self bots_TalkAll(20, "i think "+winner.name+" is a hacker");
				break;
				case 19:
					self bots_TalkAll(20, "we won lol sweet");
				break;
				case 20:
					self bots_TalkAll(20, ":v we won!");
				break;
			}
		}
		else
		{
			if(winningteam != "none")
			{
				switch(randomint(21))
				{
					case 0:
						self bots_TalkAll(20, "^" + (randomint(6) +1) + "Hackers win");
					break;
					case 1:
						self bots_TalkAll(20, "xDDDDDDDDDD LOL HAHAHA");
					break;
					case 3:
						self bots_TalkAll(20, "^" + (randomint(6) +1) + "That wasn't fun");
					break;
					case 4:
						self bots_TalkAll(20, "^" + (randomint(6) +1) + "Wow my team SUCKS!");
					break;
					case 5:
						self bots_TalkAll(20, "^" + (randomint(6) +1) + "My team " + self.pers["team"] + " always loses!!");
					break;
					case 2:
						self bots_TalkAll(20, "^" + (randomint(6) +1) + "gg");
					break;
					case 6:
						self bots_TalkAll(20, "^" + (randomint(6) +1) + "bg");
					break;
					case 7:
						self bots_TalkAll(20, "^" + (randomint(6) +1) + "vbg");
					break;
					case 8:
						self bots_TalkAll(20, "^" + (randomint(6) +1) + "WOW that was EPIC!");
					break;
					case 9:
						self bots_TalkAll(20, "^" + (randomint(6) +1) + "Good game");
					break;
					case 10:
						self bots_TalkAll(20, "^" + (randomint(6) +1) + "Bad game");
					break;
					case 11:
						self bots_TalkAll(20, "^" + (randomint(6) +1) + "very bad game");
					break;
					case 12:
						self bots_TalkAll(20, "^" + (randomint(6) +1) + "campers win");
					break;
					case 13:
						self bots_TalkAll(20, "^" + (randomint(6) +1) + "CAMPER NOOBS!!");
					break;
					case 14:
						if(self == winner)
							self bots_TalkAll(20, "LOL we lost even with my score.");
						else if(self == loser)
							self bots_TalkAll(20, "damn im probally the reason we lost");
						else if(self != loser && randomint(2) == 1)
							self bots_TalkAll(20, loser.name+" should just leave");
						else if(self != winner)
							self bots_TalkAll(20, "kwtf "+winner.name+" is a hacker");
					break;
					case 15:
						if(self == winner)
							self bots_TalkAll(20, "my teammates are garabge");
						else if(self == loser)
							self bots_TalkAll(20, "lol im garbage");
						else if(self != loser && randomint(2) == 1)
							self bots_TalkAll(20, loser.name+" sux");
						else if(self != winner)
							self bots_TalkAll(20, winner.name+" is a noob!");
					break;
					case 16:
						self bots_TalkAll(20, "we lost but i still had fun");
					break;
					case 17:
						self bots_TalkAll(20, ">.> damn try hards");
					break;
					case 18:
						self bots_TalkAll(20, ">:(  that wasnt fair");
					break;
					case 19:
						self bots_TalkAll(20, "lost did we?");
					break;
					case 20:
						self bots_TalkAll(20, ">:V noobs win");
					break;
				}
			}
			else
			{
				switch(randomint(8))
				{
					case 0:
						self bots_TalkAll(20, "^" + (randomint(6) +1) + "gg");
					break;
					case 1:
						self bots_TalkAll(20, "^" + (randomint(6) +1) + "bg");
					break;
					case 2:
						self bots_TalkAll(20, "^" + (randomint(6) +1) + "vbg");
					break;
					case 3:
						self bots_TalkAll(20, "^" + (randomint(6) +1) + "vgg");
					break;
					case 4:
						self bots_TalkAll(20, "^" + (randomint(6) +1) + "gg no rm");
					break;
					case 5:
						self bots_TalkAll(20, "^" + (randomint(6) +1) + "ggggggggg");
					break;
					case 6:
						self bots_TalkAll(20, "^" + (randomint(6) +1) + "good game");
					break;
					case 7:
						self bots_TalkAll(20, "^" + (randomint(6) +1) + "gee gee");
					break;
				}
			}
		}
	}
	else
	{
		switch(randomint(20))
		{
			case 0:
				if(self == winner)
					self bots_TalkAll(20, "^" + (randomint(6) +1) + "Haha Suck it, you all just got pwnd!");
				else if(self==loser)
					self bots_TalkAll(20, "^" + (randomint(6) +1) + "Lol i Sucked in this game, just look at my score!");
				else if(self!=loser && randomint(2) == 1)
					self bots_TalkAll(20, "^" + (randomint(6) +1) + "gga, Bad luck " + loser.name);
				else if(self!=winner)
					self bots_TalkAll(20, "This game sucked, " + winner.name + " is such a hacker!!");
			break;
			case 1:
				if(self == winner)
					self bots_TalkAll(20, "^" + (randomint(6) +1) + "LOL i just wasted you all!! Whoot whoot!");
				else if(self==loser)
					self bots_TalkAll(20, "GGA i suck, Nice score " + winner.name);
				else if(self!=loser && randomint(2) == 1)
					self bots_TalkAll(20, "^" + (randomint(6) +1) + "Rofl, " + loser.name + " dude, you suck!!");
				else if(self!=winner)
					self bots_TalkAll(20, "^" + (randomint(6) +1) + "Nice Score " + winner.name + ", how did you get to be so good?");
			break;
			case 2:
				if(self == winner)
					self bots_TalkAll(20, "^" + (randomint(6) +1) + "LOL i just wasted you all!! Whoot whoot!");
				else if(self==loser)
					self bots_TalkAll(20, "^" + (randomint(6) +1) + "nice wallhacks " + winner.name);
				else if(self!=loser && randomint(2) == 1)
					self bots_TalkAll(20, "^" + (randomint(6) +1) + "Lol atleast i did better then " + loser.name);
				else if(self!=winner)
					self bots_TalkAll(20, "^" + (randomint(6) +1) + "lolwtf " + winner.name);
			break;
			case 3:
				self bots_TalkAll(20, "^" + (randomint(6) +1) + "gee gee");
			break;
			case 4:
				self bots_TalkAll(20, "^" + (randomint(6) +1) + "WOW that was EPIC!");
			break;
			case 5:
				self bots_TalkAll(20, "^" + (randomint(6) +1) + "Nice Game!");
			break;
			case 6:
				self bots_TalkAll(20, "^" + (randomint(6) +1) + "good game");
			break;
			case 7:
				self bots_TalkAll(20, "^" + (randomint(6) +1) + "gga  c  u  all later");
			break;
			case 8:
				self bots_TalkAll(20, "^" + (randomint(6) +1) + "bg");
			break;
			case 9:
				self bots_TalkAll(20, "^" + (randomint(6) +1) + "GG");
			break;
			case 10:
				self bots_TalkAll(20, "^" + (randomint(6) +1) + "gg");
			break;
			case 11:
				self bots_TalkAll(20, "^" + (randomint(6) +1) + "vbg");
			break;
			case 12:
				self bots_TalkAll(20, "^" + (randomint(6) +1) + "gga");
			break;
			case 13:
				self bots_TalkAll(20, "^" + (randomint(6) +1) + "BG");
			break;
			case 14:
				self bots_TalkAll(20, "^" + (randomint(6) +1) + "stupid map");
			break;
			case 15:
				self bots_TalkAll(20, "^" + (randomint(6) +1) + "ffa sux");
			break;
			case 16:
				self bots_TalkAll(20, "^" + (randomint(6) +1) + ":3 i had fun");
			break;
			case 17:
				self bots_TalkAll(20, "^" + (randomint(6) +1) + ":P nubs are playin");
			break;
			case 18:
				self bots_TalkAll(50, "^" + (randomint(6) +1) + "nub nub nub thx 4 the nubs");
			break;
			case 19:
				self bots_TalkAll(50, "^" + (randomint(6) +1) + "damn campers");
			break;
		}
	}
}

bots_AntiAir(weap, tarKS)
{
	switch(randomint(14))
	{
		case 0:
			self bots_TalkAll(25, "Not on my watch...");
			break;
		case 1:
			self bots_TalkAll(25, "Take down aircraft I am");
			break;
		case 2:
			self bots_TalkAll(25, "^" + (randomint(6) +1) + "i hate killstreaks");
			break;
		case 3:
			self bots_TalkAll(25, "Killstreaks ruin this game!!");
			break;
		case 4:
			self bots_TalkAll(25, "killstreaks sux");
			break;
		case 5:
			self bots_TalkAll(25, "keep the killstreaks comin'");
			break;
		case 6:
			self bots_TalkAll(25, "lol see that killstreak? its going to go BOOM!");
			break;
		case 7:
			self bots_TalkAll(25, "^" + (randomint(6) +1) + "Lol I bet that noob used hardline to get that streak.");
			break;
		case 8:
			self bots_TalkAll(25, "WOW HOW DO YOU GET THAT?? ITS GONE NOW.");
			break;
		case 9:
			self bots_TalkAll(25, "HAHA say goodbye to your killstreak");
			break;
		case 10:
			self bots_TalkAll(25, "All your effort is gone now.");
			break;
		case 11:
			self bots_TalkAll(25, "I hope there are flares on that killstreak.");
			break;
		case 12:
			self bots_TalkAll(25, "lol u silly, i'm taking down killstreaks :3 xDD");
			break;
		case 13:
			self bots_TalkAll(25, "Im going to takedown your ks with my "+bots_getBaseWeaponName(weap));
			break;
	}
}

bots_doMessage()
{
	if(level.bots_varPlayTalk > 0 && (level.bots_varPlayTalk >= 50 || int(bots_randomInt(50 - self.pers["bots"]["trait"]["talk"]) * (1 / level.bots_varPlayTalk)) == 2) && (!isDefined(self.talking) || !self.talking))
	{
		self.talking = true;
		soundalias = ""; 
		saytext = "";
		wait 2;
		self.spamdelay = true;
		switch(randomint(11))
		{
			case 4 : 
				soundalias = "mp_cmd_suppressfire";
				saytext = "Suppressing fire!";
				break;
			case 5 : 
				soundalias = "mp_cmd_followme";
				saytext = "Follow Me!";
				break;
			case 6 :
				soundalias = "mp_stm_enemyspotted";
				saytext = "Enemy spotted!";
				break;	
			case 7 :
				soundalias = "mp_cmd_fallback";
				saytext = "Fall back!";
				break;
			case 8 :
				soundalias = "mp_stm_needreinforcements";
				saytext = "Need reinforcements!";
				break;	
		}
		if(soundalias != "" && saytext != "" && isDefined(self) && bots_isReallyAlive(self))
		{
			self maps\mp\gametypes\_quickmessages::saveHeadIcon();
			self maps\mp\gametypes\_quickmessages::doQuickMessage(soundalias, saytext);
			wait 2;
			if(isDefined(self) && bots_isReallyAlive(self))
				self maps\mp\gametypes\_quickmessages::restoreHeadIcon();
		}
		self.spamdelay = undefined;
		wait randomint(5);
		self.talking = false;
	}
}

bots_giveEMP()
{
	switch(randomint(2))
	{
		case 0:
			self bots_TalkAll(0,"Wow, wasn't expecting on getting an EMP.");
		break;
		case 1:
			self bots_TalkAll(0,"You don't see an EMP everyday!");
		break;
	}
}

bots_giveNukeL()
{
	switch(randomint(8))
	{
		case 0:
			self bots_TalkAll(0,"NUUUKE");
		break;
		case 1:
			self bots_TalkAll(0,"lol sweet nuke");
		break;
		case 2:
			self bots_TalkAll(0,"NUUUUUUKKKKKKEEEEEE!!!!");
		break;
		case 3:
			self bots_TalkAll(0,"YEEEEEEEES!!");
		break;
		case 4:
			self bots_TalkAll(0,"sweet I get a nuke and my team is noob");
		break;
		case 5:
			self bots_TalkAll(0,"GET NUKED NERDS!!!!");
		break;
		case 6:
			self bots_TalkAll(0,"NUKEM NOW!!!! NUKEEEEE!");
		break;
		case 7:
			self bots_TalkAll(0,"Get nuked kids!");
		break;
	}
}

bots_giveAC130L()
{
	switch(randomint(5))
	{
		case 0:
			self bots_TalkAll(0,"^3Time to ^1klap ^3some kids!");
			break;
		case 1:
			self bots_TalkAll(0,"Stingers are not welcome! AC130 rules all!");
			break;
		case 2:
			self bots_TalkAll(0,"Bahahahahahaaa! Time to rule the map with AC130!");
			break;
		case 3:
			self bots_TalkAll(0,"ac130 Madness!");
		break;
		case 4:
			self bots_TalkAll(0,"Say hello to my little friend, ^6AC130!");
		break;
	}
}

bots_giveChopperL()
{
	switch(randomint(7))
	{
		case 0:
			self bots_TalkAll(0,"Eat my Chopper Gunner!!");
			break;
		case 1:
			self bots_TalkAll(0,"and here comes the ^1PAIN!");
			break;
		case 2:
			self bots_TalkAll(0,"Awwwww Yeah! Time to create choas in 40 seconds flat.");
		break;
		case 3:
			self bots_TalkAll(0,"Woot! Got my chopper gunner!");
		break;
		case 4:
			self bots_TalkAll(0,"Wewt got my choppa!");
		break;
		case 5:
			self bots_TalkAll(0,"Time to spawn kill with the OP chopper!");
		break;
		case 6:
			self bots_TalkAll(0,"GET TO DA CHOPPA!!");
		break;
	}
}

bots_throwBack(nade)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i am going to throw back the grenade!");
		break;
	}
}

bots_thrownback(nade)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i threw back the grenade!");
		break;
	}
}

bots_unreachable(aircare)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i cant reach that carepackage!");
		break;
	}
}

bots_onNukeStreaks()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"I WILL TRY AND GET A NUKE!!!");
		break;
	}
}

bots_giveHeliFlares()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(0,"Nice! I got the paves!");
		break;
	}
}

bots_goingTBag(where)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(10,"Im going to go tBag XD");
		break;
	}
}

bots_doTBag(where)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(10,"Im going to tBag XD");
		break;
	}
}

bots_doTBagdone(where)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(10,"Awwww yea... How do you like that? XD");
		break;
	}
}

bots_playerWatch(target)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(75,"I think I hear "+target.name+"...");
		break;
	}
}

bots_playerWent(target)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(75,"Well i checked out "+target.name+"'s location...");
		break;
	}
}

bots_deathloc()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(75,"Im going to check out my death location.");
		break;
	}
}

bots_wentDeathloc()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(75,"i checked out my deathlocation...");
		break;
	}
}

bots_conf_gettag()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i am going to get the tag");
		break;
	}
}

bots_conf_gottag()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i got the tag");
		break;
	}
}

bots_ctf_waitEnemyCapSpawn(who)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i am going to wait for the enemy flag to spawn");
		break;
	}
}

bots_ctf_waitEnemyCap(who)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i am going to wait at the enemy cap point");
		break;
	}
}

bots_ctf_capFlag()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i am going to capture the flag!");
		break;
	}
}

bots_ctf_cappedFlag()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i captured the flag!");
		break;
	}
}

bots_ctf_killcapFlag(tarPlayer)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(75,"i am going to kill "+tarPlayer.name+" bc they got the flag!");
		break;
	}
}

bots_ctf_capFlagOwn()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i am going to get my own flag!");
		break;
	}
}

bots_ctf_gotcapFlagOwn()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i got my own flag!");
		break;
	}
}

bots_ctf_protectFlagCarrier(tarPlayer)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(75,"i am going to protect "+tarPlayer.name+" bc they got the flag!");
		break;
	}
}

bots_ctf_getEnemyFlag()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i am going to get their flag");
		break;
	}
}

bots_ctf_gotEnemyFlag()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i got their flag!");
		break;
	}
}

bots_dd_defuseBomb(nearestBombZone)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i am defusing the bomb at "+nearestBombZone.label);
		break;
	}
}

bots_dd_godefuseBomb(nearestBombZone)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i am going to defuse the bomb at "+nearestBombZone.label);
		break;
	}
}

bots_dd_defusedBomb(nearestBombZone)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i defused the bomb at "+nearestBombZone.label);
		break;
	}
}

bots_dd_protectPlant(site)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(75,"i am going to protect the planted bomb at"+site.label);
		break;
	}
}

bots_dd_protectPlantDefuser(defusers)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(75,"i am going to kill the defuser");
		break;
	}
}

bots_dd_protectPlantDefuserFinish()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(75,"i am finshed killing the defuser");
		break;
	}
}

bots_dd_goPlantBomb(targetBombsite)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(75,"i am going to plant the bomb at "+targetBombsite.label);
		break;
	}
}

bots_dd_plantingBomb(targetBombsite)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(75,"i am planting the bomb at "+targetBombsite.label);
		break;
	}
}

bots_dd_plantedBomb(targetBombsite)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(75,"i planted the bomb at "+targetBombsite.label);
		break;
	}
}

bots_dd_protectBombsite(site)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(75,"i am going to protect the bombsite "+site.label);
		break;
	}
}

bots_dd_spawnKill()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(75,"i am going to go spawn kill");
		break;
	}
}

bots_sab_killDefuser(defusers)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(75,"i am going to kill the defuser");
		break;
	}
}

bots_sab_killDefuserFinish(defusers)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(75,"i am finshed killing the defuser");
		break;
	}
}

bots_sab_protectPlant()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(75,"i am going to protect the bomb plant");
		break;
	}
}

bots_sab_goPlantBomb()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(75,"i am going to plant the bomb");
		break;
	}
}

bots_sab_plantingBomb()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(75,"i am planting the bomb");
		break;
	}
}

bots_sab_plantedBomb()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(75,"i planted the bomb");
		break;
	}
}

bots_sab_protectBombCarry(protectTarget)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(75,"i am going to protect "+protectTarget.name+" bc they have the bomb");
		break;
	}
}

bots_sab_killBombCarry(protectTarget)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(75,"i am going to kill "+protectTarget.name+" bc they have the bomb");
		break;
	}
}

bots_sab_protectBombsite()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(75,"i am going to protect the bombsite");
		break;
	}
}

bots_sab_defuseBomb()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i am defusing the bomb");
		break;
	}
}

bots_sab_godefuseBomb()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i am going to defuse the bomb");
		break;
	}
}

bots_sab_defusedBomb()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i defused the bomb");
		break;
	}
}

bots_sab_getBomb()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(10,"i am going to get the bomb!");
		break;
	}
}

bots_sab_gotBomb()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(10,"i got the bomb!");
		break;
	}
}

bots_dom_capFlag(targetFlag)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25, "going to capture flag "+targetFlag.useObj.label);
		break;
	}
}

bots_dom_cappedFlag(targetFlag)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(10, "captured flag "+targetFlag.useObj.label);
		break;
	}
}

bots_dom_lookFlag(targetFlag)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25, "looking at flag "+targetFlag.useObj.label);
		break;
	}
}

bots_dom_lookFlagDone(targetFlag)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25, "finished lookin at flag "+targetFlag.useObj.label);
		break;
	}
}

bots_dom_spawnKill(targetFlag)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25, "i am going to spawnkill at flag "+targetFlag.useObj.label);
		break;
	}
}

bots_sd_defuseBomb(nearestBombZone)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i am defusing the bomb at "+nearestBombZone.label);
		break;
	}
}

bots_sd_godefuseBomb(nearestBombZone)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i am going to defuse the bomb at "+nearestBombZone.label);
		break;
	}
}

bots_sd_defusedBomb(nearestBombZone)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i defused the bomb at "+nearestBombZone.label);
		break;
	}
}

bots_sd_protectPlant()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(75,"i am going to protect the planted bomb");
		break;
	}
}

bots_sd_protectPlantDefuser(defusers)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(75,"i am going to kill the defuser");
		break;
	}
}

bots_sd_protectPlantDefuserFinish()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(75,"i am finshed killing the defuser");
		break;
	}
}

bots_sd_goPlantBomb(targetBombsite)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(75,"i am going to plant the bomb at "+targetBombsite.label);
		break;
	}
}

bots_sd_plantingBomb(targetBombsite)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(75,"i am planting the bomb at "+targetBombsite.label);
		break;
	}
}

bots_sd_plantedBomb(targetBombsite)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(75,"i planted the bomb at "+targetBombsite.label);
		break;
	}
}

bots_sd_getBomb()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(10,"i am going to get the bomb!");
		break;
	}
}

bots_sd_gotBomb()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(10,"i got the bomb!");
		break;
	}
}

bots_sd_protectBombCarry(protectTarget)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(75,"i am going to protect "+protectTarget.name+" bc they have the bomb");
		break;
	}
}

bots_sd_killBombCarry(protectTarget)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(75,"i am going to kill "+protectTarget.name+" bc they have the bomb");
		break;
	}
}

bots_sd_protectBomb()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(75,"i am going to protect the bomb");
		break;
	}
}

bots_sd_protectBombsite(site)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(75,"i am going to protect the bombsite "+site.label);
		break;
	}
}

bots_koth()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(50,"i am going to get the hq!");
		break;
	}
}

bots_koth_protect()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(50,"i am going to protect the hq!");
		break;
	}
}

bots_koth_protectEnemy()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(50,"i am going to kill the hq destorier!");
		break;
	}
}

bots_koth_wait()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(50,"i am going to wait for the hq!");
		break;
	}
}

bots_koth_waitCap()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(50,"i am going to wait for the hq to become active!");
		break;
	}
}

bots_gtnw()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i am going to protect the nukesite");
		break;
	}
}

bots_oneflag_capFlag()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i am going to cap the flag");
		break;
	}
}

bots_oneflag_doneCap()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i capped the flag");
		break;
	}
}

bots_oneflag_doneGetFlag()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i got the flag");
		break;
	}
}

bots_oneflag_getFlag()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i am going to get the flag");
		break;
	}
}

bots_oneflag_protectCarrier(who)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i am going to protect the flag carrier");
		break;
	}
}

bots_oneflag_killCarrier(who)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i am going to kill the flag carrier");
		break;
	}
}

bots_oneflag_protectCapzone()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i am going to protect the cap zone");
		break;
	}
}

bots_oneflag_protectFlag()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i am going to protect the flag");
		break;
	}
}

bots_oneflag_returnFlag()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i am going to return the flag");
		break;
	}
}

bots_oneflag_returnFlagDone()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i returned the flag");
		break;
	}
}

bots_arena_capFlag()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i am capturing the flag");
		break;
	}
}

bots_arena_capFlagDone()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i captured the flag");
		break;
	}
}

bots_vip_extract()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i am going to the extraction zone");
		break;
	}
}

bots_vip_extractDone()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i have extracted");
		break;
	}
}

bots_vip_kill(who)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i will kill the vip");
		break;
	}
}

bots_vip_hangaround()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i will hang around the extraction zone");
		break;
	}
}

bots_vip_protect(who)
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i will protect the vip");
		break;
	}
}

bots_tdef_getFlag()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i will get the flag");
		break;
	}
}

bots_tdef_gotFlag()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i got the flag");
		break;
	}
}

bots_tdef_kill()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i will kill the flag carrier");
		break;
	}
}

bots_tdef_protect()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i will protect the flag carrier");
		break;
	}
}

bots_grndzone()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i am going to the ground zone");
		break;
	}
}

bots_grndzonearea()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i am going to the ground zone area");
		break;
	}
}

bots_blitz_getFlag()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i am going to get the flag");
		break;
	}
}

bots_blitz_gotFlag()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i got the flag");
		break;
	}
}

bots_blitz_area()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i am going to hang around the area of the flag");
		break;
	}
}

bots_blitz_areaSelf()
{
	switch(randomint(1))
	{
		case 0:
			self bots_TalkAll(25,"i am going to hang around the area of my flag");
		break;
	}
}