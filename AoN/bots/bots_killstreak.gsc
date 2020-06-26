#include bots\bots_funcs;

bots_watchUseKillStreak()
{
	self endon("bot_reset");
	self endon("death");
	for(;;)
	{
		if(level.bots_varLoadoutKS != "none" && self bots_doingNothing() && !isDefined(self.bots_RealSeen) && isDefined(self.pers["killstreaks"][0]) && self.pers["killstreaks"][0].streakName != "" && !isDefined(self.lastStand))
		{
			wait 0.5;
			if(level.bots_varLoadoutKS != "none" && self bots_doingNothing() && !isDefined(self.bots_RealSeen) && isDefined(self.pers["killstreaks"][0]) && self.pers["killstreaks"][0].streakName != "" && !isDefined(self.lastStand))
			{
				self bots_UseStreak();
			}
		}
		wait 1;
	}
}

bots_UseStreak()
{
	switch(self.pers["killstreaks"][0].streakName)
	{
		case "airdrop_sentry_minigun":
			if(!self bots_isEmp())
			{
				if(level.littleBirds < 3)
				{
					if(bulletTracePassed(self getTagOrigin( "j_head" ), self getTagOrigin( "j_head" )+(0.0,0.0,255.0), false, self) || self.pers["bots"]["skill"]["base"] <= 4)
						self bots_airdrop("airdrop_sentry_marker_mp");
				}
			}
		break;
		case "airdrop":
			if(!self bots_isEmp())
			{
				if(level.littleBirds < 3)
				{
					if(bulletTracePassed(self getTagOrigin( "j_head" ), self getTagOrigin( "j_head" )+(0.0,0.0,255.0), false, self) || self.pers["bots"]["skill"]["base"] <= 4)
						self bots_airdrop("airdrop_marker_mp" );
				}
			}
		break;
		case "airdrop_mega":
			if(!self bots_isEmp())
			{
				if(bulletTracePassed(self getTagOrigin( "j_head" ), self getTagOrigin( "j_head" )+(0.0,0.0,255.0), false, self) || self.pers["bots"]["skill"]["base"] <= 4)
					self bots_airdrop("airdrop_mega_marker_mp");
			}
		break;
		case "sentry":
			if(!self bots_isEmp())
			{
				pos = self bots_GetCursorPosition();
				if(distance(pos, self.origin) > 400.0 || self.pers["bots"]["skill"]["base"] <= 4)
					self bots_sentry();
			}
		break;
		case "harrier_airstrike":
		case "precision_airstrike":
		case "stealth_airstrike":
			if(!self bots_isEmp())
			{
				if(level.planes < 2 || self.pers["killstreaks"][0].streakName != "harrier_airstrike")
				{
					players = [];
					target = undefined;
					if(!level.bots_varTarget.size)
					{
						foreach(player in level.players)
						{
							if(!isDefined(player.pers["team"]))
								continue;
							if(!level.bots_varTargetHost && player.pers["bots_isHost"])
								continue;
							if(player == self)
								continue;
							if(level.teamBased && self.pers["team"] == player.pers["team"])
								continue;
							if(player.sessionstate != "playing")
								continue;
							if(!bots_isReallyAlive(player))
								continue;
							if(player bots_hasPerk("specialty_coldblooded"))
								continue;
							if(!bulletTracePassed(player getTagOrigin( "j_head" ), player getTagOrigin( "j_head" )+(0,0,255), false, player) && self.pers["bots"]["skill"]["base"] > 4)
								continue;
							
							players[players.size] = player;
						}
					}
					else
					{
						foreach(player in level.players)
						{
							if(!isSubStr(player.name, level.bots_varTarget))
								continue;
							
							players[players.size] = player;
							break;
						}
					}
					
					if(players.size > 0)
						target = players[randomint(players.size)];
					
					if(isDefined(target) || self.pers["bots"]["skill"]["base"] < 3)
					{
						self.bots_doing = "laptop";
						lastWeapon = self getCurrentWeapon();
						self thread maps\mp\killstreaks\_killstreaks::killstreakUsePressed();
						switch(self.pers["killstreaks"][0].streakName) {
							case "harrier_airstrike":
								self bots__giveWeapon("killstreak_harrier_airstrike_mp", 0);
								self setspawnweapon("killstreak_harrier_airstrike_mp");
							break;
							case "stealth_airstrike":
								self bots__giveWeapon("killstreak_stealth_airstrike_mp", 0);
								self setspawnweapon("killstreak_stealth_airstrike_mp");
							break;
							case "precision_airstrike":
								self bots__giveWeapon("killstreak_precision_airstrike_mp", 0);
								self setspawnweapon("killstreak_precision_airstrike_mp");
							break;
						}
						wait 1;
						if(isDefined(target)){
							self notify( "confirm_location", target.origin, randomint(360) );
						} else {
							self notify( "confirm_location", self.origin, randomint(360) );
						}
						wait 1;
						self setspawnweapon(lastWeapon);
						self takeweapon("killstreak_stealth_airstrike_mp");
						self takeweapon("killstreak_precision_airstrike_mp");
						self takeweapon("killstreak_harrier_airstrike_mp");
						self.bots_doing = "none";
					}
				}
			}
		break;
		case "uav":
			if(!self bots_isEmp())
			{
				if(((!level.teambased && !self.isRadarBlocked) || (level.teambased && !level.activeCounterUAVs[level.otherTeam[self.team]])) || self.pers["bots"]["skill"]["base"] < 3)
				{
					self.bots_doing = "ks_call";
					lastWeapon = self getCurrentWeapon();
					self bots__giveWeapon("killstreak_uav_mp", 0);
					self setspawnweapon("killstreak_uav_mp");
					wait 1;
					self thread maps\mp\killstreaks\_killstreaks::killstreakUsePressed();
					self setspawnweapon(lastWeapon);
					self takeweapon("killstreak_uav_mp");
					self.bots_doing = "none";
				}
			}
		break;
		case "counter_uav":
			if(!self bots_isEmp())
			{
				self.bots_doing = "ks_call";
				lastWeapon = self getCurrentWeapon();
				self bots__giveWeapon("killstreak_counter_uav_mp", 0);
				self setspawnweapon("killstreak_counter_uav_mp");
				wait 1;
				self thread maps\mp\killstreaks\_killstreaks::killstreakUsePressed();
				self setspawnweapon(lastWeapon);
				self takeweapon("killstreak_counter_uav_mp");
				self.bots_doing = "none";
			}
		break;
		case "helicopter":
			if(!self bots_isEmp() && (self.pers["bots"]["skill"]["base"] < 3 || !self bots_enemyHarrier()))
			{
				self.bots_doing = "ks_call";
				lastWeapon = self getCurrentWeapon();
				self bots__giveWeapon("killstreak_helicopter_mp", 0);
				self setspawnweapon("killstreak_helicopter_mp");
				wait 1;
				self thread maps\mp\killstreaks\_killstreaks::killstreakUsePressed();
				self setspawnweapon(lastWeapon);
				self takeweapon("killstreak_helicopter_mp");
				self.bots_doing = "none";
			}
		break;
		case "helicopter_flares":
			if(!self bots_isEmp() && (self.pers["bots"]["skill"]["base"] < 3 || !self bots_enemyHarrier()))
			{
				self thread bots\talk::bots_giveHeliFlares();
				self.bots_doing = "ks_call";
				lastWeapon = self getCurrentWeapon();
				self bots__giveWeapon("killstreak_helicopter_flares_mp", 0);
				self setspawnweapon("killstreak_helicopter_flares_mp");
				wait 1;
				self thread maps\mp\killstreaks\_killstreaks::killstreakUsePressed();
				self setspawnweapon(lastWeapon);
				self takeweapon("killstreak_helicopter_flares_mp");
				self.bots_doing = "none";
			}
		break;
		case "emp":
			if(!self bots_isEmp())
			{
				self thread bots\talk::bots_giveEMP();
				self.bots_doing = "ks_call";
				lastWeapon = self getCurrentWeapon();
				self bots__giveWeapon("killstreak_emp_mp", 0);
				self setspawnweapon("killstreak_emp_mp");
				wait 1;
				self thread maps\mp\killstreaks\_killstreaks::killstreakUsePressed();
				self setspawnweapon(lastWeapon);
				self takeweapon("killstreak_emp_mp");
				self.bots_doing = "none";
			}
		break;
		case "nuke":
			if(!self bots_isEmp() && level.bots_varLoadoutNuke)
			{
				if(!isDefined( level.nukeIncoming ) && !isDefined( level.moabIncoming ))
				{
					self thread bots\talk::bots_giveNukeL();
					self.bots_doing = "ks_call";
					lastWeapon = self getCurrentWeapon();
					self bots__giveWeapon("killstreak_nuke_mp", 0);
					self setspawnweapon("killstreak_nuke_mp");
					wait 1;
					self thread maps\mp\killstreaks\_killstreaks::killstreakUsePressed();
					self setspawnweapon(lastWeapon);
					self takeweapon("killstreak_nuke_mp");
					self.bots_doing = "none";
				}
			}
		break;
		case "predator_missile":
			//already called
		break;
		case "ac130":
			if(!self bots_isEmp() && !level.ac130InUse)
			{
				if(randomint(5)/* && self bots\bots_walk::bots_shouldGetObj()*/ && self.pers["killstreaks"][0].lifeId <= self.pers["deaths"])
				{
					self bots_doKSCamp();
				}
				//camp stuff here
				if(!self bots_isEmp() && !level.ac130InUse && self bots_doingNothing() && !isDefined(self.bots_RealSeen) && isDefined(self.pers["killstreaks"][0]) && self.pers["killstreaks"][0].streakName == "ac130" && level.bots_varLoadoutKS != "none" && !isDefined(self.lastStand))
					self thread bots_killstreakUsePressed();
			}
		break;
		case "helicopter_minigun":
			if(!self bots_isEmp() && !isDefined(level.chopper) && (self.pers["bots"]["skill"]["base"] < 3 || !self bots_enemyHarrier()))
			{
				if(randomint(5)/* && self bots\bots_walk::bots_shouldGetObj()*/ && self.pers["killstreaks"][0].lifeId <= self.pers["deaths"])
				{
					self bots_doKSCamp();
				}
				//camp stuff here
				if(!self bots_isEmp() && !isDefined(level.chopper) && (self.pers["bots"]["skill"]["base"] < 3 || !self bots_enemyHarrier()) && self bots_doingNothing() && !isDefined(self.bots_RealSeen) && isDefined(self.pers["killstreaks"][0]) && self.pers["killstreaks"][0].streakName == "helicopter_minigun" && level.bots_varLoadoutKS != "none" && !isDefined(self.lastStand))
					self thread bots_killstreakUsePressed();
			}
		break;
	}
}

bots_watchConKS()
{
	self endon("bot_reset");
	for(;;)
	{
		if(self bots_isInChopper())
			self bots_chopper();
		else if(self bots_isInAC130())
			self bots_ac130();
		else if(level.bots_varLoadoutKS != "none" && bots_isReallyAlive(self) && self bots_doingNothing() && !isDefined(self.bots_RealSeen) && isDefined(self.pers["killstreaks"][0]) && self.pers["killstreaks"][0].streakName == "predator_missile" && bots_gameFlag( "prematch_done" ) && !level.inGracePeriod && !isDefined(self.lastStand) && !self bots_isEmp())
			self bots_predator();
		wait 1;
	}
}

bots_doKSCamp()
{
	self endon("kill_bot_walk");
	
	self.bots_objDoing = "ks_camp";
	
	self notify("bot_obj_override");
	
	self bots\bots_walk::bots_goCamp(true, 0.25, false);
	
	self thread bots_campThread();
}

bots_campThread()
{
	self endon("bot_reset");
	self endon("kill_bot_walk");
	self endon("death");
	
	self bots\bots_walk::bots_goCamp(true, 10, false);
	self.bots_objDoing = "none";
}

bots_isInAC130()
{
	if(level.ac130InUse && isDefined(level.ac130player) && level.ac130player == self && self bots_isUsingRemote())
		return true;
	else
		return false;
}

bots_isInChopper()
{
	if(isDefined(level.chopper) && level.chopper.heliType == "minigun" && isDefined(level.chopper.owner) && level.chopper.owner == self && self bots_isUsingRemote())
		return true;
	else
		return false;
}

bots_predator()
{
	if(!randomint(3)/* && self bots\bots_walk::bots_shouldGetObj()*/ && self.pers["killstreaks"][0].lifeId <= self.pers["deaths"])
	{
		self bots_doKSCamp();
	}
	
	if(level.bots_varLoadoutKS != "none" && self bots_doingNothing() && !isDefined(self.bots_RealSeen) && isDefined(self.pers["killstreaks"][0]) && self.pers["killstreaks"][0].streakName != "" && self.pers["killstreaks"][0].streakName == "predator_missile" && !isDefined(self.lastStand) && !self bots_isEmp() && bots_isReallyAlive(self))
	{
		players = [];
		target = undefined;
		if(!level.bots_varTarget.size)
		{
			foreach(player in level.players)
			{
				if(!isDefined(player.pers["team"]))
					continue;
				if(!level.bots_varTargetHost && player.pers["bots_isHost"])
					continue;
				if(player == self)
					continue;
				if(level.teamBased && self.pers["team"] == player.pers["team"])
					continue;
				if(player.sessionstate != "playing")
					continue;
				if(!bots_isReallyAlive(player))
					continue;
				if(player bots_hasPerk("specialty_coldblooded"))
					continue;
				if(!bulletTracePassed(player getTagOrigin( "j_head" ), player getTagOrigin( "j_head" )+(0,0,255), false, player) && self.pers["bots"]["skill"]["base"] > 4)
					continue;
				
				players[players.size] = player;
			}
		}
		else
		{
			foreach(player in level.players)
			{
				if(!isSubStr(player.name, level.bots_varTarget))
					continue;
				
				players[players.size] = player;
				break;
			}
		}
		if(players.size > 0)
			target = players[randomint(players.size)];
		
		if(isDefined(target) || self.pers["bots"]["skill"]["base"] < 3)
		{
			self.bots_doing = "laptop";
			lastWeapon = self getCurrentWeapon();
			self bots__giveWeapon("killstreak_predator_missile_mp", 0);
			self setspawnweapon("killstreak_predator_missile_mp");
			lifeId = self.pers["killstreaks"][0].lifeId;
			self maps\mp\killstreaks\_killstreaks::usedKillstreak( "predator_missile", true );
			self maps\mp\killstreaks\_killstreaks::shuffleKillStreaksFILO( "predator_missile" );
			
			//thanks rsev20!
			if(isDefined(target))
				rocket = MagicBullet( "remotemissile_projectile_mp", self.origin + (0.0,0.0,7000.0 - (self.pers["bots"]["skill"]["base"] * 400)), target getTagOrigin( "j_head" ), self );
			else
				rocket = MagicBullet( "remotemissile_projectile_mp", self.origin + (0.0,0.0,7000.0 - (self.pers["bots"]["skill"]["base"] * 400)), self.origin, self );
			
			rocket.lifeId = lifeId;
			rocket.type = "remote";
				
			rocket thread maps\mp\gametypes\_weapons::AddMissileToSightTraces( self.pers["team"] );
			rocket thread maps\mp\killstreaks\_remotemissile::handleDamage();
			maps\mp\killstreaks\_remotemissile::MissileEyes( self, rocket );
			
			if(bots_isReallyAlive(self))
			{
				self.bots_doing = "none";
				self setspawnweapon(lastWeapon);
				self takeweapon("killstreak_predator_missile_mp");
			}
		}
	}
}

bots_airdrop(weap)
{
	self endon("bot_kill_streak");
	self thread bots_watchAirdrop(weap);
	wait 0.05;
	for(;;)
	{
		if(!self bots_getAmmoCount(weap))
			self bots__giveWeapon(weap, 0);
		if(self getCurrentWeapon() != weap)
			self setspawnweapon(weap);
		self thread bots\bots_aim::bots_shootWeapon();
		bots_waitFrame();
	}
}

bots_watchAirdrop(weap)
{
	self endon("bot_reset");
	self endon("death");
	lastWeapon = self getCurrentWeapon();
	self bots__giveWeapon(weap, 0);
	self.bots_doing = "nade_fire";
	self setspawnweapon(weap);
	self waittill( "grenade_fire" );
	self notify("bot_kill_streak");
	self setspawnweapon(lastWeapon);
	self takeweapon(weap);
	self.bots_doing = "none";
}

bots_sentry()
{
	self maps\mp\killstreaks\_killstreaks::usedKillstreak( "sentry", true );
	sentryGun = maps\mp\killstreaks\_autosentry::createSentryForPlayer( "sentry_minigun", self );
	sentryGun maps\mp\killstreaks\_autosentry::sentry_setPlaced();
	self notify( "sentry_placement_finished", sentryGun );
	self maps\mp\killstreaks\_killstreaks::shuffleKillStreaksFILO( "sentry" );
}

bots_changeAC130weaps()
{
	self endon("bot_reset");
	self endon("bot_kill_ac130");
	for(;;)
	{
		self bots__giveWeapon("ac130_105mm_mp", 0);
		self setspawnweapon("ac130_105mm_mp");
		wait 2+(randomint(3));
		self bots__giveWeapon("ac130_40mm_mp", 0);
		self setspawnweapon("ac130_40mm_mp");
		wait 2+(randomint(4));
		self bots__giveWeapon("ac130_25mm_mp", 0);
		self setspawnweapon("ac130_25mm_mp");
		wait 2+(randomint(4));
	}
}

bots_goodToAim(target)
{
	if(!self bots_isInAC130() && !self bots_isInChopper())
		return false;
	
	if(self bots\bots_aim::bots_isPlayerGood(target))
		return true;
	else
		return false;
}

bots_ac130()
{
	lastWeapon = self getCurrentWeapon();
	self thread bots\talk::bots_giveAC130L();
	self bots__giveWeapon("ac130_105mm_mp", 0);
	self bots__giveWeapon("ac130_25mm_mp", 0);
	self bots__giveWeapon("ac130_40mm_mp", 0);
	self.bots_doing = "laptop";
	self.bots_aimDoing = "ac130";
	self thread bots_changeAC130weaps();
	while(self bots_isInAC130())
	{
		self.bots_doing = "laptop";
		self.bots_aimDoing = "ac130";
		target = self bots\bots_aim::bots_getTargetLaptopPlayer(level.ac130.planemodel);
		if(isDefined(target))
		{
			while(self bots_goodToAim(target))
			{
				self thread bots\bots_aim::bots_doAim(VectorToAngles(target gettagorigin("j_spineupper")-self getEye()), self.pers["bots"]["skill"]["aimSpeed"]);
				self thread bots\bots_aim::bots_ShootWeapon();
				bots_waitFrame();
			}
			self bots\bots_aim::bots_StopShooting();
		}
		else
		{
			self bots\bots_aim::bots_StopShooting();
		}
		bots_waitFrame();
	}
	self bots\bots_aim::bots_stopShooting();
	self notify("bot_kill_ac130");
	self setspawnweapon(lastWeapon);
	self takeWeapon("ac130_105mm_mp");
	self takeWeapon("ac130_25mm_mp");
	self takeWeapon("ac130_40mm_mp");
	self.bots_doing = "none";
	self.bots_aimDoing = "none";
}

bots_chopper()
{
	lastWeapon = self getCurrentWeapon();
	self bots__giveWeapon("heli_remote_mp", 0);
	self setspawnweapon("heli_remote_mp");
	self.bots_doing = "laptop";
	self.bots_aimDoing = "chopper";
	self thread bots\talk::bots_giveChopperL();
	while(self bots_isInChopper())
	{
		self.bots_doing = "laptop";
		self.bots_aimDoing = "chopper";
		if(self getCurrentWeapon() != "heli_remote_mp")
			self setspawnweapon("heli_remote_mp");
		target = self bots\bots_aim::bots_getTargetLaptopPlayer(level.chopper);
		if(isDefined(target))
		{
			while(self bots_goodToAim(target))
			{
				self thread bots\bots_aim::bots_doAim(VectorToAngles(target gettagorigin("j_spineupper")-self getEye()), self.pers["bots"]["skill"]["aimSpeed"]+2);
				self thread bots\bots_aim::bots_ShootWeapon();
				bots_waitFrame();
			}
			self bots\bots_aim::bots_StopShooting();
		}
		else
		{
			self bots\bots_aim::bots_StopShooting();
		}
		bots_waitFrame();
	}
	self bots\bots_aim::bots_stopShooting();
	self setspawnweapon(lastWeapon);
	self takeWeapon("heli_remote_mp");
	self.bots_doing = "none";
	self.bots_aimDoing = "none";
}

bots_isEmp()
{
	if((level.teamBased && level.teamEMPed[self.team]) || (!level.teamBased && isDefined( level.empPlayer ) && level.empPlayer != self))
		return true;
	else
		return false;
}

bots_enemyHarrier()
{
	if(!level.planes)
		return false;
	
	if(level.teamBased)
	{
		foreach( harrier in level.harriers )
		{
			if(harrier.team == self.pers["team"])
				continue;
			
			return true;
		}
	}
	else
	{
		foreach( harrier in level.harriers )
		{
			if ( isDefined( harrier.owner ) && harrier.owner == self )
				continue;
			
			return true;
		}
	}
	
	return false;
}

bots_setupBotStreaks()
{
	if(self.pers["bots"]["killstreaks"]["set"])
		return;
	
	self.pers["bots"]["killstreaks"][0] = "none";
	self.pers["bots"]["killstreaks"][1] = "none";
	self.pers["bots"]["killstreaks"][2] = "none";
	
	switch(level.bots_varLoadoutKS)
	{
		case "random":
			for(i=0;i<3;)
			{
				switch(randomint(15))
				{
					case 0:
						if(self.pers["bots"]["killstreaks"][0] != "uav" && self.pers["bots"]["killstreaks"][1] != "uav" && self.pers["bots"]["killstreaks"][2] != "uav")
						{
							self.pers["bots"]["killstreaks"][i] = "uav";
							i++;
						}
					break;
					case 1:
						if((self.pers["bots"]["killstreaks"][0] != "counter_uav" && self.pers["bots"]["killstreaks"][1] != "counter_uav" && self.pers["bots"]["killstreaks"][2] != "counter_uav") && (self.pers["bots"]["killstreaks"][0] != "airdrop" && self.pers["bots"]["killstreaks"][1] != "airdrop" && self.pers["bots"]["killstreaks"][2] != "airdrop"))
						{
							self.pers["bots"]["killstreaks"][i] = "counter_uav";
							i++;
						}
					break;
					case 2:
						if((self.pers["bots"]["killstreaks"][0] != "counter_uav" && self.pers["bots"]["killstreaks"][1] != "counter_uav" && self.pers["bots"]["killstreaks"][2] != "counter_uav") && (self.pers["bots"]["killstreaks"][0] != "airdrop" && self.pers["bots"]["killstreaks"][1] != "airdrop" && self.pers["bots"]["killstreaks"][2] != "airdrop"))
						{
							self.pers["bots"]["killstreaks"][i] = "airdrop";
							i++;
						}
					break;
					case 3:
						if((self.pers["bots"]["killstreaks"][0] != "predator_missile" && self.pers["bots"]["killstreaks"][1] != "predator_missile" && self.pers["bots"]["killstreaks"][2] != "predator_missile") && (self.pers["bots"]["killstreaks"][0] != "airdrop_sentry_minigun" && self.pers["bots"]["killstreaks"][1] != "airdrop_sentry_minigun" && self.pers["bots"]["killstreaks"][2] != "airdrop_sentry_minigun"))
						{
							self.pers["bots"]["killstreaks"][i] = "predator_missile";
							i++;
						}
					break;
					case 4:
						if((self.pers["bots"]["killstreaks"][0] != "predator_missile" && self.pers["bots"]["killstreaks"][1] != "predator_missile" && self.pers["bots"]["killstreaks"][2] != "predator_missile") && (self.pers["bots"]["killstreaks"][0] != "airdrop_sentry_minigun" && self.pers["bots"]["killstreaks"][1] != "airdrop_sentry_minigun" && self.pers["bots"]["killstreaks"][2] != "airdrop_sentry_minigun"))
						{
							self.pers["bots"]["killstreaks"][i] = "airdrop_sentry_minigun";
							i++;
						}
					break;
					case 5:
						if(self.pers["bots"]["killstreaks"][0] != "precision_airstrike" && self.pers["bots"]["killstreaks"][1] != "precision_airstrike" && self.pers["bots"]["killstreaks"][2] != "precision_airstrike")
						{
							self.pers["bots"]["killstreaks"][i] = "precision_airstrike";
							i++;
						}
					break;
					case 6:
						if((self.pers["bots"]["killstreaks"][0] != "helicopter" && self.pers["bots"]["killstreaks"][1] != "helicopter" && self.pers["bots"]["killstreaks"][2] != "helicopter") && (self.pers["bots"]["killstreaks"][0] != "harrier_airstrike" && self.pers["bots"]["killstreaks"][1] != "harrier_airstrike" && self.pers["bots"]["killstreaks"][2] != "harrier_airstrike"))
						{
							self.pers["bots"]["killstreaks"][i] = "helicopter";
							i++;
						}
					break;
					case 7:
						if((self.pers["bots"]["killstreaks"][0] != "helicopter" && self.pers["bots"]["killstreaks"][1] != "helicopter" && self.pers["bots"]["killstreaks"][2] != "helicopter") && (self.pers["bots"]["killstreaks"][0] != "harrier_airstrike" && self.pers["bots"]["killstreaks"][1] != "harrier_airstrike" && self.pers["bots"]["killstreaks"][2] != "harrier_airstrike"))
						{
							self.pers["bots"]["killstreaks"][i] = "harrier_airstrike";
							i++;
						}
					break;
					case 8:
						if(self.pers["bots"]["killstreaks"][0] != "airdrop_mega" && self.pers["bots"]["killstreaks"][1] != "airdrop_mega" && self.pers["bots"]["killstreaks"][2] != "airdrop_mega")
						{
							self.pers["bots"]["killstreaks"][i] = "airdrop_mega";
							i++;
						}
					break;
					case 9:
						if((self.pers["bots"]["killstreaks"][0] != "stealth_airstrike" && self.pers["bots"]["killstreaks"][1] != "stealth_airstrike" && self.pers["bots"]["killstreaks"][2] != "stealth_airstrike") && (self.pers["bots"]["killstreaks"][0] != "helicopter_flares" && self.pers["bots"]["killstreaks"][1] != "helicopter_flares" && self.pers["bots"]["killstreaks"][2] != "helicopter_flares"))
						{
							self.pers["bots"]["killstreaks"][i] = "stealth_airstrike";
							i++;
						}
					break;
					case 10:
						if((self.pers["bots"]["killstreaks"][0] != "stealth_airstrike" && self.pers["bots"]["killstreaks"][1] != "stealth_airstrike" && self.pers["bots"]["killstreaks"][2] != "stealth_airstrike") && (self.pers["bots"]["killstreaks"][0] != "helicopter_flares" && self.pers["bots"]["killstreaks"][1] != "helicopter_flares" && self.pers["bots"]["killstreaks"][2] != "helicopter_flares"))
						{
							self.pers["bots"]["killstreaks"][i] = "helicopter_flares";
							i++;
						}
					break;
					case 11:
						if((self.pers["bots"]["killstreaks"][0] != "ac130" && self.pers["bots"]["killstreaks"][1] != "ac130" && self.pers["bots"]["killstreaks"][2] != "ac130") && (self.pers["bots"]["killstreaks"][0] != "helicopter_minigun" && self.pers["bots"]["killstreaks"][1] != "helicopter_minigun" && self.pers["bots"]["killstreaks"][2] != "helicopter_minigun"))
						{
							self.pers["bots"]["killstreaks"][i] = "ac130";
							i++;
						}
					break;
					case 12:
						if((self.pers["bots"]["killstreaks"][0] != "ac130" && self.pers["bots"]["killstreaks"][1] != "ac130" && self.pers["bots"]["killstreaks"][2] != "ac130") && (self.pers["bots"]["killstreaks"][0] != "helicopter_minigun" && self.pers["bots"]["killstreaks"][1] != "helicopter_minigun" && self.pers["bots"]["killstreaks"][2] != "helicopter_minigun"))
						{
							self.pers["bots"]["killstreaks"][i] = "helicopter_minigun";
							i++;
						}
					break;
					case 13:
						if(self.pers["bots"]["killstreaks"][0] != "emp" && self.pers["bots"]["killstreaks"][1] != "emp" && self.pers["bots"]["killstreaks"][2] != "emp")
						{
							self.pers["bots"]["killstreaks"][i] = "emp";
							i++;
						}
					break;
					case 14:
						if(self.pers["bots"]["killstreaks"][0] != "nuke" && self.pers["bots"]["killstreaks"][1] != "nuke" && self.pers["bots"]["killstreaks"][2] != "nuke")
						{
							self.pers["bots"]["killstreaks"][i] = "nuke";
							i++;
						}
					break;
				}
			}
		break;
		case "default":
			switch(randomint(6))
			{
				case 0:
					self thread bots\talk::bots_onNukeStreaks();
					self.pers["bots"]["killstreaks"][2] = "nuke";
					if(randomint(2))
						self.pers["bots"]["killstreaks"][1] = "helicopter_minigun";
					else
						self.pers["bots"]["killstreaks"][1] = "ac130";
					
					self.pers["bots"]["killstreaks"][0] = "harrier_airstrike";
				break;
				case 1:
					self.pers["bots"]["killstreaks"][0] = "uav";
					self.pers["bots"]["killstreaks"][1] = "counter_uav";
					if(randomint(2))
						self.pers["bots"]["killstreaks"][2] = "predator_missile";
					else
						self.pers["bots"]["killstreaks"][2] = "harrier_airstrike";
				break;
				case 2:
					self.pers["bots"]["killstreaks"][0] = "airdrop";
					self.pers["bots"]["killstreaks"][1] = "airdrop_sentry_minigun";
					self.pers["bots"]["killstreaks"][2] = "airdrop_mega";
				break;
				case 3:
					self.pers["bots"]["killstreaks"][0] = "predator_missile";
					self.pers["bots"]["killstreaks"][1] = "harrier_airstrike";
					self.pers["bots"]["killstreaks"][2] = "helicopter_flares";
				break;
				case 4:
					self.pers["bots"]["killstreaks"][0] = "helicopter";
					self.pers["bots"]["killstreaks"][1] = "helicopter_flares";
					self.pers["bots"]["killstreaks"][2] = "helicopter_minigun";
				break;
				case 5:
					self.pers["bots"]["killstreaks"][0] = "precision_airstrike";
					self.pers["bots"]["killstreaks"][1] = "harrier_airstrike";
					self.pers["bots"]["killstreaks"][2] = "stealth_airstrike";
				break;
			}
		break;
		case "level":
			self.pers["bots"]["killstreaks"][0] = "uav";
			self.pers["bots"]["killstreaks"][1] = "airdrop";
			self.pers["bots"]["killstreaks"][2] = "predator_missile";
			
			rankId = self maps\mp\gametypes\_rank::getRankForXp( self getPlayerData( "experience" ) );
			
			if(rankId >= 9)
			{
				kss = strTok("uav,counter_uav,airdrop,airdrop_sentry_minigun,airdrop_mega,precision_airstrike,predator_missile,emp,nuke,harrier_airstrike,stealth_airstrike,helicopter,helicopter_flares,helicopter_minigun,ac130", ",");
				
				ks = kss[randomint(kss.size)];
				choosenKs1 = ks;
				
				ksVal = int( tableLookup( "mp/killstreakTable.csv", 1, ks, 4 ) );
				
				myKsVal1 = int( tableLookup( "mp/killstreakTable.csv", 1, self.pers["bots"]["killstreaks"][0], 4 ) );
				myKsVal2 = int( tableLookup( "mp/killstreakTable.csv", 1, self.pers["bots"]["killstreaks"][1], 4 ) );
				myKsVal3 = int( tableLookup( "mp/killstreakTable.csv", 1, self.pers["bots"]["killstreaks"][2], 4 ) );
				
				if(ksVal == myKsVal1)
				{
					self.pers["bots"]["killstreaks"][0] = ks;
				}
				else if(ksVal == myKsVal2)
				{
					self.pers["bots"]["killstreaks"][1] = ks;
				}
				else if(ksVal == myKsVal3)
				{
					self.pers["bots"]["killstreaks"][2] = ks;
				}
				else
				{
					ran = randomint(3);
					if(ran == 0)
					{
						self.pers["bots"]["killstreaks"][0] = ks;
					}
					else if(ran == 1)
					{
						self.pers["bots"]["killstreaks"][1] = ks;
					}
					else
					{
						self.pers["bots"]["killstreaks"][2] = ks;
					}
				}
				
				if(rankId >= 14)
				{
					ks = kss[randomint(kss.size)];
					
					while(choosenKs1 == ks)
						ks = kss[randomint(kss.size)];
					
					choosenKs2 = ks;
				
					ksVal = int( tableLookup( "mp/killstreakTable.csv", 1, ks, 4 ) );
					
					myKsVal1 = int( tableLookup( "mp/killstreakTable.csv", 1, self.pers["bots"]["killstreaks"][0], 4 ) );
					myKsVal2 = int( tableLookup( "mp/killstreakTable.csv", 1, self.pers["bots"]["killstreaks"][1], 4 ) );
					myKsVal3 = int( tableLookup( "mp/killstreakTable.csv", 1, self.pers["bots"]["killstreaks"][2], 4 ) );
					
					if(ksVal == myKsVal1)
					{
						self.pers["bots"]["killstreaks"][0] = ks;
					}
					else if(ksVal == myKsVal2)
					{
						self.pers["bots"]["killstreaks"][1] = ks;
					}
					else if(ksVal == myKsVal3)
					{
						self.pers["bots"]["killstreaks"][2] = ks;
					}
					else
					{
						ran = randomint(3);
						if(ran == 0)
						{
							self.pers["bots"]["killstreaks"][0] = ks;
						}
						else if(ran == 1)
						{
							self.pers["bots"]["killstreaks"][1] = ks;
						}
						else
						{
							self.pers["bots"]["killstreaks"][2] = ks;
						}
					}
					
					if(rankId >= 22)
					{
						ks = kss[randomint(kss.size)];
					
						while(choosenKs1 == ks || choosenKs2 == ks)
							ks = kss[randomint(kss.size)];
					
						ksVal = int( tableLookup( "mp/killstreakTable.csv", 1, ks, 4 ) );
						
						myKsVal1 = int( tableLookup( "mp/killstreakTable.csv", 1, self.pers["bots"]["killstreaks"][0], 4 ) );
						myKsVal2 = int( tableLookup( "mp/killstreakTable.csv", 1, self.pers["bots"]["killstreaks"][1], 4 ) );
						myKsVal3 = int( tableLookup( "mp/killstreakTable.csv", 1, self.pers["bots"]["killstreaks"][2], 4 ) );
						
						if(ksVal == myKsVal1)
						{
							self.pers["bots"]["killstreaks"][0] = ks;
						}
						else if(ksVal == myKsVal2)
						{
							self.pers["bots"]["killstreaks"][1] = ks;
						}
						else if(ksVal == myKsVal3)
						{
							self.pers["bots"]["killstreaks"][2] = ks;
						}
						else
						{
							ran = randomint(3);
							if(ran == 0)
							{
								self.pers["bots"]["killstreaks"][0] = ks;
							}
							else if(ran == 1)
							{
								self.pers["bots"]["killstreaks"][1] = ks;
							}
							else
							{
								self.pers["bots"]["killstreaks"][2] = ks;
							}
						}
					}
				}
			}
		break;
	}
	
	self setPlayerData("killstreaks", 0, self.pers["bots"]["killstreaks"][0]);
	self setPlayerData("killstreaks", 1, self.pers["bots"]["killstreaks"][1]);
	self setPlayerData("killstreaks", 2, self.pers["bots"]["killstreaks"][2]);
}