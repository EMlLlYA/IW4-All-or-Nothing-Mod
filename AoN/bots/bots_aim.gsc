#include bots\bots_funcs;

bots_MainAimbot()
{
	self endon("bot_reset");
	self endon("death");
	
	for(i=0;;i++)
	{
		if(self bots_shouldAim())
		{
			if(self bots_isClimbing())
			{
				self bots_doClimbingAim();
			}
			else
			{
				if(i == 1 && self bots_canTDKS())
					killstreak = self bots_getTargetKillstreak();
				else
					killstreak = undefined;
				if(isDefined(killstreak))
				{
					self bots_doKillKillstreak(killstreak);
				}
				else
				{
					//if(i == 11)
						target = self bots_getTargetOnFootPlayer();
					//else
					//	target = undefined;
					if(isDefined(target))
					{
						self bots_doKillOnFootPlayer(target);
					}
					else
					{
						if(i == 6 && self bots_canKillEqu())
							equ = self bots_getTargetEquipment();
						else
							equ = undefined;
						if(isDefined(equ) && (equ.bots_EquipmentType != 2 || !self.bots_camping))
						{
							self bots_doKillEqu(equ);
						}
						else
						{
							if(i == 16)
							{
								self thread bots_checkSwitchWeap();
								self thread bots_doGNade();
							}
							self bots_stopShooting();
							if(!self maps\mp\_flashgrenades::isFlashbanged())
							{
								if(isDefined(self.bots_campingAngles))
									angles = self.bots_campingAngles;
								else if(isDefined(level.waypoints[self.bots_secondNextWp]) && self.pers["bots"]["skill"]["base"] && !self.bots_running)
									angles = VectorToAngles(((level.waypoints[self.bots_secondNextWp].origin-self.origin)-(anglesToForward(self getplayerangles()))));
								else
									angles = VectorToAngles(((self.bots_tempwp-self.origin)-(anglesToForward(self getplayerangles()))));
								
								aimSpeed = self.pers["bots"]["skill"]["aimSpeed"];
								if(self bots_isArtShocked() || self bots_IsStunned())
									aimSpeed = 15;
								
								self thread bots_doAim(angles, aimSpeed);
							}
						}
					}
				}
			}
		}
		if(i > 18)
			i = 0;
		bots_waitFrame();//wait 0.05//which is 20fps
	}
}

bots_doAim(angles, speed)
{
	self notify("bots_aim_overlap");
	self endon("bots_aim_overlap");
	self endon("bot_reset");
	self endon("death");
	
	if(level.bots_varPlayAnim == 2)
		self setPlayerAngles(angles);
	else
		self bots_setPlayerAngesReal(angles, speed);
}

bots_doKillEqu(equ)
{
	self.bots_realEqu = equ;
	while(self bots_isGoodToAimAtEqu(equ))
	{
		self thread bots_checkSwitchWeap(equ);
		
		isTI = (equ.bots_EquipmentType == 2);
		if(!isTI)
			self bots_shootWeapon();
		
		if(!self maps\mp\_flashgrenades::isFlashbanged())
		{
			if(!isTI)
				self thread bots_doGNadeTarget(equ);
			
			if(equ.bots_EquipmentType == 0)
			{
				lookLoc = equ.origin + (0.0, 0.0, 35.0);
				self thread bots_melee(equ);
			}
			else
			{
				lookLoc = equ.origin + (0.0, 0.0, 5.0);
				if(!isTI)
				{
					if(!randomint(25) && self.pers["bots"]["skill"]["base"] > 4 && self.bots_firing)
						equ notify( "damage", 5, self );
				}
			}
			
			weapon = self getCurrentWeapon();
			myEye = self getEye();
			dis = Distance(myEye, lookLoc);
			
			if(weaponClass(weapon) == "grenade" || weapon == "throwingknife_mp")
			{
				if(bots_getWeaponClass(weapon) == "weapon_projectile")
				{
					dist = (dis*(dis/400.0))/40.0;
					angles = VectorToAngles( ( lookLoc ) - ( myEye ) + (0.0,0.0,dist) );
				}
				else
				{
					dist = (dis*(dis/200.0))/15.0;
					angles = VectorToAngles( ( lookLoc ) - ( myEye ) + (0.0,0.0,dist) );
				}
			}
			else
			{
				angles = VectorToAngles( ( lookLoc ) - ( myEye ) );
			}
			
			aimSpeed = self.pers["bots"]["skill"]["aimSpeed"];
			if(self bots_isArtShocked() || self bots_IsStunned())
				aimSpeed = 15;
			
			self thread bots_doAim(angles, aimSpeed);
		}
		bots_waitFrame();
	}
	self.bots_realEqu = undefined;
	self bots_stopShooting();
}

bots_doKillKillstreak(killstreak)
{
	if((self bots_getAmmoCount("stinger_mp") || self bots_getAmmoCount("rpg_mp") || self bots_getAmmoCount("at4_mp")) && weaponClass(self getCurrentWeapon()) != "rocketlauncher")
		self bots_SwitchToOff(true);
	
	self.bots_realTarKS = killstreak;
	self bots_doAntiAir(killstreak);
	self.bots_realTarKS = undefined;
}

bots_cleanUpStinger()
{
	self endon("disconnect");
	wait 0.1;
	self.stingerTarget = undefined;
}

bots_doAntiAir(tarKS)
{
	tarKS endon("death");

	weap = self getCurrentWeapon();
	if(weap == "stinger_mp" || weap == "at4_mp")
	{
		if(!self bots_canSwitch())
			return;
		
		self bots_rocketWait(tarKS);
		
		if(isDefined(tarKS) && (self bots_getAmmoCount("stinger_mp") || self bots_getAmmoCount("at4_mp")))
		{
			myEye = self getEye();
			if (bulletTracePassed( myEye, tarKS.origin, false, tarKS ) )
			{
				weap = self getCurrentWeapon();
				if(weap == "stinger_mp" || weap == "at4_mp")
				{
					clip = self bots_getWeaponAmmoClip(weap);
					if(clip)
					{
						self bots_SetWeaponAmmoClip(weap, clip-1);
						self bots\talk::bots_AntiAir(weap, tarKS);//say stuff about anti air
						rocket = MagicBullet(weap, myEye, tarKS.origin, self );
						rocket Missile_SetTargetEnt( tarKS );
						self.stingerTarget = tarks;
						self thread bots_cleanUpStinger();
						wait 0.05;
						if(isDefined(tarKS) && isDefined(rocket))
						{
							self notify( "missile_fire", rocket, weap );
							wait 0.05;
						}
					}
					
					if(self bots_getAmmoCount(weap))
						self bots_ShootWeapon();
				}
			}
		}
	}
	else
	{
		while(self bots_isGoodToAimAtKS(tarKS))
		{
			if(!self maps\mp\_flashgrenades::isFlashbanged())
			{
				angles = VectorToAngles((tarKS.origin-self.origin)-(anglesToForward(self getplayerangles())));
				
				aimSpeed = self.pers["bots"]["skill"]["aimSpeed"];
				if(self bots_isArtShocked() || self bots_IsStunned())
					aimSpeed = 15;
				
				self thread bots_doAim(angles, aimSpeed);
			}
			self thread bots_checkSwitchWeap(tarKS);
			self bots_ShootWeapon();
			bots_waitFrame();
		}
		self bots_stopShooting();
	}
}

bots_rocketWait(tarKS)
{
	self endon("bot_rocket_kill");
	self thread bots_doNoneOnKSDeath(tarks);
	self thread bots_doNoneOnKSNoTrace(tarks);
	
	self.bots_doing = "rocket_lock";
	self.bots_aimDoing = "rocket_lock";
	
	self thread bots_watchRocketWait(tarKS);
	wait 3;
	self notify("bot_rocketwait_kill");
	
	self thread bots_watchRocketWait2(tarks);
	wait 1;
	self notify("bot_rocketwait_kill");
	
	self.bots_doing = "none";
	self.bots_aimDoing = "none";
	self notify("bot_rocket_kill");
}

bots_doNoneOnKSDeath(tarKS)
{
	self endon("bot_reset");
	self endon("death");
	self endon("bot_rocket_kill");
	tarKS waittill("death");
	self.bots_doing = "none";
	self.bots_aimDoing = "none";
}

bots_doNoneOnKSNoTrace(tarKS)
{
	self endon("bot_reset");
	self endon("death");
	self endon("bot_rocket_kill");
	tarKS endon("death");
	
	while(self bots_isKSGood(tarKS))
	{
		self.bots_aimDoing = "rocket_lock";
		
		weap = self getCurrentWeapon();
		if(weap == "at4_mp" || weap == "stinger_mp")
		{
			if(weap == "stinger_mp")
				self bots_shootWeapon();
			else
				self bots_stopShooting();
		}
		else
		{
			self.bots_doing = "none";
			self.bots_aimDoing = "none";
			self notify("bot_rocket_kill");
		}
		
		if(!self maps\mp\_flashgrenades::isFlashbanged())
		{
			angles = VectorToAngles((tarKS.origin-self.origin)-(anglesToForward(self getplayerangles())));
			
			aimSpeed = self.pers["bots"]["skill"]["aimSpeed"];
			if(self bots_isArtShocked() || self bots_IsStunned())
				aimSpeed = 15;
			
			self thread bots_doAim(angles, aimSpeed);
		}
		
		bots_waitFrame();
	}
	
	self.bots_doing = "none";
	self.bots_aimDoing = "none";
	self notify("bot_rocket_kill");
}

bots_watchRocketWait(tarKS)
{
	self endon("bot_reset");
	self endon("death");
	tarKS endon("death");
	self endon("bot_rocketwait_kill");
	self endon("bot_rocket_kill");
	for(;;)
	{
		self.bots_doing = "rocket_lock";
		if(isDefined(tarKS))
		{
			if ( isDefined( level.chopper ) && isDefined( level.chopper.gunner ) && tarKS == level.chopper )
				level.chopper.gunner playLocalSound( "missile_locking" );

			if ( isDefined( level.ac130player ) && tarKS == level.ac130.planeModel )
				level.ac130player playLocalSound( "missile_locking" );
			
			self playLocalSound( "stinger_locking" );
			self PlayRumbleOnEntity( "ac130_25mm_fire" );
		}
		wait 0.6;
	}
}

bots_watchRocketWait2(tarKS)
{
	self endon("bot_reset");
	self endon("death");
	tarKS endon("death");
	self endon("bot_rocketwait_kill");
	self endon("bot_rocket_kill");
	for(;;)
	{
		self.bots_doing = "rocket_lock";
		if(isDefined(tarKS))
		{
			if ( isDefined( level.chopper ) && isDefined( level.chopper.gunner ) && tarKS == level.chopper )
				level.chopper.gunner playLocalSound( "missile_locking" );

			if ( isDefined( level.ac130player ) && tarKS == level.ac130.planeModel )
				level.ac130player playLocalSound( "missile_locking" );
			
			self playLocalSound( "stinger_locked" );
			self PlayRumbleOnEntity( "ac130_25mm_fire" );
		}
		wait 0.25;
	}
}

bots_doKillWait()
{
	self endon("bot_reset");
	self endon("death");
	self endon("bot_kill_wait");
	wait self.pers["bots"]["skill"]["shootDelay"];
	self notify("bot_kill_wait");
}

bots_doSkillWait(target, lookLoc)
{
	if(self.pers["bots"]["skill"]["shootDelay"] <= 0.0)
		return;
	
	self endon("bot_kill_wait");
	self thread bots_doKillWait();
	while(!self bots_isClimbing() && self bots_shouldAim() && self bots_isGoodToAimAtPlayer(target))
	{
		if(!self maps\mp\_flashgrenades::isFlashbanged())
		{
			if(isDefined(self.bots_campingAngles))
				angles = self.bots_campingAngles;
			else if(isDefined(lookLoc))
				angles = VectorToAngles( ( lookLoc ) - ( self getTagOrigin( "j_head" ) ) );
			else if(isDefined(level.waypoints[self.bots_secondNextWp]) && self.pers["bots"]["skill"]["base"] && !self.bots_running)
				angles = VectorToAngles(((level.waypoints[self.bots_secondNextWp].origin-self.origin)-(anglesToForward(self getplayerangles()))));
			else 
				angles = VectorToAngles(((self.bots_tempwp-self.origin)-(anglesToForward(self getplayerangles()))));
			
			aimSpeed = self.pers["bots"]["skill"]["aimSpeed"];
			if(self bots_isArtShocked() || self bots_IsStunned())
				aimSpeed = 15;
			
			self thread bots_doAim(angles, aimSpeed);
		}
		bots_waitFrame();
	}
	self notify("bot_kill_wait");
}

bots_doKillWaitEnd()
{
	self endon("bot_reset");
	self endon("death");
	self endon("bot_kill_wait");
	wait self.pers["bots"]["skill"]["newTarg"];
	self notify("bot_kill_wait");
}

bots_doSkillWaitEnd(target, lookLoc)
{
	if(self.pers["bots"]["skill"]["newTarg"] <= 0.0)
		return;
	
	self endon("bot_kill_wait");
	self thread bots_doKillWaitEnd();
	while(!self bots_isClimbing() && self bots_shouldAim() && !self bots_isPlayerGood(target))
	{
		if(!self maps\mp\_flashgrenades::isFlashbanged())
		{
			if(isDefined(self.bots_campingAngles))
				angles = self.bots_campingAngles;
			else if(isDefined(lookLoc))
				angles = VectorToAngles( ( lookLoc ) - ( self getTagOrigin( "j_head" ) ) );
			else if(isDefined(level.waypoints[self.bots_secondNextWp]) && self.pers["bots"]["skill"]["base"] && !self.bots_running)
				angles = VectorToAngles(((level.waypoints[self.bots_secondNextWp].origin-self.origin)-(anglesToForward(self getplayerangles()))));
			else
				angles = VectorToAngles(((self.bots_tempwp-self.origin)-(anglesToForward(self getplayerangles()))));
			
			aimSpeed = self.pers["bots"]["skill"]["aimSpeed"];
			if(self bots_isArtShocked() || self bots_IsStunned())
				aimSpeed = 15;
			
			self thread bots_doAim(angles, aimSpeed);
		}
		bots_waitFrame();
	}
	self notify("bot_kill_wait");
}

bots_doKillOnFootPlayer(target)
{
	lookLoc = undefined;
	while(self bots_isGoodToAimAtPlayer(target))
	{
		self bots_doSkillWait(target, lookLoc);
		self.bots_realSeen = target;
		self thread bots\talk::bots_doMessage();
		while(self bots_isGoodToAimAtPlayer(target))
		{
			self thread bots_checkSwitchWeap(target);
			if(!self maps\mp\_flashgrenades::isFlashbanged())
			{
				self thread bots_doGNadeTarget(target);
				self thread bots_melee(target);
				
				weapon = self getCurrentWeapon();
				lookLoc = target getTagOrigin( "j_spineupper" );
				
				myEye = self getEye();
				dis = Distance(myEye, lookLoc);
				
				if(weaponClass(weapon) == "grenade" || weapon == "throwingknife_mp")
				{
					if(bots_getWeaponClass(weapon) == "weapon_projectile")
					{
						dist = (dis*(dis/400.0))/40.0;
						angles = VectorToAngles( ( lookLoc ) - ( myEye ) + (0.0,0.0,dist) );
					}
					else
					{
						dist = (dis*(dis/200.0))/15.0;
						angles = VectorToAngles( ( lookLoc ) - ( myEye ) + (0.0,0.0,dist) );
					}
				}
				else
				{
					angles = VectorToAngles( ( lookLoc ) - ( myEye ) );
				}
				
				aimSpeed = self.pers["bots"]["skill"]["aimSpeed"];
				if(self bots_isArtShocked() || self bots_IsStunned())
					aimSpeed = 15;
				
				self thread bots_doAim(angles, aimSpeed);
			}
			self bots_shootWeapon();
			bots_waitFrame();
		}
		self.bots_realSeen = undefined;
		self bots_doSkillWaitEnd(target, lookLoc);
	}
	self bots_stopShooting();
	
	if(isDefined(target))
	{
		if(bots_isReallyAlive(target))
		{
			self.bots_lastSeen[target.guid] = getTime();
			if(isDefined(lookLoc))
				self thread bots_doGNadeLoc(lookLoc);
		}
		else
		{
			self.bots_lastSeen[target.guid] = undefined;
		}
	}
}

bots_doClimbingAim()
{
	while(self bots_isClimbing())
	{
		self bots_stopShooting();
		if(!self maps\mp\_flashgrenades::isFlashbanged())
		{
			if(isdefined(level.waypoints[self.bots_currentStaticWp]) && isdefined(level.waypoints[self.bots_currentStaticWp].angles))
				angles = level.waypoints[self.bots_currentStaticWp].angles;
			else if(isDefined(level.waypoints[self.bots_secondNextWp]) && self.pers["bots"]["skill"]["base"] && !self.bots_running)
				angles = VectorToAngles(((level.waypoints[self.bots_secondNextWp].origin-self.origin)-(anglesToForward(self getplayerangles()))));
			else
				angles = VectorToAngles(((self.bots_tempwp-self.origin)-(anglesToForward(self getplayerangles()))));
			
			aimSpeed = self.pers["bots"]["skill"]["aimSpeed"];
			if(self bots_isArtShocked() || self bots_IsStunned())
				aimSpeed = 15;
			
			self thread bots_doAim(angles, aimSpeed);
		}
		bots_waitFrame();
	}
}

bots_shootOnce()
{
	self endon("bot_reset");
	self endon("death");
	self.bots_shootTime = true;
	self bots_freezeControls(false);
	wait 0.15;
	self bots_freezeControls(true);
	theNum = self.pers["bots"]["skill"]["base"]/10;
	
	if(theNum >= 0.75)
		theNum = 0.745;
	if(theNum < 0)
		theNum = 0;
		
	wait 0.75 - theNum;
	self.bots_shootTime = false;
}

bots_ShootWeapon()
{
	if( isDefined( level.bots_semiAuto[ bots_getBaseWeaponName( self getCurrentWeapon() ) ] ) )
	{
		if(!self.bots_shootTime)
		{
			if(self bots_CanShoot())
			{
				self thread bots_shootOnce();
			}
			else
			{
				self bots_freezeControls(true);
			}
		}
	}
	else
	{
		if(self bots_CanShoot())
		{
			self bots_freezeControls(false);
		}
		else
		{
			self bots_freezeControls(true);
		}
	}
}

bots_checkSwitchWeap(target)
{
	self endon("bot_reset");
	self endon("death");
	
	if(!self bots_canSwitch())
		return;
	
	weapon = self getCurrentWeapon();
	isDef = isDefined(target);
	
	if(isDef)
	{
		sec = self bots_tryGetGoodWeap(self bots_getSecondariesName());
		if(weaponClass(sec) == "spread")
		{
			if(Distance(self.origin, target.origin) < 500.0)
			{
				if(weaponClass(weapon) != "spread" && !randomint(5))
				{
					self bots_SwitchToOff();
					return;
				}
			}
			else
			{
				if(weaponClass(weapon) == "spread" && self.pers["bots"]["trait"]["playStyle"] != 2)
				{
					self bots_SwitchToOff();
					return;
				}
			}
		}
		else if(self.pers["bots"]["trait"]["playStyle"] == 1)
		{
			if(isSubStr(sec, "tactical_") && !isSubStr(weapon, "tactical_"))
			{
				self bots_SwitchToOff();
				return;
			}
		}
		
		if(isDefined(level.bots_forceSwitch[weapon]) || (self.pers["bots"]["trait"]["playStyle"] == 2 && self bots_isValidPrimary(bots_getBaseWeaponName(weapon))))
		{
			self bots_SwitchToOff();
			return;
		}
	}
	
	if(self.pers["bots"]["trait"]["switch"] <= 0)
		return;
	
	if(isDef)
		rand = self.pers["bots"]["trait"]["switch"];
	else
		rand = int(self.pers["bots"]["trait"]["switch"]*4);
	
	if(rand < 4)
		rand = 4;
	
	rnd = bots_randomInt(rand);
		
	if(!self bots_getAmmoCount(weapon) || (!self bots_getWeaponAmmoClip( weapon ) && (rnd == 2 || rnd == 3 || rnd == 0)) || (rnd == 1 && (!isDef || self.hasRiotShieldEquipped)))
	{
		self bots_SwitchToOff();
		return;
	}
}

bots_doSwitchTime()
{
	self endon("bot_reset");
	self endon("death");
	self.bots_switchTime = true;
	wait 2.5;
	self.bots_switchTime = false;
}

bots_SwitchToOff(pref, reverse)
{
	if(self bots_canSwitch() && !self.bots_switchTime)
	{
		lastWeapon = self getCurrentWeapon();
		primary = bots_tryGetGoodWeap(self bots_getPrimariesName());
		secondary = self bots_tryGetGoodWeap(self bots_getSecondariesName());
		weap = undefined;
		
		if(!isDefined(pref))
		{
			if(isDefined(secondary) && (!isDefined(primary) || (isDefined(primary) && lastWeapon == primary)) && level.bots_varLoadoutSecondary)
				weap = secondary;
			else if(isDefined(primary))
				weap = primary;
		}
		else
		{
			if(!isDefined(reverse))
				weap = pref;
			else
			{
				weaps = [];
				if(isDefined(primary))
					weaps[weaps.size] = primary;
				if(isDefined(secondary))
					weaps[weaps.size] = secondary;
				
				for(i = 0; i < weaps.size; i++)
				{
					if(weaps[i] == pref)
						continue;
					
					weap = weaps[i];
					break;
				}
			}
		}
		
		if(isDefined(weap))
		{
			self setspawnweapon(weap);
			self bots_stopShooting();
			
			if(lastWeapon != weap && lastWeapon != "none")
			{
				self.bots_doing = "switch";
				self thread bots_doSwitchTime();
				wait 1;
				self.bots_doing = "none";
			}
		}
	}
}

bots_doNoneOnGNadeAmmo(weap, lastWeap)
{
	self endon("death");
	self endon("bot_reset");
	self endon("bot_kill_nade");
	
	while(self bots_getAmmoCount(weap) && self getCurrentWeapon() == weap)
		bots_waitFrame();
	
	wait 1;
	self setspawnweapon(lastWeap);
	self.bots_doing = "none";
	self bots_stopShooting();
	self notify("bot_kill_nade");
}

bots_doNoneOnGNadeAmmoTube(weap, lastWeap)
{
	self endon("death");
	self endon("bot_reset");
	self endon("bot_kill_nade");
	
	while(self bots_getAmmoCount(weap) && self getCurrentWeapon() == weap)
		bots_waitFrame();
	
	wait 1;
	self setspawnweapon(lastWeap);
	if(self.bots_doing != "climb")
		self.bots_doing = "none";
	self bots_stopShooting();
	self notify("bot_kill_nade");
}

bots_forceGNadeFire()
{
	self endon("death");
	self endon("bot_reset");
	self endon("bot_kill_nade");
	for(;;)
	{
		self bots_shootWeapon();
		bots_waitFrame();
	}
}

bots_watchGNadeFire(lastWeap)
{
	self endon("death");
	self endon("bot_reset");
	self endon("bot_kill_nade");
	
	self bots_waittill_either("grenade_fire", "offhand_end");
	
	self setspawnweapon(lastWeap);
	self.bots_doing = "none";
	self bots_stopShooting();
	self notify("bot_kill_nade");
}

bots_doNoneOnDeadNadeAim()
{
	self endon("death");
	self endon("bot_reset");
	self waittill("bot_kill_nade");
	self.bots_camping = false;
	self.bots_campingAngles = undefined;
}

bots_forceGNadeAim(pos, dis, istube)
{
	self endon("death");
	self endon("bot_reset");
	self endon("bot_kill_nade");
	
	self thread bots_doNoneOnDeadNadeAim();
	
	if(!isDefined(istube))
		dist = (dis*(dis/200.0))/15.0;
	else
		dist = (dis*(dis/400.0))/40.0;
	self.bots_camping = true;
	self.bots_campingAngles = VectorToAngles( ( pos ) - ( self getEye() ) + (0.0,0.0,dist) );
}

bots_canNade()
{
	return (self bots_doingNothing() && (!isDefined(self.lastStand) || (isDefined(self.inFinalStand) && self.inFinalStand) || self bots_hasPerk("specialty_laststandoffhand")));
}

bots_canSwitch()
{
	return (self bots_doingNothing() && (!isDefined(self.lastStand) || (isDefined(self.inFinalStand) && self.inFinalStand)));
}

bots_doGNadeLoc(bombLoc)
{
	self endon("death");
	self endon("bot_reset");
	self endon("bot_kill_nade");
	
	if(!self bots_canNade())
		return;
	
	if(self.pers["bots"]["trait"]["nade"] <= 0)
		return;
	
	rand = int(self.pers["bots"]["trait"]["nade"]/6);
	if(rand < 3)
		rand = 3;
	
	rnd = bots_randomInt(rand);
	
	switch(rnd)
	{
		case 0:
			if(level.bots_varLoadoutNade)
			{
				gnade = self bots_tryGetGoodWeap(self bots_getGrenadesName());
				if(isDefined(gnade) && gnade != "c4_mp")
				{
					if(gnade == "claymore_mp" || gnade == "flare_mp")
						i = randomInt(5);
					else
						i = 0;
					if(self bots_getAmmoCount(gnade) && !i)
					{
						dis = Distance(self getEye(), bombLoc);
						if(dis >= level.bots_minNadeDis || gnade == "claymore_mp" || gnade == "flare_mp")
						{
							lastWeapon = self getCurrentWeapon();
							self setspawnweapon(gnade);
							self.bots_doing = "nade_fire";
							self thread bots_watchGNadeFire(lastWeapon);
							self thread bots_doNoneOnGNadeAmmo(gnade, lastWeapon);
							
							if(gnade != "flare_mp" && gnade != "claymore_mp")
							{
								self thread bots_forceGNadeAim(bombLoc, dis);
								wait 1;
							}
							self thread bots_forceGNadeFire();
							
							wait 5;
							self setspawnweapon(lastWeapon);
							self.bots_doing = "none";
							self bots_stopShooting();
							self notify("bot_kill_nade");
						}
					}
				}
			}
		break;
		case 1:
			if(level.bots_varLoadoutNade)
			{
				secnade = self bots_tryGetGoodWeap(self bots_getOffhandsName());
				if(isDefined(secnade))
				{
					if(self bots_getAmmoCount(secnade))
					{
						dis = Distance(self getEye(), bombLoc);
						if(dis >= level.bots_minNadeDis)
						{
							lastWeapon = self getCurrentWeapon();
							self setspawnweapon(secnade);
							self.bots_Doing = "nade_fire";
							self thread bots_doNoneOnGNadeAmmo(secnade, lastWeapon);
							self thread bots_watchGNadeFire(lastWeapon);
							
							self thread bots_forceGNadeAim(bombLoc, dis);
							wait 1;
								
							self thread bots_forceGNadeFire();
							
							wait 3;
							self setspawnweapon(lastWeapon);
							self.bots_Doing = "none";
							self bots_stopShooting();
							self notify("bot_kill_nade");
						}
					}
				}
			}
		break;
		case 2:
			if(level.bots_varLoadoutTube && self bots_canSwitch())
			{
				weap = self bots_tryGetGoodWeap(self bots_getWeaponsGL());
				if(isDefined(weap))
				{
					if(self bots_getAmmoCount(weap))
					{
						dis = Distance(self getEye(), bombLoc);
						if(dis >= level.bots_minNadeDis)
						{
							self.bots_Doing = "ftube";
							lastWeapon = self getCurrentWeapon();
							self setspawnweapon(weap);
							self thread bots_doNoneOnGNadeAmmoTube(weap, lastWeapon);
							
							self thread bots_forceGNadeAim(bombLoc, dis, true);
							wait 1;
							
							self thread bots_forceGNadeFire();
							
							wait 5.5;
								
							self setspawnweapon(lastWeapon);
							if(self.bots_doing != "climb")
								self.bots_Doing = "none";
							self bots_stopShooting();
							self notify("bot_kill_nade");
						}
					}
				}
			}
		break;
	}
}

bots_doGNadeTarget(target)
{
	self endon("death");
	self endon("bot_reset");
	self endon("bot_kill_nade");
	
	if(!self bots_canNade())
		return;
					
	if(self.pers["bots"]["trait"]["nade"] <= 0)
		return;
	
	rand = int(self.pers["bots"]["trait"]["nade"]*2);
	if(rand < 6)
		rand = 6;
	
	rnd = bots_randomInt(rand);
	
	switch(rnd)
	{
		case 0:
			gnade = self bots_tryGetGoodWeap(self bots_getGrenadesName());
			if(isDefined(gnade) && gnade != "c4_mp")
			{
				if(gnade == "claymore_mp" || gnade == "flare_mp")
					i = randomInt(5);
				else
					i = 0;
				dis = distance(self.origin, target.origin);
				if(level.bots_varLoadoutNade && (dis >= level.bots_minNadeDis || gnade == "claymore_mp" || gnade == "flare_mp"))
				{
					if(self bots_getAmmoCount(gnade) && !i)
					{
						lastWeapon = self getCurrentWeapon();
						self setspawnweapon(gnade);
						self.bots_doing = "nade_fire";
						self thread bots_watchGNadeFire(lastWeapon);
						self thread bots_doNoneOnGNadeAmmo(gnade, lastWeapon);
						
						self thread bots_forceGNadeFire();
						
						wait 5;
						self setspawnweapon(lastWeapon);
						self.bots_doing = "none";
						self bots_stopShooting();
						self notify("bot_kill_nade");
					}
				}
			}
		break;
		case 1:
			dis = distance(self.origin, target.origin);
			if(level.bots_varLoadoutNade && dis >= level.bots_minNadeDis)
			{
				secnade = self bots_tryGetGoodWeap(self bots_getOffhandsName());
				if(isDefined(secnade))
				{
					if(self bots_getAmmoCount(secnade))
					{
						lastWeapon = self getCurrentWeapon();
						self setspawnweapon(secnade);
						self.bots_Doing = "nade_fire";
						self thread bots_doNoneOnGNadeAmmo(secnade, lastWeapon);
						self thread bots_watchGNadeFire(lastWeapon);
							
						self thread bots_forceGNadeFire();
						
						wait 3;
						self setspawnweapon(lastWeapon);
						self.bots_Doing = "none";
						self bots_stopShooting();
						self notify("bot_kill_nade");
					}
				}
			}
		break;
		case 2:
		case 3:
			dis = distance(self.origin, target.origin);
			if(level.bots_varLoadoutTube && self bots_canSwitch() && dis >= level.bots_minNadeDis)
			{
				weap = self bots_tryGetGoodWeap(self bots_getWeaponsGL());
				if(isDefined(weap))
				{
					if(self bots_getAmmoCount(weap))
					{
						self setspawnweapon(weap);
					}
				}
			}
		break;
		case 4:
		case 5:
			if(level.bots_varLoadoutShotgun && self bots_canSwitch())
			{
				weapS = self bots_tryGetGoodWeap(self bots_getWeaponsShot());
				if(isDefined(weapS))
				{
					if(self bots_getAmmoCount(weapS))
					{
						self setspawnweapon(weapS);
					}
				}
			}
		break;
	}
}

bots_doGNade()
{
	self endon("death");
	self endon("bot_reset");
	self endon("bot_kill_nade");
	
	if(!self bots_canNade())
		return;
	
	if(self.pers["bots"]["trait"]["nade"] <= 0)
		return;
	
	rand = int(self.pers["bots"]["trait"]["nade"]*6);
	if(rand < 9)
		rand = 9;
	
	rnd = bots_randomInt(rand);
	
	switch(rnd)
	{
		case 0:
			if(level.bots_varLoadoutNade)
			{
				gnade = self bots_tryGetGoodWeap(self bots_getGrenadesName());
				if(isDefined(gnade) && gnade != "c4_mp")
				{
					if(self bots_getAmmoCount(gnade))
					{
						pos = self bots_GetCursorPosition();
						myEye = self getEye();
						dis = Distance(myEye, pos);
						if((dis >= level.bots_minNadeDis && dis < 5000.0 && bulletTracePassed(myEye,self.origin+(0.0,0.0,255.0),false,self)) || gnade == "flare_mp" || gnade == "claymore_mp")
						{
							lastWeapon = self getCurrentWeapon();
							self setspawnweapon(gnade);
							self.bots_doing = "nade_fire";
							self thread bots_watchGNadeFire(lastWeapon);
							self thread bots_doNoneOnGNadeAmmo(gnade, lastWeapon);
							
							if(gnade != "flare_mp" && gnade != "claymore_mp")
							{
								self thread bots_forceGNadeAim(pos, dis);
								wait 1;
							}
							self thread bots_forceGNadeFire();
							
							wait 5;
							self setspawnweapon(lastWeapon);
							self.bots_doing = "none";
							self bots_stopShooting();
							self notify("bot_kill_nade");
						}
					}
				}
			}
		break;
		case 1:
			if(level.bots_varLoadoutNade)
			{
				secnade = self bots_tryGetGoodWeap(self bots_getOffhandsName());
				if(isDefined(secnade))
				{
					if(self bots_getAmmoCount(secnade))
					{
						pos = self bots_GetCursorPosition();
						myEye = self getEye();
						dis = Distance(myEye, pos);
						if(dis >= level.bots_minNadeDis && dis < 5000.0 && bulletTracePassed(myEye,self.origin+(0.0,0.0,255.0),false,self))
						{
							lastWeapon = self getCurrentWeapon();
							self setspawnweapon(secnade);
							self.bots_Doing = "nade_fire";
							self thread bots_doNoneOnGNadeAmmo(secnade, lastWeapon);
							self thread bots_watchGNadeFire(lastWeapon);
							
							self thread bots_forceGNadeAim(pos, dis);
							wait 1;
								
							self thread bots_forceGNadeFire();
							
							wait 3;
							self setspawnweapon(lastWeapon);
							self.bots_Doing = "none";
							self bots_stopShooting();
							self notify("bot_kill_nade");
						}
					}
				}
			}
		break;
		case 2:
			if(level.bots_varLoadoutNade && self bots_canSwitch())
			{
				weap = self bots_tryGetGoodWeap(self bots_getWeaponsGL());
				if(isDefined(weap))
				{
					if(self bots_getAmmoCount(weap))
					{
						pos = self bots_GetCursorPosition();
						myEye = self getEye();
						dis = Distance(myEye, pos);
						if(dis >= level.bots_minNadeDis && dis < 5000.0 && bulletTracePassed(myEye,self.origin+(0.0,0.0,255.0),false,self))
						{
							self.bots_Doing = "ftube";
							lastWeapon = self getCurrentWeapon();
							self setspawnweapon(weap);
							self thread bots_doNoneOnGNadeAmmoTube(weap, lastWeapon);
							
							self thread bots_forceGNadeAim(pos, dis, true);
							wait 1;
							
							self thread bots_forceGNadeFire();
							
							wait 5.5;
								
							self setspawnweapon(lastWeapon);
							if(self.bots_doing != "climb")
								self.bots_Doing = "none";
							self bots_stopShooting();
							self notify("bot_kill_nade");
						}
					}
				}
			}
		break;
		case 3:
		case 4:
		case 5:
			if(level.bots_varLoadoutTube && self bots_canSwitch())
			{
				weap = self bots_tryGetGoodWeap(self bots_getWeaponsGL());
				if(isDefined(weap))
				{
					if(self bots_getAmmoCount(weap))
					{
						self setspawnweapon(weap);
					}
				}
			}
		break;
		case 6:
		case 7:
		case 8:
			if(level.bots_varLoadoutShotgun && self bots_canSwitch())
			{
				weapS = self bots_tryGetGoodWeap(self bots_getWeaponsShot());
				if(isDefined(weapS))
				{
					if(self bots_getAmmoCount(weapS))
					{
						self setspawnweapon(weapS);
					}
				}
			}
		break;
	}
}

bots_melee(target)
{
	self endon("bot_reset");
	self endon("death");
	
	if(!level.bots_varLoadoutKnife || !self bots_doingNothing())
		return;
	
	if(target == self)
		return;
	
	if(!self.hasRiotShieldEquipped && self bots_GetCurrentWeaponClipAmmo())
	{
		if(self.pers["bots"]["trait"]["knife"] <= 0)
			return;
		
		if(bots_randomInt(self.pers["bots"]["trait"]["knife"]) != 1)
			return;
	}
	
	knife = level.bots_knifeDis;
	
	if(self bots_hasPerk("specialty_extendedmelee"))
		knife = knife + level.bots_knifeDisPerk;
	
	knife = knife*(getDvarFloat("player_meleeRange")/64.0);
	
	dis = distance(self.origin, target.origin);
	if(dis <= knife)
	{
		wait self.pers["bots"]["skill"]["shootDelay"];
		if(level.bots_varLoadoutKnife && self bots_doingNothing())
		{
			lastWeapon = self getCurrentWeapon();
			self.bots_doing = "knife";
			hadRiot = (lastWeapon == "riotshield_mp");
			
			if(!hadRiot)
			{
				self bots__giveWeapon("killstreak_counter_uav_mp", 0);
				self setspawnweapon("killstreak_counter_uav_mp");
				
				if(knife <= 0)
					knife = 0.1;
				
				if((dis / knife) < 0.333)
					self playSound("melee_swing_small");
				else
					self playSound("melee_swing_ps_large");
			}
			else
				self playSound("melee_riotshield_swing");
			
			wait 0.1;
			
			knife = level.bots_knifeDis;
			hasKnife = self bots_hasPerk("specialty_extendedmelee");
		
			if(hasKnife)
				knife = knife + level.bots_knifeDisPerk;
			
			knife = knife*(getDvarFloat("player_meleeRange")/64.0);
			
			dis = distance(self.origin, target.origin);
			if(isDefined(target) && (dis <= knife || hasKnife))
			{
				if(!isDefined(self.lastStand))
				{
					pushOutDir = VectorNormalize((self.origin[0], self.origin[1], 0)-(target.origin[0], target.origin[1], 0));
					pushoutPos = self.origin + (pushOutDir * (60-distance(target.origin,self.origin)));
					self SetOrigin((pushoutPos[0], pushoutPos[1], target.origin[2]));
				}
				
				if(!hadRiot)
				{
					if(knife <= 0)
						knife = 0.1;
					
					if((dis / knife) > 0.75)
					{
						self playSound("melee_knife_stab");
						self.bots_doing = "knifebig";
						if(!isDefined(self.lastStand))
							self setStance("stand");
					}
					
					if(!isPlayer(target))
					{
						if(randomint(5) && (self bots_isFacingAtTarget(target, self.pers["bots"]["skill"]["perfView"]) || hasKnife))
						{
							target notify( "damage", 135, self, self.angles, self.origin, "MOD_MELEE" );
							self playSound("melee_hit_other");
						}
					}
					else
					{
						if(target.hasRiotShield)
							rnd = (!randomInt(4));
						else
							rnd = (randomInt(5));
						
						if(rnd)
						{
							if((self bots_isFacingAtTarget(target, self.pers["bots"]["skill"]["perfView"]) || hasKnife) && bulletTracePassed( self getEye(), target.origin, false, target ))
							{
								playFx( level.bots_bloodfx,target.origin + (0.0, 0.0, 30.0) );
								if(bots_isReallyAlive(target))
									target thread maps\mp\gametypes\_callbacksetup::CodeCallback_PlayerDamage(self, self, 135, 0, "MOD_MELEE", lastWeapon, self.origin, VectorNormalize(target.origin-self.origin), "none", 0);
								if(randomInt(50))
									self playSound("melee_knife_hit_body");
								else
									self playSound("melee_hit");//cp running :)
							}
						}
						else
						{
							if(randomint(7) && target.hasRiotShield && (self bots_isFacingAtTarget(target, self.pers["bots"]["skill"]["perfView"]) || hasKnife) && bulletTracePassed( self getEye(), target.origin, false, target ))
								self playSound("melee_knife_hit_shield");
						}
					}
				}
				else
				{
					if(!isPlayer(target))
					{
						if(randomint(5) && (self bots_isFacingAtTarget(target, self.pers["bots"]["skill"]["perfView"]) || hasKnife))
						{
							target notify( "damage", 52, self, self.angles, self.origin, "MOD_MELEE" );
							self playSound("melee_riotshield_impact");
						}
					}
					else
					{
						if(target.hasRiotShield)
							rnd = (!randomInt(4));
						else
							rnd = (randomInt(5));
						
						if(rnd)
						{
							if((self bots_isFacingAtTarget(target, self.pers["bots"]["skill"]["perfView"]) || hasKnife) && bulletTracePassed( self getEye(), target.origin, false, target ))
							{
								if(bots_isReallyAlive(target))
									target thread maps\mp\gametypes\_callbacksetup::CodeCallback_PlayerDamage(self, self, 52, 0, "MOD_MELEE", lastWeapon, self.origin, VectorNormalize(target.origin-self.origin), "none", 0);
								self playSound("melee_riotshield_impact");
							}
						}
						else
						{
							if(randomint(7) && target.hasRiotShield && (self bots_isFacingAtTarget(target, self.pers["bots"]["skill"]["perfView"]) || hasKnife) && bulletTracePassed( self getEye(), target.origin, false, target ))
								self playSound("melee_riotshield_impact");
						}
					}
				}
				
				self setplayerangles(VectorToAngles( ( target.origin ) - ( self getEye() ) ));
			}
			
			if(isSubStr(lastWeapon, "tactical_") || hadRiot)
				wait 0.5;//less wait if bot has tac knife...
			else
				wait 1;
				
			if(!hadRiot)
			{
				self setspawnweapon(lastWeapon);
				self takeweapon("killstreak_counter_uav_mp");
			}
			
			wait 1;
			self.bots_doing = "none";
		}
	}
}

bots_canTDKS()
{
	return (level.bots_varPlayTDKS && (self.bots_traitRandom == 4 || self bots_getAmmoCount("stinger_mp") || self bots_getAmmoCount("rpg_mp") || self bots_getAmmoCount("at4_mp")));
}

bots_canKillEqu()
{
	return (level.bots_varPlayEqu && self.bots_traitRandom != 2);
}

bots_isGoodToAimAtKS(KS)
{
	if(self bots_isClimbing() || !self bots_shouldAim())
		return false;
	
	if(self bots_getAmmoCount("stinger_mp") || self bots_getAmmoCount("at4_mp"))
		return false;
	
	return (self bots_isKSGood(KS));
}

bots_isKSGood(KS)
{
	if(!isDefined(ks))
		return false;
	
	return (bulletTracePassed(self getEye(), ks.origin, false, ks));
}

bots_isGoodToAimAtEqu(equ)
{
	if(self bots_isClimbing() || !self bots_shouldAim())
		return false;
	
	return (self bots_isEquGood(equ));
}

bots_isEquGood(equ)
{
	if(!isDefined(equ))
		return false;
	
	if(equ.bots_EquipmentType == 0)
	{
		if((equ.health > 20000) && bulletTracePassed(self getEye(), equ.origin + (0, 0, 35), false, equ))
			return true;
	}
	else
	{
		if(equ.bots_EquipmentType != 2)
		{
			if(bulletTracePassed(self getEye(), equ.origin + (0, 0, 5), false, equ))
				return true;
		}
		else
		{
			if(bulletTracePassed(self getEye(), equ.origin + (0, 0, 5), false, equ) && !self.bots_camping)
				return true;
		}
		
	}
	return false;
}

bots_isGoodToAimAtPlayer(player)
{
	if(self bots_isClimbing() || !self bots_shouldAim())
		return false;
	
	return (self bots_isPlayerGood(player));
}

bots_isPlayerGood(player)
{
	if(!isDefined(player))
		return false;
	
	if(level.bots_varTarget.size)
		return true;
	
	myEye = self getEye();
	return (bots_isReallyAlive(player) && (bulletTracePassed(myEye, player getTagOrigin("j_ankle_le"), false, player) || bulletTracePassed(myEye, player getTagOrigin("j_head"), false, player) || bulletTracePassed(myEye, player getTagOrigin("j_ankle_ri"), false, player)));
}

bots_hasTargetRocketAmmo()
{
	return (self bots_getAmmoCount("stinger_mp") || self bots_getAmmoCount("at4_mp"));
}

bots_getTargetKillstreak()
{
	myEye = self getEye();
	
	if(level.teamBased)
	{
		if( IsDefined( level.chopper ) && level.chopper.team != self.pers["team"] && bulletTracePassed( myEye, level.chopper.origin, false, level.chopper ) && (!isDefined(self.bots_engageLimit) || distance(myEye, level.chopper.origin) <= self.bots_engageLimit))
			return level.chopper;
		
		foreach( harrier in level.harriers )
		{
			if(harrier.team == self.pers["team"])
				continue;
			
			if(!bulletTracePassed(myEye, harrier.origin, false, harrier))
				continue;
			
			if(isDefined(self.bots_engageLimit) && distance(myEye, harrier.origin) > self.bots_engageLimit)
				continue;
			
			return harrier;
		}
		
		if(self bots_hasTargetRocketAmmo())
		{
			if ( isDefined( level.ac130player ) && level.ac130player.team != self.pers["team"] && bulletTracePassed(myEye, level.ac130.planemodel.origin, false, level.ac130.planemodel) )
				return level.ac130.planemodel;
			
			foreach ( UAV in level.UAVModels[level.otherTeam[self.pers["team"]]] )
			{
				if(!bulletTracePassed(myEye, UAV.origin, false, UAV ))
					continue;
				
				return UAV;
			}
		}
	}
	else
	{
		if ( IsDefined( level.chopper ) && (!isDefined(level.chopper.owner) || level.chopper.owner != self ) && bulletTracePassed( myEye, level.chopper.origin, false, level.chopper ) && (!isDefined(self.bots_engageLimit) || distance(myEye, level.chopper.origin) <= self.bots_engageLimit))
			return level.chopper;
		
		foreach( harrier in level.harriers )
		{
			if ( isDefined( harrier.owner ) && harrier.owner == self )
				continue;
			
			if(!bulletTracePassed(myEye, harrier.origin, false, harrier ))
				continue;
			
			if(isDefined(self.bots_engageLimit) && distance(myEye, harrier.origin) > self.bots_engageLimit)
				continue;
			
			return harrier;
		}
		
		if(self bots_hasTargetRocketAmmo())
		{
			if ( isDefined( level.ac130player ) && bulletTracePassed(myEye, level.ac130.planemodel.origin, false, level.ac130.planemodel ) )
				return level.ac130.planemodel;
				
			foreach ( ownerGuid, UAV in level.UAVModels )
			{
				if ( isDefined( UAV.owner ) && UAV.owner == self )
					continue;
				if(!bulletTracePassed(myEye, UAV.origin, false, UAV ))
					continue;
				
				return UAV;
			}
		}
	}
	
	return undefined;
}

bots_getTargetEquipment()
{
	myEye = self getEye();
	
	foreach(turret in level.turrets)
	{
		if(turret.health <= 20000)
			continue;
		if(isDefined(turret.owner) && turret.owner == self)
			continue;
		if(turret.team == self.pers["team"] && level.teamBased)
			continue;
		where = turret.origin + (0.0, 0.0, 35.0);
		dist = distance(myEye, where);
		if(dist > self.pers["bots"]["skill"]["viewDis"])
			continue;
		if(isDefined(self.bots_engageLimit) && dist > self.bots_engageLimit)
			continue;
		if(!bulletTracePassed(myEye, where, false, turret))//just so no wallbanging never hitting it
			continue;
		if(!self bots_IsFacingAtTarget(turret, self.pers["bots"]["skill"]["perfView"]))
			continue;
		
		turret.bots_EquipmentType = 0;
		return turret;
	}
	
	grenades = getEntArray( "grenade", "classname" );
	foreach(grenade in grenades)
	{
		if(!isDefined(grenade.weaponName) || (grenade.weaponName != "claymore_mp" && grenade.weaponName != "c4_mp"))
			continue;
		if(isDefined(grenade.owner) && grenade.owner == self)
			continue;
		if(grenade.team == self.pers["team"] && level.teamBased)
			continue;
		where = grenade.origin + (0.0, 0.0, 5.0);
		dist = distance(myEye, where);
		if(dist > self.pers["bots"]["skill"]["viewDis"])
			continue;
		if(isDefined(self.bots_engageLimit) && dist > self.bots_engageLimit)
			continue;
		if(!bulletTracePassed(myEye, where, false, grenade))//just so no wallbanging never hitting it
			continue;
		if(!self bots_hasPerk("specialty_detectexplosive") && !self bots_IsFacingAtTarget(grenade, self.pers["bots"]["skill"]["perfView"]))
			continue;
		
		grenade.bots_EquipmentType = 1;
		return grenade;
	}
	
	foreach(player in level.players)
	{
		if(!isDefined(player.setSpawnPoint))
			continue;
		if(player == self)
			continue;
		if(!isDefined(player.pers["team"]))
			continue;
		if(level.teamBased && self.pers["team"] == player.pers["team"])
			continue;
		if(!self bots_hasPerk("specialty_detectexplosive") && (!self bots_IsFacingAtTarget(player.setSpawnPoint, self.pers["bots"]["skill"]["perfView"]) || !bulletTracePassed(myEye, player.setSpawnPoint.origin + (0.0, 0.0, 5.0), false, player.setSpawnPoint)))
			continue;
	
		player.setSpawnPoint.bots_EquipmentType = 2;
		return player.setSpawnPoint;
	}
	return undefined;
}

bots_getTargetOnFootPlayer()
{
	if(!level.bots_varTarget.size)
	{
		myEye = self getEye();
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
			dist = distance(myEye, player.origin);
			if(dist > self.pers["bots"]["skill"]["viewDis"])
				continue;
			if(isDefined(self.bots_engageLimit) && dist > self.bots_engageLimit)
				continue;
			tarCheck1 = player getTagOrigin( "j_head" );
			tarCheck2 = player getTagOrigin( "j_ankle_le" );
			tarCheck3 = player getTagOrigin( "j_ankle_ri" );
			if((distance(PhysicsTrace( myEye, tarCheck1 ), tarCheck1) > 0.0) && (distance(PhysicsTrace( myEye, tarCheck2 ), tarCheck2) > 0.0) && (distance(PhysicsTrace( myEye, tarCheck3 ), tarCheck3) > 0.0))
				continue;
			if(!bots\bots::bots_SmokeTrace(myEye, player.origin, 300.0))
				continue;
			if(!self bots_IsFacingAtTarget(player, self.pers["bots"]["skill"]["perfView"]) && !self bots_getTurned(player))
				continue;
			
			return player;
		}
	}
	else
	{
		foreach(player in level.players)
		{
			if(!isSubStr(player.name, level.bots_varTarget))
				continue;
			
			return player;
		}
	}
	return undefined;
}

bots_getTargetLaptopPlayer(model)
{
	if(!level.bots_varTarget.size)
	{
		myEye = self getEye();
		foreach (player in level.players)
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
			if(!bulletTracePassed(myEye, player getTagOrigin( "j_head" ), false, model))
				continue;
			if(player bots_hasPerk("specialty_coldblooded"))
				continue;
			
			return player;
		}
	}
	else
	{
		foreach (player in level.players)
		{
			if(!isSubStr(player.name, level.bots_varTarget))
				continue;
			
			return player;
		}
	}
	return undefined;
}

bots_AttackedMe(attacker)
{//ty pezbot
	foreach(rat in self.attackers)
	{
		if(rat != attacker)
			continue;
		
		if( isDefined( level.bots_attackedMeans[ self.attackerData[ rat.guid ].sMeansOfDeath ] ) )
			return true;
		else
			return false;
	}
	return false;
}

bots_AttackedHim(attacker)
{
	foreach(rat in attacker.attackers)
	{
		if(rat != self)
			continue;
		
		if( isDefined( level.bots_attackedMeans[ attacker.attackerData[ rat.guid ].sMeansOfDeath ] ) )
			return true;
		else
			return false;
	}
	return false;
}

bots_seen(target)
{
	if(isDefined(self.bots_lastSeen[target.guid]))
	{
		if((getTime() - self.bots_lastSeen[target.guid]) >= self.pers["bots"]["skill"]["seenTime"])
		{
			self.bots_lastSeen[target.guid] = undefined;
			return false;
		}
		else
			return true;
	}
	else
		return false;
}

bots_doHeartbeat(player)
{
	return (!player bots_hasPerk("specialty_heartbreaker") && !self bots\bots_killstreak::bots_isEmp() && isSubStr(self getCurrentWeapon(), "heartbeat_") && distance(self.origin, player.origin) < 500.0 && self bots_IsFacingAtTarget(player, self.pers["bots"]["skill"]["perfView"]));
}

bots_canHearPlayer(target)
{
	if(target bots_hasPerk("specialty_quieter"))
		return false;
	
	if(lengthsquared( target getVelocity() ) >= 20000 || (target bots_playerIsABot() && target.bots_fMoveSpeed >= 5.0))
	{
		if(self bots_hasPerk("specialty_selectivehearing"))
			_distance = 200.0;
		else
			_distance = 100.0;
		
		if(distance(self.origin, target.origin) <= _distance)
			return true;
	}
	return false;
}

bots_playerOnUAV(target)
{
	if(target bots_hasPerk("specialty_localjammer") && distance(self.origin, target.origin) < 500.0)
		return false;
	
	if(self bots_hasPerk("_specialty_blastshield"))
		return false;
	
	if(level.teambased)
	{
		if(level.teamEMPed[self.team] || level.activeCounterUAVs[level.otherTeam[self.pers["team"]]])
			return false;
		
		hasUAV = level.activeUAVs[self.pers["team"]];
		if(hasUAV && !target bots_hasPerk("specialty_coldblooded"))
			return true;
			
		if(target.bots_firing && (!level.hardcoreMode || hasUAV) && !isSubStr(target getCurrentWeapon(), "silencer_"))
			return true;
	}
	else
	{
		if(isDefined( level.empPlayer ) && level.empPlayer != self)
			return false;
		
		if(self.isRadarBlocked)
			return false;
		
		if(self.hasRadar && !target bots_hasPerk("specialty_coldblooded"))
			return true;
			
		if(target.bots_firing && (!level.hardcoreMode || self.hasRadar) && !isSubStr(target getCurrentWeapon(), "silencer_"))
			return true;
	}
	return false;
}

bots_getTurned(player)
{
	if(!self.pers["bots"]["skill"]["base"])
		return false;

	if(self bots_playerOnUAV(player) || self bots_canHearPlayer(player) || self bots_AttackedHim(player) || self bots_AttackedMe(player) || self bots_seen(player))
		return true;
	else
		return false;
}

bots_StopShooting()
{
	if(!self bots_CanStopShoot())
	{
		self bots_freezeControls(false);
	}
	else
	{
		self bots_freezeControls(true);
	}
}

bots_CanStopShoot()
{
	if(isDefined(level.bots_canStopShoot[self.bots_doing]))
		return false;
	
	return true;
}

bots_CanShoot()
{
	if(!level.bots_varPlayAttack)
		return false;
	
	if(self.bots_running || self.bots_runDelay)
		return false;
	
	if(self.pers["bots"]["trait"]["playStyle"] == 1 && isSubStr(self getCurrentWeapon(), "tactical_"))
		return false;
	
	if(isDefined(level.bots_canShoot[self.bots_doing]))
		return false;
	
	if(self.hasRiotShieldEquipped)
		return false;
	
	return true;
}

bots_shouldAim()
{
	return (isDefined(level.bots_shouldAim[self.bots_aimDoing]));
}

bots_isClimbing()
{
	return (isDefined(level.bots_isClimbing[self.bots_doing]));
}

bots_IsStunned()
{
	return (isdefined(self.concussionEndTime) && self.concussionEndTime > gettime());
}

bots_isArtShocked()
{
	return (isDefined(self.beingArtilleryShellshocked) && self.beingArtilleryShellshocked);
}

bots_isShellShocked()
{
	return (self maps\mp\_flashgrenades::isFlashbanged() || self bots_IsStunned() || self bots_isArtShocked());
}

bots_setPlayerAngesReal(Angle,Steps)
{
	myAngle=self getPlayerAngles();
	
	X=(Angle[0]-myAngle[0]);
	while(X > 170.0)
		X=X-360.0;
	while(X < -170.0)
		X=X+360.0;
	X=X/Steps;
	
	Y=(Angle[1]-myAngle[1]);
	while(Y > 180.0)
		Y=Y-360.0;
	while(Y < -180.0)
		Y=Y+360.0;
		
	Y=Y/Steps;
	
	for(i=0;i<Steps;i++)
	{
		newAngle=(myAngle[0]+X,myAngle[1]+Y,0);
		self setPlayerAngles(newAngle);
		myAngle=self getPlayerAngles();
		wait 0.05;
	}
}