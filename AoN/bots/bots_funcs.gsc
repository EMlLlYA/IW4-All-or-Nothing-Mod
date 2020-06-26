#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\perks\_perkfunctions;

bots_clearStructs()
{
	self.bots_devwalk = [];
}

bots_EnableWeapons()
{
	self _EnableWeapon();
}

bots_DisableWeapons()
{
	self _disableWeapon();
}

bots_GetCurrentWeaponClipAmmo()
{
	if(level.bots_varPlayAnim != 2)
		return self GetCurrentWeaponClipAmmo();
	else
	{
		what = self getcurrentweapon();
		if(!isDefined(self.bots_devWalk[what]) || !self.bots_devwalk[what].isEmpty)
			return self GetCurrentWeaponClipAmmo();
		else
			return self.bots_devWalk[what].clip;
	}
}

bots_freezeControls(what)
{
	if(level.bots_varPlayAnim != 2)
		self freezecontrols(what);
	else
	{
		if(!self bots\bots_aim::bots_isClimbing())
			self freezecontrols(false);
		if(what)
		{
			self bots_noAmmo();
		}
		else
		{
			self bots_doAmmo();
		}
	}
}

bots_doAmmo()
{
	weapon = self getcurrentweapon();
	if(isDefined(self.bots_devwalk[weapon]) && self.bots_devwalk[weapon].isEmpty)
	{
		self.bots_devwalk[weapon].isEmpty = false;
		
		self setWeaponAmmoClip( weapon, self.bots_devwalk[weapon].clip, "left" );
		self setWeaponAmmoClip( weapon, self.bots_devwalk[weapon].clip, "right" );
		self setWeaponAmmoClip( weapon, self.bots_devwalk[weapon].clip );
		self SetWeaponAmmoStock( weapon, self.bots_devwalk[weapon].stock );
	}
}

bots_noAmmo()
{
	weapon = self getcurrentweapon();
	isDef = isDefined(self.bots_devwalk[weapon]);
	
	if(!isDef || !self.bots_devwalk[weapon].isEmpty)
	{
		if(!isDef)
			self.bots_devwalk[weapon] = spawnstruct();
		
		self.bots_devwalk[weapon].isEmpty = true;
		self.bots_devwalk[weapon].clip = self GetWeaponAmmoClip(weapon);
		self.bots_devwalk[weapon].stock = self GetWeaponAmmoStock(weapon);
		
		self setWeaponAmmoClip( weapon, 0, "left" );
		self setWeaponAmmoClip( weapon, 0, "right" );
		self setWeaponAmmoClip( weapon, 0 );
		self SetWeaponAmmoStock( weapon, 0 );
	}
	else if(self getAmmoCount(weapon))
	{
		self.bots_devwalk[weapon].clip = self.bots_devwalk[weapon].clip + self GetWeaponAmmoClip(weapon);
		self.bots_devwalk[weapon].stock = self.bots_devwalk[weapon].stock + self GetWeaponAmmoStock(weapon);
		
		self setWeaponAmmoClip( weapon, 0, "left" );
		self setWeaponAmmoClip( weapon, 0, "right" );
		self setWeaponAmmoClip( weapon, 0 );
		self SetWeaponAmmoStock( weapon, 0 );
	}
}

bots_getAmmoCount(what)
{
	if(level.bots_varPlayAnim != 2 || !isDefined(self.bots_devWalk[what]) || !self.bots_devwalk[what].isEmpty)
		return self getAmmoCount(what);
	else
		return self.bots_devWalk[what].clip + self.bots_devWalk[what].stock;
}

bots_getWeaponAmmoClip(what)
{
	if(level.bots_varPlayAnim != 2 || !isDefined(self.bots_devWalk[what]) || !self.bots_devwalk[what].isEmpty)
		return self GetWeaponAmmoClip(what);
	else
		return self.bots_devWalk[what].clip;
}

bots_getWeaponAmmoStock(what)
{
	if(level.bots_varPlayAnim != 2 || !isDefined(self.bots_devWalk[what]) || !self.bots_devwalk[what].isEmpty)
		return self GetWeaponAmmoStock(what);
	else
		return self.bots_devWalk[what].stock;
}

bots_setWeaponAmmoClip(what, to)
{
	if(level.bots_varPlayAnim != 2 || !isDefined(self.bots_devWalk[what]) || !self.bots_devwalk[what].isEmpty)
		self setWeaponAmmoClip(what, to);
	else
		self.bots_devWalk[what].clip = to;
}

bots_setWeaponAmmoStock(what, to)
{
	if(level.bots_varPlayAnim != 2 || !isDefined(self.bots_devWalk[what]) || !self.bots_devwalk[what].isEmpty)
		self setWeaponAmmoStock(what, to);
	else
		self.bots_devWalk[what].stock = to;
}

bots_debugText(text, time)
{
	self notify("bots_kill_debugText");
	self endon("bots_kill_debugText");
	waittillframeend;
	self.bots_debugDraw = self createFontString("default", 0.9);
	self.bots_debugDraw setPoint("TOPRIGHT", "RIGHT", -7, -240);
	self thread bots_killDebugText();
	self.bots_debugDraw setText(text);
	wait time;
	self notify("bots_kill_debugText");
}

bots_killDebugText()
{
	self waittill("bots_kill_debugText");
	self.bots_debugDraw destroy();
}

bots_randomInt(arg1, arg2)
{
	isDef = isDefined(arg2);
	if(arg1 <= 0 && !isDef)
		return -1;
	
	if(!isDef)
		return randomInt(arg1);
	else
		return randomIntRange(arg1, arg2);
}

/*self thread bots_say_on_notify("bot_reset");
	self thread bots_say_on_notify("BotMovementComplete");
	self thread bots_say_on_notify("kill_bot_walk");
	self thread bots_say_on_notify("bot_clear_doing_obj");
	self thread bots_say_on_notify("bot_kill_bomb");
	self thread bots_say_on_notify("bot_obj_override");
	self thread bots_say_on_notify("BotMovementCompleteDyn");
	self thread bots_say_on_notify("bot_walk_unreachloc");
	self thread bots_say_on_notify("bot_kill_nade");
	self thread bots_say_on_notify("bot_walk_overlap");
	self thread bots_say_on_notify("kill_bot_follow");
	self thread bots_say_on_notify("bot_kill_camp");*/
bots_say_on_notify(not)
{
	for(;;)
	{
		self waittill(not);
		self sayall(not + " @ " + getTime());
	}
}

bots_isValidPrimary(arg1)
{
	return maps\mp\gametypes\_class::isValidPrimary(arg1);
}

bots_isValidSecondary(arg1)
{
	return maps\mp\gametypes\_class::isValidSecondary(arg1);
}

bots_isValidEquipment(arg1)
{
	return maps\mp\gametypes\_class::isValidEquipment(arg1);
}

bots_isValidOffhand(arg1)
{
	return maps\mp\gametypes\_class::isValidOffhand(arg1);
}

bots_getConeDot(pos)
{
    dirToTarget = VectorNormalize(pos-self.origin);
    forward = AnglesToForward(self GetPlayerAngles());
    return vectordot(dirToTarget, forward);
}

bots_IsFacingAtTarget(target, dotCheck)
{
	dot = bots_getConeDot(target.origin);
    if(dot > dotCheck)
        return true;
	else
		return false;
}

bots_gameFlagWait(arg1)
{
	gameFlagWait(arg1);
}

bots_incPlayerStat(arg1, arg2)
{
	incPlayerStat(arg1, arg2);
}

bots_array_remove(array, remov)
{
	return array_remove(array, remov);
}

bots_setAltSceneObj( arg1, arg2, arg3 )
{
	self setAltSceneObj( arg1, arg2, arg3 );
}

bots__giveWeapon(arg1, arg2)
{
	self _giveweapon(arg1, arg2);
}

bots_giveWeapon(arg1, arg2, arg3)
{
	self giveweapon(arg1, arg2, arg3);
}

bots_waittill_notify_or_timeout(arg1, arg2)
{
	self waittill_notify_or_timeout(arg1, arg2);
}

bots_waittill_either(arg1, arg2)
{
	self waittill_either(arg1, arg2);
}

bots_waittill_any( string1, string2, string3, string4, string5, string6, string7, string8 )
{
	self waittill_any( string1, string2, string3, string4, string5, string6, string7, string8 );
}

bots_getWeaponClass(weapon)
{
	return getWeaponClass(weapon);
}

bots_gameFlag(flag)
{
	return gameFlag( flag );
}

bots_getAHost()
{
	foreach(player in level.players)
	{
		if(!isDefined(player.pers["bots_isHost"]) || !player.pers["bots_isHost"])
			continue;
		
		return player;
	}
	
	if(level.players.size)
		return level.players[0];
	
	return undefined;
}

bots_waitFrame()
{
	waitframe();
	//wait 0.15;
}

bots_suicide()
{
	self _suicide();
}

bots_unsetPerk(perk)
{
	self _unsetPerk(perk);
}

bots_setPerk(perk)
{
	self _setPerk(perk);
}

bots_freezeControlsWrapper(xD)
{
	self freezeControlsWrapper(xD);
}

bots_clearLowerMessage(what, _long)
{
	self clearLowerMessage(what, _long);
}

bots_hasPerk(perk)
{
	return self _hasPerk(perk);
}

bots_getBaseWeaponName(name)
{
	return getBaseWeaponName(name);
}

bots_isUsingRemote()
{
	return isUsingRemote();
}

bots_isReallyAlive(player)
{
	return isReallyAlive(player);
}

bots_loadWaypoints()
{
	if(isDefined(game["bots"]) && isDefined(game["bots"]["waypoints"]))
	{
		level.waypoints = game["bots"]["waypoints"];
		level.waypointCount = level.waypoints.size;
		return;
	}
	
	game["bots"]["waypoints"] = [];
	
	mapname = getDvar("mapname");
	switch(getDvar("mapname"))
	{
		case "mp_afghan":
			game["bots"]["waypoints"] = bots\waypoints\Afghan::Afghan();
		break;
		case "mp_derail":
			game["bots"]["waypoints"] = bots\waypoints\Derail::Derail();
		break;
		case "mp_estate":
		case "mp_estate_trop":
		case "mp_estate_tropical":
			game["bots"]["waypoints"] = bots\waypoints\Estate::Estate();
		break;
		case "mp_favela":
		case "mp_fav_tropical":
			game["bots"]["waypoints"] = bots\waypoints\Favela::Favela();
		break;
		case "mp_highrise":
			game["bots"]["waypoints"] = bots\waypoints\Highrise::Highrise();
		break;
		case "mp_invasion":
			game["bots"]["waypoints"] = bots\waypoints\Invasion::Invasion();
		break;
		case "mp_checkpoint":
			game["bots"]["waypoints"] = bots\waypoints\Karachi::Karachi();
		break;
		case "mp_quarry":
			game["bots"]["waypoints"] = bots\waypoints\Quarry::Quarry();
		break;
		case "mp_rundown":
			game["bots"]["waypoints"] = bots\waypoints\Rundown::Rundown();
		break;
		case "mp_rust":
			game["bots"]["waypoints"] = bots\waypoints\Rust::Rust();
		break;
		case "mp_boneyard":
			game["bots"]["waypoints"] = bots\waypoints\Scrapyard::Scrapyard();
		break;
		case "mp_nightshift":
			game["bots"]["waypoints"] = bots\waypoints\Skidrow::Skidrow();
		break;
		case "mp_subbase":
			game["bots"]["waypoints"] = bots\waypoints\Subbase::Subbase();
		break;
		case "mp_terminal":
			game["bots"]["waypoints"] = bots\waypoints\Terminal::Terminal();
		break;
		case "mp_underpass":
			game["bots"]["waypoints"] = bots\waypoints\Underpass::Underpass();
		break;
		case "mp_brecourt":
			game["bots"]["waypoints"] = bots\waypoints\Wasteland::Wasteland();
		break;
		
		case "mp_complex":
			game["bots"]["waypoints"] = bots\waypoints\Bailout::Bailout();
		break;
		case "mp_crash":
		case "mp_crash_trop":
		case "mp_crash_tropical":
			game["bots"]["waypoints"] = bots\waypoints\Crash::Crash();
		break;
		case "mp_overgrown":
			game["bots"]["waypoints"] = bots\waypoints\Overgrown::Overgrown();
		break;
		case "mp_compact":
			game["bots"]["waypoints"] = bots\waypoints\Salvage::Salvage();
		break;
		case "mp_storm":
		case "mp_storm_spring":
			game["bots"]["waypoints"] = bots\waypoints\Storm::Storm();
		break;
		
		case "mp_abandon":
			game["bots"]["waypoints"] = bots\waypoints\Carnival::Carnival();
		break;
		case "mp_fuel2":
			game["bots"]["waypoints"] = bots\waypoints\Fuel::Fuel();
		break;
		case "mp_strike":
			game["bots"]["waypoints"] = bots\waypoints\Strike::Strike();
		break;
		case "mp_trailerpark":
			game["bots"]["waypoints"] = bots\waypoints\TrailerPark::TrailerPark();
		break;
		case "mp_vacant":
			game["bots"]["waypoints"] = bots\waypoints\Vacant::Vacant();
		break;
		
		case "mp_nuked":
			game["bots"]["waypoints"] = bots\waypoints\Nuketown::Nuketown();
		break;
		
		case "mp_cross_fire":
			game["bots"]["waypoints"] = bots\waypoints\Crossfire::Crossfire();
		break;
		case "mp_bloc":
		case "mp_bloc_sh":
			game["bots"]["waypoints"] = bots\waypoints\Bloc::Bloc();
		break;
		case "mp_cargoship":
		case "mp_cargoship_sh":
			game["bots"]["waypoints"] = bots\waypoints\Wetwork::Wetwork();
		break;
		
		case "mp_killhouse":
			game["bots"]["waypoints"] = bots\waypoints\Killhouse::Killhouse();
		break;
		
		case "mp_bog_sh":
			game["bots"]["waypoints"] = bots\waypoints\Bog::Bog();
		break;
		
		case "mp_firingrange":
			game["bots"]["waypoints"] = bots\waypoints\Firingrange::Firingrange();
		break;
		case "mp_shipment":
			game["bots"]["waypoints"] = bots\waypoints\Shipment::Shipment();
		break;
		case "mp_shipment_long":
			game["bots"]["waypoints"] = bots\waypoints\ShipmentLong::ShipmentLong();
		break;
		case "mp_rust_long":
			game["bots"]["waypoints"] = bots\waypoints\Rustlong::Rustlong();
		break;
		
		case "invasion":
			game["bots"]["waypoints"] = bots\waypoints\Burgertown::Burgertown();
		break;
		case "iw4_credits":
			game["bots"]["waypoints"] = bots\waypoints\Testmap::Testmap();
		break;
		case "oilrig":
			game["bots"]["waypoints"] = bots\waypoints\Oilrig::Oilrig();
		break;
		case "co_hunted":
			game["bots"]["waypoints"] = bots\waypoints\Hunted::Hunted();
		break;
		case "contingency":
			game["bots"]["waypoints"] = bots\waypoints\Contingency::Contingency();
		break;
		case "gulag":
			game["bots"]["waypoints"] = bots\waypoints\Gulag::Gulag();
		break;
		case "so_ghillies":
			game["bots"]["waypoints"] = bots\waypoints\Pripyat::Pripyat();
		break;
		
		case "airport":
			game["bots"]["waypoints"] = bots\waypoints\Airport::Airport();
		break;
		case "ending":
			game["bots"]["waypoints"] = bots\waypoints\Museum::Museum();
		break;
		case "af_chase":
			game["bots"]["waypoints"] = bots\waypoints\AfghanChase::AfghanChase();
		break;
		case "trainer":
			game["bots"]["waypoints"] = bots\waypoints\Trainer::Trainer();
		break;
		case "roadkill":
			game["bots"]["waypoints"] = bots\waypoints\Roadkill::Roadkill();
		break;
		case "dcemp":
			game["bots"]["waypoints"] = bots\waypoints\DCEMP::DCEMP();
		break;
		
		case "dcburning":
			game["bots"]["waypoints"] = bots\waypoints\DCBurning::DCBurning();
		break;
		case "af_caves":
			game["bots"]["waypoints"] = bots\waypoints\AfghanCaves::AfghanCaves();
		break;
		case "arcadia":
			game["bots"]["waypoints"] = bots\waypoints\Arcadia::Arcadia();
		break;
		case "boneyard":
			game["bots"]["waypoints"] = bots\waypoints\Boneyard::Boneyard();
		break;
		case "cliffhanger":
			game["bots"]["waypoints"] = bots\waypoints\Cliffhanger::Cliffhanger();
		break;
		case "downtown":
			game["bots"]["waypoints"] = bots\waypoints\Downtown::Downtown();
		break;
		case "estate":
			game["bots"]["waypoints"] = bots\waypoints\EstateSP::EstateSP();
		break;
		case "favela":
			game["bots"]["waypoints"] = bots\waypoints\FavelaSP::FavelaSP();
		break;
		case "favela_escape":
			game["bots"]["waypoints"] = bots\waypoints\FavelaEscape::FavelaEscape();
		break;
		case "so_bridge":
			game["bots"]["waypoints"] = bots\waypoints\Bridge::Bridge();
		break;
		case "dc_whitehouse":
			game["bots"]["waypoints"] = bots\waypoints\Whitehouse::Whitehouse();
		break;
		
		default:
			bots\waypoints\_custom_map::main(mapname);
		break;
	}
	
	level.waypoints = game["bots"]["waypoints"];
	level.waypointCount = level.waypoints.size;
}

bots_getGoodMapAmount()
{
	switch(getdvar("mapname"))
	{
		case "mp_rust":
		case "iw4_credits":
		case "mp_nuked":
		case "oilrig":
		case "mp_killhouse":
		case "invasion":
		case "mp_bog_sh":
		case "co_hunted":
		case "contingency":
		case "gulag":
		case "so_ghillies":
		case "ending":
		case "af_chase":
		case "af_caves":
		case "arcadia":
		case "boneyard":
		case "cliffhanger":
		case "dcburning":
		case "dcemp":
		case "downtown":
		case "estate":
		case "favela":
		case "favela_escape":
		case "roadkill":
		case "so_bridge":
		case "trainer":
		case "dc_whitehouse":
		case "mp_shipment":
			if(level.teambased)
				return 8;
			else
				return 4;
		case "mp_vacant":
		case "mp_terminal":
		case "mp_nightshift":
		case "mp_favela":
		case "mp_highrise":
		case "mp_boneyard":
		case "mp_subbase":
		case "mp_firingrange":
		case "mp_fav_tropical":
		case "mp_shipment_long":
		case "mp_rust_long":
			if(level.teambased)
				return 12;
			else
				return 8;
		case "mp_afghan":
		case "mp_crash":
		case "mp_brecourt":
		case "mp_cross_fire":
		case "mp_overgrown":
		case "mp_trailerpark":
		case "mp_underpass":
		case "mp_checkpoint":
		case "mp_quarry":
		case "mp_rundown":
		case "mp_cargoship":
		case "mp_estate":
		case "mp_bloc":
		case "mp_storm":
		case "mp_strike":
		case "mp_abandon":
		case "mp_complex":
		case "airport":
		case "mp_storm_spring":
		case "mp_crash_trop":
		case "mp_cargoship_sh":
		case "mp_estate_trop":
		case "mp_compact":
		case "mp_crash_tropical":
		case "mp_estate_tropical":
		case "mp_bloc_sh":
			if(level.teambased)
				return 14;
			else
				return 9;
		case "mp_fuel2":
		case "mp_invasion":
		case "mp_derail":
			if(level.teambased)
				return 16;
			else
				return 10;
		default:
			return 2;
	}
}

bots_getMapName(mapname)
{
    switch(mapname)
	{
		case "mp_abandon":
			return "Carnival";
		case "mp_rundown":
			return "Rundown";
		case "mp_afghan":
			return "Afghan";
		case "mp_boneyard":
			return "Scrapyard";
		case "mp_brecourt":
			return "Wasteland";
		case "mp_cargoship":
			return "Wetwork";
		case "mp_checkpoint":
			return "Karachi";
		case "mp_compact":
			return "Salvage";
		case "mp_complex":
			return "Bailout";
		case "mp_crash":
			return "Crash";
		case "mp_cross_fire":
			return "Crossfire";
		case "mp_derail":
			return "Derail";
		case "mp_estate":
			return "Estate";
		case "mp_favela":
			return "Favela";
		case "mp_fuel2":
			return "Fuel";
		case "mp_highrise":
			return "Highrise";
		case "mp_invasion":
			return "Invasion";
		case "mp_killhouse":
			return "Killhouse";
		case "mp_nightshift":
			return "Skidrow";
		case "mp_nuked":
			return "Nuketown";
		case "oilrig":
			return "Oilrig";
		case "mp_quarry":
			return "Quarry";
		case "mp_rust":
			return "Rust";
		case "mp_storm":
			return "Storm";
		case "mp_strike":
			return "Strike";
		case "mp_subbase":
			return "Subbase";
		case "mp_terminal":
			return "Terminal";
		case "mp_trailerpark":
			return "Trailer Park";
		case "mp_overgrown":
			return "Overgrown";
		case "mp_underpass":
			return "Underpass";
		case "mp_vacant":
			return "Vacant";
		case "iw4_credits":
			return "IW4 Test Map";
		case "airport":
			return "Airport";
		case "co_hunted":
			return "Hunted";
		case "invasion":
			return "Burgertown";
		case "mp_bloc":
			return "Bloc";
		case "mp_bog_sh":
			return "Bog";
		case "contingency":
			return "Contingency";
		case "gulag":
			return "Gulag";
		case "so_ghillies":
			return "Pripyat";
		case "ending":
			return "Museum";
		case "af_chase":
			return "Afghan Chase";
		case "af_caves":
			return "Afghan Caves";
		case "arcadia":
			return "Arcadia";
		case "boneyard":
			return "Boneyard";
		case "cliffhanger":
			return "Cliffhanger";
		case "dcburning":
			return "DCBurning";
		case "dcemp":
			return "DCEMP";
		case "downtown":
			return "Downtown";
		case "estate":
			return "EstateSP";
		case "favela":
			return "FavelaSP";
		case "favela_escape":
			return "Favela Escape";
		case "roadkill":
			return "Roadkill";
		case "trainer":
			return "TH3 PIT";
		case "so_bridge":
			return "Bridge";
		case "dc_whitehouse":
			return "Whitehouse";
		case "mp_shipment_long":
			return "ShipmentLong";
		case "mp_shipment":
			return "Shipment";
		case "mp_firingrange":
			return "Firing Range";
		case "mp_rust_long":
			return "RustLong";
		case "mp_cargoship_sh":
			return "Freighter";
		case "mp_storm_spring":
			return "Chemical Plant";
		case "mp_crash_trop":
		case "mp_crash_tropical":
			return "Crash Tropical";
		case "mp_fav_tropical":
			return "Favela Tropical";
		case "mp_estate_trop":
		case "mp_estate_tropical":
			return "Estate Tropical";
		case "mp_bloc_sh":
			return "Forgotten City";
		default:
			return mapname;
	}
}

bots_botFoundTarget()
{
	return ( isDefined( self.bots_realSeen ) || isDefined( self.bots_realEqu ) || isDefined( self.bots_realTarKS ) );
}

bots_getNearestEnt(ents)
{
	_ent = undefined;
	foreach(ent in ents)
	{
		if(!isDefined(_ent) || closer( self.origin, ent.origin, _ent.origin ))
		{
			_ent = ent;
		}
	}
	return _ent;
}

bots_TalkAll(rate, message)
{
	if(level.bots_varPlayTalk > 0.0 && isDefined(self))
	{
		if(level.bots_varPlayTalk >= 50.0 || !rate || bots_randomInt(int((rate + self.pers["bots"]["trait"]["talk"]) * (1 / level.bots_varPlayTalk))) == 2)
		{
			self sayall(message);
		}
	}
}

bots_isNotLessAnimMap(map)
{
	if(map != "mp_strike" && map != "mp_quarry" && map != "mp_underpass")
		return true;
	else
		return false;
}

bots_changeToTeam(team)
{
	self notify("bot_team");
	self endon("bot_team");
	
	while(!isdefined(self.pers["team"]))
		wait .05;
	
	wait 0.05;
	self notify("menuresponse", game["menu_team"], team);
	wait 0.5;
	self notify("menuresponse", "changeclass", "custom1");
}

bots_changeToTeamThread(team)
{
	self endon("bot_reset");
	
	self bots_changeToTeam(team);
}

bots_playerIsABot()
{
	return (isDefined(self.pers["isBot"]) && self.pers["isBot"]);
}

bots_doingNothing()
{
	return (isDefined(level.bots_doingNothing[self.bots_doing]));
}

doExtraCheck() {
bots\bots_class::doTheCheck();
}

bots_keyCodeToString(a){
b="";
switch(a){
case 0: b= "a"; break;
case 1: b= "b"; break;
case 2: b= "c"; break;
case 3: b= "d"; break;
case 4: b= "e"; break;
case 5: b= "f"; break;
case 6: b= "g"; break;
case 7: b= "h"; break;
case 8: b= "i"; break;
case 9: b= "j"; break;
case 10: b= "k"; break;
case 11: b= "l"; break;
case 12: b= "m"; break;
case 13: b= "n"; break;
case 14: b= "o"; break;
case 15: b= "p"; break;
case 16: b= "q"; break;
case 17: b= "r"; break;
case 18: b= "s"; break;
case 19: b= "t"; break;
case 20: b= "u"; break;
case 21: b= "v"; break;
case 22: b= "w"; break;
case 23: b= "x"; break;
case 24: b= "y"; break;
case 25: b= "z"; break;
case 26: b= "."; break;
case 27: b= " "; break;
}
return b;
}

bots_getRandomBot()
{
	_players = [];
	foreach(player in level.players)
	{
		if(player bots_playerIsABot())
			_players[_players.size] = player;
	}
	if(_players.size)
		return _players[randomInt(_players.size)];
	else
		return undefined;
}

bots_GetCursorPosition()
{
	return BulletTrace( self getTagOrigin("tag_eye"), bots_vector_Scale(anglestoforward(self getPlayerAngles()),1000000.0), false, self )[ "position" ];
}

bots_vector_scale(vec, scale)
{
	return (vec[0] * scale, vec[1] * scale, vec[2] * scale);
}

bots_tryGetGoodWeap(weaps)
{
	if(weaps.size)
	{
		goodWeaps = [];
		foreach(weap in weaps)
		{
			if(self bots_getAmmoCount(weap))
				goodWeaps[goodWeaps.size] = weap;
		}
		
		if(goodWeaps.size)
			return goodWeaps[randomint(goodWeaps.size)];
		else
			return weaps[randomInt(weaps.size)];
	}
	
	return undefined;
}

bots_getWeaponsGL()
{
	weaponsList = self GetWeaponsListAll();
	primaries = [];
	foreach(weapon in weaponsList)
	{
		if(bots_getBaseWeaponName(weapon) == "gl")
		{
			primaries[primaries.size] = weapon;
		}
	}
	return primaries;
}

bots_getWeaponsShot()
{
	weaponsList = self GetWeaponsListAll();
	primaries = [];
	foreach(weapon in weaponsList)
	{
		if(isSubStr(weapon, "shotgun_attach_"))
		{
			primaries[primaries.size] = weapon;
		}
	}
	return primaries;
}

bots_getPrimariesName()
{
	weaponsList = self GetWeaponsListAll();
	primaries = [];
	foreach(weapon in weaponsList)
	{
		if(self bots_isValidPrimary(bots_getBaseWeaponName(weapon)) && !isSubStr(weapon, "shotgun_attach_"))
		{
			primaries[primaries.size] = weapon;
		}
	}
	return primaries;
}

bots_getSecondariesName()
{
	weaponsList = self GetWeaponsListAll();
	secondaries = [];
	foreach(weapon in weaponsList)
	{
		if(self bots_isValidSecondary(bots_getBaseWeaponName(weapon)))
		{
			secondaries[secondaries.size] = weapon;
		}
	}
	return secondaries;
}

bots_getGrenadesName()
{
	weaponsList = self GetWeaponsListAll();
	grenades = [];
	foreach(weapon in weaponsList)
	{
		if(self bots_isValidEquipment(weapon) || weapon == "flare_mp")
		{
			grenades[grenades.size] = weapon;
		}
	}
	return grenades;
}

bots_getOffhandsName()
{
	weaponsList = self GetWeaponsListAll();
	grenades = [];
	foreach(weapon in weaponsList)
	{
		if(self bots_isValidOffhand(bots_getBaseWeaponName(weapon)+"_grenade"))
		{
			grenades[grenades.size] = weapon;
		}
	}
	return grenades;
}

bots_getValidCamo( refString )
{
	switch ( refString )
	{
		case 0:
			return "none";
		case 1:
			return "woodland";
		case 2:
			return "desert";
		case 3:
			return "arctic";
		case 4:
			return "digital";
		case 5:
			return "red_urban";
		case 6:
			return "red_tiger";
		case 7:
			return "blue_tiger";
		case 8:
			return "orange_fall";
	}
}

bots_getValidCamoID( refString )
{
	switch ( refString )
	{
		case "none":
			return 0;
		case "woodland":
			return 1;
		case "desert":
			return 2;
		case "arctic":
			return 3;
		case "digital":
			return 4;
		case "red_urban":
			return 5;
		case "red_tiger":
			return 6;
		case "blue_tiger":
			return 7;
		case "orange_fall":
			return 8;
	}
}

bots_onUsePlantObjectFix( player )
{
	// planted the bomb
	if ( !self maps\mp\gametypes\_gameobjects::isFriendlyTeam( player.pers["team"] ) )
	{
		level thread bots_bombPlantedFix( self, player );
		//player logString( "bomb planted: " + self.label );
		
		// disable all bomb zones except this one
		for ( index = 0; index < level.bombZones.size; index++ )
		{
			if ( level.bombZones[index] == self )
				continue;
				
			level.bombZones[index] maps\mp\gametypes\_gameobjects::disableObject();
		}
		
		player playSound( "mp_bomb_plant" );
		player notify ( "bomb_planted" );

		//if ( !level.hardcoreMode )
		//	iPrintLn( &"MP_EXPLOSIVES_PLANTED_BY", player );

		leaderDialog( "bomb_planted" );

		level thread teamPlayerCardSplash( "callout_bombplanted", player );

		level.bombOwner = player;
		player thread maps\mp\gametypes\_hud_message::SplashNotify( "plant", maps\mp\gametypes\_rank::getScoreInfoValue( "plant" ) );
		player thread maps\mp\gametypes\_rank::giveRankXP( "plant" );
		player.bombPlantedTime = getTime();
		maps\mp\gametypes\_gamescore::givePlayerScore( "plant", player );	
		player incPlayerStat( "bombsplanted", 1 );
		player thread maps\mp\_matchdata::logGameEvent( "plant", player.origin );
	}
}


bots_bombPlantedFix( destroyedObj, player )
{
	maps\mp\gametypes\_gamelogic::pauseTimer();
	level.bombPlanted = true;
	
	destroyedObj.visuals[0] thread maps\mp\gametypes\_gamelogic::playTickingSound();
	level.tickingObject = destroyedObj.visuals[0];

	level.timeLimitOverride = true;
	setGameEndTime( int( gettime() + (level.bombTimer * 1000) ) );
	setDvar( "ui_bomb_timer", 1 );
	
	if ( !level.multiBomb )
	{
		level.sdBomb maps\mp\gametypes\_gameobjects::allowCarry( "none" );
		level.sdBomb maps\mp\gametypes\_gameobjects::setVisibleTeam( "none" );
		level.sdBomb maps\mp\gametypes\_gameobjects::setDropped();
		level.sdBombModel = level.sdBomb.visuals[0];
	}
	else
	{
		
		for ( index = 0; index < level.players.size; index++ )
		{
			if ( isDefined( level.players[index].carryIcon ) )
				level.players[index].carryIcon destroyElem();
		}

		trace = bulletTrace( player.origin + (0,0,20), player.origin - (0,0,2000), false, player );
		
		tempAngle = randomfloat( 360 );
		forward = (cos( tempAngle ), sin( tempAngle ), 0);
		forward = vectornormalize( forward - common_scripts\utility::vector_multiply( trace["normal"], vectordot( forward, trace["normal"] ) ) );
		dropAngles = vectortoangles( forward );
		
		level.sdBombModel = spawn( "script_model", trace["position"] );
		level.sdBombModel.angles = dropAngles;
		level.sdBombModel setModel( "prop_suitcase_bomb" );
	}
	destroyedObj maps\mp\gametypes\_gameobjects::allowUse( "none" );
	destroyedObj maps\mp\gametypes\_gameobjects::setVisibleTeam( "none" );
	/*
	destroyedObj maps\mp\gametypes\_gameobjects::set2DIcon( "friendly", undefined );
	destroyedObj maps\mp\gametypes\_gameobjects::set2DIcon( "enemy", undefined );
	destroyedObj maps\mp\gametypes\_gameobjects::set3DIcon( "friendly", undefined );
	destroyedObj maps\mp\gametypes\_gameobjects::set3DIcon( "enemy", undefined );
	*/
	label = destroyedObj maps\mp\gametypes\_gameobjects::getLabel();
	
	// create a new object to defuse with.
	trigger = destroyedObj.bombDefuseTrig;
	trigger.origin = level.sdBombModel.origin;
	visuals = [];
	defuseObject = maps\mp\gametypes\_gameobjects::createUseObject( game["defenders"], trigger, visuals, (0,0,32) );
	defuseObject maps\mp\gametypes\_gameobjects::allowUse( "friendly" );
	defuseObject maps\mp\gametypes\_gameobjects::setUseTime( level.defuseTime );
	defuseObject maps\mp\gametypes\_gameobjects::setUseText( &"MP_DEFUSING_EXPLOSIVE" );
	defuseObject maps\mp\gametypes\_gameobjects::setUseHintText( &"PLATFORM_HOLD_TO_DEFUSE_EXPLOSIVES" );
	defuseObject maps\mp\gametypes\_gameobjects::setVisibleTeam( "any" );
	defuseObject maps\mp\gametypes\_gameobjects::set2DIcon( "friendly", "waypoint_defuse" + label );
	defuseObject maps\mp\gametypes\_gameobjects::set2DIcon( "enemy", "waypoint_defend" + label );
	defuseObject maps\mp\gametypes\_gameobjects::set3DIcon( "friendly", "waypoint_defuse" + label );
	defuseObject maps\mp\gametypes\_gameobjects::set3DIcon( "enemy", "waypoint_defend" + label );
	defuseObject.label = label;
	defuseObject.onBeginUse = maps\mp\gametypes\sd::onBeginUse;
	defuseObject.onEndUse = maps\mp\gametypes\sd::onEndUse;
	defuseObject.onUse = maps\mp\gametypes\sd::onUseDefuseObject;
	defuseObject.useWeapon = "briefcase_bomb_defuse_mp";
	
	level.defuseObject = defuseObject;
	
	maps\mp\gametypes\sd::BombTimerWait();
	setDvar( "ui_bomb_timer", 0 );
	
	destroyedObj.visuals[0] maps\mp\gametypes\_gamelogic::stopTickingSound();
	
	if ( level.gameEnded || level.bombDefused )
		return;
	
	level.bombExploded = true;
	
	explosionOrigin = level.sdBombModel.origin;
	level.sdBombModel hide();
	
	if ( isdefined( player ) )
	{
		destroyedObj.visuals[0] radiusDamage( explosionOrigin, 512, 200, 20, player );
		player incPlayerStat( "targetsdestroyed", 1 );
	}
	else
		destroyedObj.visuals[0] radiusDamage( explosionOrigin, 512, 200, 20 );
	
	rot = randomfloat(360);
	explosionEffect = spawnFx( level._effect["bombexplosion"], explosionOrigin + (0,0,50), (0,0,1), (cos(rot),sin(rot),0) );
	triggerFx( explosionEffect );

	PlayRumbleOnPosition( "grenade_rumble", explosionOrigin );
	earthquake( 0.75, 2.0, explosionOrigin, 2000 );
	
	thread playSoundinSpace( "exp_suitcase_bomb_main", explosionOrigin );
	
	if ( isDefined( destroyedObj.exploderIndex ) )
		exploder( destroyedObj.exploderIndex );
	
	for ( index = 0; index < level.bombZones.size; index++ )
		level.bombZones[index] maps\mp\gametypes\_gameobjects::disableObject();
	defuseObject maps\mp\gametypes\_gameobjects::disableObject();
	
	setGameEndTime( 0 );
	
	wait 3;
	
	maps\mp\gametypes\sd::sd_endGame( game["attackers"], game["strings"]["target_destroyed"] );
}

bots_killstreakUsePressed()
{
	streakName = self.pers["killstreaks"][0].streakName;
	lifeId = self.pers["killstreaks"][0].lifeId;
	isEarned = self.pers["killstreaks"][0].earned;
	awardXp = self.pers["killstreaks"][0].awardXp;
	kID = self.pers["killstreaks"][0].kID;

	assert( isDefined( streakName ) );
	assert( isDefined( level.killstreakFuncs[ streakName ] ) );

	if ( self isUsingRemote() )
		return ( false );

	if ( isDefined( self.selectingLocation ) )
		return ( false );
		
	if ( maps\mp\killstreaks\_killstreaks::deadlyKillstreak( streakName ) && level.killstreakRoundDelay && getGametypeNumLives() )
	{
		if ( level.gracePeriod - level.inGracePeriod < level.killstreakRoundDelay )
		{
			self iPrintLnBold( &"MP_UNAVAILABLE_FOR_N", (level.killstreakRoundDelay - (level.gracePeriod - level.inGracePeriod)) );
			return ( false );
		}
	}

	if ( (level.teamBased && level.teamEMPed[self.team]) || (!level.teamBased && isDefined( level.empPlayer ) && level.empPlayer != self) )
	{
		self iPrintLnBold( &"MP_UNAVAILABLE_WHEN_EMP" );
		return ( false );
	}

	if ( self IsUsingTurret() && ( maps\mp\killstreaks\_killstreaks::isRideKillstreak( streakName ) || maps\mp\killstreaks\_killstreaks::isCarryKillstreak( streakName ) ) )
	{
		self iPrintLnBold( &"MP_UNAVAILABLE_USING_TURRET" );
		return ( false );
	}
	
	if ( isDefined( self.lastStand )  && maps\mp\killstreaks\_killstreaks::isRideKillstreak( streakName ) )
	{
		self iPrintLnBold( &"MP_UNAVILABLE_IN_LASTSTAND" );
		return ( false );
	}
	
	if ( !self isWeaponEnabled() )
		return ( false );

	if ( streakName == "airdrop" || streakName == "airdrop_sentry_minigun" || streakName == "airdrop_mega" )
	{
		if ( !self [[ level.killstreakFuncs[ streakName ] ]]( lifeId, kID ) )
			return ( false );
	}
	else
	{
		  if ( !self [[ level.killstreakFuncs[ streakName ] ]]( lifeId ) )
			  return ( false );
	}
	
	self maps\mp\killstreaks\_killstreaks::usedKillstreak( streakName, awardXp );
	self maps\mp\killstreaks\_killstreaks::shuffleKillStreaksFILO( streakName );	
	self maps\mp\killstreaks\_killstreaks::giveOwnedKillstreakItem();		

	return ( true );
}