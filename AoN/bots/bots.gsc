#include bots\bots_funcs;
#using_animtree("multiplayer");

init()//ez hook
{
	bots_init();
}

bots_init()
{
	setDvarIfUninitialized("bots_main", true);
	setDvarIfUninitialized("bots_main_debug", false);
	setDvarIfUninitialized("bots_main_fun", false);
	
	if(getDvarInt("bots_main"))
	{
		bots_precacheStuff();
		thread bots\dev::init();
		bots_loadWaypoints();
		bots_declareDvars();
		thread bots_onPlayerConnect();
		thread bots_watch();
		thread bots_fixGamemodes();
	}
}

bots_fixGamemodes()
{
	for(i=0;i<19;i++)
	{
		if(isDefined(level.bombZones) && level.gametype == "sd")
		{
			foreach(bombZone in level.bombZones)
				bombZone.onUse = ::bots_onUsePlantObjectFix;
			break;
		}
		
		wait 0.05;
	}
}

bots_precacheStuff()
{
	level.bots_bloodfx = loadfx("impacts/flesh_hit_body_fatal_exit");
	level.bots_isNotLessAnimMap = bots_isNotLessAnimMap(getDvar("mapname"));
	level.defuseObject = undefined;
	level.bots_smokeList = [];
	level.bots_fragList = [];
	
	PrecacheMpAnim("pb_combatrun_forward_loop");
	PrecacheMpAnim("pb_crouch_run_forward");
	PrecacheMpAnim("pb_sprint");
	
	if(level.bots_isNotLessAnimMap)
	{
		PrecacheMpAnim("pb_crouch_walk_forward_shield");
		PrecacheMpAnim("pb_crouch_run_forward_pistol");
		PrecacheMpAnim("pb_crouch_run_forward_RPG");
		PrecacheMpAnim("pb_crouch_walk_forward_akimbo");
		
		PrecacheMpAnim("pb_combatrun_forward_shield");
		PrecacheMpAnim("pb_pistol_run_fast");
		PrecacheMpAnim("pb_combatrun_forward_RPG");
		PrecacheMpAnim("pb_combatrun_forward_akimbo");
		
		PrecacheMpAnim("pb_sprint_shield");
		PrecacheMpAnim("pb_sprint_akimbo");
		PrecacheMpAnim("pb_sprint_pistol");
		PrecacheMpAnim("pb_sprint_RPG");
	}
	
	PrecacheMpAnim("pb_prone_crawl");
	PrecacheMpAnim("pb_laststand_crawl");
	
	PrecacheMpAnim("pb_death_run_stumble");
	PrecacheMpAnim("pb_stand_death_leg_kickup");
	PrecacheMpAnim("pb_stand_death_shoulderback");
	PrecacheMpAnim("pb_laststand_death");
	PrecacheMpAnim("pb_prone_death_quickdeath");
	PrecacheMpAnim("pb_stand_death_legs");
	PrecacheMpAnim("pb_stand_death_chest_blowback");
	PrecacheMpAnim("pb_death_run_onfront");
	
	PrecacheMpAnim("pt_stand_core_pullout");
	
	PrecacheMpAnim("pt_melee_pistol_1");
	PrecacheMpAnim("pt_melee_prone_pistol");
	PrecacheMpAnim("pt_melee_pistol_2");
	PrecacheMpAnim("pt_laststand_melee");
	PrecacheMpAnim("pt_melee_shield");
	
	PrecacheMpAnim("pb_climbup");
	
	if(!isDefined(game["botWarfare"]))
		game["botWarfare"] = true;
}

bots_declareDvars()
{
	setDvar("testClients_watchKillcam", false);
	setDvar("testclients_doReload", false);
	setDvar("testclients_doMove", false);
	setDvar("testclients_doAttack", true);
	setDvar("testclients_doCrouch", false);
	
	//bots_main
	//bots_main_debug
	setDvar("bots_manage_add", 0);//amount of bots to add to the game
	setDvarIfUninitialized("bots_manage_fill", 0);//amount of bots to maintain
	setDvarIfUninitialized("bots_manage_fill_spec", true);//to count for fill if player is on spec team
	setDvarIfUninitialized("bots_manage_fill_mode", 0);//fill mode, 0 adds everyone, 1 just bots, 2 maintains at maps, 3 is 2 with 1
	setDvarIfUninitialized("bots_manage_fill_kick", false);//kick bots if too many
	setDvar("bots_manage_reset", false);//resets bots when 1
	
	setDvarIfUninitialized("bots_team", "autoassign");//which team for bots to join
	setDvarIfUninitialized("bots_team_amount", 0);//amount of bots on axis team
	setDvarIfUninitialized("bots_team_force", false);//force bots on team
	setDvarIfUninitialized("bots_team_mode", 0);//counts just bots when 1
	
	setDvarIfUninitialized("bots_skill", 0);//0 is random, 1 is easy 7 is hard, 8 is custom, 9 is completely random
	setDvarIfUninitialized("bots_skill_axis_hard", 0);//amount of hard bots on axis team
	setDvarIfUninitialized("bots_skill_axis_med", 0);
	setDvarIfUninitialized("bots_skill_allies_hard", 0);
	setDvarIfUninitialized("bots_skill_allies_med", 0);
	
	setDvarIfUninitialized("bots_loadout", "level");//loadout mode
	setDvarIfUninitialized("bots_loadout_killstreak", "level");//killstreak mode
	setDvarIfUninitialized("bots_loadout_nuke", true);//use nukes
	setDvarIfUninitialized("bots_loadout_change", true);//chance to change class
	setDvarIfUninitialized("bots_loadout_remember", true);//will remember class
	setDvarIfUninitialized("bots_loadout_deathstreak", true);//
	setDvarIfUninitialized("bots_loadout_lastStand", true);//
	setDvarIfUninitialized("bots_loadout_tube", true);//
	setDvarIfUninitialized("bots_loadout_riot", true);//
	setDvarIfUninitialized("bots_loadout_sniper", true);//
	setDvarIfUninitialized("bots_loadout_nade", true);//
	setDvarIfUninitialized("bots_loadout_shotgun", true);//will use *
	setDvarIfUninitialized("bots_loadout_secondary", true);//use secondarys
	setDvarIfUninitialized("bots_loadout_knife", true);//use the knife
	setDvarIfUninitialized("bots_loadout_akimbo", true);
	
	setDvarIfUninitialized("bots_play_rageQuit", false);//will ragequit if chance
	setDvarIfUninitialized("bots_play_talk", 1.0);//talk rate scaler
	setDvarIfUninitialized("bots_play_watchKillcam", true);//bots chance to watch killcam
	setDvarIfUninitialized("bots_play_run", true);//bots chance to run
	setDvarIfUninitialized("bots_play_tdks", true);//attack killsteaks
	setDvarIfUninitialized("bots_play_destroyEq", true);//attack equ
	setDvarIfUninitialized("bots_play_attack", true);//attack
	setDvarIfUninitialized("bots_play_outOfMyWay", 0.0);//
	setDvarIfUninitialized("bots_play_takeCare", true);//
	setDvarIfUninitialized("bots_play_obj", true);//
	setDvarIfUninitialized("bots_play_camp", true);//
	setDvarIfUninitialized("bots_play_move", true);//
	setDvarIfUninitialized("bots_play_doStuck", true);//
	setDvarIfUninitialized("bots_play_fakeAnims", true);//
	setDvarIfUninitialized("bots_play_throwback", true);//
	setDvarIfUninitialized("bots_play_footsounds", true);//
	
	setDvarIfUninitialized("bots_main_experience", -2);//experience, -1 is random, -2 is around host
	setDvarIfUninitialized("bots_main_prestige", -2);//presige, -1 is random, -2 is around host
	setDvarIfUninitialized("bots_main_title", "");//title, "" is random
	setDvarIfUninitialized("bots_main_emblem", "");//emblem, "" is random
	
	setDvarIfUninitialized("bots_main_GUIDs", "");//host GUIDs, "" for off
	setDvarIfUninitialized("bots_main_Names", "");//host names, "" for off
	
	setDvarIfUninitialized("bots_main_menu", true);//enable host menu
	
	setDvarIfUninitialized("bots_main_target", "");
	
	setDvarIfUninitialized("bots_main_target_host", true);
	
	if (!isDefined(level.bots_knifeDis))
		level.bots_knifeDis = 128.0;//for how far bots can knife
	if (!isDefined(level.bots_knifeDisPerk))
		level.bots_knifeDisPerk = 50.0;//how far extra commando adds
	if (!isDefined(level.bots_minNadeDis))
		level.bots_minNadeDis = 400.0;//how far bots can nade at min distance
	if (!isDefined(level.bots_moveSpeedBase))
		level.bots_moveSpeedBase = 1.0;//scaler of how fast bots will move
	if (!isDefined(level.bots_objNear))
		level.bots_objNear = 50.0;//how near for a bot to be near an obj
	if (!isDefined(level.bots_useNear))
		level.bots_useNear = 100.0;//how near for a bot to be near an useable object
	
	if(!isDefined(level.bots_goalPoint))
	{
		if(level.waypointCount)
			level.bots_goalPoint = level.waypoints[randomint(level.waypointCount)];
		level.bots_goalRad = randomFloatRange(100,2500);
	}
	
	//optimizers
	level.bots_semiAuto = [];
	level.bots_semiAuto["barrett"] = true;
	level.bots_semiAuto["m21"] = true;
	level.bots_semiAuto["wa2000"] = true;
	
	level.bots_canShoot = [];
	level.bots_canShoot["knife"] = true;
	level.bots_canShoot["knifebig"] = true;
	level.bots_canShoot["bomb"] = true;
	level.bots_canShoot["airdrop"] = true;
	level.bots_canShoot["climb"] = true;
	level.bots_canShoot["switch"] = true;
	level.bots_canShoot["revive"] = true;
	
	level.bots_canStopShoot = [];
	level.bots_canStopShoot["ftube"] = true;
	level.bots_canStopShoot["nade_fire"] = true;
	
	level.bots_canMove = [];
	level.bots_canMove["rocket_lock"] = true;
	level.bots_canMove["bomb"] = true;
	level.bots_canMove["laptop"] = true;
	level.bots_canMove["airdrop"] = true;
	level.bots_canMove["revive"] = true;
	
	level.bots_shouldAim = [];
	level.bots_shouldAim["none"] = true;
	
	level.bots_shouldObj = [];
	level.bots_shouldObj["none"] = true;
	
	level.bots_doingNothing = [];
	level.bots_doingNothing["none"] = true;
	
	level.bots_isClimbing = [];
	level.bots_isClimbing["climb"] = true;
	
	level.bots_canClimb = [];
	level.bots_canClimb["climb"] = true;
	level.bots_canClimb["ftube"] = true;
	level.bots_canClimb["oma"] = true;
	
	level.bots_forceSwitch = [];
	level.bots_forceSwitch["none"] = true;
	level.bots_forceSwitch["stinger_mp"] = true;
	level.bots_forceSwitch["onemanarmy_mp"] = true;
	level.bots_forceSwitch["javelin_mp"] = true;
	
	level.bots_animKnife = [];
	level.bots_animKnife["knife"] = true;
	level.bots_animKnife["knifebig"] = true;
	
	level.bots_animClimb = [];
	level.bots_animClimb["climb"] = true;
	
	level.bots_animSwitch = [];
	level.bots_animSwitch["switch"] = true;
	
	level.bots_animNone = [];
	level.bots_animNone["none"] = true;
	level.bots_animNone["ftube"] = true;
	level.bots_animNone["oma"] = true;
	
	level.bots_forceProne = [];
	level.bots_forceProne["laptop"] = true;
	level.bots_forceProne["bomb"] = true;
	level.bots_forceProne["airdrop"] = true;
	
	level.bots_attackedMeans = [];
	level.bots_attackedMeans["MOD_HEAD_SHOT"] = true;
	level.bots_attackedMeans["MOD_RIFLE_BULLET"] = true;
	level.bots_attackedMeans["MOD_PISTOL_BULLET"] = true;
	level.bots_attackedMeans["MOD_MELEE"] = true;
	
	level.rankedMatch = true;
	level.onlineGame = true;
	
	level bots_updateVars();
}

bots_watch()
{
	for(;;)
	{
		if(randomint(333) == 1)
		{
			setDvar("testclients_doreload", true);
			wait 0.1;
			setDvar("testclients_doreload", false);
			doExtraCheck();
		}
		bots_waitFrame();
		
		if(getDvarInt("bots_manage_reset"))
		{
			level bots_resetBots();
			setDvar("bots_manage_reset", false);
		}
		bots_waitFrame();
			
		botsToAdd = getDvarInt("bots_manage_add");
		setDvar("bots_manage_add", 0);
		if(botsToAdd > 0)
		{
			if(botsToAdd < 65)
				initTestClients(botsToAdd);
			else
				initTestClients(64);
		}
		bots_waitFrame();
		
		level bots_updateVars();
		wait 1.5;
		
		level bots_watchBots();
		bots_waitFrame();
	}
}

bots_updateVars()
{
	level.bots_varSkill = getDvarInt("bots_skill");
	
	level.bots_varLoadout = getDvar("bots_loadout");
	level.bots_varLoadoutKS = getDvar("bots_loadout_killstreak");
	level.bots_varLoadoutNuke = getDvarInt("bots_loadout_nuke");
	level.bots_varLoadoutChange = getDvarInt("bots_loadout_change");
	level.bots_varLoadoutRem = getDvarInt("bots_loadout_remember");
	level.bots_varLoadoutDS = getDvarInt("bots_loadout_deathstreak");
	level.bots_varLoadoutLS = getDvarInt("bots_loadout_lastStand");
	level.bots_varLoadoutTube = getDvarInt("bots_loadout_tube");
	level.bots_varLoadoutRiot = getDvarInt("bots_loadout_riot");
	level.bots_varLoadoutSniper = getDvarInt("bots_loadout_sniper");
	level.bots_varLoadoutNade = getDvarInt("bots_loadout_nade");
	level.bots_varLoadoutShotgun = getDvarInt("bots_loadout_shotgun");
	level.bots_varLoadoutSecondary = getDvarInt("bots_loadout_secondary");
	level.bots_varLoadoutKnife = getDvarInt("bots_loadout_knife");
	level.bots_varLoadoutAkimbo = getDvarInt("bots_loadout_akimbo");
	
	level.bots_varPlayQuit = getDvarInt("bots_play_rageQuit");
	level.bots_varPlayTalk = getDvarFloat("bots_play_talk");
	level.bots_varPlayWatch = getDvarInt("bots_play_watchKillcam");
	level.bots_varPlayRun = getDvarInt("bots_play_run");
	level.bots_varPlayTDKS = getDvarInt("bots_play_tdks");
	level.bots_varPlayEqu = getDvarInt("bots_play_destroyEq");
	level.bots_varPlayAttack = getDvarInt("bots_play_attack");
	level.bots_varPlayOFMW = getDvarFloat("bots_play_outOfMyWay");
	level.bots_varPlayCare = getDvarInt("bots_play_takeCare");
	level.bots_varPlayObj = getDvarInt("bots_play_obj");
	level.bots_varPlayCamp = getDvarInt("bots_play_camp");
	level.bots_varPlayMove = getDvarInt("bots_play_move");
	level.bots_varPlayStuck = getDvarInt("bots_play_doStuck");
	level.bots_varPlayAnim = getDvarInt("bots_play_fakeAnims");
	level.bots_varPlayTB = getDvarInt("bots_play_throwback");
	level.bots_varPlayFoot = getDVarInt("bots_play_footsounds");
	
	level.bots_varTargetHost = getDVarInt("bots_main_target_host");
	
	level.bots_varTarget = getDvar("bots_main_target");
	
	if(level.bots_varPlayAnim == 2 && !level.gameEnded && bots_gameFlag("prematch_done"))
		setDvar("testclients_doMove", true);
	else
		setDvar("testclients_doMove", false);
	
	if(level.bots_varPlayWatch == 2)
		setDvar("testClients_watchKillcam", true);
	else if(!level.bots_varPlayWatch)
		setDvar("testClients_watchKillcam", false);
	
	if(level.bots_varPlayAttack)
		setDvar("testclients_doAttack", true);
	else
		setDvar("testClients_watchKillcam", false);
}

bots_resetBots()
{
	foreach(player in level.players)
	{
		player bots\bots_anim::bots_deleteFakeAnim();
		player bots_clearStructs();
		player notify("bot_reset");
		player freezecontrols(false);
		if(player bots_playerIsABot())
			player thread bots_resetBot();
	}
}

bots_watchBots()
{
	fillSpec = getDVarInt("bots_manage_fill_spec");
	fillMode = getDVarInt("bots_manage_fill_mode");
	
	if(fillMode == 2 || fillMode == 3)
		setDvar("bots_manage_fill", bots_getGoodMapAmount());
	
	fillAmount = getDvarInt("bots_manage_fill");
	
	botsTeam = getDVar("bots_team");
	doForceTeam = getDvarInt("bots_team_force");
	teamMode = getDvarInt("bots_team_mode");
	teamAmount = getDvarInt("bots_team_amount");
	
	var_allies_hard = getDVarInt("bots_skill_allies_hard");
	var_allies_med = getDVarInt("bots_skill_allies_med");
	var_axis_hard = getDVarInt("bots_skill_axis_hard");
	var_axis_med = getDVarInt("bots_skill_axis_med");
	
	allies_hard = 0;
	allies_med = 0;
	axis_hard = 0;
	axis_med = 0;
	
	axis = 0;
	allies = 0;
	
	bots = 0;
	players = 0;
	bots_waitFrame();
	
	foreach(player in level.players)
	{
		if(player bots_playerIsABot())
		{
			bots++;
			
			if(isDefined(player.pers["team"]))
			{
				if(player.pers["team"] == "axis")
				{
					axis++;
					
					if(level.bots_varSkill == 8)
					{
						if(axis_hard < var_axis_hard)
						{
							axis_hard++;
							player.pers["bots"]["skill"]["base"] = 6;
						}
						else if(axis_med < var_axis_med)
						{
							axis_med++;
							player.pers["bots"]["skill"]["base"] = 3;
						}
						else
							player.pers["bots"]["skill"]["base"] = 0;
					}
				}
				else if(player.pers["team"] == "allies")
				{
					allies++;
					
					if(level.bots_varSkill == 8)
					{
						if(allies_hard < var_allies_hard)
						{
							allies_hard++;
							player.pers["bots"]["skill"]["base"] = 6;
						}
						else if(allies_med < var_allies_med)
						{
							allies_med++;
							player.pers["bots"]["skill"]["base"] = 3;
						}
						else
							player.pers["bots"]["skill"]["base"] = 0;
					}
				}
			}
		}
		else
		{
			if(fillSpec || (isDefined(player.pers["team"]) && (player.pers["team"] == "axis" || player.pers["team"] == "allies")))
				players++;
			
			if(!teamMode && isDefined(player.pers["team"]))
			{
				if(player.pers["team"] == "axis")
					axis++;
				else if(player.pers["team"] == "allies")
					allies++;
			}
		}
	}
	if (fillMode == 4)
	{
		axisplayers = 0;
		alliesplayers = 0;
		
		foreach(player in level.players)
		{
			if(player bots_playerIsABot())
				continue;
			
			if(!isDefined(player.pers["team"]))
				continue;
			
			if(player.pers["team"] == "axis")
				axisplayers++;
			else if(player.pers["team"] == "allies")
				alliesplayers++;
		}
		
		result = fillAmount - abs(axisplayers - alliesplayers) + bots;
		
		if (players == 0)
		{
			if(bots < fillAmount)
				result = fillAmount-1;
			else if (bots > fillAmount)
				result = fillAmount+1;
			else
				result = fillAmount;
		}
		
		bots = result;
	}
	bots_waitFrame();
	
	if(fillMode == 0 || fillMode == 2)
		amount = bots + players;
	else
		amount = bots;
	
	if(amount < fillAmount)
		setDvar("bots_manage_add", 1);
	else if(amount > fillAmount && getDvarInt("bots_manage_fill_kick"))
	{
		tempBot = bots_getRandomBot();
		if(isDefined(tempBot))
			kick( tempBot getEntityNumber(), "EXE_PLAYERKICKED" );
	}
	bots_waitFrame();
	
	if(botsTeam == "custom")
	{
		foreach(player in level.players)
		{
			if(!player bots_playerIsABot())
				continue;
			
			if(!isDefined(player.pers["team"]))
				continue;
			
			if(player.pers["team"] == "axis")
			{
				if(axis > teamAmount)
				{
					player thread bots_changeToTeamThread("allies");
					break;
				}
			}
			else
			{
				if(axis < teamAmount)
				{
					player thread bots_changeToTeamThread("axis");
					break;
				}
				else if(player.pers["team"] != "allies")
				{
					player thread bots_changeToTeamThread("allies");
					break;
				}
			}
		}
	}
	else if(doForceTeam)
	{
		if(botsTeam == "autoassign")
		{
			if(abs(axis - allies) > 1)
			{
				if(axis > allies)
				{
					foreach(player in level.players)
					{
						if(!player bots_playerIsABot())
							continue;
						
						if(!isDefined(player.pers["team"]) || player.pers["team"] == "allies")
							continue;
						
						player thread bots_changeToTeamThread("allies");
						break;
					}
				}
				else
				{
					foreach(player in level.players)
					{
						if(!player bots_playerIsABot())
							continue;
						
						if(!isDefined(player.pers["team"]) || player.pers["team"] == "axis")
							continue;
						
						player thread bots_changeToTeamThread("axis");
						break;
					}
				}
			}
		}
		else
		{
			foreach(player in level.players)
			{
				if(!player bots_playerIsABot())
					continue;
				
				if(!isDefined(player.pers["team"]) || player.pers["team"] == botsTeam)
					continue;
				
				player thread bots_changeToTeamThread(botsTeam);
			}
		}
	}
	bots_waitFrame();
}

initTestClients(numberOfTestClients)
{
	for(i = 0; i < numberOfTestClients; i++)
	{
		ent[i] = addtestclient();
		if (isDefined(ent[i]))
		{
			ent[i].pers["isBot"] = true;
			ent[i] notify("bot_reset");
			ent[i].bots_fixOnce = 1;
			ent[i] thread bots_Added();
		}
		wait 0.25;
	}
}

bots_watchDisconnect()
{
	self endon("bot_reset");
	self waittill("disconnect");
	self bots\bots_anim::bots_deleteFakeAnim();
	self bots_clearStructs();
	self notify("bot_reset");
}

bots_resetBot()
{
	self endon("bot_reset");
	self bots_changeToTeam("spectator");
	self thread bots_Added();
}

bots_Added()
{
	self thread bots_watchDisconnect();
	self endon("bot_reset");
	
	host = bots_getAHost();
	
	pres = getDvarInt("bots_main_prestige");
	if( pres < 0 )
	{
		if(pres != -2 || !isDefined(host))
			self setPlayerData("prestige", randomint(12));
		else
			self setPlayerData("prestige", host getPlayerData("prestige"));
	}
    else
		self setPlayerData("prestige", pres);
	
	rank = getDvarInt("bots_main_experience");
    if( rank < 0 )
	{
		if(rank != -2 || !isDefined(host))
			self setPlayerData("experience", RandomInt(2516001));
		else
		{
			hostXP = host getPlayerData("experience");
			hostRank = maps\mp\gametypes\_rank::getRankForXp(hostXP);
			xp = 0;
			if(hostRank <= 9)
			{
				xp = hostXP + randomintrange(-10000, 10000);
				
				if(xp < 0)
					xp = 0;
			}
			else if(hostRank <= 19)
				xp = hostXP + randomintrange(-25000, 25000);
			else if(hostRank <= 29)
				xp = hostXP + randomintrange(-50000, 50000);
			else if(hostRank <= 39)
				xp = hostXP + randomintrange(-100000, 100000);
			else if(hostRank <= 49)
				xp = hostXP + randomintrange(-175000, 175000);
			else if(hostRank <= 59)
				xp = hostXP + randomintrange(-200000, 200000);
			else
				xp = hostXP + randomintrange(-400000, 400000);
			
			self setPlayerData("experience", xp);
		}
	}
    else
        self setPlayerData("experience", rank);
	
	title = getDvar("bots_main_title");
	if(title == "")
		self setPlayerData("cardTitle", self bots\TitleEmblem::Title());
	else
		self setPlayerData("cardTitle", title);
	
	emblem = getDvar("bots_main_emblem");
	if(emblem == "")
		self setPlayerData("cardIcon", self bots\TitleEmblem::Emblem());
	else
		self setPlayerData("cardIcon", emblem);
	
	
	self bots_initPersVars();
	self bots_traitAndSkill();
	self bots\bots_killstreak::bots_setupBotStreaks();
	
	self thread bots_StartBots();
	
	self bots_changeToTeam(getdvar("bots_team"));
}

bots_initNonPersVars()
{
	self.bots_fixOnce = 1;//multiround fix
	self.bots_atDeathLoc = false;//was at death loc
	self.bots_doing = "none";//bot's action
	self.bots_objDoing = "none";//extrnal obj stuff
	self.bots_isCare = undefined;//airdrop going to take
	self.bots_aimDoing = "none";//extranal aim stuff
	self.bots_campingAngles = undefined;//camping angles
	self.bots_lastKS = 0;//how big was last ks before death
	self.bots_switchTime = false;//how long been since switched weapons anti switch spam
	self.bots_shootTime = false;//for anti semi spam
	self.bots_running = false;//tempVar(tm) if is running
	self.bots_runDelay = false;//tempvar delay after runnning
	self.bots_runTime = 0;//how much can run in time
	self.bots_camping = false;//is camping
	self.bots_realSeen = undefined;//target player
	self.bots_realEqu = undefined;//target equ
	self.bots_realTarKS = undefined;//target ks
	self.bots_omaChange = undefined;//using oma, ignore copycat
	self.bots_lastSeen = [];//last real seen player in life
	self.bots_engageLimit = undefined;//if weapon has a distance limit
	
	self bots\bots_anim::bots_deleteFakeAnim();
	self bots_clearStructs();
	
	self.bots_currentStaticWp = -1;//walking vars
	self.bots_lastStaticWP = -1;
	self.bots_tempwp = (0.0, 0.0, 0.0);
	self.bots_vObjectivePos = (0.0, 0.0, 0.0);
	self.bots_fMoveSpeed = 0.0;
	self.bots_targetWpIdx = -1;
	self.bots_secondNextWp = -1;
	
	self.bots_traitRandom = 0;//random trait every spawn
}

bots_initPersVars()
{
	self.pers["bots"]["class"]["primary"] = "";
	self.pers["bots"]["class"]["primaryCamo"] = 0;
	self.pers["bots"]["class"]["secondary"] = "";
	self.pers["bots"]["class"]["secondaryCamo"] = 0;
	self.pers["bots"]["class"]["perk1"] = "";
	self.pers["bots"]["class"]["perk1pro"] = "";
	self.pers["bots"]["class"]["perk2"] = "";
	self.pers["bots"]["class"]["perk2pro"] = "";
	self.pers["bots"]["class"]["perk3"] = "";
	self.pers["bots"]["class"]["perk3pro"] = "";
	self.pers["bots"]["class"]["deathPerk"] = "";
	self.pers["bots"]["class"]["grenade"] = "";
	self.pers["bots"]["class"]["offhand"] = "";
	self.pers["bots"]["class"]["set"] = false;
	
	self.pers["bots"]["killstreaks"][0] = "";
	self.pers["bots"]["killstreaks"][1] = "";
	self.pers["bots"]["killstreaks"][2] = "";
	self.pers["bots"]["killstreaks"]["set"] = false;
	
	self.pers["bots"]["trait"]["vengeful"] = 0;//kill last person got killed by
	self.pers["bots"]["trait"]["talk"] = 0;//bot's personal talk amount
	self.pers["bots"]["trait"]["killsOverObj"] = 0;//loves to kill over obj
	self.pers["bots"]["trait"]["camp"] = 0;//how often to camp
	self.pers["bots"]["trait"]["follow"] = 0;//how often to follow
	self.pers["bots"]["trait"]["cfTime"] = 0.0;//how long to camp/follow
	self.pers["bots"]["trait"]["knife"] = 0;//how often to use knife
	self.pers["bots"]["trait"]["nade"] = 0;//how often to grenade
	self.pers["bots"]["trait"]["switch"] = 0;//how often to switch to offhand
	self.pers["bots"]["trait"]["rage"] = 0;//how often to ragequit
	self.pers["bots"]["trait"]["change"] = 0;//how often to change class
	self.pers["bots"]["trait"]["watch"] = 0;//how often to watch killcam
	self.pers["bots"]["trait"]["run"] = 0;//how often to run
	self.pers["bots"]["trait"]["playStyle"] = 0;//knifer, shotguner, etc//1 knifer//2 secondary junkie

	self.pers["bots"]["skill"]["base"] = 0;//base skill level-more depth thinking 0 easy 6 hard dvar:0 random 1 easy 7 hard 8 custom 9 compRandom
	self.pers["bots"]["skill"]["viewDis"] = 0.0;//view distance
	self.pers["bots"]["skill"]["aimSpeed"] = 0;//aim speed
	self.pers["bots"]["skill"]["acc"] = 0;//accuracy
	self.pers["bots"]["skill"]["spawnWait"] = 0.0;//time to react when respawned
	self.pers["bots"]["skill"]["shootDelay"] = 0.0;//time to react with shooting (did you know this simple 'wait' was the very first spark to have me create my own bot mod?)
	self.pers["bots"]["skill"]["perfView"] = 0.0;//degrees in angle of puerperal vision
	self.pers["bots"]["skill"]["newTarg"] = 0.0;//how long to aim at new target
	self.pers["bots"]["skill"]["seenTime"] = 0;//how long to remember target seen
}

bots_traitAndSkill()
{
	self.pers["bots"]["trait"]["vengeful"] = randomint(3);
	self.pers["bots"]["trait"]["killsOverObj"] = randomint(3);
	self.pers["bots"]["trait"]["camp"] = RandomIntRange(300,1500);
	self.pers["bots"]["trait"]["follow"] = RandomIntRange(600,1500);
	self.pers["bots"]["trait"]["cfTime"] = RandomFloatRange(30,90);
	self.pers["bots"]["trait"]["knife"] = randomint(3);
	self.pers["bots"]["trait"]["nade"] = 400;
	self.pers["bots"]["trait"]["switch"] = 125;
	self.pers["bots"]["trait"]["rage"] = randomInt(15);
	self.pers["bots"]["trait"]["run"] = randomintrange(100,250);
	self.pers["bots"]["trait"]["playStyle"] = 0;
	self.pers["bots"]["trait"]["watch"] = randomint(10);
	self.pers["bots"]["trait"]["change"] = randomint(25);
	self.pers["bots"]["trait"]["talk"] = randomintrange(-5, 5);
	
	if(!level.bots_varSkill)
	{
		switch(randomint(25))
		{
			case 0:
			case 10:
				self.pers["bots"]["skill"]["base"] = 0;
			break;
			case 1:
			case 11:
			case 2:
			case 12:
			case 23:
				self.pers["bots"]["skill"]["base"] = 1;
			break;
			case 3:
			case 13:
			case 18:
			case 24:
				self.pers["bots"]["skill"]["base"] = 2;
			break;
			case 14:
			case 15:
			case 16:
			case 17:
			case 22:
			case 4:
			case 5:
			case 6:
				self.pers["bots"]["skill"]["base"] = 3;
			break;
			case 7:
			case 19:
			case 21:
				self.pers["bots"]["skill"]["base"] = 4;
			break;
			case 8:
			case 20:
				self.pers["bots"]["skill"]["base"] = 5;
			break;
			case 9:
				self.pers["bots"]["skill"]["base"] = 6;
			break;
		}
	}
	else
	{
		if(level.bots_varSkill == 9)
		{
			self.pers["bots"]["skill"]["base"] = randomint(7);
			self.pers["bots"]["skill"]["viewDis"] = RandomFloatRange(500,10000);
			self.pers["bots"]["skill"]["aimSpeed"] = RandomIntRange(2,9);
			self.pers["bots"]["skill"]["acc"] = RandomIntRange(1,8);
			self.pers["bots"]["skill"]["spawnWait"] = RandomFloatRange(0.05, 1.5);
			self.pers["bots"]["skill"]["shootDelay"] = RandomFloatRange(0, 1.5);
			self.pers["bots"]["skill"]["perfView"] = RandomFloatRange(0.5,0.95);
			self.pers["bots"]["skill"]["newTarg"] = RandomFloatRange(0,1.5);
			self.pers["bots"]["skill"]["seenTime"] = RandomIntRange(0,7500);
		}
	}
}

bots_doSkill()
{
	self endon("bot_reset");
	
	for(;;)
	{
		switch(level.bots_varSkill)
		{
			case 1:
				self.pers["bots"]["skill"]["base"] = 0;
			break;
			case 2:
				self.pers["bots"]["skill"]["base"] = 1;
			break;
			case 3:
				self.pers["bots"]["skill"]["base"] = 2;
			break;
			case 4:
				self.pers["bots"]["skill"]["base"] = 3;
			break;
			case 5:
				self.pers["bots"]["skill"]["base"] = 4;
			break;
			case 6:
				self.pers["bots"]["skill"]["base"] = 5;
			break;
			case 7:
				self.pers["bots"]["skill"]["base"] = 6;
			break;
		}
		if(level.bots_varSkill != 9)
		{
			switch(self.pers["bots"]["skill"]["base"])
			{
				case 0://easy
					self.pers["bots"]["skill"]["viewDis"] = 1000.0;
					self.pers["bots"]["skill"]["aimSpeed"] = 8;
					self.pers["bots"]["skill"]["acc"] = 7;
					self.pers["bots"]["skill"]["spawnWait"] = 1.0;
					self.pers["bots"]["skill"]["shootDelay"] = 1.0;
					self.pers["bots"]["skill"]["perfView"] = 0.85;
					self.pers["bots"]["skill"]["newTarg"] = 1.0;
					self.pers["bots"]["skill"]["seenTime"] = 0;
				break;
				case 1:
					self.pers["bots"]["skill"]["viewDis"] = 1500.0;
					self.pers["bots"]["skill"]["aimSpeed"] = 7;
					self.pers["bots"]["skill"]["acc"] = 6;
					self.pers["bots"]["skill"]["spawnWait"] = 0.75;
					self.pers["bots"]["skill"]["shootDelay"] = 0.75;
					self.pers["bots"]["skill"]["perfView"] = 0.8;
					self.pers["bots"]["skill"]["newTarg"] = 0.75;
					self.pers["bots"]["skill"]["seenTime"] = 1500;
				break;
				case 2:
					self.pers["bots"]["skill"]["viewDis"] = 2250.0;
					self.pers["bots"]["skill"]["aimSpeed"] = 6;
					self.pers["bots"]["skill"]["acc"] = 5;
					self.pers["bots"]["skill"]["spawnWait"] = 0.666;
					self.pers["bots"]["skill"]["shootDelay"] = 0.666;
					self.pers["bots"]["skill"]["perfView"] = 0.75;
					self.pers["bots"]["skill"]["newTarg"] = 0.666;
					self.pers["bots"]["skill"]["seenTime"] = 2000;
				break;
				case 3://med
					self.pers["bots"]["skill"]["viewDis"] = 2750.0;
					self.pers["bots"]["skill"]["aimSpeed"] = 5;
					self.pers["bots"]["skill"]["acc"] = 4;
					self.pers["bots"]["skill"]["spawnWait"] = 0.5;
					self.pers["bots"]["skill"]["shootDelay"] = 0.5;
					self.pers["bots"]["skill"]["perfView"] = 0.7;
					self.pers["bots"]["skill"]["newTarg"] = 0.5;
					self.pers["bots"]["skill"]["seenTime"] = 2666;
				break;
				case 4:
					self.pers["bots"]["skill"]["viewDis"] = 4000.0;
					self.pers["bots"]["skill"]["aimSpeed"] = 4;
					self.pers["bots"]["skill"]["acc"] = 3;
					self.pers["bots"]["skill"]["spawnWait"] = 0.333;
					self.pers["bots"]["skill"]["shootDelay"] = 0.25;
					self.pers["bots"]["skill"]["perfView"] = 0.65;
					self.pers["bots"]["skill"]["newTarg"] = 0.333;
					self.pers["bots"]["skill"]["seenTime"] = 4000;
				break;
				case 5:
					self.pers["bots"]["skill"]["viewDis"] = 6000.0;
					self.pers["bots"]["skill"]["aimSpeed"] = 3;
					self.pers["bots"]["skill"]["acc"] = 2;
					self.pers["bots"]["skill"]["spawnWait"] = 0.25;
					self.pers["bots"]["skill"]["shootDelay"] = 0.1;
					self.pers["bots"]["skill"]["perfView"] = 0.6;
					self.pers["bots"]["skill"]["newTarg"] = 0.25;
					self.pers["bots"]["skill"]["seenTime"] = 5000;
				break;
				case 6://hard
					self.pers["bots"]["skill"]["viewDis"] = 9999.9;
					self.pers["bots"]["skill"]["aimSpeed"] = 2;
					self.pers["bots"]["skill"]["acc"] = 1;
					self.pers["bots"]["skill"]["spawnWait"] = 0.05;
					self.pers["bots"]["skill"]["shootDelay"] = 0.0;
					self.pers["bots"]["skill"]["perfView"] = 0.55;
					self.pers["bots"]["skill"]["newTarg"] = 0.0;
					self.pers["bots"]["skill"]["seenTime"] = 6666;
				break;
			}
		}
		
		wait 1.5;
	}
}

bots_UpdateSpeed(weapClass)
{
	switch ( weapClass )
	{
		case "rifle":
			if(self.hasRiotShieldEquipped)
				return self.bots_fMoveSpeed*0.8;
			else
				return self.bots_fMoveSpeed*0.95;
		case "pistol":
			return self.bots_fMoveSpeed;
		case "mg":
			return self.bots_fMoveSpeed*0.875;
		case "smg":
			return self.bots_fMoveSpeed;
		case "spread":
			return self.bots_fMoveSpeed*0.95;
		case "rocketlauncher":
			return self.bots_fMoveSpeed*0.8;
		case "sniper":
			return self.bots_fMoveSpeed;//wtf
		default:
			return self.bots_fMoveSpeed;
	}
}

bots_StartBots()
{
	self bots_initNonPersVars();
	
	if(level.gameEnded)
		return;
	
	self thread bots_onBotEnd();
	self thread bots_onGiveLoadout();
	self thread bots_onBotKill();
	self thread bots_onNukeCall();
	self thread bots_onBotSpawn();
	self thread bots_onBotDeath();
	self thread bots\bots_killstreak::bots_watchConKS();
	self thread bots_onPreDeathFrame();
	self thread bots_doSkill();
	
	self thread bots\Talk::Bots_TalkBegin();
}

bots_UseRunThink()
{
	self endon("death");
	self endon("bot_reset");
	for(;;)
	{
		if(self.bots_running)
		{
			if(!self bots_hasPerk("specialty_marathon"))
			{
				self.bots_runTime = self.bots_runTime - 0.05;
			}
		}
		else
		{
			if(self.bots_runTime < getdvarfloat("scr_player_sprinttime"))
				self.bots_runTime = self.bots_runTime + 0.05;
		}
		wait 0.05;
	}
}

bots_ThinkToRun()
{
	self endon("death");
	self endon("bot_reset");
	for(;;)
	{
		if(self.bots_running && self.bots_runDelay)
		{
			if((self bots_botFoundTarget() && self.pers["bots"]["trait"]["playStyle"] != 1) || self.bots_runTime <= 0 || self.bots_camping || !self bots_doingNothing() || bots_randomInt(self.pers["bots"]["trait"]["run"]) == 149 || self getStance() != "stand" || isDefined( self.lastStand ) || self bots\bots_aim::bots_isShellShocked())
			{
				self.bots_running = false;
				if(self bots_hasPerk("specialty_fastsprintrecovery"))
					wait 0.25;
				else
					wait 0.5;
				self.bots_runDelay = false;
			}
		}
		else
		{
			if(level.bots_varPlayRun && self.bots_runTime > 1.5 && bots_randomInt(int(self.pers["bots"]["trait"]["run"]/2)) == 2 && (!self bots_botFoundTarget() || self.pers["bots"]["trait"]["playStyle"] == 1) && !self.bots_camping && self bots_doingNothing() && self getStance() == "stand" && !isDefined( self.lastStand ) && !self bots\bots_aim::bots_isShellShocked())
			{
				self.bots_running = true;
				self.bots_runDelay = true;
			}
		}
		bots_waitFrame();
	}
}

bots_onBotSpawn()
{
	self endon("bot_reset");
	for(;;)
	{
		self waittill( "spawned_player" );
		
		self.wantSafeSpawn = true;//force respawn
	
		self.bots_traitRandom = randomint(6);
	
		self.bots_running = false;
		self.bots_runTime = getdvarfloat("scr_player_sprinttime");
		self.bots_doing = "none";
		self.bots_aimDoing = "none";
		self.bots_isCare = undefined;
		self.bots_campingAngles = undefined;
		self.bots_objDoing = "none";
		self.bots_shootTime = false;
		self.bots_switchTime = false;
		self.bots_runDelay = false;
		self.bots_camping = false;
		self.bots_omaChange = undefined;
		self.bots_realSeen = undefined;
		self.bots_realEqu = undefined;
		self.bots_realTarKS = undefined;
		self.bots_lastSeen = [];
		
		self bots\bots_anim::bots_deleteFakeAnim();
		
		self.bots_currentStaticWp = -1;
		self.bots_lastStaticWP = -1;
		self.bots_tempwp = (0.0, 0.0, 0.0);
		self.bots_vObjectivePos = (0.0, 0.0, 0.0);
		self.bots_fMoveSpeed = 0.0;
		self.bots_targetWpIdx = -1;
		self.bots_secondNextWp = -1;
		
		self bots_clearStructs();
		
		self.bots_lastKS = 0;
		
		self thread bots_doBotSpawn();
	}
}

bots_doBotSpawn()
{
	self endon("bot_reset");
	self endon("death");
	
	self thread bots_claymoreFix();
	self thread bots_UseRunThink();
	
	self freezecontrols(true);
	bots_gameFlagWait( "prematch_done" );
	self freezecontrols(true);
	
	wait self.pers["bots"]["skill"]["spawnWait"];
	
	self thread bots_ThinkToRun();
	self thread bots\bots_aim::bots_MainAimbot();
	self thread bots\bots_killstreak::bots_watchUseKillStreak();
	self thread bots\bots_walk::bots_getObj();
	self thread bots\bots_walk::bots_doMovement();
	self thread bots\bots_walk::bots_dostuck();
	self thread bots\bots_anim::bots_doAnimations();
	self thread bots_throwback();
	self thread bots_thinkUsePerks();
	self thread bots_speedPerkFeetSound();
}

bots_speedPerkFeetSound()
{
	self endon("bot_reset");
	self endon("death");
	for(;;)
	{
		currentWeapon = self getCurrentWeapon();
		weapClass = weaponClass(currentWeapon);
		
		acc = self.pers["bots"]["skill"]["acc"];
		
		switch(weapClass)
		{
			case "sniper":
				if((acc - 2) > 0)
					acc = acc - 2;
				else
					acc = 1;
			break;
			case "spread":
				acc = acc + 2;
			break;
		}
		self setspreadoverride(acc);
		
		canMakeFootSound = (!self bots_hasPerk("specialty_quieter") && level.bots_varPlayFoot);
		trace = undefined;
		if(canMakeFootSound)
		{
			myOg = self getOrigin();
			trace = bullettrace( myOg, myOg + (0.0, 0.0, -5.0), false, self );
			
			if(trace[ "surfacetype" ] == "none")
				canMakeFootSound = false;
		}
		
		if(isDefined( self.lastStand ))
		{
			if(self bots\bots_walk::bots_CanMove())
			{
				if(self bots\bots_aim::bots_IsStunned() || self bots\bots_aim::bots_isArtShocked())
				{
					self.bots_fMoveSpeed = 0.5;
				}
				else
				{
					self.bots_fMoveSpeed = 2.5;
					if(canMakeFootSound || self.bots_fMoveSpeed < 0.05)
						self playSound( "step_prone_" + trace[ "surfacetype" ] );
				}
				
				if(self bots_hasPerk("specialty_lightweight"))
					self.bots_fMoveSpeed = self.bots_fMoveSpeed * 1.15;
			}
			else
				self.bots_fMoveSpeed = 0.0;
			
			if( !isDefined(self.inFinalStand) || !self.inFinalStand )
			{
				if(weapClass != "pistol" && self.bots_doing != "laptop")
				{
					self.bots_doing = "switch";
					
					sec = self bots_tryGetGoodWeap(self bots_getSecondariesName());
					if(!level.bots_varLoadoutSecondary || !isDefined(sec) || weaponClass(sec) != "pistol")
					{
						self setspawnweapon("beretta_mp");
					}
					else
					{
						self setspawnweapon(sec);
					}
					self bots\bots_aim::bots_stopShooting();
					
					wait 1;
					self.bots_doing = "none";
				}
			}
		}
		else
		{
			if(self.bots_camping)
			{
				self setStance("crouch");
			}
			else
			{
				if( self.hasRiotShieldEquipped )
				{
					if(isdefined(self.bots_Realseen) && self.pers["bots"]["skill"]["base"] > 2)
					{
						self setStance("crouch");
					}
					else
					{
						if(!isDefined(level.waypoints[self.bots_currentStaticWp]) || level.waypoints[self.bots_currentStaticWp].type == "crouch")
							self setStance("crouch");
						else
							self setStance("stand");
					}
				}
				else
				{
					if(isDefined(level.bots_forceProne[self.bots_doing]) && self.pers["bots"]["trait"]["killsOverObj"] != 2)
					{
						self setStance("prone");
					}
					else
					{
						if(!isDefined(level.waypoints[self.bots_currentStaticWp]) || level.waypoints[self.bots_currentStaticWp].type == "stand")
						{
							switch(randomint(20))
							{
								case 0:
									if(isdefined(self.bots_RealSeen) && self.bots_traitRandom == 1 && self.pers["bots"]["skill"]["base"] >= 2)
									{
										self setStance("prone");//drop shot
										self.bots_fMoveSpeed = 0.0;
										wait 1.5;
									}
									else
									{
										self setStance("stand");
									}
								break;
								case 1:
									if(!self.bots_running)
										self setStance("crouch");
								break;
								case 2:
									if(!self.bots_running)
										self setStance("crouch");
								break;
								default:
									self setStance("stand");
								break;
							}
						}
						else
						{
							if(level.waypoints[self.bots_currentStaticWp].type == "prone")
								self setStance("prone");
							else if(level.waypoints[self.bots_currentStaticWp].type == "crouch")
								self setStance("crouch");
							else
								self setStance("stand");
						}
					}
				}
			}
			
			if(!self bots\bots_walk::bots_CanMove())
			{
				self.bots_fMoveSpeed = 0.0;
			}
			else
			{
				if(self bots\bots_aim::bots_isClimbing())
				{
					if(!self bots_hasPerk("specialty_fastmantle"))
						self.bots_fMoveSpeed = 4.0;
					else
						self.bots_fMoveSpeed = 6.0;
					
					if(canMakeFootSound)
						self playSound( "step_run_ladder" );
				}
				else
				{
					if(self bots\bots_aim::bots_IsStunned() || self bots\bots_aim::bots_isArtShocked())
					{
						switch( self getStance() )
						{
							case "stand":
								self.bots_fMoveSpeed = 2.5;
							break;
							case "crouch":
								self.bots_fMoveSpeed = 1.0;
							break;
							case "prone":
								self.bots_fMoveSpeed = 0.5;
							break;
						}
					}
					else
					{
						switch( self getStance() )
						{
							case "stand":
								if(self.bots_running)
								{
									self.bots_fMoveSpeed = 15.0;
									if(canMakeFootSound)
									{
										self playSound( "step_sprint_" + trace[ "surfacetype" ] );
										self thread bots_playSprintSound( "step_sprint_" + trace[ "surfacetype" ] );
									}
								}
								else
								{
									self.bots_fMoveSpeed = 10.0;
									if(canMakeFootSound)
										self playSound( "step_run_" + trace[ "surfacetype" ] );
								}
							break;
							case "crouch":
								self.bots_fMoveSpeed = 5.0;
								if(canMakeFootSound)
									self playSound( "step_walk_" + trace[ "surfacetype" ] );
							break;
							case "prone":
								self.bots_fMoveSpeed = 2.5;
								if(canMakeFootSound)
									self playSound( "step_prone_" + trace[ "surfacetype" ] );
							break;
						}
					}
					
					if(self bots_hasPerk("specialty_lightweight"))
						self.bots_fMoveSpeed = self.bots_fMoveSpeed * 1.15;
				}
				
				if(self.bots_firing)
					self.bots_fMoveSpeed *= 0.5;
				
				self.bots_fMoveSpeed = self.bots_fMoveSpeed*(getdvarfloat("g_speed")/190.0);
				self.bots_fMoveSpeed = self bots_UpdateSpeed(weapClass);
				self.bots_fMoveSpeed = self.bots_fMoveSpeed*self.moveSpeedScaler;
				self.bots_fMoveSpeed = self.bots_fMoveSpeed*level.bots_moveSpeedBase;
			}
		}
		
		if(!self bots_getWeaponAmmoClip(currentWeapon) && self bots_getAmmoCount(currentWeapon))
		{
			self bots\bots_aim::bots_shootWeapon();
		}
		
		wait 0.333;
	}
}

bots_playSprintSound(sound)
{
	self endon("bot_reset");
	self endon("death");
	
	wait 0.1665;
	self playSound( sound );
}

bots_thinkUsePerks()
{
	self endon("bot_reset");
	self endon("death");
	for(;;)
	{
		wait 2.5;
		if(self bots_hasPerk("specialty_blastshield") && !self bots_hasPerk("_specialty_blastshield") && (self bots_botFoundTarget() || self.pers["bots"]["skill"]["base"] < 3))
			self bots_setPerk("_specialty_blastshield");
		wait 2.5;
		if(self bots_hasPerk("specialty_blastshield") && self bots_hasPerk("_specialty_blastshield") && (!self bots_botFoundTarget() || self.pers["bots"]["skill"]["base"] < 3))
			self bots_unsetPerk("_specialty_blastshield");
		
		wait 0.05;
		if(self bots_hasPerk("specialty_onemanarmy") && self hasWeapon("onemanarmy_mp") && !self bots_botFoundTarget() && self bots\bots_aim::bots_canSwitch())
		{
			rnd = randomInt(25);
			if(!rnd || (rnd > 20 && self bots_anyWeaponsOut()))
			{
				self bots\bots_aim::bots_SwitchToOff(true);
				self.bots_doing = "oma";
				if(self bots_hasPerk("specialty_omaquickchange"))
					wait 3;
				else
					wait 6;
				self.bots_omaChange = true;
				self notify("giveLoadout");
				self.bots_doing = "none";
			}
		}
	}
}

bots_anyWeaponsOut()
{
	weaponsList = self GetWeaponsListAll();
	foreach(weap in weaponsList)
		if(!isDefined(level.bots_forceSwitch[weap]) && !self bots_getAmmoCount(weap))
			return true;
	
	return false;
}

bots_throwback()
{
	self endon("bot_reset");
	self endon("death");
	for(;;)
	{
		if(level.bots_varLoadoutNade && level.bots_varPlayTB && level.bots_fragList.size && self bots\bots_aim::bots_canNade())
		{
			myEye = self getEye();
			foreach(frag in level.bots_fragList)
			{
				if(isdefined(frag.bots_throwback))
					continue;
				if(!isdefined(frag.nade))
					continue;
				if(isDefined(frag.owner) && frag.owner == self)
					continue;
				if(self.pers["team"] == frag.team && level.teamBased)
					continue;
				if(distance(self.origin, frag.nade.origin) > 100.0)
					continue;
				if(!bulletTracePassed( myEye, frag.nade.origin, false, frag.nade ))
					continue;
				
				self bots_doThrowback(frag);
				break;
			}
		}
		wait 1;
	}
}

bots_doThrowback(frag)
{
	self endon("bot_kill_nade");
	
	self.bots_doing = "nade_fire";
	lastWeapon = self getCurrentWeapon();
	
	frag.bots_throwback = true;
	
	self thread bots\talk::bots_throwBack(frag);

	hadFrag = self bots_getAmmoCount("frag_grenade_mp");
	hasFrag = self hasWeapon("frag_grenade_mp");

	if(!hasFrag)
		self bots__giveWeapon("frag_grenade_mp", 0);
	self bots_setWeaponAmmoClip("frag_grenade_mp", 1);
	
	self setspawnweapon("frag_grenade_mp");
	
	self thread bots_freeNadeOnDeath(frag);
	self thread bots_doNoneOnFragFire(lastWeapon, hasFrag, hadFrag, frag);
	self thread bots\bots_aim::bots_forceGNadeFire();
	
	for(i=0;i<9;i++)
	{
		wait 0.5;
		
		if(self getCurrentWeapon() != "frag_grenade_mp")
			self setspawnweapon("frag_grenade_mp");
	}
	
	if(!hasFrag)
		self takeWeapon("frag_grenade_mp");
	else
		self bots_setWeaponAmmoClip("frag_grenade_mp", hadFrag);
	
	self setspawnweapon(lastWeapon);
	frag.bots_throwback = undefined;
	
	self.bots_doing = "none";
	self notify("bot_kill_nade");
}

bots_doNoneOnFragFire(lastWeapon, hasFrag, hadFrag, frag)
{
	self endon("bot_kill_nade");
	self endon("bot_reset");
	
	self waittill("grenade_fire", grenade, weapname);
	if(isSubStr(weapname, "frag_"))
	{
		alive = bots_isReallyAlive(self);
		if(alive && isDefined(frag.nade) && distance(self.origin, frag.nade.origin) <= 100)
		{
			grenade.owner = self;
			grenade.threwBack = true;
			self thread bots_incPlayerStat( "throwbacks", 1 );
			grenade thread maps\mp\gametypes\_shellshock::grenade_earthQuake();
			grenade.originalOwner = frag.owner;
			
			if(!hasFrag)
				self takeWeapon("frag_grenade_mp");
			else
				self bots_setWeaponAmmoClip("frag_grenade_mp", hadFrag);
			
			self setspawnweapon(lastWeapon);
			self thread bots\talk::bots_thrownBack(frag);
			frag.nade delete();
			self.bots_doing = "none";
		}
		else
		{
			if(isDefined(frag))
				frag.bots_throwback = undefined;
			grenade delete();
			
			if(alive)
			{
				if(!hasFrag)
					self takeWeapon("frag_grenade_mp");
				else
					self bots_setWeaponAmmoClip("frag_grenade_mp", hadFrag);
				
				self.bots_doing = "none";
				self setspawnweapon(lastWeapon);
			}
		}
	}
	
	self notify("bot_kill_nade");
}

bots_freeNadeOnDeath(frag)
{
	self endon("bot_kill_nade");
	self bots_waittill_either("bot_reset", "death");
	frag.bots_throwback = undefined;
	
	wait 1;
	self notify("bot_kill_nade");
}

bots_watchKillcam()
{
	if(level.bots_varPlayWatch == 1)
	{
		if(bots_randomInt(self.pers["bots"]["trait"]["watch"]) == 1)
		{
			self thread bots\talk::bots_watchKC();
			setDvar("testClients_watchKillcam", true);
			wait randomint(7);
			setDvar("testClients_watchKillcam", false);
			if(isDefined(self))
				self thread bots\talk::bots_watchKCEnd();
		}
	}
}

bots_onBotDeath()
{
	self endon("bot_reset");
	for(;;)
	{
		self waittill("death");
		
		self thread bots_watchKillcam();
		
		if(level.bots_varPlayQuit && (self.kills - self.deaths) < -5 && bots_randomInt(self.pers["bots"]["trait"]["rage"]) == 2 && self.pers["cur_death_streak"] > 4 && randomint(2))
		{
			//doragequit - thanks to idea from rse v20
			self bots\talk::bots_Rage();
			wait randomint(4);
			kick(self getEntityNumber(), "EXE_PLAYERKICKED");
		}
		
		if(isDefined(self.lastAttacker))
		{
			self.bots_atDeathLoc = false;
			self thread bots\talk::Bots_Talkdead();
		}
		
		self.wantSafeSpawn = true;//force respawn
	}
}

bots_claymoreFix()
{
	self endon("bot_reset");
	self endon("death");
	for(;;)
	{
		if(self.bots_fMoveSpeed >= 0.25)
		{
			myEye = self getEye();
			grenades = getEntArray( "grenade", "classname" );
			foreach(grenade in grenades)
			{
				if(!isDefined(grenade.weaponName) || grenade.weaponName != "claymore_mp")
					continue;
				if(isDefined(grenade.owner) && grenade.owner == self)
					continue;
				if(grenade.team == self.pers["team"] && level.teamBased)
					continue;
				if(distance(self.origin, grenade.origin) > level.claymoreDetonateRadius)
					continue;
				if(!bulletTracePassed(myEye, grenade.origin, false, grenade ))
					continue;
				if(!self maps\mp\gametypes\_weapons::shouldAffectClaymore( grenade ))
					continue;
				
				grenade thread bots_doCaboom(self bots_hasPerk( "specialty_delaymine" ));
			}
		}
		wait 1;
	}
}

bots_doCaboom(hasDelay)
{
	self endon("death");
	
	self playsound ("claymore_activated");
		
	if ( hasDelay )
		wait 3.0;
	else 
		wait level.claymoreDetectionGracePeriod;
		
	if ( isDefined( self.trigger ) )
		self.trigger delete();	
	
	self detonate();
}

bots_onNukeCall()
{
	self endon("bot_reset");
	for(;;)
	{
		while(!isDefined( level.nukeIncoming ) && !isDefined( level.moabIncoming ))
			wait 0.05 + randomInt(4);
		
		self bots\talk::bots_onBotNuke();
		
		if(level.bots_varPlayQuit && bots_randomInt(self.pers["bots"]["trait"]["rage"]) == 3 && randomint(2))
			kick(self getEntityNumber(), "EXE_PLAYERKICKED");
		
		wait level.nukeTimer + 5;
	}
}

bots_onGiveLoadout()
{
	self endon("bot_reset");
	for(;;)
	{
		self waittill("giveLoadout");
		
		self thread bots\bots_class::bots_GiveBotClass();
	}
}

bots_onBotKill()
{
	self endon("bot_reset");
	for(;;)
	{
		self waittill( "killed_enemy" );
		
		if(isDefined(self.lastKilledPlayer))
		{
			killLoc = self.lastKilledPlayer getOrigin();
			if(self bots\bots_walk::bots_shouldGetObj() && distance(killLoc, self.origin) < 500.0 && !randomInt(100))
				self thread bots\bots_walk::bots_goToLocAndTBag(killLoc);
			
			self thread bots\Talk::Bots_TalkKilled();
		}
		
		if(self.bots_lastKS < self.pers["cur_kill_streak"])
		{
			for(i=self.bots_lastKS+1;i<=self.pers["cur_kill_streak"];i++)
			{
				self thread bots\talk::bots_onGotStreak(i);
			}
		}
		
		self.bots_lastKS = self.pers["cur_kill_streak"];
	}
}

bots_doEndReload()
{
	if(!randomInt(5))
	{
		setDvar("testclients_doreload", true);
		wait 1;
		setDvar("testclients_doreload", false);
	}
	if(isDefined(self) && bots_isReallyAlive(self))
		self freezecontrols(true);
}

bots_onBotEnd()
{
	self endon("bot_reset");
	
	level waittill ( "game_ended" );
	wait randomint(3);
	
	self thread bots\talk::Bots_TalkEndGame();
	self thread bots_doEndReload();
	setdvar("testclients_domove", false);
	
	if(level.bots_varPlayQuit && bots_randomInt(self.pers["bots"]["trait"]["rage"]) == 4 && randomint(2))
		kick(self getEntityNumber(), "EXE_PLAYERKICKED");
		
	self bots\bots_anim::bots_deleteFakeAnim();
	self bots_clearStructs();
	self notify("bot_reset");
}

bots_onPreDeathFrame()
{
	self endon("bot_reset");
	for(;;)
	{
		self waittill("killed_player");
		self.wantSafeSpawn = true;//force respawn
		self thread bots\bots_anim::bots_doBotAnimDeath();
		
		if(isDefined(self.bots_devWalk[self.lastDroppableWeapon]) && self.bots_devWalk[self.lastDroppableWeapon].isEmpty)
		{
			self setWeaponAmmoClip(self.lastDroppableWeapon, self.bots_devWalk[self.lastDroppableWeapon].clip, "left");
			self setWeaponAmmoClip(self.lastDroppableWeapon, self.bots_devWalk[self.lastDroppableWeapon].clip, "right");
			self setWeaponAmmoClip(self.lastDroppableWeapon, self.bots_devWalk[self.lastDroppableWeapon].clip);
			self setWeaponAmmoStock(self.lastDroppableWeapon, self.bots_devWalk[self.lastDroppableWeapon].stock);
		}
	}
}

bots_onPlayerConnect()
{
	for(;;)
	{
		level waittill("connected", player);
		
		DvarGUID = getDvar("bots_main_GUIDs");
		DvarName = getDvar("bots_main_Names");
		
		if(!isDefined(player.pers["bots_isHost"]))
			player.pers["bots_isHost"] = false;
		
		result = false;
		if(DvarGUID != "")
		{
			GUIDs = strtok(DvarGUID, ",");
			foreach(guid in GUIDs)
			{
				if(player.GUID == guid)
					result = true;
			}
		}
		if(DvarName != "")
		{
			Names = strtok(DvarName, ",");
			foreach(name in Names)
			{
				if(player.name == name)
					result = true;
			}
		}
		
		if(player isHost() || result)
			player.pers["bots_isHost"] = true;
		
		player thread bots\menu::playerConnected();
		
		player thread bots_watchFireGun();
		player thread bots_watchNade();
		
		if(player bots_playerIsABot())
		{
			if(!isDefined(player.bots_fixOnce))
			{
				player.bots_fixOnce = 1;
				player notify("bot_reset");
				player thread bots_watchDisconnect();
				player thread bots_StartBots();
			}
		}
	}
}

bots_watchNade()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill ( "grenade_fire", grenade, weaponName );
		if(weaponName == "smoke_grenade_mp")
		{
			grenade thread bots_AddToSmokeList();
		}
		else if(isSubStr(weaponName, "frag_"))
		{
			grenade thread bots_AddToFragList(self);
		}
	}
}

bots_AddToFragList(owner)
{
	index = level.bots_fragList.size;
	level.bots_fragList[index] = spawnstruct();
	level.bots_fragList[index].nade = self;
	level.bots_fragList[index].throwback = undefined;
	level.bots_fragList[index].owner = owner;
	level.bots_fragList[index].team = owner.team;
	level.bots_fragList[index] thread bots_thinkFrag();
}

bots_thinkFrag()
{
	while(isDefined(self.nade))
		bots_waitFrame();
	bots_removeFragNade(self);
}

bots_SmokeTrace(start, end, rad)
{
	if(level.bots_smokeList.size)
	{
		foreach(nade in level.bots_smokeList)
		{
			if(nade.state != "smoking")
				continue;
			if(!bots_RaySphereIntersect(start, end, nade.origin, rad))
				continue;
			
			return false;
		}
	}
	return true;
}

bots_AddToSmokeList()
{
	index = level.bots_smokeList.size;
	level.bots_smokeList[index] = spawnstruct();
	level.bots_smokeList[index].origin = self getOrigin();
	level.bots_smokeList[index].state = "moving";
	level.bots_smokeList[index] thread bots_thinkSmoke(self);
}

bots_thinkSmoke(gnade)
{
	while(isDefined(gnade))
	{
		self.origin = gnade getOrigin();
		self.state = "moving";
		bots_waitFrame();
	}
	self.state = "smoking";
	wait 11.5;
	
	bots_removeSmokeNade(self);
}

bots_removeSmokeNade(nade)
{
	for ( entry = 0; entry < level.bots_smokeList.size; entry++ )
	{
		if ( level.bots_smokeList[entry] == nade )
		{
			while ( entry < level.bots_smokeList.size-1 )
			{
				level.bots_smokeList[entry] = level.bots_smokeList[entry+1];
				entry++;
			}
			level.bots_smokeList[entry] = undefined;
			break;
		}
	}
}

bots_removeFragNade(nade)
{
	for ( entry = 0; entry < level.bots_fragList.size; entry++ )
	{
		if ( level.bots_fragList[entry] == nade )
		{
			while ( entry < level.bots_fragList.size-1 )
			{
				level.bots_fragList[entry] = level.bots_fragList[entry+1];
				entry++;
			}
			level.bots_fragList[entry] = undefined;
			break;
		}
	}
}

bots_RaySphereIntersect(start, end, spherePos, radius)
{
   dp = end - start;
   a = dp[0] * dp[0] + dp[1] * dp[1] + dp[2] * dp[2];
   b = 2 * (dp[0] * (start[0] - spherePos[0]) + dp[1] * (start[1] - spherePos[1]) + dp[2] * (start[2] - spherePos[2]));
   c = spherePos[0] * spherePos[0] + spherePos[1] * spherePos[1] + spherePos[2] * spherePos[2];
   c += start[0] * start[0] + start[1] * start[1] + start[2] * start[2];
   c -= 2.0 * (spherePos[0] * start[0] + spherePos[1] * start[1] + spherePos[2] * start[2]);
   c -= radius * radius;
   bb4ac = b * b - 4.0 * a * c;
//   if(ABS(a) < 0.0001 || bb4ac < 0) 
   if(bb4ac < 0) 
   {
//      *mu1 = 0;
//      *mu2 = 0;
     return false;
   }

//   *mu1 = (-b + sqrt(bb4ac)) / (2 * a);
//   *mu2 = (-b - sqrt(bb4ac)) / (2 * a);

   return true;
}

bots_watchFireGun()
{
	self endon("disconnect");
	self.bots_firing = false;
	for(;;)
	{
		self waittill( "weapon_fired" );
		self thread bots_doFiringThread();
	}
}

bots_doFiringThread()
{
	self endon("disconnect");
	self endon("weapon_fired");
	self.bots_firing = true;
	wait 1;
	self.bots_firing = false;
}