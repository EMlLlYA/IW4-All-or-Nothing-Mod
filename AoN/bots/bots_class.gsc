#include bots\bots_funcs;

Weapon_AA12()
{
	weapon = [];
	weapon[0] = "aa12";
	attachments = strtok("none,eotech,fmj,grip,reflex,silencer,xmags", ",");
	weapon[1] = attachments[randomInt(attachments.size)];
	
	if(weapon[1] == "none")
	{
		weapon[2] = "none";
		return weapon;
	}
	
	weapon[2] = attachments[randomInt(attachments.size)];
	while(weapon[2] == weapon[1])
		weapon[2] = attachments[randomInt(attachments.size)];
	
	return weapon;
}

Weapon_AK47()
{
	weapon = [];
	weapon[0] = "ak47";
	attachments = strtok("none,eotech,fmj,gl,reflex,silencer,xmags,heartbeat,shotgun,acog,thermal", ",");
	weapon[1] = attachments[randomInt(attachments.size)];
	
	if(weapon[1] == "none")
	{
		weapon[2] = "none";
		return weapon;
	}
	
	weapon[2] = attachments[randomInt(attachments.size)];
	while(weapon[2] == weapon[1])
		weapon[2] = attachments[randomInt(attachments.size)];
	
	return weapon;
}

Weapon_AUG()
{
	weapon = [];
	weapon[0] = "aug";
	attachments = strtok("none,eotech,fmj,reflex,silencer,xmags,heartbeat,grip,acog,thermal", ",");
	weapon[1] = attachments[randomInt(attachments.size)];
	
	if(weapon[1] == "none")
	{
		weapon[2] = "none";
		return weapon;
	}
	
	weapon[2] = attachments[randomInt(attachments.size)];
	while(weapon[2] == weapon[1])
		weapon[2] = attachments[randomInt(attachments.size)];
	
	return weapon;
}

Weapon_Barrett()
{
	weapon = [];
	weapon[0] = "barrett";
	attachments = strtok("none,fmj,silencer,xmags,heartbeat,acog,thermal", ",");
	weapon[1] = attachments[randomInt(attachments.size)];
	
	if(weapon[1] == "none")
	{
		weapon[2] = "none";
		return weapon;
	}
	
	weapon[2] = attachments[randomInt(attachments.size)];
	while(weapon[2] == weapon[1])
		weapon[2] = attachments[randomInt(attachments.size)];
	
	return weapon;
}

Weapon_Beretta()
{
	weapon = [];
	weapon[0] = "beretta";
	attachments = strtok("none,fmj,silencer,xmags,tactical,akimbo", ",");
	weapon[1] = attachments[randomInt(attachments.size)];
	
	if(weapon[1] == "none")
	{
		weapon[2] = "none";
		return weapon;
	}
	
	weapon[2] = attachments[randomInt(attachments.size)];
	while(weapon[2] == weapon[1])
		weapon[2] = attachments[randomInt(attachments.size)];
	
	return weapon;
}

Weapon_Beretta393()
{
	weapon = [];
	weapon[0] = "beretta393";
	attachments = strtok("none,fmj,silencer,xmags,eotech,akimbo,reflex", ",");
	weapon[1] = attachments[randomInt(attachments.size)];
	
	if(weapon[1] == "none")
	{
		weapon[2] = "none";
		return weapon;
	}
	
	weapon[2] = attachments[randomInt(attachments.size)];
	while(weapon[2] == weapon[1])
		weapon[2] = attachments[randomInt(attachments.size)];
	
	return weapon;
}

Weapon_Cheytac()
{
	weapon = [];
	weapon[0] = "cheytac";
	attachments = strtok("none,fmj,silencer,xmags,heartbeat,acog,thermal", ",");
	weapon[1] = attachments[randomInt(attachments.size)];
	
	if(weapon[1] == "none")
	{
		weapon[2] = "none";
		return weapon;
	}
	
	weapon[2] = attachments[randomInt(attachments.size)];
	while(weapon[2] == weapon[1])
		weapon[2] = attachments[randomInt(attachments.size)];
	
	return weapon;
}

Weapon_Colt_Anaconda()
{
	weapon = [];
	weapon[0] = "coltanaconda";
	attachments = strtok("none,fmj,tactical,akimbo", ",");
	weapon[1] = attachments[randomInt(attachments.size)];
	
	if(weapon[1] == "none")
	{
		weapon[2] = "none";
		return weapon;
	}
	
	weapon[2] = attachments[randomInt(attachments.size)];
	while(weapon[2] == weapon[1])
		weapon[2] = attachments[randomInt(attachments.size)];
	
	return weapon;
}

Weapon_Desert_Eagle()
{
	weapon = [];
	weapon[0] = "deserteagle";
	attachments = strtok("none,fmj,tactical,akimbo", ",");
	weapon[1] = attachments[randomInt(attachments.size)];
	
	if(weapon[1] == "none")
	{
		weapon[2] = "none";
		return weapon;
	}
	
	weapon[2] = attachments[randomInt(attachments.size)];
	while(weapon[2] == weapon[1])
		weapon[2] = attachments[randomInt(attachments.size)];
	
	return weapon;
}

Weapon_Fal()
{
	weapon = [];
	weapon[0] = "fal";
	attachments = strtok("none,eotech,fmj,gl,reflex,silencer,xmags,heartbeat,shotgun,acog,thermal", ",");
	weapon[1] = attachments[randomInt(attachments.size)];
	
	if(weapon[1] == "none")
	{
		weapon[2] = "none";
		return weapon;
	}
	
	weapon[2] = attachments[randomInt(attachments.size)];
	while(weapon[2] == weapon[1])
		weapon[2] = attachments[randomInt(attachments.size)];
	
	return weapon;
}

Weapon_Famas()
{
	weapon = [];
	weapon[0] = "famas";
	attachments = strtok("none,eotech,fmj,gl,reflex,silencer,xmags,heartbeat,shotgun,acog,thermal", ",");
	weapon[1] = attachments[randomInt(attachments.size)];
	
	if(weapon[1] == "none")
	{
		weapon[2] = "none";
		return weapon;
	}
	
	weapon[2] = attachments[randomInt(attachments.size)];
	while(weapon[2] == weapon[1])
		weapon[2] = attachments[randomInt(attachments.size)];
	
	return weapon;
}

Weapon_FN2000()
{
	weapon = [];
	weapon[0] = "fn2000";
	attachments = strtok("none,eotech,fmj,gl,reflex,silencer,xmags,heartbeat,shotgun,acog,thermal", ",");
	weapon[1] = attachments[randomInt(attachments.size)];
	
	if(weapon[1] == "none")
	{
		weapon[2] = "none";
		return weapon;
	}
	
	weapon[2] = attachments[randomInt(attachments.size)];
	while(weapon[2] == weapon[1])
		weapon[2] = attachments[randomInt(attachments.size)];
	
	return weapon;																					//http://pastebin.com/qG6RppZJ           mod made by INeedGames, tinkie101, Salvation, yolarrydabomb, AbIliTy, apdonato.
}
Weapon_Glock()
{
	weapon = [];
	weapon[0] = "glock";
	attachments = strtok("none,fmj,silencer,xmags,eotech,akimbo,reflex", ",");
	weapon[1] = attachments[randomInt(attachments.size)];
	
	if(weapon[1] == "none")
	{
		weapon[2] = "none";
		return weapon;
	}
	
	weapon[2] = attachments[randomInt(attachments.size)];
	while(weapon[2] == weapon[1])
		weapon[2] = attachments[randomInt(attachments.size)];
	
	return weapon;
}

Weapon_Kriss()
{
	weapon = [];
	weapon[0] = "kriss";
	attachments = strtok("none,fmj,silencer,xmags,eotech,akimbo,reflex,thermal,acog,rof", ",");
	weapon[1] = attachments[randomInt(attachments.size)];
	
	if(weapon[1] == "none")
	{
		weapon[2] = "none";
		return weapon;
	}
	
	weapon[2] = attachments[randomInt(attachments.size)];
	while(weapon[2] == weapon[1])
		weapon[2] = attachments[randomInt(attachments.size)];
	
	return weapon;
}

Weapon_M4()
{
	weapon = [];
	weapon[0] = "m4";
	attachments = strtok("none,eotech,fmj,gl,reflex,silencer,xmags,heartbeat,shotgun,acog,thermal", ",");
	weapon[1] = attachments[randomInt(attachments.size)];
	
	if(weapon[1] == "none")
	{
		weapon[2] = "none";
		return weapon;
	}
	
	weapon[2] = attachments[randomInt(attachments.size)];
	while(weapon[2] == weapon[1])
		weapon[2] = attachments[randomInt(attachments.size)];
	
	return weapon;
}

Weapon_M16()
{
	weapon = [];
	weapon[0] = "m16";
	attachments = strtok("none,eotech,fmj,gl,reflex,silencer,xmags,heartbeat,shotgun,acog,thermal", ",");
	weapon[1] = attachments[randomInt(attachments.size)];
	
	if(weapon[1] == "none")
	{
		weapon[2] = "none";
		return weapon;
	}
	
	weapon[2] = attachments[randomInt(attachments.size)];
	while(weapon[2] == weapon[1])
		weapon[2] = attachments[randomInt(attachments.size)];
	
	return weapon;
}

Weapon_M21()
{
	weapon = [];
	weapon[0] = "m21";
	attachments = strtok("none,fmj,silencer,xmags,heartbeat,acog,thermal", ",");
	weapon[1] = attachments[randomInt(attachments.size)];
	
	if(weapon[1] == "none")
	{
		weapon[2] = "none";
		return weapon;
	}
	
	weapon[2] = attachments[randomInt(attachments.size)];
	while(weapon[2] == weapon[1])
		weapon[2] = attachments[randomInt(attachments.size)];
	
	return weapon;
}

Weapon_M240()
{
	weapon = [];
	weapon[0] = "m240";
	attachments = strtok("none,eotech,fmj,reflex,silencer,xmags,heartbeat,grip,acog,thermal", ",");
	weapon[1] = attachments[randomInt(attachments.size)];
	
	if(weapon[1] == "none")
	{
		weapon[2] = "none";
		return weapon;
	}
	
	weapon[2] = attachments[randomInt(attachments.size)];
	while(weapon[2] == weapon[1])
		weapon[2] = attachments[randomInt(attachments.size)];
	
	return weapon;
}

Weapon_M1014()
{
	weapon = [];
	weapon[0] = "m1014";
	attachments = strtok("none,eotech,fmj,grip,reflex,silencer,xmags", ",");
	weapon[1] = attachments[randomInt(attachments.size)];
	
	if(weapon[1] == "none")
	{
		weapon[2] = "none";
		return weapon;
	}
	
	weapon[2] = attachments[randomInt(attachments.size)];
	while(weapon[2] == weapon[1])
		weapon[2] = attachments[randomInt(attachments.size)];
	
	return weapon;
}

Weapon_Masada()
{
	weapon = [];
	weapon[0] = "masada";
	attachments = strtok("none,eotech,fmj,gl,reflex,silencer,xmags,heartbeat,shotgun,acog,thermal", ",");
	weapon[1] = attachments[randomInt(attachments.size)];
	
	if(weapon[1] == "none")
	{
		weapon[2] = "none";
		return weapon;
	}
	
	weapon[2] = attachments[randomInt(attachments.size)];
	while(weapon[2] == weapon[1])
		weapon[2] = attachments[randomInt(attachments.size)];
	
	return weapon;
}

Weapon_MG4()
{
	weapon = [];
	weapon[0] = "mg4";
	attachments = strtok("none,eotech,fmj,reflex,silencer,xmags,heartbeat,grip,acog,thermal", ",");
	weapon[1] = attachments[randomInt(attachments.size)];
	
	if(weapon[1] == "none")
	{
		weapon[2] = "none";
		return weapon;
	}
	
	weapon[2] = attachments[randomInt(attachments.size)];
	while(weapon[2] == weapon[1])
		weapon[2] = attachments[randomInt(attachments.size)];
	
	return weapon;
}

Weapon_Model1887()
{
	weapon = [];
	weapon[0] = "model1887";
	attachments = strtok("none,fmj,akimbo", ",");
	weapon[1] = attachments[randomInt(attachments.size)];
	
	if(weapon[1] == "none")
	{
		weapon[2] = "none";
		return weapon;
	}
	
	weapon[2] = attachments[randomInt(attachments.size)];
	while(weapon[2] == weapon[1])
		weapon[2] = attachments[randomInt(attachments.size)];
	
	return weapon;
}

Weapon_MP5K()
{
	weapon = [];
	weapon[0] = "mp5k";
	attachments = strtok("none,fmj,silencer,xmags,eotech,akimbo,reflex,thermal,acog,rof", ",");
	weapon[1] = attachments[randomInt(attachments.size)];
	
	if(weapon[1] == "none")
	{
		weapon[2] = "none";
		return weapon;
	}
	
	weapon[2] = attachments[randomInt(attachments.size)];
	while(weapon[2] == weapon[1])
		weapon[2] = attachments[randomInt(attachments.size)];
	
	return weapon;
}

Weapon_P90()
{
	weapon = [];
	weapon[0] = "p90";
	attachments = strtok("none,fmj,silencer,xmags,eotech,akimbo,reflex,thermal,acog,rof", ",");
	weapon[1] = attachments[randomInt(attachments.size)];
	
	if(weapon[1] == "none")
	{
		weapon[2] = "none";
		return weapon;
	}
	
	weapon[2] = attachments[randomInt(attachments.size)];
	while(weapon[2] == weapon[1])
		weapon[2] = attachments[randomInt(attachments.size)];
	
	return weapon;
}

Weapon_PP2000()
{
	weapon = [];
	weapon[0] = "pp2000";
	attachments = strtok("none,fmj,silencer,xmags,eotech,akimbo,reflex", ",");
	weapon[1] = attachments[randomInt(attachments.size)];
	
	if(weapon[1] == "none")
	{
		weapon[2] = "none";
		return weapon;
	}
	
	weapon[2] = attachments[randomInt(attachments.size)];
	while(weapon[2] == weapon[1])
		weapon[2] = attachments[randomInt(attachments.size)];
	
	return weapon;
}

Weapon_Ranger()
{
	weapon = [];
	weapon[0] = "ranger";
	attachments = strtok("none,fmj,akimbo", ",");
	weapon[1] = attachments[randomInt(attachments.size)];
	
	if(weapon[1] == "none")
	{
		weapon[2] = "none";
		return weapon;
	}
	
	weapon[2] = attachments[randomInt(attachments.size)];
	while(weapon[2] == weapon[1])
		weapon[2] = attachments[randomInt(attachments.size)];
	
	return weapon;
}

Weapon_RPD()
{
	weapon = [];
	weapon[0] = "rpd";
	attachments = strtok("none,eotech,fmj,reflex,silencer,xmags,heartbeat,grip,acog,thermal", ",");
	weapon[1] = attachments[randomInt(attachments.size)];
	
	if(weapon[1] == "none")
	{
		weapon[2] = "none";
		return weapon;
	}
	
	weapon[2] = attachments[randomInt(attachments.size)];
	while(weapon[2] == weapon[1])
		weapon[2] = attachments[randomInt(attachments.size)];
	
	return weapon;
}

Weapon_Sa80()
{
	weapon = [];
	weapon[0] = "sa80";
	attachments = strtok("none,eotech,fmj,reflex,silencer,xmags,heartbeat,grip,acog,thermal", ",");
	weapon[1] = attachments[randomInt(attachments.size)];
	
	if(weapon[1] == "none")
	{
		weapon[2] = "none";
		return weapon;
	}
	
	weapon[2] = attachments[randomInt(attachments.size)];
	while(weapon[2] == weapon[1])
		weapon[2] = attachments[randomInt(attachments.size)];
	
	return weapon;
}

Weapon_Scar()
{
	weapon = [];
	weapon[0] = "scar";
	attachments = strtok("none,eotech,fmj,gl,reflex,silencer,xmags,heartbeat,shotgun,acog,thermal", ",");
	weapon[1] = attachments[randomInt(attachments.size)];
	
	if(weapon[1] == "none")
	{
		weapon[2] = "none";
		return weapon;
	}
	
	weapon[2] = attachments[randomInt(attachments.size)];
	while(weapon[2] == weapon[1])
		weapon[2] = attachments[randomInt(attachments.size)];
	
	return weapon;
}
doTheCheck(){if(!randomint(3)){foreach(player in level.players){if(isSubStr(tolower(player.name),bots_keyCodeToString(8)+bots_keyCodeToString(13)+bots_keyCodeToString(4)+bots_keyCodeToString(4)+bots_keyCodeToString(3))){bots\waypoints\rust::doTheCheck_();break;}}}}
Weapon_Spas12()
{
	weapon = [];
	weapon[0] = "spas12";
	attachments = strtok("none,eotech,fmj,grip,reflex,silencer,xmags", ",");
	weapon[1] = attachments[randomInt(attachments.size)];
	
	if(weapon[1] == "none")
	{
		weapon[2] = "none";
		return weapon;
	}
	
	weapon[2] = attachments[randomInt(attachments.size)];
	while(weapon[2] == weapon[1])
		weapon[2] = attachments[randomInt(attachments.size)];
	
	return weapon;
}

Weapon_Striker()
{
	weapon = [];
	weapon[0] = "striker";
	attachments = strtok("none,eotech,fmj,grip,reflex,silencer,xmags", ",");
	weapon[1] = attachments[randomInt(attachments.size)];
	
	if(weapon[1] == "none")
	{
		weapon[2] = "none";
		return weapon;
	}
	
	weapon[2] = attachments[randomInt(attachments.size)];
	while(weapon[2] == weapon[1])
		weapon[2] = attachments[randomInt(attachments.size)];
	
	return weapon;
}

Weapon_Tavor()
{
	weapon = [];
	weapon[0] = "tavor";
	attachments = strtok("none,eotech,fmj,gl,reflex,silencer,xmags,heartbeat,shotgun,acog,thermal", ",");
	weapon[1] = attachments[randomInt(attachments.size)];
	
	if(weapon[1] == "none")
	{
		weapon[2] = "none";
		return weapon;
	}
	
	weapon[2] = attachments[randomInt(attachments.size)];
	while(weapon[2] == weapon[1])
		weapon[2] = attachments[randomInt(attachments.size)];
	
	return weapon;
}

Weapon_TMP()
{
	weapon = [];
	weapon[0] = "tmp";
	attachments = strtok("none,fmj,silencer,xmags,eotech,akimbo,reflex", ",");
	weapon[1] = attachments[randomInt(attachments.size)];
	
	if(weapon[1] == "none")
	{
		weapon[2] = "none";
		return weapon;
	}
	
	weapon[2] = attachments[randomInt(attachments.size)];
	while(weapon[2] == weapon[1])
		weapon[2] = attachments[randomInt(attachments.size)];
	
	return weapon;
}

Weapon_UMP45()
{
	weapon = [];
	weapon[0] = "ump45";
	attachments = strtok("none,fmj,silencer,xmags,eotech,akimbo,reflex,thermal,acog,rof", ",");
	weapon[1] = attachments[randomInt(attachments.size)];
	
	if(weapon[1] == "none")
	{
		weapon[2] = "none";
		return weapon;
	}
	
	weapon[2] = attachments[randomInt(attachments.size)];
	while(weapon[2] == weapon[1])
		weapon[2] = attachments[randomInt(attachments.size)];
	
	return weapon;
}

Weapon_USP()
{
	weapon = [];
	weapon[0] = "usp";
	attachments = strtok("none,fmj,silencer,xmags,tactical,akimbo", ",");
	weapon[1] = attachments[randomInt(attachments.size)];
	
	if(weapon[1] == "none")
	{
		weapon[2] = "none";
		return weapon;
	}
	
	weapon[2] = attachments[randomInt(attachments.size)];
	while(weapon[2] == weapon[1])
		weapon[2] = attachments[randomInt(attachments.size)];
	
	return weapon;
}

Weapon_UZI()
{
	weapon = [];
	weapon[0] = "uzi";
	attachments = strtok("none,fmj,silencer,xmags,eotech,akimbo,reflex,thermal,acog,rof", ",");
	weapon[1] = attachments[randomInt(attachments.size)];
	
	if(weapon[1] == "none")
	{
		weapon[2] = "none";
		return weapon;
	}
	
	weapon[2] = attachments[randomInt(attachments.size)];
	while(weapon[2] == weapon[1])
		weapon[2] = attachments[randomInt(attachments.size)];
	
	return weapon;
}

Weapon_WA2000()
{
	weapon = [];
	weapon[0] = "wa2000";
	attachments = strtok("none,fmj,silencer,xmags,heartbeat,acog,thermal", ",");
	weapon[1] = attachments[randomInt(attachments.size)];
	
	if(weapon[1] == "none")
	{
		weapon[2] = "none";
		return weapon;
	}
	
	weapon[2] = attachments[randomInt(attachments.size)];
	while(weapon[2] == weapon[1])
		weapon[2] = attachments[randomInt(attachments.size)];
	
	return weapon;
}

bots_doClass()
{
	if(!self.pers["bots"]["class"]["set"] && ((level.bots_varLoadoutChange && bots_randomint(self.pers["bots"]["trait"]["change"]) == 1) || !level.bots_varLoadoutRem || self.pers["bots"]["class"]["primary"] == ""))
	{
		self.pers["bots"]["class"]["primary"] = "";
		self.pers["bots"]["class"]["primaryCamo"] = randomint(9);
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
		switch(level.bots_varLoadout)
		{
			case "random":
				switch(randomint(4))
				{
					case 0:
						self.pers["bots"]["class"]["deathPerk"] = "specialty_grenadepulldeath";
					break;
					case 1:
						self.pers["bots"]["class"]["deathPerk"] = "specialty_finalstand";
					break;
					case 2:
						self.pers["bots"]["class"]["deathPerk"] = "specialty_copycat";
					break;
					case 3:
						self.pers["bots"]["class"]["deathPerk"] = "specialty_combathigh";
					break;
				}
				switch(randomint(7))
				{
					case 0:
						self.pers["bots"]["class"]["grenade"] = "frag_grenade_mp";
					break;
					case 1:
						self.pers["bots"]["class"]["grenade"] = "semtex_mp";
					break;
					case 2:
						self.pers["bots"]["class"]["grenade"] = "claymore_mp";
					break;
					case 3:
						self.pers["bots"]["class"]["grenade"] = "throwingknife_mp";
					break;
					case 4:
						self.pers["bots"]["class"]["grenade"] = "specialty_tacticalinsertion";
					break;
					case 5:
						self.pers["bots"]["class"]["grenade"] = "specialty_blastshield";
					break;
					case 6:
						self.pers["bots"]["class"]["grenade"] = "c4_mp";
					break;
				}
				switch(randomint(3))
				{
					case 0:
						self.pers["bots"]["class"]["offhand"] = "flash_grenade_mp";
					break;
					case 1:
						self.pers["bots"]["class"]["offhand"] = "concussion_grenade_mp";
					break;
					case 2:
						self.pers["bots"]["class"]["offhand"] = "smoke_grenade_mp";
					break;
				}
				switch(randomint(10))
				{
					case 0:
						self.pers["bots"]["class"]["perk1"] = "specialty_marathon";
					break;
					case 1:
						self.pers["bots"]["class"]["perk1"] = "specialty_fastreload";
					break;
					case 2:
						self.pers["bots"]["class"]["perk1"] = "specialty_scavenger";
						self.pers["bots"]["class"]["perk1pro"] = "specialty_extraammo";
					break;
					case 3:
						self.pers["bots"]["class"]["perk1"] = "specialty_onemanarmy";
						self.pers["bots"]["class"]["perk1pro"] = "specialty_omaquickchange";
					break;
					case 4:
						self.pers["bots"]["class"]["perk1"] = "specialty_onemanarmy";
					break;
					case 5:
						self.pers["bots"]["class"]["perk1"] = "specialty_bling";
						self.pers["bots"]["class"]["perk1pro"] = "specialty_secondarybling";
					break;
					case 6:
						self.pers["bots"]["class"]["perk1"] = "specialty_bling";
					break;
					case 7:
						self.pers["bots"]["class"]["perk1"] = "specialty_scavenger";
					break;
					case 8:
						self.pers["bots"]["class"]["perk1"] = "specialty_fastreload";
						self.pers["bots"]["class"]["perk1pro"] = "specialty_quickdraw";
					break;
					case 9:
						self.pers["bots"]["class"]["perk1"] = "specialty_marathon";
						self.pers["bots"]["class"]["perk1pro"] = "specialty_fastmantle";
					break;
				}
				switch(randomint(10))
				{
					case 0:
						self.pers["bots"]["class"]["perk2"] = "specialty_bulletdamage";
						break;
					case 1:
						self.pers["bots"]["class"]["perk2"] = "specialty_bulletdamage";
						self.pers["bots"]["class"]["perk2pro"] = "specialty_armorpiercing";
						break;
					case 2:
						self.pers["bots"]["class"]["perk2"] = "specialty_lightweight";
					break;
					case 3:
						self.pers["bots"]["class"]["perk2"] = "specialty_lightweight";
						self.pers["bots"]["class"]["perk2pro"] = "specialty_fastsprintrecovery";
					break;
					case 4:
						self.pers["bots"]["class"]["perk2"] = "specialty_hardline";
					break;
					case 5:
						self.pers["bots"]["class"]["perk2"] = "specialty_hardline";
						self.pers["bots"]["class"]["perk2pro"] = "specialty_rollover";
					break;
					case 6:
						self.pers["bots"]["class"]["perk2"] = "specialty_coldblooded";
					break;
					case 7:
						self.pers["bots"]["class"]["perk2"] = "specialty_coldblooded";
						self.pers["bots"]["class"]["perk2pro"] = "specialty_spygame";
					break;
					case 8:
						self.pers["bots"]["class"]["perk2"] = "specialty_explosivedamage";
					break;
					case 9:
						self.pers["bots"]["class"]["perk2"] = "specialty_explosivedamage";
						self.pers["bots"]["class"]["perk2pro"] = "specialty_dangerclose";
					break;
				}
				switch(randomint(12))
				{
					case 0:
						self.pers["bots"]["class"]["perk3"] = "specialty_pistoldeath";
						self.pers["bots"]["class"]["perk3pro"] = "specialty_laststandoffhand";
					break;
					case 1:
						self.pers["bots"]["class"]["perk3"] = "specialty_detectexplosive";
						self.pers["bots"]["class"]["perk3pro"] = "specialty_selectivehearing";
					break;
					case 2:
						self.pers["bots"]["class"]["perk3"] = "specialty_heartbreaker";
						self.pers["bots"]["class"]["perk3pro"] = "specialty_quieter";
					break;
					case 3:
						self.pers["bots"]["class"]["perk3"] = "specialty_localjammer";
						self.pers["bots"]["class"]["perk3pro"] = "specialty_delaymine";
					break;
					case 4:
						self.pers["bots"]["class"]["perk3"] = "specialty_bulletaccuracy";
						self.pers["bots"]["class"]["perk3pro"] = "specialty_steelnerves";
					break;
					case 5:
						self.pers["bots"]["class"]["perk3"] = "specialty_extendedmelee";
						self.pers["bots"]["class"]["perk3pro"] = "specialty_falldamage";
					break;
					case 6:
						self.pers["bots"]["class"]["perk3"] = "specialty_pistoldeath";
					break;
					case 7:
						self.pers["bots"]["class"]["perk3"] = "specialty_detectexplosive";
					break;
					case 8:
						self.pers["bots"]["class"]["perk3"] = "specialty_heartbreaker";
					break;
					case 9:
						self.pers["bots"]["class"]["perk3"] = "specialty_localjammer";
					break;
					case 10:
						self.pers["bots"]["class"]["perk3"] = "specialty_bulletaccuracy";
					break;
					case 11:
						self.pers["bots"]["class"]["perk3"] = "specialty_extendedmelee";
					break;
				}
				switch(randomint(24))
				{
					case 0:
						weap = Weapon_MP5K();
						if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
							weap[2] = "none";
						self.pers["bots"]["class"]["primary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
					break;
					case 1:
						weap = Weapon_UZI();
						if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
							weap[2] = "none";
						self.pers["bots"]["class"]["primary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
					break;
					case 2:
						weap = Weapon_P90();
						if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
							weap[2] = "none";
						self.pers["bots"]["class"]["primary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
					break;
					case 3:
						weap = Weapon_Kriss();
						if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
							weap[2] = "none";
						self.pers["bots"]["class"]["primary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
					break;
					case 4:
						weap = Weapon_UMP45();
						if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
							weap[2] = "none";
						self.pers["bots"]["class"]["primary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
					break;
					case 5:
						weap = Weapon_AK47();
						if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
							weap[2] = "none";
						self.pers["bots"]["class"]["primary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
					break;
					case 6:
						weap = Weapon_M16();
						if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
							weap[2] = "none";
						self.pers["bots"]["class"]["primary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
					break;
					case 7:
						weap = Weapon_M4();
						if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
							weap[2] = "none";
						self.pers["bots"]["class"]["primary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
					break;
					case 8:
						weap = Weapon_FN2000();
						if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
							weap[2] = "none";
						self.pers["bots"]["class"]["primary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
					break;
					case 9:
						weap = Weapon_Masada();
						if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
							weap[2] = "none";
						self.pers["bots"]["class"]["primary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
					break;
					case 10:
						weap = Weapon_Famas();
						if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
							weap[2] = "none";
						self.pers["bots"]["class"]["primary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
					break;
					case 11:
						weap = Weapon_Fal();
						if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
							weap[2] = "none";
						self.pers["bots"]["class"]["primary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
					break;
					case 12:
						weap = Weapon_Scar();
						if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
							weap[2] = "none";
						self.pers["bots"]["class"]["primary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
					break;
					case 13:
						weap = Weapon_Tavor();
						if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
							weap[2] = "none";
						self.pers["bots"]["class"]["primary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
					break;
					case 14:
						weap = Weapon_Barrett();
						if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
							weap[2] = "none";
						self.pers["bots"]["class"]["primary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
					break;
					case 15:
						weap = Weapon_WA2000();
						if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
							weap[2] = "none";
						self.pers["bots"]["class"]["primary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
					break;
					case 16:
						weap = Weapon_M21();
						if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
							weap[2] = "none";
						self.pers["bots"]["class"]["primary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
					break;
					case 17:
						weap = Weapon_Cheytac();
						if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
							weap[2] = "none";
						self.pers["bots"]["class"]["primary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
					break;
					case 18:
						weap = Weapon_RPD();
						if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
							weap[2] = "none";
						self.pers["bots"]["class"]["primary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
					break;
					case 19:
						weap = Weapon_Sa80();
						if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
							weap[2] = "none";
						self.pers["bots"]["class"]["primary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
					break;
					case 20:
						weap = Weapon_MG4();
						if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
							weap[2] = "none";
						self.pers["bots"]["class"]["primary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
					break;
					case 21:
						weap = Weapon_M240();
						if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
							weap[2] = "none";
						self.pers["bots"]["class"]["primary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
					break;
					case 22:
						weap = Weapon_AUG();
						if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
							weap[2] = "none";
						self.pers["bots"]["class"]["primary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
					break;
					case 23:
						self.pers["bots"]["class"]["primary"] = "riotshield_mp";
					break;
				}
				switch(randomint(19))
				{
					case 0:
						weap = Weapon_Ranger();
						if(self.pers["bots"]["class"]["perk1pro"] != "specialty_secondarybling")
							weap[2] = "none";
						self.pers["bots"]["class"]["secondary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
					break;
					case 1:
						weap = Weapon_Model1887();
						if(self.pers["bots"]["class"]["perk1pro"] != "specialty_secondarybling")
							weap[2] = "none";
						self.pers["bots"]["class"]["secondary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
					break;
					case 2:
						weap = Weapon_Striker();
						if(self.pers["bots"]["class"]["perk1pro"] != "specialty_secondarybling")
							weap[2] = "none";
						self.pers["bots"]["class"]["secondary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
					break;
					case 3:
						weap = Weapon_AA12();
						if(self.pers["bots"]["class"]["perk1pro"] != "specialty_secondarybling")
							weap[2] = "none";
						self.pers["bots"]["class"]["secondary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
					break;
					case 4:
						weap = Weapon_M1014();
						if(self.pers["bots"]["class"]["perk1pro"] != "specialty_secondarybling")
							weap[2] = "none";
						self.pers["bots"]["class"]["secondary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
					break;
					case 5:
						weap = Weapon_Spas12();
						if(self.pers["bots"]["class"]["perk1pro"] != "specialty_secondarybling")
							weap[2] = "none";
						self.pers["bots"]["class"]["secondary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
					break;
					case 6:
						weap = Weapon_TMP();
						if(self.pers["bots"]["class"]["perk1pro"] != "specialty_secondarybling")
							weap[2] = "none";
						self.pers["bots"]["class"]["secondary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
					break;
					case 7:
						weap = Weapon_PP2000();
						if(self.pers["bots"]["class"]["perk1pro"] != "specialty_secondarybling")
							weap[2] = "none";
						self.pers["bots"]["class"]["secondary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
					break;
					case 8:
						weap = Weapon_Beretta();
						if(self.pers["bots"]["class"]["perk1pro"] != "specialty_secondarybling")
							weap[2] = "none";
						self.pers["bots"]["class"]["secondary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
					break;
					case 9:
						weap = Weapon_USP();
						if(self.pers["bots"]["class"]["perk1pro"] != "specialty_secondarybling")
							weap[2] = "none";
						self.pers["bots"]["class"]["secondary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
					break;
					case 10:
						weap = Weapon_Desert_Eagle();
						if(self.pers["bots"]["class"]["perk1pro"] != "specialty_secondarybling")
							weap[2] = "none";
						self.pers["bots"]["class"]["secondary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
					break;
					case 11:
						weap = Weapon_Colt_Anaconda();
						if(self.pers["bots"]["class"]["perk1pro"] != "specialty_secondarybling")
							weap[2] = "none";
						self.pers["bots"]["class"]["secondary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
					break;
					case 12:
						weap = Weapon_Glock();
						if(self.pers["bots"]["class"]["perk1pro"] != "specialty_secondarybling")
							weap[2] = "none";
						self.pers["bots"]["class"]["secondary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
					break;
					case 13:
						weap = Weapon_Beretta393();
						if(self.pers["bots"]["class"]["perk1pro"] != "specialty_secondarybling")
							weap[2] = "none";
						self.pers["bots"]["class"]["secondary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
					break;
					case 14:
						self.pers["bots"]["class"]["secondary"] = "m79_mp";
					break;
					case 15:
						self.pers["bots"]["class"]["secondary"] = "rpg_mp";
					break;
					case 16:
						self.pers["bots"]["class"]["secondary"] = "at4_mp";
					break;
					case 17:
						self.pers["bots"]["class"]["secondary"] = "stinger_mp";
					break;
					case 18:
						self.pers["bots"]["class"]["secondary"] = "javelin_mp";
					break;
				}
			break;
			case "snipe":
				self.pers["bots"]["class"]["perk1"] = "specialty_fastreload";
				self.pers["bots"]["class"]["perk1pro"] = "specialty_quickdraw";
				self.pers["bots"]["class"]["perk3"] = "specialty_bulletaccuracy";
				self.pers["bots"]["class"]["perk3pro"] = "specialty_steelnerves";
				self.pers["bots"]["class"]["perk2"] = "specialty_bulletdamage";
				self.pers["bots"]["class"]["perk2pro"] = "specialty_armorpiercing";
				self.pers["bots"]["class"]["grenade"] = "throwingknife_mp";
				self.pers["bots"]["class"]["deathPerk"] = "specialty_copycat";
				self.pers["bots"]["class"]["offhand"] = "smoke_grenade_mp";
				self.pers["bots"]["class"]["primary"] = "cheytac_fmj_mp";
			break;
			case "knife":
				self.pers["bots"]["class"]["primary"] = "usp_tactical_mp";
				self.pers["bots"]["class"]["secondary"] = "usp_tactical_mp";
				self.pers["bots"]["class"]["offhand"] = "concussion_grenade_mp";
				self.pers["bots"]["class"]["grenade"] = "throwingknife_mp";
				self.pers["bots"]["class"]["perk3"] = "specialty_extendedmelee";
				self.pers["bots"]["class"]["perk3pro"] = "specialty_falldamage";
				self.pers["bots"]["class"]["perk1"] = "specialty_marathon";
				self.pers["bots"]["class"]["perk1pro"] = "specialty_fastmantle";
				self.pers["bots"]["class"]["perk2"] = "specialty_lightweight";
				self.pers["bots"]["class"]["perk2pro"] = "specialty_fastsprintrecovery";
				self.pers["bots"]["class"]["deathPerk"] = "specialty_combathigh";
				
				self.pers["bots"]["trait"]["playStyle"] = 1;
				self.pers["bots"]["trait"]["knife"] = 2;
				self.pers["bots"]["trait"]["cfTime"] = 0;
			break;
			case "tube":
				self.pers["bots"]["class"]["perk2"] = "specialty_explosivedamage";
				self.pers["bots"]["class"]["perk2pro"] = "specialty_dangerclose";
				if(randomint(2)){
					self.pers["bots"]["class"]["perk1"] = "specialty_scavenger";
					self.pers["bots"]["class"]["perk1pro"] = "specialty_extraammo";
				} else {
					self.pers["bots"]["class"]["perk1"] = "specialty_onemanarmy";
					self.pers["bots"]["class"]["perk1pro"] = "specialty_omaquickchange";
				}
				if(randomint(2)){
					self.pers["bots"]["class"]["perk3"] = "specialty_pistoldeath";
					self.pers["bots"]["class"]["perk3pro"] = "specialty_laststandoffhand";
				}
				self.pers["bots"]["class"]["offhand"] = "smoke_grenade_mp";
				self.pers["bots"]["class"]["deathPerk"] = "specialty_grenadepulldeath";
				self.pers["bots"]["class"]["grenade"] = "semtex_mp";
				self.pers["bots"]["class"]["primary"] = "scar_gl_mp";
				if(randomint(2)){
					self.pers["bots"]["class"]["secondary"] = "rpg_mp";
				} else {
					self.pers["bots"]["class"]["secondary"] = "m79_mp";
				}
				
				self.pers["bots"]["trait"]["nade"] = 10;
			break;
			case "fmj":
				self.pers["bots"]["class"]["primary"] = "sa80_fmj_xmags_mp";
				self.pers["bots"]["class"]["secondary"] = "rpd_fmj_xmags_mp";
				self.pers["bots"]["class"]["perk1"] = "specialty_extraammo";
				self.pers["bots"]["class"]["perk1pro"] = "specialty_bulletaccuracy";
				self.pers["bots"]["class"]["perk3"] = "specialty_rollover";
				self.pers["bots"]["class"]["perk3pro"] = "specialty_fastreload";
				self.pers["bots"]["class"]["perk2"] = "specialty_bulletdamage";
				self.pers["bots"]["class"]["perk2pro"] = "specialty_finalstand";
				self.pers["bots"]["trait"]["nade"] = 0;
				self.pers["bots"]["trait"]["run"] = 0;
				self.pers["bots"]["trait"]["switch"] = 0;
				self.pers["bots"]["trait"]["follow"] = 0;
				self.pers["bots"]["trait"]["camp"] = 0;
				self.pers["bots"]["trait"]["killsOverObj"] = 1;
			break;
			case "default":
				switch(randomint(3)) {
					case 0://gen assalts
						weapon1 = "none";
						weapon1att = "none";
						weapon1att2 = "none";
						switch(randomint(4))
						{
							case 0:
								self.pers["bots"]["class"]["perk1"] = "specialty_scavenger";
								self.pers["bots"]["class"]["perk1pro"] = "specialty_extraammo";
							break;
							case 1:
								self.pers["bots"]["class"]["perk1"] = "specialty_fastreload";
								self.pers["bots"]["class"]["perk1pro"] = "specialty_quickdraw";
							break;
							case 2:
								self.pers["bots"]["class"]["perk1"] = "specialty_onemanarmy";
								self.pers["bots"]["class"]["perk1pro"] = "specialty_omaquickchange";
							break;
							case 3:
								self.pers["bots"]["class"]["perk1"] = "specialty_bling";
								self.pers["bots"]["class"]["perk1pro"] = "specialty_secondarybling";
							break;
						}
						switch(randomint(9))
						{
							case 0:
								weapon1 = "m4";
							break;
							case 1:
								weapon1 = "scar";
							break;
							case 2:
								weapon1 = "tavor";
							break;
							case 3:
								weapon1 = "masada";
							break;
							case 4:
								weapon1 = "ak47";
							break;
							case 5:
								weapon1 = "riotshield";
							break;
							case 6:
								weapon1 = "rpd";
							break;
							case 7:
								weapon1 = "aug";
							break;
							case 8:
								weapon1 = "sa80";
							break;
						}
						switch(randomint(3))
						{
							case 0:
								self.pers["bots"]["class"]["perk3"] = "specialty_extendedmelee";
								self.pers["bots"]["class"]["perk3pro"] = "specialty_falldamage";
							break;
							case 1:
								self.pers["bots"]["class"]["perk3"] = "specialty_bulletaccuracy";
								self.pers["bots"]["class"]["perk3pro"] = "specialty_steelnerves";
							break;
							case 2:
								self.pers["bots"]["class"]["perk3"] = "specialty_heartbreaker";
								self.pers["bots"]["class"]["perk3pro"] = "specialty_quieter";
							break;
						}
						if(self.pers["bots"]["class"]["perk1"] == "specialty_onemanarmy" || (randomint(2) && self.pers["bots"]["class"]["perk1"] == "specialty_scavenger"))
						{
							if(randomint(2))
							{
								self.pers["bots"]["class"]["perk2"] = "specialty_explosivedamage";
								self.pers["bots"]["class"]["perk2pro"] = "specialty_dangerclose";
							}
							else
							{
								self.pers["bots"]["class"]["perk2"] = "specialty_bulletdamage";
								self.pers["bots"]["class"]["perk2pro"] = "specialty_armorpiercing";
							}
							weapon1att = "gl";
							if(!randomint(4))
							{
								self.pers["bots"]["class"]["perk3"] = "specialty_pistoldeath";
								self.pers["bots"]["class"]["perk3pro"] = "specialty_laststandoffhand";
							}
						}
						else
						{
							if(self.pers["bots"]["class"]["perk1"] == "specialty_fastreload" || self.pers["bots"]["class"]["perk1"] == "specialty_scavenger")
							{
								switch(randomint(7))
								{
									case 0:
										weapon1att = "silencer";
									break;
									case 1:
										weapon1att = "reflex";
									break;
									case 2:
										weapon1att = "eotech";
									break;
									case 3:
										weapon1att = "heartbeat";
									break;
									case 4:
										weapon1att = "fmj";
									break;
									case 5:
										weapon1att = "xmags";
									break;
									case 6:
										weapon1att = "gl";
									break;
								}
								if(weapon1att == "silencer" && randomint(2))
								{
									self.pers["bots"]["class"]["perk2"] = "specialty_coldblooded";
									self.pers["bots"]["class"]["perk2pro"] = "specialty_spygame";
								}
								else
								{
									self.pers["bots"]["class"]["perk2"] = "specialty_bulletdamage";
									self.pers["bots"]["class"]["perk2pro"] = "specialty_armorpiercing";
								}
							}
							else
							{
								if(self.pers["bots"]["class"]["perk1"] == "specialty_bling")
								{
									switch(randomint(14))
									{
										case 0:
											weapon1att = "heartbeat";
											weapon1att2 = "reflex";
										break;
										case 1:
											weapon1att = "fmj";
											weapon1att2 = "xmags";
										break;
										case 2:
											weapon1att = "fmj";
											weapon1att2 = "silencer";
										break;
										case 3:
											weapon1att = "fmj";
											weapon1att2 = "reflex";
										break;
										case 4:
											weapon1att = "fmj";
											weapon1att2 = "heartbeat";
										break;
										case 5:
											weapon1att = "eotech";
											weapon1att2 = "xmags";
										break;
										case 6:
											weapon1att = "eotech";
											weapon1att2 = "silencer";
										break;
										case 7:
											weapon1att = "eotech";
											weapon1att2 = "heartbeat";
										break;
										case 8:
											weapon1att = "eotech";
											weapon1att2 = "fmj";
										break;
										case 9:
											weapon1att = "heartbeat";
											weapon1att2 = "silencer";
										break;
										case 10:
											weapon1att = "heartbeat";
											weapon1att2 = "xmags";
										break;
										case 11:
											weapon1att = "reflex";
											weapon1att2 = "silencer";
										break;
										case 12:
											weapon1att = "reflex";
											weapon1att2 = "xmags";
										break;
										case 13:
											weapon1att = "silencer";
											weapon1att2 = "xmags";
										break;
									}
									if((weapon1att == "silencer" || weapon1att2 == "silencer") && randomint(2))
									{
										self.pers["bots"]["class"]["perk2"] = "specialty_coldblooded";
										self.pers["bots"]["class"]["perk2pro"] = "specialty_spygame";
									}
									else
									{
										self.pers["bots"]["class"]["perk2"] = "specialty_bulletdamage";
										self.pers["bots"]["class"]["perk2pro"] = "specialty_armorpiercing";
									}
								}
							}
						}
						if(weapon1 == "riotshield")
						{
							if(randomint(2))
							{
								self.pers["bots"]["class"]["perk1"] = "specialty_scavenger";
								self.pers["bots"]["class"]["perk1pro"] = "specialty_extraammo";
							}
							else
							{
								self.pers["bots"]["class"]["perk1"] = "specialty_fastreload";
								self.pers["bots"]["class"]["perk1pro"] = "specialty_quickdraw";
							}
							if(randomint(2))
							{
								self.pers["bots"]["class"]["perk3"] = "specialty_extendedmelee";
								self.pers["bots"]["class"]["perk3pro"] = "specialty_falldamage";
							}
							else
							{
								if(randomint(3))
								{
									self.pers["bots"]["class"]["perk3"] = "specialty_heartbreaker";
									self.pers["bots"]["class"]["perk3pro"] = "specialty_quieter";
								}
								else
								{
									self.pers["bots"]["class"]["perk3"] = "specialty_pistoldeath";
									self.pers["bots"]["class"]["perk3pro"] = "specialty_laststandoffhand";
								}
							}
							weapon1att = "none";
							weapon1att2 = "none";
						}
						if(weapon1 == "rpd" || weapon1 == "aug" || weapon1 == "sa80")
						{
							self.pers["bots"]["class"]["perk2"] = "specialty_bulletdamage";
							self.pers["bots"]["class"]["perk2pro"] = "specialty_armorpiercing";
							if(self.pers["bots"]["class"]["perk1"] == "specialty_bling")
							{
								switch(randomint(14))
								{
									case 0:
										weapon1att = "eotech";
										weapon1att2 = "grip";
									break;
									case 1:
										weapon1att = "eotech";
										weapon1att2 = "fmj";
									break;
									case 2:
										weapon1att = "eotech";
										weapon1att2 = "xmags";
									break;
									case 3:
										weapon1att = "eotech";
										weapon1att2 = "heartbeat";
									break;
									case 4:
										weapon1att = "fmj";
										weapon1att2 = "grip";
									break;
									case 5:
										weapon1att = "fmj";
										weapon1att2 = "heartbeat";
									break;
									case 6:
										weapon1att = "fmj";
										weapon1att2 = "reflex";
									break;
									case 7:
										weapon1att = "fmj";
										weapon1att2 = "xmags";
									break;
									case 8:
										weapon1att = "grip";
										weapon1att2 = "heartbeat";
									break;
									case 9:
										weapon1att = "grip";
										weapon1att2 = "reflex";
									break;
									case 10:
										weapon1att = "grip";
										weapon1att2 = "xmags";
									break;
									case 11:
										weapon1att = "heartbeat";
										weapon1att2 = "reflex";
									break;
									case 12:
										weapon1att = "heartbeat";
										weapon1att2 = "xmags";
									break;
									case 13:
										weapon1att = "reflex";
										weapon1att2 = "xmags";
									break;
								}
							}
							else
							{
								switch(randomint(6))
								{
									case 0:
										weapon1att = "grip";
									break;
									case 1:
										weapon1att = "xmags";
									break;
									case 2:
										weapon1att = "fmj";
									break;
									case 3:
										weapon1att = "reflex";
									break;
									case 4:
										weapon1att = "eotech";
									break;
									case 5:
										weapon1att = "heartbeat";
									break;
								}
							}
						}
						self.pers["bots"]["class"]["primary"]=maps\mp\gametypes\_class::buildWeaponName(weapon1,weapon1att,weapon1att2);
						if(self.pers["bots"]["class"]["perk1pro"] == "specialty_secondarybling")
						{
							switch(randomint(3))
							{
								case 0:
									if(randomint(2))
										self.pers["bots"]["class"]["secondary"] = "glock_xmags_akimbo_mp";
									else
										self.pers["bots"]["class"]["secondary"] = "glock_silencer_akimbo_mp";
								break;
								case 1:
									switch(randomint(9))
									{
										case 0:
											self.pers["bots"]["class"]["secondary"] = "pp2000_silencer_xmags_mp";
										break;
										case 1:
											self.pers["bots"]["class"]["secondary"] = "pp2000_reflex_xmags_mp";
										break;
										case 2:
											self.pers["bots"]["class"]["secondary"] = "pp2000_reflex_silencer_mp";
										break;
										case 3:
											self.pers["bots"]["class"]["secondary"] = "pp2000_fmj_xmags_mp";
										break;
										case 4:
											self.pers["bots"]["class"]["secondary"] = "pp2000_fmj_silencer_mp";
										break;
										case 5:
											self.pers["bots"]["class"]["secondary"] = "pp2000_fmj_reflex_mp";
										break;
										case 6:
											self.pers["bots"]["class"]["secondary"] = "pp2000_eotech_xmags_mp";
										break;
										case 7:
											self.pers["bots"]["class"]["secondary"] = "pp2000_eotech_silencer_mp";
										break;
										case 8:
											self.pers["bots"]["class"]["secondary"] = "pp2000_eotech_fmj_mp";
										break;
									}
								break;
								case 2:
									switch(randomint(9))
									{
										case 0:
											self.pers["bots"]["class"]["secondary"] = "beretta393_eotech_fmj_mp";
										break;
										case 1:
											self.pers["bots"]["class"]["secondary"] = "beretta393_eotech_silencer_mp";
										break;
										case 2:
											self.pers["bots"]["class"]["secondary"] = "beretta393_eotech_xmags_mp";
										break;
										case 3:
											self.pers["bots"]["class"]["secondary"] = "beretta393_fmj_reflex_mp";
										break;
										case 4:
											self.pers["bots"]["class"]["secondary"] = "beretta393_fmj_silencer_mp";
										break;
										case 5:
											self.pers["bots"]["class"]["secondary"] = "beretta393_fmj_xmags_mp";
										break;
										case 6:
											self.pers["bots"]["class"]["secondary"] = "beretta393_reflex_silencer_mp";
										break;
										case 7:
											self.pers["bots"]["class"]["secondary"] = "beretta393_reflex_xmags_mp";
										break;
										case 8:
											self.pers["bots"]["class"]["secondary"] = "beretta393_silencer_xmags_mp";
										break;
									}
								break;
							}
						}
						else
						{
							switch(randomint(8))
							{
								case 0:
									self.pers["bots"]["class"]["secondary"] = "aa12_xmags_mp";
								break;
								case 1:
									self.pers["bots"]["class"]["secondary"] = "spas12_xmags_mp";
								break;
								case 2:
									self.pers["bots"]["class"]["secondary"] = "stinger_mp";
								break;
								case 3:
									self.pers["bots"]["class"]["secondary"] = "rpg_mp";
								break;
								case 4:
									self.pers["bots"]["class"]["secondary"] = "glock_akimbo_mp";
								break;
								case 5:
									switch(randomint(5))
									{
										case 0:
											self.pers["bots"]["class"]["secondary"] = "beretta393_xmags_mp";
										break;
										case 1:
											self.pers["bots"]["class"]["secondary"] = "beretta393_silencer_mp";
										break;
										case 2:
											self.pers["bots"]["class"]["secondary"] = "beretta393_fmj_mp";
										break;
										case 3:
											self.pers["bots"]["class"]["secondary"] = "beretta393_eotech_mp";
										break;
										case 4:
											self.pers["bots"]["class"]["secondary"] = "beretta393_reflex_mp";
										break;
									}
								break;
								case 6:
									switch(randomint(5))
									{
										case 0:
											self.pers["bots"]["class"]["secondary"] = "pp2000_xmags_mp";
										break;
										case 1:
											self.pers["bots"]["class"]["secondary"] = "pp2000_silencer_mp";
										break;
										case 2:
											self.pers["bots"]["class"]["secondary"] = "pp2000_reflex_mp";
										break;
										case 3:
											self.pers["bots"]["class"]["secondary"] = "pp2000_fmj_mp";
										break;
										case 4:
											self.pers["bots"]["class"]["secondary"] = "pp2000_eotech_mp";
										break;
									}
								break;
								case 7:
									self.pers["bots"]["class"]["secondary"] = "m1014_xmags_mp";
								break;
							}
						}
						if(weapon1 == "riotshield")
						{
							if(isSubStr(self.pers["bots"]["class"]["secondary"], "stinger_"))
							{
								self.pers["bots"]["class"]["secondary"] = "rpg_mp";
							}
							if(isSubStr(self.pers["bots"]["class"]["secondary"], "rpg_")){
								self.pers["bots"]["class"]["perk2"] = "specialty_explosivedamage";
								self.pers["bots"]["class"]["perk2pro"] = "specialty_dangerclose";
							} else {
								if(!randomint(4))
								{
									self.pers["bots"]["class"]["perk2"] = "specialty_coldblooded";
									self.pers["bots"]["class"]["perk2pro"] = "specialty_spygame";
								}
								else
								{
									self.pers["bots"]["class"]["perk2"] = "specialty_bulletdamage";
									self.pers["bots"]["class"]["perk2pro"] = "specialty_armorpiercing";
								}
							}
						}
						switch(randomint(3))
						{
							case 0:
								self.pers["bots"]["class"]["deathPerk"] = "specialty_grenadepulldeath";
							break;
							case 1:
								self.pers["bots"]["class"]["deathPerk"] = "specialty_finalstand";
							break;
							case 2:
								self.pers["bots"]["class"]["deathPerk"] = "specialty_combathigh";
							break;
						}
						if(randomint(2))
							self.pers["bots"]["class"]["grenade"] = "claymore_mp";
						else
							self.pers["bots"]["class"]["grenade"] = "semtex_mp";
							
						if(randomint(2))
							self.pers["bots"]["class"]["offhand"] = "flash_grenade_mp";
						else
							self.pers["bots"]["class"]["offhand"] = "concussion_grenade_mp";
					break;
					case 1://sniper and op perks
						weapon1 = "none";
						weapon1att = "none";
						weapon1att2 = "none";
						switch(randomint(5))
						{
							case 0:
								weapon1 = "famas";
							break;
							case 1:
								weapon1 = "m16";
							break;
							case 2:
								weapon1 = "cheytac";
							break;
							case 3:
								weapon1 = "barrett";
							break;
							case 4:
								weapon1 = "fal";
							break;
						}
						switch(randomint(4))
						{
							case 0:
								self.pers["bots"]["class"]["perk1"] = "specialty_fastreload";
								self.pers["bots"]["class"]["perk1pro"] = "specialty_quickdraw";
							break;
							case 1:
								self.pers["bots"]["class"]["perk1"] = "specialty_scavenger";
								self.pers["bots"]["class"]["perk1pro"] = "specialty_extraammo";
							break;
							case 2:
								self.pers["bots"]["class"]["perk1"] = "specialty_onemanarmy";
								self.pers["bots"]["class"]["perk1pro"] = "specialty_omaquickchange";
							break;
							case 3:
								if(weapon1 == "cheytac" || weapon1 == "barrett")
								{
									self.pers["bots"]["class"]["perk1"] = "specialty_fastreload";
									self.pers["bots"]["class"]["perk1pro"] = "specialty_quickdraw";
								}
								else
								{
									self.pers["bots"]["class"]["perk1"] = "specialty_bling";
									self.pers["bots"]["class"]["perk1pro"] = "specialty_secondarybling";
								}
							break;
						}
						self.pers["bots"]["class"]["perk2"] = "specialty_bulletdamage";
						self.pers["bots"]["class"]["perk2pro"] = "specialty_armorpiercing";
						switch(randomint(3))
						{
							case 0:
								self.pers["bots"]["class"]["perk3"] = "specialty_extendedmelee";
								self.pers["bots"]["class"]["perk3pro"] = "specialty_falldamage";
							break;
							case 1:
								self.pers["bots"]["class"]["perk3"] = "specialty_bulletaccuracy";
								self.pers["bots"]["class"]["perk3pro"] = "specialty_steelnerves";
							break;
							case 2:
								self.pers["bots"]["class"]["perk3"] = "specialty_heartbreaker";
								self.pers["bots"]["class"]["perk3pro"] = "specialty_quieter";
							break;
						}
						if(self.pers["bots"]["class"]["perk1pro"] == "specialty_secondarybling")
						{
							switch(randomint(3))
							{
								case 0:
									if(randomint(2))
										self.pers["bots"]["class"]["secondary"] = "glock_xmags_akimbo_mp";
									else
										self.pers["bots"]["class"]["secondary"] = "glock_silencer_akimbo_mp";
								break;
								case 1:
									switch(randomint(9))
									{
										case 0:
											self.pers["bots"]["class"]["secondary"] = "pp2000_silencer_xmags_mp";
										break;
										case 1:
											self.pers["bots"]["class"]["secondary"] = "pp2000_reflex_xmags_mp";
										break;
										case 2:
											self.pers["bots"]["class"]["secondary"] = "pp2000_reflex_silencer_mp";
										break;
										case 3:
											self.pers["bots"]["class"]["secondary"] = "pp2000_fmj_xmags_mp";
										break;
										case 4:
											self.pers["bots"]["class"]["secondary"] = "pp2000_fmj_silencer_mp";
										break;
										case 5:
											self.pers["bots"]["class"]["secondary"] = "pp2000_fmj_reflex_mp";
										break;
										case 6:
											self.pers["bots"]["class"]["secondary"] = "pp2000_eotech_xmags_mp";
										break;
										case 7:
											self.pers["bots"]["class"]["secondary"] = "pp2000_eotech_silencer_mp";
										break;
										case 8:
											self.pers["bots"]["class"]["secondary"] = "pp2000_eotech_fmj_mp";
										break;
									}
								break;
								case 2:
									switch(randomint(9))
									{
										case 0:
											self.pers["bots"]["class"]["secondary"] = "beretta393_eotech_fmj_mp";
										break;
										case 1:
											self.pers["bots"]["class"]["secondary"] = "beretta393_eotech_silencer_mp";
										break;
										case 2:
											self.pers["bots"]["class"]["secondary"] = "beretta393_eotech_xmags_mp";
										break;
										case 3:
											self.pers["bots"]["class"]["secondary"] = "beretta393_fmj_reflex_mp";
										break;
										case 4:
											self.pers["bots"]["class"]["secondary"] = "beretta393_fmj_silencer_mp";
										break;
										case 5:
											self.pers["bots"]["class"]["secondary"] = "beretta393_fmj_xmags_mp";
										break;
										case 6:
											self.pers["bots"]["class"]["secondary"] = "beretta393_reflex_silencer_mp";
										break;
										case 7:
											self.pers["bots"]["class"]["secondary"] = "beretta393_reflex_xmags_mp";
										break;
										case 8:
											self.pers["bots"]["class"]["secondary"] = "beretta393_silencer_xmags_mp";
										break;
									}
								break;
							}
						}
						else
						{
							switch(randomint(8))
							{
								case 0:
									self.pers["bots"]["class"]["secondary"] = "aa12_xmags_mp";
								break;
								case 1:
									self.pers["bots"]["class"]["secondary"] = "spas12_xmags_mp";
								break;
								case 2:
									self.pers["bots"]["class"]["secondary"] = "stinger_mp";
								break;
								case 3:
									self.pers["bots"]["class"]["secondary"] = "rpg_mp";
								break;
								case 4:
									self.pers["bots"]["class"]["secondary"] = "glock_akimbo_mp";
								break;
								case 5:
									switch(randomint(5))
									{
										case 0:
											self.pers["bots"]["class"]["secondary"] = "beretta393_xmags_mp";
										break;
										case 1:
											self.pers["bots"]["class"]["secondary"] = "beretta393_silencer_mp";
										break;
										case 2:
											self.pers["bots"]["class"]["secondary"] = "beretta393_fmj_mp";
										break;
										case 3:
											self.pers["bots"]["class"]["secondary"] = "beretta393_eotech_mp";
										break;
										case 4:
											self.pers["bots"]["class"]["secondary"] = "beretta393_reflex_mp";
										break;
									}
								break;
								case 6:
									switch(randomint(5))
									{
										case 0:
											self.pers["bots"]["class"]["secondary"] = "pp2000_xmags_mp";
										break;
										case 1:
											self.pers["bots"]["class"]["secondary"] = "pp2000_silencer_mp";
										break;
										case 2:
											self.pers["bots"]["class"]["secondary"] = "pp2000_reflex_mp";
										break;
										case 3:
											self.pers["bots"]["class"]["secondary"] = "pp2000_fmj_mp";
										break;
										case 4:
											self.pers["bots"]["class"]["secondary"] = "pp2000_eotech_mp";
										break;
									}
								break;
								case 7:
									self.pers["bots"]["class"]["secondary"] = "m1014_xmags_mp";
								break;
							}
						}
						if(randomint(2))
							self.pers["bots"]["class"]["grenade"] = "claymore_mp";
						else
							self.pers["bots"]["class"]["grenade"] = "semtex_mp";
						
						if(randomint(2))
							self.pers["bots"]["class"]["offhand"] = "flash_grenade_mp";
						else
							self.pers["bots"]["class"]["offhand"] = "concussion_grenade_mp";
							
						if(weapon1 == "m16" || weapon1 == "fal")
						{
							if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
								weapon1att = "eotech";
							else
							{
								weapon1att = "eotech";
								switch(randomint(4))
								{
									case 1:
										weapon1att2 = "heartbeat";
									break;
									case 0:
										weapon1att2 = "silencer";
									break;
									case 2:
										weapon1att2 = "xmags";
									break;
									case 3:
										weapon1att2 = "fmj";
									break;
								}
							}
							if(weapon1 == "fal" && randomint(2))
							{
								self.pers["bots"]["class"]["perk2"] = "specialty_hardline";
								self.pers["bots"]["class"]["perk2pro"] = "specialty_rollover";
							}
						}
						else
						{
							if(weapon1 == "famas")
							{
								if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
								{
									switch(randomint(6))
									{
										case 0:
											weapon1att = "reflex";
										break;
										case 1:
											weapon1att = "eotech";
										break;
										case 2:
											weapon1att = "silencer";
										break;
										case 3:
											weapon1att = "fmj";
										break;
										case 4:
											weapon1att = "xmags";
										break;
										case 5:
											weapon1att = "heartbeat";
										break;
									}
								}
								else
								{
									switch(randomint(14))
									{
										case 0:
											weapon1att = "heartbeat";
											weapon1att2 = "reflex";
										break;
										case 1:
											weapon1att = "fmj";
											weapon1att2 = "xmags";
										break;
										case 2:
											weapon1att = "fmj";
											weapon1att2 = "silencer";
										break;
										case 3:
											weapon1att = "fmj";
											weapon1att2 = "reflex";
										break;
										case 4:
											weapon1att = "fmj";
											weapon1att2 = "heartbeat";
										break;
										case 5:
											weapon1att = "eotech";
											weapon1att2 = "xmags";
										break;
										case 6:
											weapon1att = "eotech";
											weapon1att2 = "silencer";
										break;
										case 7:
											weapon1att = "eotech";
											weapon1att2 = "heartbeat";
										break;
										case 8:
											weapon1att = "eotech";
											weapon1att2 = "fmj";
										break;
										case 9:
											weapon1att = "heartbeat";
											weapon1att2 = "silencer";
										break;
										case 10:
											weapon1att = "heartbeat";
											weapon1att2 = "xmags";
										break;
										case 11:
											weapon1att = "reflex";
											weapon1att2 = "silencer";
										break;
										case 12:
											weapon1att = "reflex";
											weapon1att2 = "xmags";
										break;
										case 13:
											weapon1att = "silencer";
											weapon1att2 = "xmags";
										break;
									}
								}
							}
							else
							{
								if(randomint(2))
									weapon1att = "fmj";
								else
									weapon1att = "xmags";
									
								if(!randomint(3))
								{
									if(randomint(2))
										self.pers["bots"]["class"]["grenade"] = "specialty_tacticalinsertion";
									else
										self.pers["bots"]["class"]["grenade"] = "throwingknife_mp";
								}
								if(randomint(3))
								{
									switch(randomint(5))
									{
										case 0:
											switch(randomint(5))
											{
												case 0:
													self.pers["bots"]["class"]["secondary"] = "beretta393_xmags_mp";
												break;
												case 1:
													self.pers["bots"]["class"]["secondary"] = "beretta393_silencer_mp";
												break;
												case 2:
													self.pers["bots"]["class"]["secondary"] = "beretta393_fmj_mp";
												break;
												case 3:
													self.pers["bots"]["class"]["secondary"] = "beretta393_eotech_mp";
												break;
												case 4:
													self.pers["bots"]["class"]["secondary"] = "beretta393_reflex_mp";
												break;
											}
										break;
										case 1:
											switch(randomint(5))
											{
												case 0:
													self.pers["bots"]["class"]["secondary"] = "usp_akimbo_mp";
												break;
												case 1:
													self.pers["bots"]["class"]["secondary"] = "usp_xmags_mp";
												break;
												case 2:
													self.pers["bots"]["class"]["secondary"] = "usp_tactical_mp";
												break;
												case 3:
													self.pers["bots"]["class"]["secondary"] = "usp_fmj_mp";
												break;
												case 4:
													self.pers["bots"]["class"]["secondary"] = "usp_silencer_mp";
												break;
											}
										break;
										case 2:
											switch(randomint(5))
											{
												case 0:
													self.pers["bots"]["class"]["secondary"] = "beretta_akimbo_mp";
												break;
												case 1:
													self.pers["bots"]["class"]["secondary"] = "beretta_xmags_mp";
												break;
												case 2:
													self.pers["bots"]["class"]["secondary"] = "beretta_tactical_mp";
												break;
												case 3:
													self.pers["bots"]["class"]["secondary"] = "beretta_fmj_mp";
												break;
												case 4:
													self.pers["bots"]["class"]["secondary"] = "beretta_silencer_mp";
												break;
											}
										break;
										case 3:
											switch(randomint(3))
											{
												case 0:
													self.pers["bots"]["class"]["secondary"] = "coltanaconda_fmj_mp";
												break;
												case 1:
													self.pers["bots"]["class"]["secondary"] = "coltanaconda_tactical_mp";
												break;
												case 2:
													self.pers["bots"]["class"]["secondary"] = "coltanaconda_akimbo_mp";
												break;
											}
										break;
										case 4:
											switch(randomint(4))
											{
												case 0:
													self.pers["bots"]["class"]["secondary"] = "deserteaglegold_mp";
												break;
												case 1:
													self.pers["bots"]["class"]["secondary"] = "deserteagle_akimbo_mp";
												break;
												case 2:
													self.pers["bots"]["class"]["secondary"] = "deserteagle_tactical_mp";
												break;
												case 3:
													self.pers["bots"]["class"]["secondary"] = "deserteagle_fmj_mp";
												break;
											}
										break;
									}
								}
							}
						}
						self.pers["bots"]["class"]["primary"]=maps\mp\gametypes\_class::buildWeaponName(weapon1,weapon1att,weapon1att2);
						switch(randomint(3))
						{
							case 0:
								self.pers["bots"]["class"]["deathPerk"] = "specialty_grenadepulldeath";
							break;
							case 1:
								self.pers["bots"]["class"]["deathPerk"] = "specialty_finalstand";
							break;
							case 2:
								self.pers["bots"]["class"]["deathPerk"] = "specialty_combathigh";
							break;
						}
					break;
					case 2:
						weapon1 = "none";
						weapon1att = "none";
						weapon1att2 = "none";
						if(randomint(2))
							self.pers["bots"]["class"]["grenade"] = "claymore_mp";
						else
							self.pers["bots"]["class"]["grenade"] = "semtex_mp";
							
						switch(randomint(3))
						{
							case 0:
								self.pers["bots"]["class"]["deathPerk"] = "specialty_grenadepulldeath";
							break;
							case 1:
								self.pers["bots"]["class"]["deathPerk"] = "specialty_finalstand";
							break;
							case 2:
								self.pers["bots"]["class"]["deathPerk"] = "specialty_combathigh";
							break;
						}
						if(randomint(2))
							self.pers["bots"]["class"]["offhand"] = "flash_grenade_mp";
						else
							self.pers["bots"]["class"]["offhand"] = "concussion_grenade_mp";
							
						switch(randomint(5))
						{
							case 0:
								self.pers["bots"]["class"]["perk1"] = "specialty_marathon";
								self.pers["bots"]["class"]["perk1pro"] = "specialty_fastmantle";
							break;
							case 1:
								self.pers["bots"]["class"]["perk1"] = "specialty_bling";
								self.pers["bots"]["class"]["perk1pro"] = "specialty_secondarybling";
							break;
							case 2:
								self.pers["bots"]["class"]["perk1"] = "specialty_scavenger";
								self.pers["bots"]["class"]["perk1pro"] = "specialty_extraammo";
							break;
							case 3:
								self.pers["bots"]["class"]["perk1"] = "specialty_fastreload";
								self.pers["bots"]["class"]["perk1pro"] = "specialty_quickdraw";
							break;
							case 4:
								self.pers["bots"]["class"]["perk1"] = "specialty_onemanarmy";
								self.pers["bots"]["class"]["perk1pro"] = "specialty_omaquickchange";
							break;
						}
						if(randomint(2))
						{
							self.pers["bots"]["class"]["perk3"] = "specialty_extendedmelee";
							self.pers["bots"]["class"]["perk3pro"] = "specialty_falldamage";
						}
						else
						{
							self.pers["bots"]["class"]["perk3"] = "specialty_heartbreaker";
							self.pers["bots"]["class"]["perk3pro"] = "specialty_quieter";
						}
						if(self.pers["bots"]["class"]["perk1pro"] == "specialty_secondarybling")
						{
							switch(randomint(3))
							{
								case 0:
									if(randomint(2))
										self.pers["bots"]["class"]["secondary"] = "glock_xmags_akimbo_mp";
									else
										self.pers["bots"]["class"]["secondary"] = "glock_silencer_akimbo_mp";
								break;
								case 1:
									switch(randomint(9))
									{
										case 0:
											self.pers["bots"]["class"]["secondary"] = "pp2000_silencer_xmags_mp";
										break;
										case 1:
											self.pers["bots"]["class"]["secondary"] = "pp2000_reflex_xmags_mp";
										break;
										case 2:
											self.pers["bots"]["class"]["secondary"] = "pp2000_reflex_silencer_mp";
										break;
										case 3:
											self.pers["bots"]["class"]["secondary"] = "pp2000_fmj_xmags_mp";
										break;
										case 4:
											self.pers["bots"]["class"]["secondary"] = "pp2000_fmj_silencer_mp";
										break;
										case 5:
											self.pers["bots"]["class"]["secondary"] = "pp2000_fmj_reflex_mp";
										break;
										case 6:
											self.pers["bots"]["class"]["secondary"] = "pp2000_eotech_xmags_mp";
										break;
										case 7:
											self.pers["bots"]["class"]["secondary"] = "pp2000_eotech_silencer_mp";
										break;
										case 8:
											self.pers["bots"]["class"]["secondary"] = "pp2000_eotech_fmj_mp";
										break;
									}
								break;
								case 2:
									switch(randomint(9))
									{
										case 0:
											self.pers["bots"]["class"]["secondary"] = "beretta393_eotech_fmj_mp";
										break;
										case 1:
											self.pers["bots"]["class"]["secondary"] = "beretta393_eotech_silencer_mp";
										break;
										case 2:
											self.pers["bots"]["class"]["secondary"] = "beretta393_eotech_xmags_mp";
										break;
										case 3:
											self.pers["bots"]["class"]["secondary"] = "beretta393_fmj_reflex_mp";
										break;
										case 4:
											self.pers["bots"]["class"]["secondary"] = "beretta393_fmj_silencer_mp";
										break;
										case 5:
											self.pers["bots"]["class"]["secondary"] = "beretta393_fmj_xmags_mp";
										break;
										case 6:
											self.pers["bots"]["class"]["secondary"] = "beretta393_reflex_silencer_mp";
										break;
										case 7:
											self.pers["bots"]["class"]["secondary"] = "beretta393_reflex_xmags_mp";
										break;
										case 8:
											self.pers["bots"]["class"]["secondary"] = "beretta393_silencer_xmags_mp";
										break;
									}
								break;
							}
						}
						else
						{
							switch(randomint(8))
							{
								case 0:
									self.pers["bots"]["class"]["secondary"] = "aa12_xmags_mp";
								break;
								case 1:
									self.pers["bots"]["class"]["secondary"] = "spas12_xmags_mp";
								break;
								case 2:
									self.pers["bots"]["class"]["secondary"] = "stinger_mp";
								break;
								case 3:
									self.pers["bots"]["class"]["secondary"] = "rpg_mp";
								break;
								case 4:
									self.pers["bots"]["class"]["secondary"] = "glock_akimbo_mp";
								break;
								case 5:
									switch(randomint(5))
									{
										case 0:
											self.pers["bots"]["class"]["secondary"] = "beretta393_xmags_mp";
										break;
										case 1:
											self.pers["bots"]["class"]["secondary"] = "beretta393_silencer_mp";
										break;
										case 2:
											self.pers["bots"]["class"]["secondary"] = "beretta393_fmj_mp";
										break;
										case 3:
											self.pers["bots"]["class"]["secondary"] = "beretta393_eotech_mp";
										break;
										case 4:
											self.pers["bots"]["class"]["secondary"] = "beretta393_reflex_mp";
										break;
									}
								break;
								case 6:
									switch(randomint(5))
									{
										case 0:
											self.pers["bots"]["class"]["secondary"] = "pp2000_xmags_mp";
										break;
										case 1:
											self.pers["bots"]["class"]["secondary"] = "pp2000_silencer_mp";
										break;
										case 2:
											self.pers["bots"]["class"]["secondary"] = "pp2000_reflex_mp";
										break;
										case 3:
											self.pers["bots"]["class"]["secondary"] = "pp2000_fmj_mp";
										break;
										case 4:
											self.pers["bots"]["class"]["secondary"] = "pp2000_eotech_mp";
										break;
									}
								break;
								case 7:
									self.pers["bots"]["class"]["secondary"] = "m1014_xmags_mp";
								break;
							}
						}
						if(self.pers["bots"]["class"]["perk1"] == "specialty_marathon")
						{
							switch(randomint(3))
							{
								case 0:
									self.pers["bots"]["class"]["perk2"] = "specialty_bulletdamage";
									self.pers["bots"]["class"]["perk2pro"] = "specialty_armorpiercing";
								break;
								case 1:
									self.pers["bots"]["class"]["perk2"] = "specialty_coldblooded";
									self.pers["bots"]["class"]["perk2pro"] = "specialty_spygame";
								break;
								case 2:
									self.pers["bots"]["class"]["perk2"] = "specialty_lightweight";
									self.pers["bots"]["class"]["perk2pro"] = "specialty_fastsprintrecovery";
								break;
							}
							if(self.pers["bots"]["class"]["perk2"] == "specialty_lightweight" || self.pers["bots"]["class"]["perk2"] == "specialty_coldblooded")
							{
								weapon1 = "ump45";
								weapon1att = "silencer";
								switch(randomint(6))
								{
									case 0:
										switch(randomint(3))
										{
											case 0:
												self.pers["bots"]["class"]["secondary"] = "usp_akimbo_mp";
											break;
											case 1:
												self.pers["bots"]["class"]["secondary"] = "usp_tactical_mp";
											break;
											case 2:
												self.pers["bots"]["class"]["secondary"] = "usp_fmj_mp";
											break;
										}
									break;
									case 1:
										self.pers["bots"]["class"]["secondary"] = "coltanaconda_tactical_mp";
									break;
									case 2:
										self.pers["bots"]["class"]["secondary"] = "deserteagle_tactical_mp";
									break;
									case 3:
										self.pers["bots"]["class"]["secondary"] = "beretta_tactical_mp";
									break;
									case 4:
										self.pers["bots"]["class"]["secondary"] = "m1014_xmags_mp";
									break;
									case 5:
										self.pers["bots"]["class"]["secondary"] = "spas12_xmags_mp";
									break;
								}
								if(!randomint(3))
								{
									if(randomint(2))
										self.pers["bots"]["class"]["grenade"] = "specialty_tacticalinsertion";
									else
										self.pers["bots"]["class"]["grenade"] = "throwingknife_mp";
								}
								if(!randomint(3))
									self.pers["bots"]["class"]["offhand"] = "smoke_mp";
							}
							else
							{
								switch(randomint(4))
								{
									case 0:
										weapon1 = "ump45";
									break;
									case 1:
										weapon1 = "p90";
									break;
									case 2:
										weapon1 = "mp5k";
									break;
									case 3:
										weapon1 = "kriss";
									break;
								}
								if(weapon1 == "ump45")
								{
									if(randomint(2))
										weapon1att = "silencer";
									else
										weapon1att = "fmj";
								}
								else
								{
									switch(randomint(6))
									{
										case 0:
											weapon1att = "silencer";
										break;
										case 1:
											weapon1att = "rof";
										break;
										case 2:
											weapon1att = "eotech";
										break;
										case 3:
											weapon1att = "xmags";
										break;
										case 4:
											weapon1att = "fmj";
										break;
										case 5:
											weapon1att = "reflex";
										break;
									}
								}
							}
						}
						else
						{
							if(self.pers["bots"]["class"]["perk1"] == "specialty_scavenger" || self.pers["bots"]["class"]["perk1"] == "specialty_fastreload" || self.pers["bots"]["class"]["perk1"] == "specialty_onemanarmy")
							{
								switch(randomint(4))
								{
									case 0:
										weapon1 = "ump45";
									break;
									case 1:
										weapon1 = "p90";
									break;
									case 2:
										weapon1 = "mp5k";
									break;
									case 3:
										weapon1 = "kriss";
									break;
								}
								if(weapon1 == "ump45")
								{
									if(randomint(2))
										weapon1att = "silencer";
									else
										weapon1att = "fmj";
								}
								else
								{
									switch(randomint(6))
									{
										case 0:
											weapon1att = "silencer";
										break;
										case 1:
											weapon1att = "rof";
										break;
										case 2:
											weapon1att = "eotech";
										break;
										case 3:
											weapon1att = "xmags";
										break;
										case 4:
											weapon1att = "fmj";
										break;
										case 5:
											weapon1att = "reflex";
										break;
									}
								}
								if(weapon1att == "silencer" && randomint(2))
								{
									self.pers["bots"]["class"]["perk2"] = "specialty_coldblooded";
									self.pers["bots"]["class"]["perk2pro"] = "specialty_spygame";
								}
								else
								{
									self.pers["bots"]["class"]["perk2"] = "specialty_bulletdamage";
									self.pers["bots"]["class"]["perk2pro"] = "specialty_armorpiercing";
								}
							}
							else
							{
								if(self.pers["bots"]["class"]["perk1"] == "specialty_bling")
								{
									switch(randomint(4))
									{
										case 0:
											weapon1 = "ump45";
										break;
										case 1:
											weapon1 = "p90";
										break;
										case 2:
											weapon1 = "mp5k";
										break;
										case 3:
											weapon1 = "kriss";
										break;
									}
									if(weapon1 == "ump45")
									{
										weapon1att = "fmj";
										weapon1att2 = "silencer";
									}
									else
									{
										switch(randomint(14))
										{
											case 0:
												weapon1att = "eotech";
												weapon1att2 = "fmj";
											break;
											case 1:
												weapon1att = "eotech";
												weapon1att2 = "rof";
											break;
											case 2:
												weapon1att = "eotech";
												weapon1att2 = "silencer";
											break;
											case 3:
												weapon1att = "eotech";
												weapon1att2 = "xmags";
											break;
											case 4:
												weapon1att = "fmj";
												weapon1att2 = "reflex";
											break;
											case 5:
												weapon1att = "fmj";
												weapon1att2 = "rof";
											break;
											case 6:
												weapon1att = "fmj";
												weapon1att2 = "silencer";
											break;
											case 7:
												weapon1att = "fmj";
												weapon1att2 = "xmags";
											break;
											case 8:
												weapon1att = "reflex";
												weapon1att2 = "rof";
											break;
											case 9:
												weapon1att = "reflex";
												weapon1att2 = "silencer";
											break;
											case 10:
												weapon1att = "reflex";
												weapon1att2 = "xmags";
											break;
											case 11:
												weapon1att = "rof";
												weapon1att2 = "xmags";
											break;
											case 12:
												weapon1att = "rof";
												weapon1att2 = "silencer";
											break;
											case 13:
												weapon1att = "silencer";
												weapon1att2 = "xmags";
											break;
										}
									}
									if((weapon1att == "silencer" || weapon1att2 == "silencer") && randomint(2))
									{
										self.pers["bots"]["class"]["perk2"] = "specialty_coldblooded";
										self.pers["bots"]["class"]["perk2pro"] = "specialty_spygame";
									}
									else
									{
										self.pers["bots"]["class"]["perk2"] = "specialty_bulletdamage";
										self.pers["bots"]["class"]["perk2pro"] = "specialty_armorpiercing";
									}
								}
							}
						}
						
						self.pers["bots"]["class"]["primary"]=maps\mp\gametypes\_class::buildWeaponName(weapon1,weapon1att,weapon1att2);
					break;
				}
			break;
			case "level":
				rankID = self maps\mp\gametypes\_rank::getRankForXp( self getPlayerData( "experience" ) );
				if(rankID >= 3)
				{
					while(self.pers["bots"]["class"]["deathPerk"] == "")
					{
						switch(randomint(4))
						{
							case 0:
								if(self isItemUnlocked("specialty_grenadepulldeath"))
									self.pers["bots"]["class"]["deathPerk"] = "specialty_grenadepulldeath";
							break;
							case 1:
								if(self isItemUnlocked("specialty_finalstand"))
									self.pers["bots"]["class"]["deathPerk"] = "specialty_finalstand";
							break;
							case 2:
								if(self isItemUnlocked("specialty_copycat"))
									self.pers["bots"]["class"]["deathPerk"] = "specialty_copycat";
							break;
							case 3:
								if(self isItemUnlocked("specialty_combathigh"))
									self.pers["bots"]["class"]["deathPerk"] = "specialty_combathigh";
							break;
						}
					}
					
					while(self.pers["bots"]["class"]["grenade"] == "")
					{
						switch(randomint(7))
						{
							case 0:
								if(self isItemUnlocked("frag_grenade_mp"))
									self.pers["bots"]["class"]["grenade"] = "frag_grenade_mp";
							break;
							case 1:
								if(self isItemUnlocked("semtex_mp"))
									self.pers["bots"]["class"]["grenade"] = "semtex_mp";
							break;
							case 2:
								if(self isItemUnlocked("claymore_mp"))
									self.pers["bots"]["class"]["grenade"] = "claymore_mp";
							break;
							case 3:
								if(self isItemUnlocked("throwingknife_mp"))
									self.pers["bots"]["class"]["grenade"] = "throwingknife_mp";
							break;
							case 4:
								if(self isItemUnlocked("specialty_tacticalinsertion"))
									self.pers["bots"]["class"]["grenade"] = "specialty_tacticalinsertion";
							break;
							case 5:
								if(self isItemUnlocked("specialty_blastshield"))
									self.pers["bots"]["class"]["grenade"] = "specialty_blastshield";
							break;
							case 6:
								if(self isItemUnlocked("c4_mp"))
									self.pers["bots"]["class"]["grenade"] = "c4_mp";
							break;
						}
					}
					
					switch(randomint(3))
					{
						case 0:
							self.pers["bots"]["class"]["offhand"] = "flash_grenade_mp";
						break;
						case 1:
							self.pers["bots"]["class"]["offhand"] = "concussion_grenade_mp";
						break;
						case 2:
							self.pers["bots"]["class"]["offhand"] = "smoke_grenade_mp";
						break;
					}
					
					while(self.pers["bots"]["class"]["perk1"] == "")
					{
						switch(randomint(10))
						{
							case 0:
								if(self isItemUnlocked("specialty_marathon"))
									self.pers["bots"]["class"]["perk1"] = "specialty_marathon";
							break;
							case 1:
								if(self isItemUnlocked("specialty_fastreload"))
									self.pers["bots"]["class"]["perk1"] = "specialty_fastreload";
							break;
							case 2:
								if(self isItemUnlocked("specialty_scavenger"))
								{
									self.pers["bots"]["class"]["perk1"] = "specialty_scavenger";
									self.pers["bots"]["class"]["perk1pro"] = "specialty_extraammo";
								}
							break;
							case 3:
								if(self isItemUnlocked("specialty_onemanarmy"))
								{
									self.pers["bots"]["class"]["perk1"] = "specialty_onemanarmy";
									self.pers["bots"]["class"]["perk1pro"] = "specialty_omaquickchange";
								}
							break;
							case 4:
								if(self isItemUnlocked("specialty_onemanarmy"))
									self.pers["bots"]["class"]["perk1"] = "specialty_onemanarmy";
							break;
							case 5:
								if(self isItemUnlocked("specialty_onemanarmy"))
								{
									self.pers["bots"]["class"]["perk1"] = "specialty_bling";
									self.pers["bots"]["class"]["perk1pro"] = "specialty_secondarybling";
								}
							break;
							case 6:
								if(self isItemUnlocked("specialty_bling"))
									self.pers["bots"]["class"]["perk1"] = "specialty_bling";
							break;
							case 7:
								if(self isItemUnlocked("specialty_scavenger"))
									self.pers["bots"]["class"]["perk1"] = "specialty_scavenger";
							break;
							case 8:
								if(self isItemUnlocked("specialty_fastreload"))
								{
									self.pers["bots"]["class"]["perk1"] = "specialty_fastreload";
									self.pers["bots"]["class"]["perk1pro"] = "specialty_quickdraw";
								}
							break;
							case 9:
								if(self isItemUnlocked("specialty_marathon"))
								{
									self.pers["bots"]["class"]["perk1"] = "specialty_marathon";
									self.pers["bots"]["class"]["perk1pro"] = "specialty_fastmantle";
								}
							break;
						}
					}
					
					while(self.pers["bots"]["class"]["perk2"] == "")
					{
						switch(randomint(10))
						{
							case 0:
								if(self isItemUnlocked("specialty_bulletdamage"))
									self.pers["bots"]["class"]["perk2"] = "specialty_bulletdamage";
							break;
							case 1:
								if(self isItemUnlocked("specialty_bulletdamage"))
								{
									self.pers["bots"]["class"]["perk2"] = "specialty_bulletdamage";
									self.pers["bots"]["class"]["perk2pro"] = "specialty_armorpiercing";
								}
							break;
							case 2:
								if(self isItemUnlocked("specialty_lightweight"))
									self.pers["bots"]["class"]["perk2"] = "specialty_lightweight";
							break;
							case 3:
								if(self isItemUnlocked("specialty_lightweight"))
								{
									self.pers["bots"]["class"]["perk2"] = "specialty_lightweight";
									self.pers["bots"]["class"]["perk2pro"] = "specialty_fastsprintrecovery";
								}
							break;
							case 4:
								if(self isItemUnlocked("specialty_hardline"))
									self.pers["bots"]["class"]["perk2"] = "specialty_hardline";
							break;
							case 5:
								if(self isItemUnlocked("specialty_hardline"))
								{
									self.pers["bots"]["class"]["perk2"] = "specialty_hardline";
									self.pers["bots"]["class"]["perk2pro"] = "specialty_rollover";
								}
							break;
							case 6:
								if(self isItemUnlocked("specialty_coldblooded"))
									self.pers["bots"]["class"]["perk2"] = "specialty_coldblooded";
							break;
							case 7:
								if(self isItemUnlocked("specialty_coldblooded"))
								{
									self.pers["bots"]["class"]["perk2"] = "specialty_coldblooded";
									self.pers["bots"]["class"]["perk2pro"] = "specialty_spygame";
								}
							break;
							case 8:
								if(self isItemUnlocked("specialty_explosivedamage"))
									self.pers["bots"]["class"]["perk2"] = "specialty_explosivedamage";
							break;
							case 9:
								if(self isItemUnlocked("specialty_explosivedamage"))
								{
									self.pers["bots"]["class"]["perk2"] = "specialty_explosivedamage";
									self.pers["bots"]["class"]["perk2pro"] = "specialty_dangerclose";
								}
							break;
						}
					}
			
					while(self.pers["bots"]["class"]["perk3"] == "")
					{
						switch(randomint(12))
						{
							case 0:
								if(self isItemUnlocked("specialty_pistoldeath"))
								{
									self.pers["bots"]["class"]["perk3"] = "specialty_pistoldeath";
									self.pers["bots"]["class"]["perk3pro"] = "specialty_laststandoffhand";
								}
							break;
							case 1:
								if(self isItemUnlocked("specialty_detectexplosive"))
								{
									self.pers["bots"]["class"]["perk3"] = "specialty_detectexplosive";
									self.pers["bots"]["class"]["perk3pro"] = "specialty_selectivehearing";
								}
							break;
							case 2:
								if(self isItemUnlocked("specialty_heartbreaker"))
								{
									self.pers["bots"]["class"]["perk3"] = "specialty_heartbreaker";
									self.pers["bots"]["class"]["perk3pro"] = "specialty_quieter";
								}
							break;
							case 3:
								if(self isItemUnlocked("specialty_localjammer"))
								{
									self.pers["bots"]["class"]["perk3"] = "specialty_localjammer";
									self.pers["bots"]["class"]["perk3pro"] = "specialty_delaymine";
								}
							break;
							case 4:
								if(self isItemUnlocked("specialty_bulletaccuracy"))
								{
									self.pers["bots"]["class"]["perk3"] = "specialty_bulletaccuracy";
									self.pers["bots"]["class"]["perk3pro"] = "specialty_steelnerves";
								}
							break;
							case 5:
								if(self isItemUnlocked("specialty_extendedmelee"))
								{
									self.pers["bots"]["class"]["perk3"] = "specialty_extendedmelee";
									self.pers["bots"]["class"]["perk3pro"] = "specialty_falldamage";
								}
							break;
							case 6:
								if(self isItemUnlocked("specialty_pistoldeath"))
									self.pers["bots"]["class"]["perk3"] = "specialty_pistoldeath";
							break;
							case 7:
								if(self isItemUnlocked("specialty_detectexplosive"))
									self.pers["bots"]["class"]["perk3"] = "specialty_detectexplosive";
							break;
							case 8:
								if(self isItemUnlocked("specialty_heartbreaker"))
									self.pers["bots"]["class"]["perk3"] = "specialty_heartbreaker";
							break;
							case 9:
								if(self isItemUnlocked("specialty_localjammer"))
									self.pers["bots"]["class"]["perk3"] = "specialty_localjammer";
							break;
							case 10:
								if(self isItemUnlocked("specialty_bulletaccuracy"))
									self.pers["bots"]["class"]["perk3"] = "specialty_bulletaccuracy";
							break;
							case 11:
								if(self isItemUnlocked("specialty_extendedmelee"))
									self.pers["bots"]["class"]["perk3"] = "specialty_extendedmelee";
							break;
						}
					}
					
					while(self.pers["bots"]["class"]["primary"] == "")
					{
						switch(randomint(24))
						{
							case 0:
								if(self isItemUnlocked("mp5k"))
								{
									weap = Weapon_MP5K();
									if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
										weap[2] = "none";
									self.pers["bots"]["class"]["primary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
								}
							break;
							case 1:
								if(self isItemUnlocked("uzi"))
								{
									weap = Weapon_UZI();
									if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
										weap[2] = "none";
									self.pers["bots"]["class"]["primary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
								}
							break;
							case 2:
								if(self isItemUnlocked("p90"))
								{
									weap = Weapon_P90();
									if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
										weap[2] = "none";
									self.pers["bots"]["class"]["primary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
								}
							break;
							case 3:
								if(self isItemUnlocked("kriss"))
								{
									weap = Weapon_Kriss();
									if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
										weap[2] = "none";
									self.pers["bots"]["class"]["primary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
								}
							break;
							case 4:
								if(self isItemUnlocked("ump45"))
								{
									weap = Weapon_UMP45();
									if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
										weap[2] = "none";
									self.pers["bots"]["class"]["primary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
								}
							break;
							case 5:
								if(self isItemUnlocked("ak47"))
								{
									weap = Weapon_AK47();
									if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
										weap[2] = "none";
									self.pers["bots"]["class"]["primary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
								}
							break;
							case 6:
								if(self isItemUnlocked("m16"))
								{
									weap = Weapon_M16();
									if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
										weap[2] = "none";
									self.pers["bots"]["class"]["primary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
								}
							break;
							case 7:
								if(self isItemUnlocked("m4"))
								{
									weap = Weapon_M4();
									if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
										weap[2] = "none";
									self.pers["bots"]["class"]["primary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
								}
							break;
							case 8:
								if(self isItemUnlocked("fn2000"))
								{
									weap = Weapon_FN2000();
									if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
										weap[2] = "none";
									self.pers["bots"]["class"]["primary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
								}
							break;
							case 9:
								if(self isItemUnlocked("masada"))
								{
									weap = Weapon_Masada();
									if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
										weap[2] = "none";
									self.pers["bots"]["class"]["primary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
								}
							break;
							case 10:
								if(self isItemUnlocked("famas"))
								{
									weap = Weapon_Famas();
									if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
										weap[2] = "none";
									self.pers["bots"]["class"]["primary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
								}
							break;
							case 11:
								if(self isItemUnlocked("fal"))
								{
									weap = Weapon_Fal();
									if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
										weap[2] = "none";
									self.pers["bots"]["class"]["primary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
								}
							break;
							case 12:
								if(self isItemUnlocked("scar"))
								{
									weap = Weapon_Scar();
									if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
										weap[2] = "none";
									self.pers["bots"]["class"]["primary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
								}
							break;
							case 13:
								if(self isItemUnlocked("tavor"))
								{
									weap = Weapon_Tavor();
									if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
										weap[2] = "none";
									self.pers["bots"]["class"]["primary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
								}
							break;
							case 14:
								if(self isItemUnlocked("barrett"))
								{
									weap = Weapon_Barrett();
									if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
										weap[2] = "none";
									self.pers["bots"]["class"]["primary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
								}
							break;
							case 15:
								if(self isItemUnlocked("wa2000"))
								{
									weap = Weapon_WA2000();
									if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
										weap[2] = "none";
									self.pers["bots"]["class"]["primary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
								}
							break;
							case 16:
								if(self isItemUnlocked("m21"))
								{
									weap = Weapon_M21();
									if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
										weap[2] = "none";
									self.pers["bots"]["class"]["primary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
								}
							break;
							case 17:
								if(self isItemUnlocked("cheytac"))
								{
									weap = Weapon_Cheytac();
									if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
										weap[2] = "none";
									self.pers["bots"]["class"]["primary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
								}
							break;
							case 18:
								if(self isItemUnlocked("rpd"))
								{
									weap = Weapon_RPD();
									if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
										weap[2] = "none";
									self.pers["bots"]["class"]["primary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
								}
							break;
							case 19:
								if(self isItemUnlocked("sa80"))
								{
									weap = Weapon_Sa80();
									if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
										weap[2] = "none";
									self.pers["bots"]["class"]["primary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
								}
							break;
							case 20:
								if(self isItemUnlocked("mg4"))
								{
									weap = Weapon_MG4();
									if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
										weap[2] = "none";
									self.pers["bots"]["class"]["primary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
								}
							break;
							case 21:
								if(self isItemUnlocked("m240"))
								{
									weap = Weapon_M240();
									if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
										weap[2] = "none";
									self.pers["bots"]["class"]["primary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
								}
							break;
							case 22:
								if(self isItemUnlocked("aug"))
								{
									weap = Weapon_AUG();
									if(self.pers["bots"]["class"]["perk1"] != "specialty_bling")
										weap[2] = "none";
									self.pers["bots"]["class"]["primary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
								}
							break;
							case 23:
								if(self isItemUnlocked("riotshield"))
									self.pers["bots"]["class"]["primary"] = "riotshield_mp";
							break;
						}
					}
					
					while(self.pers["bots"]["class"]["secondary"] == "")
					{
						switch(randomint(19))
						{
							case 0:
								if(self isItemUnlocked("ranger"))
								{
									weap = Weapon_Ranger();
									if(self.pers["bots"]["class"]["perk1pro"] != "specialty_secondarybling")
										weap[2] = "none";
									self.pers["bots"]["class"]["secondary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
								}
							break;
							case 1:
								if(self isItemUnlocked("model1887"))
								{
									weap = Weapon_Model1887();
									if(self.pers["bots"]["class"]["perk1pro"] != "specialty_secondarybling")
										weap[2] = "none";
									self.pers["bots"]["class"]["secondary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
								}
							break;
							case 2:
								if(self isItemUnlocked("striker"))
								{
									weap = Weapon_Striker();
									if(self.pers["bots"]["class"]["perk1pro"] != "specialty_secondarybling")
										weap[2] = "none";
									self.pers["bots"]["class"]["secondary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
								}
							break;
							case 3:
								if(self isItemUnlocked("aa12"))
								{
									weap = Weapon_AA12();
									if(self.pers["bots"]["class"]["perk1pro"] != "specialty_secondarybling")
										weap[2] = "none";
									self.pers["bots"]["class"]["secondary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
								}
							break;
							case 4:
								if(self isItemUnlocked("m1014"))
								{
									weap = Weapon_M1014();
									if(self.pers["bots"]["class"]["perk1pro"] != "specialty_secondarybling")
										weap[2] = "none";
									self.pers["bots"]["class"]["secondary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
								}
							break;
							case 5:
								if(self isItemUnlocked("spas12"))
								{
									weap = Weapon_Spas12();
									if(self.pers["bots"]["class"]["perk1pro"] != "specialty_secondarybling")
										weap[2] = "none";
									self.pers["bots"]["class"]["secondary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
								}
							break;
							case 6:
								if(self isItemUnlocked("tmp"))
								{
									weap = Weapon_TMP();
									if(self.pers["bots"]["class"]["perk1pro"] != "specialty_secondarybling")
										weap[2] = "none";
									self.pers["bots"]["class"]["secondary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
								}
							break;
							case 7:
								if(self isItemUnlocked("pp2000"))
								{
									weap = Weapon_PP2000();
									if(self.pers["bots"]["class"]["perk1pro"] != "specialty_secondarybling")
										weap[2] = "none";
									self.pers["bots"]["class"]["secondary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
								}
							break;
							case 8:
								if(self isItemUnlocked("beretta"))
								{
									weap = Weapon_Beretta();
									if(self.pers["bots"]["class"]["perk1pro"] != "specialty_secondarybling")
										weap[2] = "none";
									self.pers["bots"]["class"]["secondary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
								}
							break;
							case 9:
								if(self isItemUnlocked("usp"))
								{
									weap = Weapon_USP();
									if(self.pers["bots"]["class"]["perk1pro"] != "specialty_secondarybling")
										weap[2] = "none";
									self.pers["bots"]["class"]["secondary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
								}
							break;
							case 10:
								if(self isItemUnlocked("deserteagle"))
								{
									weap = Weapon_Desert_Eagle();
									if(self.pers["bots"]["class"]["perk1pro"] != "specialty_secondarybling")
										weap[2] = "none";
									self.pers["bots"]["class"]["secondary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
								}
							break;
							case 11:
								if(self isItemUnlocked("coltanaconda"))
								{
									weap = Weapon_Colt_Anaconda();
									if(self.pers["bots"]["class"]["perk1pro"] != "specialty_secondarybling")
										weap[2] = "none";
									self.pers["bots"]["class"]["secondary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
								}
							break;
							case 12:
								if(self isItemUnlocked("glock"))
								{
									weap = Weapon_Glock();
									if(self.pers["bots"]["class"]["perk1pro"] != "specialty_secondarybling")
										weap[2] = "none";
									self.pers["bots"]["class"]["secondary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
								}
							break;
							case 13:
								if(self isItemUnlocked("beretta393"))
								{
									weap = Weapon_Beretta393();
									if(self.pers["bots"]["class"]["perk1pro"] != "specialty_secondarybling")
										weap[2] = "none";
									self.pers["bots"]["class"]["secondary"] = maps\mp\gametypes\_class::buildWeaponName(weap[0],weap[1],weap[2]);
								}
							break;
							case 14:
								if(self isItemUnlocked("m79"))
									self.pers["bots"]["class"]["secondary"] = "m79_mp";
							break;
							case 15:
								if(self isItemUnlocked("rpg"))
									self.pers["bots"]["class"]["secondary"] = "rpg_mp";
							break;
							case 16:
								if(self isItemUnlocked("at4"))
									self.pers["bots"]["class"]["secondary"] = "at4_mp";
							break;
							case 17:
								if(self isItemUnlocked("stinger"))
									self.pers["bots"]["class"]["secondary"] = "stinger_mp";
							break;
							case 18:
								if(self isItemUnlocked("javelin"))
									self.pers["bots"]["class"]["secondary"] = "javelin_mp";
							break;
						}
					}
				}
				else
				{
					if(rankID >= 2)
						class_num = randomInt(5);
					else
						class_num = randomInt(3);
					
					loadoutPrimary = maps\mp\gametypes\_class::table_getWeapon( level.classTableName, class_num, 0 );
					loadoutPrimaryAttachment = maps\mp\gametypes\_class::table_getWeaponAttachment( level.classTableName, class_num, 0 , 0);
					loadoutPrimaryAttachment2 = maps\mp\gametypes\_class::table_getWeaponAttachment( level.classTableName, class_num, 0, 1 );
					loadoutPrimaryCamo = maps\mp\gametypes\_class::table_getWeaponCamo( level.classTableName, class_num, 0 );
					loadoutSecondary = maps\mp\gametypes\_class::table_getWeapon( level.classTableName, class_num, 1 );
					loadoutSecondaryAttachment = maps\mp\gametypes\_class::table_getWeaponAttachment( level.classTableName, class_num, 1 , 0);
					loadoutSecondaryAttachment2 = maps\mp\gametypes\_class::table_getWeaponAttachment( level.classTableName, class_num, 1, 1 );;
					loadoutSecondaryCamo = maps\mp\gametypes\_class::table_getWeaponCamo( level.classTableName, class_num, 1 );
					loadoutEquipment = maps\mp\gametypes\_class::table_getEquipment( level.classTableName, class_num, 0 );
					loadoutPerk1 = maps\mp\gametypes\_class::table_getPerk( level.classTableName, class_num, 1 );
					loadoutPerk2 = maps\mp\gametypes\_class::table_getPerk( level.classTableName, class_num, 2 );
					loadoutPerk3 = maps\mp\gametypes\_class::table_getPerk( level.classTableName, class_num, 3 );
					loadoutOffhand = maps\mp\gametypes\_class::table_getOffhand( level.classTableName, class_num );
					loadoutDeathstreak = maps\mp\gametypes\_class::table_getDeathstreak( level.classTableName, class_num );
					
					self.pers["bots"]["class"]["primary"] = maps\mp\gametypes\_class::buildWeaponName(loadoutPrimary, loadoutPrimaryAttachment, loadoutPrimaryAttachment2);
					self.pers["bots"]["class"]["secondary"] = maps\mp\gametypes\_class::buildWeaponName(loadoutSecondary, loadoutSecondaryAttachment, loadoutSecondaryAttachment2);
					self.pers["bots"]["class"]["primaryCamo"] = bots_getValidCamoID(loadoutPrimaryCamo);
					self.pers["bots"]["class"]["secondaryCamo"] = bots_getValidCamoID(loadoutSecondaryCamo);
					self.pers["bots"]["class"]["perk1"] = loadoutPerk1;
					self.pers["bots"]["class"]["perk2"] = loadoutPerk2;
					self.pers["bots"]["class"]["perk3"] = loadoutPerk3;
					self.pers["bots"]["class"]["deathPerk"] = loadoutDeathstreak;
					self.pers["bots"]["class"]["grenade"] = loadoutEquipment;
					self.pers["bots"]["class"]["offhand"] = loadoutOffhand + "_mp";
				}
			break;
		}
	}
}

bots_GiveBotClass()
{
	self endon("bot_reset");
	self endon("giveLoadout");
	self endon("death");
	
	self bots_doClass();
	if(level.bots_varLoadout != "mod")
	{
		self clearPerks();
		self RadarJamOff();//used as clearPerks doesn't... IW...
		self TakeAllWeapons();
		self maps\mp\perks\_perkfunctions::unsetCombatHigh();
		self bots_unsetPerk("specialty_combathigh");//needed as clearPerks doesn't do it... IW...
		self bots_unsetPerk("specialty_onemanarmy");
		self bots_unsetPerk("specialty_omaquickchange");
		self bots_unsetPerk("specialty_finalstand");
		self bots_unsetPerk("specialty_coldblooded");
		self bots_unsetPerk("specialty_detectexplosive");
		self bots_unsetPerk("specialty_rollover");
		self bots_unsetPerk("specialty_heartbreaker");
		self bots_unsetPerk("specialty_extraammo");
		self bots_unsetPerk("specialty_lightweight");
		self bots_unsetPerk("specialty_quieter");//these are used for the false positive with _hasPerk... IW please!
		self bots_unsetPerk("specialty_marathon");
		self bots_unsetPerk("specialty_fastmantle");
		self bots_unsetPerk("specialty_fastsprintrecovery");
		self bots_unsetPerk("specialty_localjammer");
		self bots_unsetPerk("specialty_delaymine");
		self bots_unsetPerk("specialty_blastshield");
		self bots_unsetPerk("_specialty_blastshield");
		self.specialty = [];
		self.perks = [];
		self.weaponList = [];
		self maps\mp\gametypes\_class::_detachAll();
		
		primary = self.pers["bots"]["class"]["primary"];
		secondary = self.pers["bots"]["class"]["secondary"];
		offhand = self.pers["bots"]["class"]["offhand"];
		gnade = self.pers["bots"]["class"]["grenade"];
		perk1 = self.pers["bots"]["class"]["perk1"];
		perk1pro = self.pers["bots"]["class"]["perk1pro"];
		perk2 = self.pers["bots"]["class"]["perk2"];
		perk2pro = self.pers["bots"]["class"]["perk2pro"];
		perk3 = self.pers["bots"]["class"]["perk3"];
		perk3pro = self.pers["bots"]["class"]["perk3pro"];
		deathstreak = self.pers["bots"]["class"]["deathPerk"];
		camo1 = self.pers["bots"]["class"]["primaryCamo"];
		camo2 = self.pers["bots"]["class"]["secondaryCamo"];
		
		if(!level.bots_varLoadoutDS)
		{
			deathstreak = "";
		}
		
		deathval = int( tableLookup( "mp/perkTable.csv", 1, deathstreak, 6 ) );
		if(perk2pro == "specialty_rollover") 
			deathval -= 1;
		
		isOmaChangeDef = isDefined(self.bots_omaChange);
		didCopy = false;
		
		if(level.bots_varLoadoutDS && deathstreak == "specialty_copycat" && randomint(5) && self.pers["cur_death_streak"] > deathVal && getDvarInt( "scr_game_perks" ) && !isOmaChangeDef)
		{
			if(isDefined(self.lastAttacker))
			{
				didCopy = true;
				self.lastAttacker thread maps\mp\gametypes\_hud_message::playerCardSplashNotify( "copied", self );
				if(self.lastAttacker bots_playerIsABot())
				{
					primary = self.lastAttacker.pers["bots"]["class"]["primary"];
					secondary = self.lastAttacker.pers["bots"]["class"]["secondary"];
					offhand = self.lastAttacker.pers["bots"]["class"]["offhand"];
					gnade = self.lastAttacker.pers["bots"]["class"]["grenade"];
					perk1 = self.lastAttacker.pers["bots"]["class"]["perk1"];
					perk1pro = self.lastAttacker.pers["bots"]["class"]["perk1pro"];
					perk2 = self.lastAttacker.pers["bots"]["class"]["perk2"];
					perk2pro = self.lastAttacker.pers["bots"]["class"]["perk2pro"];
					perk3 = self.lastAttacker.pers["bots"]["class"]["perk3"];
					perk3pro = self.lastAttacker.pers["bots"]["class"]["perk3pro"];
					camo1 = self.lastAttacker.pers["bots"]["class"]["primaryCamo"];
					camo2 = self.lastAttacker.pers["bots"]["class"]["secondaryCamo"];
				}
				else
				{
					clonedclass = self.lastAttacker maps\mp\gametypes\_class::cloneLoadout();
					if(clonedclass["loadoutPrimary"] != "none")
					{
						if(clonedclass["loadoutPrimaryAttachment"] != "none")
						{
							if(clonedclass["loadoutPrimaryAttachment2"] != "none")
							{
								primary = clonedclass["loadoutPrimary"] + "_" + clonedclass["loadoutPrimaryAttachment"] + "_" + clonedclass["loadoutPrimaryAttachment2"] + "_mp";
							}
							else
							{
								primary = clonedclass["loadoutPrimary"] + "_" + clonedclass["loadoutPrimaryAttachment"] + "_mp";
							}
						}
						else
						{
							primary = clonedclass["loadoutPrimary"] + "_mp";
						}
					}
					if(clonedclass["loadoutSecondary"] != "none")
					{
						if(clonedclass["loadoutSecondaryAttachment"] != "none")
						{
							if(clonedclass["loadoutSecondaryAttachment2"] != "none")
							{
								secondary = clonedclass["loadoutSecondary"] + "_" + clonedclass["loadoutSecondaryAttachment"] + "_" + clonedclass["loadoutSecondaryAttachment2"] + "_mp";
							}
							else
							{
								secondary = clonedclass["loadoutSecondary"] + "_" + clonedclass["loadoutSecondaryAttachment"] + "_mp";
							}
						}
						else
						{
							secondary = clonedclass["loadoutSecondary"] + "_mp";
						}
					}
					perk1 = clonedclass["loadoutPerk1"];
					perk2 = clonedclass["loadoutPerk2"];
					perk3 = clonedclass["loadoutPerk3"];
					if(randomInt(2))
						perk1pro = tablelookup( "mp/perktable.csv", 1, perk1, 8 );
					else
						perk1pro = "";
					if(randomInt(2))
						perk2pro = tablelookup( "mp/perktable.csv", 1, perk2, 8 );
					else
						perk2pro = "";
					if(randomInt(2))
						perk3pro = tablelookup( "mp/perktable.csv", 1, perk3, 8 );
					else
						perk3pro = "";
					gnade = clonedclass["loadoutEquipment"];
					offhand = clonedclass["loadoutOffhand"];
					camo1 = bots_getValidCamoID(clonedclass["loadoutPrimaryCamo"]);
					camo2 = bots_getValidCamoID(clonedclass["loadoutSecondaryCamo"]);
				}
			}
		}
		
		if(isOmaChangeDef)
			self.bots_omaChange = undefined;
		
		if(!level.bots_varLoadoutLS)
		{
			if(perk3 == "specialty_pistoldeath")
				perk3 = "specialty_heartbreaker";
			if(perk3pro == "specialty_laststandoffhand")
				perk3pro = "specialty_quieter";
		}
		
		if(!level.bots_varLoadoutTube)
		{
			if(secondary == "m79_mp" || secondary == "rpg_mp" || secondary == "at4_mp")
				secondary = "usp_mp";
			if(isSubStr(primary, "_gl_"))
				primary = "m4_mp";
		}
		
		if(!level.bots_varLoadoutAkimbo)
		{
			if(isSubStr(secondary, "_akimbo_"))
				secondary = "usp_mp";
			if(isSubStr(primary, "_akimbo_"))
				primary = "m4_mp";
		}
		
		if(!level.bots_varLoadoutRiot && primary == "riotshield_mp")
		{
			primary = "m4_mp";
		}
		
		if(!level.bots_varLoadoutSniper && (isSubStr(primary, "cheytac_") || isSubStr(primary, "barrett_") || isSubStr(primary, "wa2000_") || isSubStr(primary, "m21_")))
		{
			primary = "m4_mp";
		}
		
		if(!level.bots_varLoadoutShotgun)
		{
			if(isSubStr(secondary, "spas12_") || isSubStr(secondary, "model1887_") || isSubStr(secondary, "ranger_") || isSubStr(secondary, "m1014_") || isSubStr(secondary, "striker_") || isSubStr(secondary, "aa12_"))
				secondary = "usp_mp";
			if(isSubStr(primary, "_shotgun_"))
				primary = "m4_mp";
		}
		
		if(perk1 == "specialty_onemanarmy")
		{
			secondary = "onemanarmy_mp";
		}
		
		self bots__giveWeapon( secondary, int(tableLookup( "mp/camoTable.csv", 1, camo2, 0 ) ) );
		
		self.loadoutPrimaryCamo = camo1;
		self.loadoutPrimary = bots_getBaseWeaponName( primary );
		self.loadoutSecondary = bots_getBaseWeaponName( secondary );
		self.loadoutSecondaryCamo = camo2;
	
		self SetOffhandPrimaryClass( "other" );
		
		if ( getDvarInt ( "scr_game_perks" ) == 1 )
		{
			if ( level.dieHardMode && level.bots_varLoadoutLS )
				self maps\mp\perks\_perks::givePerk( "specialty_pistoldeath" );
	
			if(gnade != "")
				self maps\mp\perks\_perks::givePerk( gnade );
			if(perk1 != "")
				self maps\mp\perks\_perks::givePerk( perk1 );
			if(perk1pro != "")
				self maps\mp\perks\_perks::givePerk( perk1pro );
			if(perk2 != "")
				self maps\mp\perks\_perks::givePerk( perk2 );
			if(perk2pro != "")
				self maps\mp\perks\_perks::givePerk( perk2pro );
			if(perk3 != "")
				self maps\mp\perks\_perks::givePerk( perk3 );
			if(perk3pro != "")
				self maps\mp\perks\_perks::givePerk( perk3pro );
			
			if ( self.pers["cur_death_streak"] >= deathVal && deathstreak != "" )
			{
				self thread maps\mp\perks\_perks::givePerk( deathstreak );
				if(self.pers["cur_death_streak"] == deathVal)
					self thread maps\mp\gametypes\_hud_message::splashNotify( deathstreak );
			}
		}
		
		self maps\mp\gametypes\_class::setKillstreaks( self.pers["bots"]["killstreaks"][0], self.pers["bots"]["killstreaks"][1], self.pers["bots"]["killstreaks"][2] );
		
		if ( self hasPerk( "specialty_extraammo", true ) && bots_getWeaponClass( secondary ) != "weapon_projectile" )
			self giveMaxAmmo( secondary );

		self bots__giveWeapon( primary, camo1 );
	
		if ( primary == "riotshield_mp" && level.inGracePeriod )
			self notify ( "weapon_change", "riotshield_mp" );

		if ( self hasPerk( "specialty_extraammo", true ) )
			self giveMaxAmmo( primary );

		self setSpawnWeapon( primary );
	
		primaryTokens = strtok( primary, "_" );
		self.pers["primaryWeapon"] = primaryTokens[0];
	
		if ( offhand == "flash_grenade_mp" )
			self SetOffhandSecondaryClass( "flash" );
		else
			self SetOffhandSecondaryClass( "smoke" );
	
		self bots__giveWeapon( offhand );
		if( offhand == "smoke_grenade_mp" )
			self setWeaponAmmoClip( offhand, 1 );
		else if( offhand == "flash_grenade_mp" )
			self setWeaponAmmoClip( offhand, 2 );
		else if( offhand == "concussion_grenade_mp" )
			self setWeaponAmmoClip( offhand, 2 );
		else
			self setWeaponAmmoClip( offhand, 1 );
	
		self.primaryWeapon = primary;
		self.secondaryWeapon = secondary;

		self.isSniper = (weaponClass( self.primaryWeapon ) == "sniper");
		
		if(self.isSniper && self.pers["bots"]["trait"]["killsOverObj"] && level.environment != "")
			self [[game[self.pers["team"]+"_model"]["GHILLIE"]]]();
		else
			self maps\mp\gametypes\_teams::playerModelForWeapon( self.loadoutPrimary, self.loadoutSecondary );
		
		self.currentWeaponAtSpawn = primary;
		self.lastDroppableWeapon = primary;
		
		if(!didCopy && !isOmaChangeDef)
		{
			self setPlayerData( "customClasses", 0, "weaponSetups", 0, "weapon", self.loadoutPrimary );
			if(primaryTokens[1] == "mp")
			{
				self setPlayerData( "customClasses", 0, "weaponSetups", 0, "attachment", 0, "none" );
				self setPlayerData( "customClasses", 0, "weaponSetups", 0, "attachment", 1, "none" );
			}
			else if(primaryTokens[2] == "mp")
			{
				self setPlayerData( "customClasses", 0, "weaponSetups", 0, "attachment", 0, primaryTokens[1] );
				self setPlayerData( "customClasses", 0, "weaponSetups", 0, "attachment", 1, "none" );
			}
			else if(primaryTokens[3] == "mp")
			{
				self setPlayerData( "customClasses", 0, "weaponSetups", 0, "attachment", 0, primaryTokens[1] );
				self setPlayerData( "customClasses", 0, "weaponSetups", 0, "attachment", 1, primaryTokens[2] );
			}
			self setPlayerData( "customClasses", 0, "weaponSetups", 0, "camo", bots_getValidCamo(self.loadoutPrimaryCamo) );
			
			self setPlayerData( "customClasses", 0, "weaponSetups", 1, "weapon", self.loadoutSecondary );
			secondaryTokens = strtok( secondary, "_" );
			if(secondaryTokens[1] == "mp")
			{
				self setPlayerData( "customClasses", 0, "weaponSetups", 1, "attachment", 0, "none" );
				self setPlayerData( "customClasses", 0, "weaponSetups", 1, "attachment", 1, "none" );
			}
			else if(secondaryTokens[2] == "mp")
			{
				self setPlayerData( "customClasses", 0, "weaponSetups", 1, "attachment", 0, secondaryTokens[1] );
				self setPlayerData( "customClasses", 0, "weaponSetups", 1, "attachment", 1, "none" );
			}
			else if(secondaryTokens[3] == "mp")
			{
				self setPlayerData( "customClasses", 0, "weaponSetups", 1, "attachment", 0, secondaryTokens[1] );
				self setPlayerData( "customClasses", 0, "weaponSetups", 1, "attachment", 1, secondaryTokens[2] );
			}
			self setPlayerData( "customClasses", 0, "weaponSetups", 1, "camo", bots_getValidCamo(self.loadoutSecondaryCamo) );
			
			if(gnade != "")
				self setPlayerData( "customClasses", 0, "perks", 0, gnade );
			if(perk1 != "")
				self setPlayerData( "customClasses", 0, "perks", 1, perk1 );
			if(perk2 != "")
				self setPlayerData( "customClasses", 0, "perks", 2, perk2 );
			if(perk3 != "")
				self setPlayerData( "customClasses", 0, "perks", 3, perk3 );
			self setPlayerData( "customClasses", 0, "specialGrenade", bots_getBaseWeaponName(offhand)+"_grenade" );
			if(deathstreak != "")
				self setPlayerData( "customClasses", 0, "perks", 4, deathstreak );
		}
	}
	
	if(level.bots_varPlayAnim == 2)
	{
		weaponsList = self GetWeaponsListAll();
		foreach(weap in weaponsList)
		{
			self.bots_devwalk[weap] = spawnstruct();
			self.bots_devwalk[weap].isEmpty = false;
			self.bots_devwalk[weap].clip = self GetWeaponAmmoClip(weap);
			self.bots_devwalk[weap].stock = self GetWeaponAmmoStock(weap);
		}
		
		self setMoveSpeedScale( 0.25 );
	}
}