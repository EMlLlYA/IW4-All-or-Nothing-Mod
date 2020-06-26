#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
/*
	All or Nothing
	Objective: 	Score points by eliminating other players
	Map ends:	When one player reaches the score limit, or time limit is reached
	Respawning:	No wait / Away from other players

	Level requirements
	------------------
		Spawnpoints:
			classname		mp_dm_spawn
			All players spawn from these. The spawnpoint chosen is dependent on the current locations of enemies at the time of spawn.
			Players generally spawn away from enemies.

		Spectator Spawnpoints:
			classname		mp_global_intermission
			Spectators spawn from these and intermission is viewed from these positions.
			Atleast one is required, any more and they are randomly chosen between.
*/

//TODO: GSC: Fix leaderboards
//TODO: GSC: Fix Weapon Dropping
//TODO: GSC: Fix grace period weapon switch bug, this allows players to use any weapon they want to.
//TODO: GSC: Make it so that when a player has the specialist usp, they are unable to pick up the normal usp
//TODO: GSC: Check if this actually works with multiple clients. (Bots dont count)
//TODO: MENU FILES: Fix killfeed not matching "safe zone" of the custom HUD.
//TODO: MENU FILES: Adjust the safezone a bit, move the scoreboard more to the left.

main()
{
	precacheShader("hud_icon_c4");
	precacheShader("hud_icon_nvg");
	precacheShader("ui_host");
	precacheShader("nightvision_overlay_goggles");
	//Precache for custom hud icons.

	self thread doVariables1();
	self thread detectVelocity1();

	maps\mp\gametypes\_globallogic::init();
	maps\mp\gametypes\_callbacksetup::SetupCallbacks();
	maps\mp\gametypes\_globallogic::SetupCallbacks();

	setDvar("scr_game_hardpoints", 0);
	setDvar("ui_allow_classchange", 0);

	registerTimeLimitDvar( level.gameType, 5, 0, 1440 );
	registerScoreLimitDvar( level.gameType, 1000, 0, 5000 );
	registerWinLimitDvar( level.gameType, 1, 0, 5000 );
	registerRoundLimitDvar( level.gameType, 1, 0, 10 );
	registerNumLivesDvar( level.gameType, 0, 0, 10 );
	registerHalfTimeDvar( level.gameType, 0, 0, 1 );

	level.onStartGameType = ::onStartGameType;
	level.getSpawnPoint = ::getSpawnPoint;
    level thread onConnectPlayer();

	game["dialog"]["gametype"] = "freeforall";
    
}


onStartGameType()
{
	setClientNameMode("auto_change");

	setObjectiveText( "allies", "All or Nothing" );
	setObjectiveText( "axis", "All or Nothing" );

	if ( level.splitscreen )
	{
		setObjectiveScoreText( "allies", "All or Nothing" );
		setObjectiveScoreText( "axis", "All or Nothing" );
	}
	else
	{
		setObjectiveScoreText( "allies", "All or Nothing" );
		setObjectiveScoreText( "axis", "All or Nothing" );
	}
	setObjectiveHintText( "allies", "All or Nothing" );
	setObjectiveHintText( "axis", "All or Nothing" );

	level.spawnMins = ( 0, 0, 0 );
	level.spawnMaxs = ( 0, 0, 0 );
	maps\mp\gametypes\_spawnlogic::addSpawnPoints( "allies", "mp_dm_spawn" );
	maps\mp\gametypes\_spawnlogic::addSpawnPoints( "axis", "mp_dm_spawn" );
	level.mapCenter = maps\mp\gametypes\_spawnlogic::findBoxCenter( level.spawnMins, level.spawnMaxs );
	setMapCenter( level.mapCenter );
	
	allowed[0] = "dm";
	maps\mp\gametypes\_gameobjects::main(allowed);

	maps\mp\gametypes\_rank::registerScoreInfo( "kill", 50 );
	maps\mp\gametypes\_rank::registerScoreInfo( "headshot", 50 );
	maps\mp\gametypes\_rank::registerScoreInfo( "assist", 10 );
	maps\mp\gametypes\_rank::registerScoreInfo( "suicide", 0 );
	maps\mp\gametypes\_rank::registerScoreInfo( "teamkill", 0 );
	
	level.QuickMessageToAll = true;
}


getSpawnPoint()
{
	spawnPoints = maps\mp\gametypes\_spawnlogic::getTeamSpawnPoints( self.pers["team"] );
	spawnPoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_DM( spawnPoints );

	return spawnPoint;
}

onConnectPlayer()
{
	for (;;)
	{
		level waittill("connected", player);
		player thread onSpawnPlayer();
		player thread doOnce();
		
		self.pers["kills"] = 0;
		self.PerkStreakCount = 0;
        self.currentKills = 0;
	}
}

onSpawnPlayer()
{
	self endon("disconnect");

	for (;;)
	{
		self waittill("spawned_player");

		//self.pers["kills"] = 0;
		self.PerkStreakCount = 0;
        //self.currentKills = 0;  // Hardcoding these or the monitor freaks out on first spawn
        
        //setDvar("con_gameMsgWindow0MsgTime", "0"); //Killfeed disabling, ghetto as fuck & doesnt reset which ends in fucked config.
    	//setDvar("con_gameMsgWindow0LineCount", "0");

    	self thread koyEle(); //for trickshot niggas
        self giveStartClass();
        self thread victimsStreakMonitor();
	}
}

doOnce() 	// called onPlayerConnect
{
	self.versionText = self createFontString("default", 0.9);
	self.versionText setPoint("CENTER", "TOP", -400, 12.5);
	self.versionText setText("^build beta-1");
	wait 2;
}

giveStartClass()
{
    self TakeAllWeapons();
    self ClearPerks();

    self giveWeapon( "usp_tactical_mp" );
    wait 0.01;
    self switchToWeapon( "usp_tactical_mp" );
    self setWeaponAmmoStock("usp_tactical_mp", 0);
    self setWeaponAmmoClip( "usp_tactical_mp", 0 );
    self maps\mp\perks\_perks::givePerk( "throwingknife_mp");
    self SetWeaponAmmoClip( "throwingknife_mp", 1 );
    wait 0.1;

    self maps\mp\perks\_perks::givePerk( "specialty_marathon");
    self maps\mp\perks\_perks::givePerk( "specialty_fastmantle");

    self maps\mp\perks\_perks::givePerk( "specialty_lightweight");
    self maps\mp\perks\_perks::givePerk( "specialty_fastsprintrecovery");

    self maps\mp\perks\_perks::givePerk( "specialty_heartbreaker");
    self maps\mp\perks\_perks::givePerk( "specialty_quieter");
}


giveEndClass()
{
    self TakeAllWeapons();
    self ClearPerks();
    wait 1;
    self giveWeapon( "usp_mp" );
    wait 0.1;
    self switchToWeapon( "usp_mp" );
    self setWeaponAmmoStock("usp_mp", 24);
    self setWeaponAmmoClip( "usp_mp", 12 );
    self maps\mp\perks\_perks::givePerk( "throwingknife_mp");
    self SetWeaponAmmoClip( "throwingknife_mp", 2 );
    wait 0.1;

    self maps\mp\perks\_perks::givePerk( "specialty_marathon");
    self maps\mp\perks\_perks::givePerk( "specialty_fastmantle");

    self maps\mp\perks\_perks::givePerk( "specialty_lightweight");
    self maps\mp\perks\_perks::givePerk( "specialty_fastsprintrecovery");

    self maps\mp\perks\_perks::givePerk( "specialty_heartbreaker");
    self maps\mp\perks\_perks::givePerk( "specialty_quieter");
}

victimsStreakMonitor()
{
    level endon( "game_ended" );
    self endon( "disconnected" );
    self endon("death");

    for(;;)
    {
        if(self.pers["kills"] != self.currentKills)
        {
            self.PerkStreakCount++;
            self.currentKills = self.pers["kills"];
            self giveNewPerks(self.PerkStreakCount);
        }
        wait 0.1;
    }
}


scavengerPopup()
{
			notifyData = spawnstruct();
			notifyData.iconName = "hud_icon_c4";
			notifyData.notifyText = "1 Point Streak! - Scavenger Pro";
			notifyData.glowColor = (0.3, 0.6, 0.3);
			notifyData.sound = "mp_steal_class";
			notifyData.duration = 3;
			notifyData.hideWhenInMenu = 0;
			self thread maps\mp\gametypes\_hud_message::notifyMessage( notifyData );
}

sohPopup()
{
			notifyData = spawnstruct();
			notifyData.iconName = "hud_icon_nvg";
			notifyData.notifyText = "3 Point Streak! - Sleight of Hand Pro";
			notifyData.glowColor = (0.3, 0.6, 0.3);
			notifyData.sound = "mp_steal_class";
			notifyData.duration = 3;
			notifyData.hideWhenInMenu = 0;
			self thread maps\mp\gametypes\_hud_message::notifyMessage( notifyData );
}

aimPopup()
{
			notifyData = spawnstruct();
			notifyData.iconName = "ui_host";
			notifyData.notifyText = "5 Point Streak! - Steady Aim Pro";
			notifyData.glowColor = (0.3, 0.6, 0.3);
			notifyData.sound = "mp_steal_class";
			notifyData.duration = 3;
			notifyData.hideWhenInMenu = 0;
			self thread maps\mp\gametypes\_hud_message::notifyMessage( notifyData );
}

finalPopup()
{
			notifyData = spawnstruct();
			notifyData.iconName = "nightvision_overlay_goggles";
			notifyData.notifyText = "7 Point Streak! - Specialist Bonus!";
			notifyData.glowColor = (0.3, 0.6, 0.3);
			notifyData.sound = "mp_steal_class";
			notifyData.duration = 3;
			notifyData.hideWhenInMenu = 0;
			self thread maps\mp\gametypes\_hud_message::notifyMessage( notifyData );
}

giveNewPerks(count)
{
    if(count == 1)
    {
            self maps\mp\perks\_perks::givePerk("specialty_scavenger");
            self maps\mp\perks\_perks::givePerk("specialty_extraammo");
            self scavengerPopup();
    }
    if(count == 3)
    {
            self maps\mp\perks\_perks::givePerk("specialty_quickdraw");
            self maps\mp\perks\_perks::givePerk("specialty_fastreload");
            self sohPopup();
    }
    if(count == 5)
    {
    		self maps\mp\perks\_perks::givePerk("specialty_bulletaccuracy");
            self maps\mp\perks\_perks::givePerk("specialty_steelnerves");
            self aimPopup();
    }
    if(count == 7)
    {
    		self.current_weapon = self GetCurrentWeapon();
			self takeweapon(self.current_weapon);
			wait 0.1;
			self giveweapon("cheytac_mp");
			self SwitchToWeapon("cheytac_mp");
            self finalPopup();
    }
    wait 0.01;
}

Negate1( vector ) // Credits go to CodJumper. //boots <3
{
    self endon( "death" );
    negative = vector - (vector * 2.125);
    return( negative );
}
initialize()
{
	self thread doVariables1();
	self thread detectVelocity1();
}
doVariables1()
{
	self.vel = 0;
	self.newVel = 0;
	self.topVel = 0;
}
detectVelocity1()
{
	for(;;)
	{
		self.vel = self GetVelocity();
		self.newVel = (self.vel[0], self.vel[1], self Negate1(self.vel[2]));
		wait 0.1;
	}
}

koyEle()
{
	wait 1;
	//self iprintln("^6Elevators Unpatched");
	if(getDvar("mapname") == "mp_afghan")
	{
		level thread Afghan();
	}
	else if(getDvar("mapname") == "mp_nighshift")
	{
		level thread Skidrow();
	}
}
CreateElevator(enter, exit)
{
	self thread ElevatorThink(enter, exit);
}
ElevatorThink(enter, exit)
{
	self endon("disconnect");
	while(1)
	{
		foreach(player in level.players)
		{
			if(Distance(enter, player.origin) <= 10)
			{
				player setOrigin( enter );
				player thread ElevatorFloat(enter, exit);
				wait 5;
			}
		}
		wait .25;
	}
}
ElevatorFloat(enter, exit)
{
	self iPrintLn("DEBUG: Elevator hit");
	self.Float = spawn( "script_model", self.origin );
	self playerLinkTo( self.Float );
	for(;;)
	{
		wait 0.01;
		if(Distance(exit, self.origin) > 30)
		{
			self.Elevate = self.origin +(0,0,5);
			self.Float moveTo( self.Elevate, 0.01 );
		}
		else
		{
			self setOrigin( exit );
			self unlink();
			return;
		}
	}
}

Afghan()
{
	CreateElevator( (-272, 1150, 342), (-272, 1150, 1272) );
	CreateElevator( (727, 183, 122), (727, 183, 1222) );
}
Skidrow()
{
	CreateElevator( (-272, 1150, 342), (-272, 1150, 1272) );
	CreateElevator( (727, 183, 122), (727, 183, 1222) );
}