#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include bots\bots_funcs;

init()
{
	if(getDVarint("bots_main_debug"))
	{
		if(!getDVarint("developer"))
		{
			setdvar("developer_script", 1);
			setdvar("developer", 1);
			
			setdvar("sv_mapRotation", "map "+getDvar("mapname"));
			exitLevel(false);
		}
		
		setdvar("bots_main_menu", 0);
		setdvar("bots_manage_fill_mode", 0);
		setdvar("bots_manage_fill", 0);
		setdvar("bots_manage_add", 0);
		setdvar("bots_manage_fill_kick", 1);
		
		setDvarIfUninitialized("bots_main_debug_distance", 500.0);
		setDvarIfUninitialized("bots_main_debug_cone", 0.65);
		setDvarIfUninitialized("bots_main_debug_minDist", 30.0);
		setDvarIfUninitialized("bots_main_debug_drawThrough", false);
		
		level waittill( "connected", player);
		
		player thread onPlayerSpawned();
	}
}

onPlayerSpawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		self thread startDev();
	}
}

StartDev()
{
	level.wpToLink = -1;
	level.autoLink = false;
	self.nearest = -1;
	
	self takeAllWeapons();
	self giveWeapon("usp_tactical_mp");//to knife windows
	self _clearperks();
	self.specialty = [];
	self maps\mp\perks\_perks::givePerk("specialty_fastmantle");
	self maps\mp\perks\_perks::givePerk("specialty_falldamage");
	self maps\mp\perks\_perks::givePerk("specialty_marathon");
	self maps\mp\perks\_perks::givePerk("specialty_lightweight");
	self freezecontrols(false);
	
	self thread watchAddWaypointCommand();
	self thread watchDeleteAllWaypointsCommand();
	self thread watchDeleteWaypointCommand();
	self thread watchLinkWaypointCommand();
	self thread watchLoadWaypointsCommand();
	self thread watchSaveWaypointsCommand();
	self thread watchUnlinkWaypointCommand();
	self thread watchAutoLinkCommand();
	self thread updateWaypointsStats();
	
	self thread sayExtras();
}

sayExtras()
{
	self endon("disconnect");
	self endon("death");
	self iprintln("Before adding waypoints, holding buttons:");
	wait 4;
	self iprintln("ADS - climb");
	self iprintln("Use + Attack - tube");
	self iprintln("Attack - grenade");
	self iprintln("Use - claymore");
	wait 4;
	self iprintln("Else the waypoint will be your stance.");
	self iprintln("Making a crouch waypoint with only one link...");
	self iprintln("Makes a camping waypoint.");
}

updateWaypointsStats()
{
	self endon("disconnect");
	self endon("death");
	
	self initHudElem("TotalWps:",502,5);
	totalWpsHud = self initHudElem("",580,5);
	self initHudElem("NearestWP:",502,15);
	nearestWP = self initHudElem("",580,15);
	self initHudElem("Childs:",502,25);
	children = self initHudElem("",560,25);
	self initHudElem("Type:",502,35);
	type = self initHudElem("",560,35);
	self initHudElem("ToLink:",502,45);
	wpToLink = self initHudElem("",560,45);
	
	infotext = self initHudElem2();
	self initHudElem3();
	self initHudElem4();
	
	for(;;)
	{
		totalWpsHud setText(level.waypointCount);
		
		closest = -1;
		myEye = self getEye();
		for(i = 0; i < level.waypointCount; i++)
		{
			if(closest == -1 || closer(self.origin, level.waypoints[i].origin, level.waypoints[closest].origin))
				closest = i;
			
			if(distance(level.waypoints[i].origin, self.origin) < getDvarFloat("bots_main_debug_distance") && (bulletTracePassed(myEye, level.waypoints[i].origin + (0, 0, 25), false, self) || getDVarint("bots_main_debug_drawThrough")))
			{
				for(h = 0; h < level.waypoints[i].childCount; h++)
					line(level.waypoints[i].origin + (0, 0, 25), level.waypoints[level.waypoints[i].children[h]].origin + (0, 0, 25), (1,0,1));
				
				if(self bots_IsFacingAtTarget(level.waypoints[i], getDvarFloat("bots_main_debug_cone")))
					print3d(level.waypoints[i].origin + (0, 0, 25), i, (1,0,0), 2);
			}
		}
		
		self.nearest = closest;
		
		nearestWP setText(self.nearest);
		
		children setText(buildChildString(self.nearest));
		
		type setText(buildTypeString(self.nearest));
		
		wpToLink setText(level.wpToLink);
		
		infotext.x = infotext.x - 2;
		if(infotext.x <= -800)
			infotext.x = 800;
		
		wait 0.05;
	}
}

watchLoadWaypointsCommand()
{
	self endon("disconnect");
	self endon("death");
	
	self notifyOnPlayerCommand("[{+actionslot 2}]", "+actionslot 2");
	for( ;; )
	{
		self waittill("[{+actionslot 2}]");
		self LoadWaypoints();
	}
}

watchAddWaypointCommand()
{
	self endon("disconnect");
	self endon("death");
	
	self notifyOnPlayerCommand("[{+smoke}]", "+smoke");
	for( ;; )
	{
		self waittill("[{+smoke}]");
		self AddWaypoint();
	}
}

watchAutoLinkCommand()
{
	self endon("disconnect");
	self endon("death");
	
	self notifyOnPlayerCommand("[{weapnext}]", "weapnext");
	for( ;; )
	{
		self waittill("[{weapnext}]");
		if(level.autoLink)
		{
			self iPrintlnBold("Auto link disabled");
			level.autoLink = false;
		}
		else
		{
			self iPrintlnBold("Auto link enabled");
			level.autoLink = true;
		}
	}
}

watchLinkWaypointCommand()
{
	self endon("disconnect");
	self endon("death");
	
	self notifyOnPlayerCommand("[{+melee}]", "+melee");
	for( ;; )
	{
		self waittill("[{+melee}]");
		self LinkWaypoint(self.nearest);
	}
}			

watchUnlinkWaypointCommand()
{
	self endon("disconnect");
	self endon("death");
	
	self notifyOnPlayerCommand("[{+reload}]", "+reload");
	for( ;; )
	{
		self waittill("[{+reload}]");
		self UnLinkWaypoint(self.nearest);
	}
}			

watchDeleteWaypointCommand()
{
	self endon("disconnect");
	self endon("death");
	
	self notifyOnPlayerCommand("[{+actionslot 3}]", "+actionslot 3");
	for( ;; )
	{
		self waittill("[{+actionslot 3}]");
		self DeleteWaypoint(self.nearest);
	}
}

watchDeleteAllWaypointsCommand()
{
	self endon("disconnect");
	self endon("death");
	
	self notifyOnPlayerCommand("[{+actionslot 4}]", "+actionslot 4");
	for( ;; )
	{
		self waittill("[{+actionslot 4}]");
		self DeleteAllWaypoints();
	}
}

watchSaveWaypointsCommand()
{
	self endon("death");
	self endon("disconnect");
	
	self notifyOnPlayerCommand("[{+actionslot 1}]", "+actionslot 1");
	for(;;)
	{
		self waittill("[{+actionslot 1}]");
		self checkForWarnings();
		logprint("***********ABiliTy's WPDump**************\n\n");
		logprint("\n\n\n\n");
		mpnm=bots_getMapName(getdvar("mapname"));
		logprint("\n\n"+mpnm+"()\n{\n/*");
		logprint("*/waypoints = [];\n/*");
		for(i = 0; i < level.waypointCount; i++)
		{
			logprint("*/waypoints["+i+"] = spawnstruct();\n/*");
			logprint("*/waypoints["+i+"].origin = "+level.waypoints[i].origin+";\n/*");
			logprint("*/waypoints["+i+"].type = \""+level.waypoints[i].type+"\";\n/*");
			logprint("*/waypoints["+i+"].childCount = "+level.waypoints[i].childCount+";\n/*");
			for(c = 0; c < level.waypoints[i].childCount; c++)
			{
				logprint("*/waypoints["+i+"].children["+c+"] = "+level.waypoints[i].children[c]+";\n/*");
			}
			if(isDefined(level.waypoints[i].angles) && (level.waypoints[i].type == "claymore" || level.waypoints[i].type == "tube" || (level.waypoints[i].type == "crouch" && level.waypoints[i].childCount == 1) || level.waypoints[i].type == "climb" || level.waypoints[i].type == "grenade"))
				logprint("*/waypoints["+i+"].angles = "+level.waypoints[i].angles+";\n/*");
		}
		logprint("*/return waypoints;\n}\n\n\n\n");
		self iprintln("Saved!!!");
	}
}

LoadWaypoints()
{
	self DeleteAllWaypoints();
	self iPrintlnBold("Loading WPS...");
	bots_loadWaypoints();
	
	self checkForWarnings();
}

checkForWarnings()
{
	if(level.waypointCount <= 0)
		self iprintln("WARNING: waypointCount is "+level.waypointCount);
	
	if(level.waypointCount != level.waypoints.size)
		self iprintln("WARNING: waypointCount is not "+level.waypoints.size);
	
	for(i = 0; i < level.waypointCount; i++)
	{
		if(!isDefined(level.waypoints[i]))
		{
			self iprintln("WARNING: waypoint "+i+" is undefined");
			continue;
		}
		
		if(level.waypoints[i].childCount <= 0)
			self iprintln("WARNING: waypoint "+i+" childCount is "+level.waypoints[i].childCount);
		
		if(level.waypoints[i].childCount != level.waypoints[i].children.size)
			self iprintln("WARNING: waypoint "+i+" childCount is not "+level.waypoints[i].children.size);
		
		foreach(child in level.waypoints[i].children)
		{
			if(!isDefined(level.waypoints[child]))
				self iprintln("WARNING: waypoint "+i+" child "+child+" is undefined");
			else if(child == i)
				self iprintln("WARNING: waypoint "+i+" child "+child+" is itself");
		}
		
		if(!isDefined(level.waypoints[i].type))
		{
			self iprintln("WARNING: waypoint "+i+" type is undefined");
			continue;
		}
		
		if(!isDefined(level.waypoints[i].angles) && (level.waypoints[i].type == "claymore" || level.waypoints[i].type == "tube" || (level.waypoints[i].type == "crouch" && level.waypoints[i].childCount == 1) || level.waypoints[i].type == "climb" || level.waypoints[i].type == "grenade"))
			self iprintln("WARNING: waypoint "+i+" angles is undefined");
	}
}

UnLinkWaypoint(nwp)
{
	if(nwp == -1 || distance(self.origin, level.waypoints[nwp].origin) > getDvarFloat("bots_main_debug_minDist"))
	{
		self iprintln("Waypoint Unlink Cancelled "+level.wpToLink);
		level.wpToLink = -1;
		return;
	}
	
	if(level.wpToLink == -1 || nwp == level.wpToLink)
	{
		level.wpToLink = nwp;
		self iprintln("Waypoint Unlink Started "+nwp);
		return;
	}
	
	level.waypoints[nwp].children = array_remove(level.waypoints[nwp].children, level.wpToLink);
	level.waypoints[level.wpToLink].children = array_remove(level.waypoints[level.wpToLink].children, nwp);
	
	level.waypoints[nwp].childCount = level.waypoints[nwp].children.size;
	level.waypoints[level.wpToLink].childCount = level.waypoints[level.wpToLink].children.size;
	
	self iprintln("Waypoint " + nwp + " Broken to " + level.wpToLink);
	level.wpToLink = -1;
}

LinkWaypoint(nwp)
{
	if(nwp == -1 || distance(self.origin, level.waypoints[nwp].origin) > getDvarFloat("bots_main_debug_minDist"))
	{
		self iprintln("Waypoint Link Cancelled "+level.wpToLink);
		level.wpToLink = -1;
		return;
	}
	
	if(level.wpToLink == -1 || nwp == level.wpToLink)
	{
		level.wpToLink = nwp;
		self iprintln("Waypoint Link Started "+nwp);
		return;
	}
	
	weGood = true;
	foreach(child in level.waypoints[level.wpToLink].children)
	{
		if(child == nwp)
		{
			weGood = false;
			break;
		}
	}
	if(weGood)
	{
		foreach(child in level.waypoints[nwp].children)
		{
			if(child == level.wpToLink)
			{
				weGood = false;
				break;
			}
		}
	}
	
	if (!weGood )
	{
		self iprintln("Waypoint Link Cancelled "+nwp+" and "+level.wpToLink+" already linked.");
		level.wpToLink = -1;
		return;
	}
	
	level.waypoints[level.wpToLink].children[level.waypoints[level.wpToLink].childcount] = nwp;
	level.waypoints[level.wpToLink].childcount++;
	level.waypoints[nwp].children[level.waypoints[nwp].childcount] = level.wpToLink;
	level.waypoints[nwp].childcount++;
	
	self iprintln("Waypoint " + nwp + " Linked to " + level.wpToLink);
	level.wpToLink = -1;
}

DeleteWaypoint(nwp)
{
	if(nwp == -1 || distance(self.origin, level.waypoints[nwp].origin) > getDvarFloat("bots_main_debug_minDist"))
	{
		self iprintln("No close enough waypoint to delete.");
		return;
	}
	
	level.wpToLink = -1;
	
	foreach(child in level.waypoints[nwp].children)
	{
		level.waypoints[child].children = array_remove(level.waypoints[child].children, nwp);
		
		level.waypoints[child].childCount = level.waypoints[child].children.size;
	}
	
	for(i = 0; i < level.waypointCount; i++)
	{
		for(h = 0; h < level.waypoints[i].childCount; h++)
		{
			if(level.waypoints[i].children[h] > nwp)
				level.waypoints[i].children[h]--;
		}
	}
	
	for ( entry = 0; entry < level.waypointCount; entry++ )
	{
		if ( entry == nwp )
		{
			while ( entry < level.waypointCount-1 )
			{
				level.waypoints[entry] = level.waypoints[entry+1];
				entry++;
			}
			level.waypoints[entry] = undefined;
			break;
		}
	}
	level.waypointCount--;
	
	self iprintln("DelWp "+nwp);
}

AddWaypoint()
{
	level.waypoints[level.waypointCount] = spawnstruct();
	
	pos = self getOrigin();
	level.waypoints[level.waypointCount].origin = pos;
	
	if(self AdsButtonPressed())
		level.waypoints[level.waypointCount].type = "climb";
	else if(self AttackButtonPressed() && self UseButtonPressed())
		level.waypoints[level.waypointCount].type = "tube";
	else if(self AttackButtonPressed())
		level.waypoints[level.waypointCount].type = "grenade";
	else if(self UseButtonPressed())
		level.waypoints[level.waypointCount].type = "claymore";
	else
		level.waypoints[level.waypointCount].type = self getStance();
	
	level.waypoints[level.waypointCount].angles = self getPlayerAngles();
	
	level.waypoints[level.waypointCount].children = [];
	level.waypoints[level.waypointCount].childCount = 0;
	
	self iprintln(level.waypoints[level.waypointCount].type + " Waypoint "+ level.waypointCount +" Added at "+pos);
	
	if(level.autoLink)
	{
		if(level.wpToLink == -1)
			level.wpToLink = level.waypointCount - 1;
		
		level.waypointCount++;
		self LinkWaypoint(level.waypointCount - 1);
	}
	else
	{
		level.waypointCount++;
	}
}

roundUp( floatVal )
{
	if ( int( floatVal ) != floatVal )
		return int( floatVal+1 );
	else
		return int( floatVal );
}

DeleteAllWaypoints()
{
	foreach(wp in level.waypoints)
	{
		wp = undefined;
	}
	
	level.waypoints = [];
	level.waypointCount = 0;
	
	foreach(wp in game["bots"]["waypoints"])
	{
		wp = undefined;
	}
	
	game["bots"]["waypoints"] = [];
	game["bots"]["waypoints"] = undefined;
	
	self iprintln("DelAllWps");
}

buildChildString( wp )
{
	if ( wp == -1 )
		return "";
	
	wpstr = "";
	
	for(i = 0; i < level.waypoints[wp].childCount; i++)
	{
		if(i != 0)
			wpstr = wpstr + "," + level.waypoints[wp].children[i];
		else
			wpstr= wpstr + level.waypoints[wp].children[i];
	}
	
	return wpstr;
}

buildTypeString( wp )
{
	if ( wp == -1 )
		return "";
	
	return level.waypoints[wp].type;
}

destroyOnDeath(hud)
{
	hud endon("death");
	self waittill_either("death","disconnect");
	hud destroy();
	hud = undefined;
	hud notify("death");
}

initHudElem(txt, xl, yl)
{
	hud = NewClientHudElem( self );
	hud setText(txt);
	hud.alignX = "top";
	hud.alignY =  "left";
	hud.horzAlign =  "top";
	hud.vertAlign =  "left";
	hud.x = xl;
	hud.y = yl;
	hud.foreground = true;
	hud.fontScale = 1;
	hud.font = "objective";
	hud.alpha = 1;
	hud.glow = 0;
	hud.glowColor = ( 0, 0, 0 );
	hud.glowAlpha = 1;
	hud.color = ( 1.0, 1.0, 1.0 );
	
	self thread destroyOnDeath( hud );
	
	return hud;
}

initHudElem2()
{
	infotext = NewHudElem();
	infotext setText("^1[{+smoke}]-AddWp ^2[{+melee}]-LinkWp ^3[{+reload}]-UnLinkWp ^4[{+actionslot 3}]-DeleteWp ^5[{+actionslot 4}]-DelAllWps ^6[{+actionslot 2}]-LoadWPS ^7[{+actionslot 1}]-SaveWp");
	infotext.alignX = "center";
	infotext.alignY = "bottom";
	infotext.horzAlign = "center";
	infotext.vertAlign = "bottom";
	infotext.x = -800;
	infotext.y = 25;
	infotext.foreground = true;
	infotext.fontScale = 1.35;
	infotext.font = "objective";
	infotext.alpha = 1;
	infotext.glow = 0;
	infotext.glowColor = ( 0, 0, 0 );
	infotext.glowAlpha = 1;
	infotext.color = ( 1.0, 1.0, 1.0 );
	
	self thread destroyOnDeath( infotext );
	
	return infotext;
}

initHudElem3()
{
	bar = level createServerBar((0.5, 0.5, 0.5), 1000, 25);
	bar.alignX = "center";
	bar.alignY = "bottom";
	bar.horzAlign = "center";
	bar.vertAlign = "bottom";
	bar.y = 30;
	bar.foreground = true;
	
	self thread destroyOnDeath( bar );
	
	return bar;
}

initHudElem4()
{
	OptionsBG = NewClientHudElem( self );
	OptionsBG.x = 500;
	OptionsBG.y = 2;
	OptionsBG.alignX = "top";
	OptionsBG.alignY = "left";
	OptionsBG.horzAlign = "top";
	OptionsBG.vertAlign = "left";
	OptionsBG setshader("black", 200, 50);
	OptionsBG.alpha = 0.4;
	
	self thread destroyOnDeath( OptionsBG );
	
	return OptionsBG;
}