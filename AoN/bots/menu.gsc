#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include bots\bots_funcs;

playerConnected()
{
	if(self.pers["bots_isHost"])
	{
		self thread checkButtons();
		
		self init();
	}
	
	self thread onPlayerSpawn();
}

init()
{
	self.menuInit = true;
	
	self.menuOpen = false;
	self.menu_player = undefined;
	self.SubMenu = "Main";
	self.Curs["Main"]["X"] = 0;	
	self AddOptions();
	
	self thread watchPlayerOpenMenu();
	self thread MenuSelect();
	self thread RightMenu();
	self thread LeftMenu();
	self thread UpMenu();
	self thread DownMenu();
	
	self thread watchDisconnect();
	
	self thread doGreetings();
}

watchDisconnect()
{
	self waittill_either("disconnect", "bots_kill_menu");
	
	if(self.menuOpen)
	{
		if(isDefined(self.MenuTextY))
			for(i = 0; i < self.MenuTextY.size; i++)
				if(isDefined(self.MenuTextY[i]))
					self.MenuTextY[i] destroy();
		
		if(isDefined(self.MenuText))
			for(i = 0; i < self.MenuText.size; i++)
				if(isDefined(self.MenuText[i]))
					self.MenuText[i] destroy();
		
		if(isDefined(self.Menu) && isDefined(self.Menu["X"]))
		{
			if(isDefined(self.Menu["X"]["Shader"]))
				self.Menu["X"]["Shader"] destroy();
			
			if(isDefined(self.Menu["X"]["Scroller"]))
				self.Menu["X"]["Scroller"] destroy();
		}
	}
}

doGreetings()
{
	self endon ( "disconnect" );
	self endon ( "bots_kill_menu" );
	wait 1;
	self iPrintln("Welcome to Bot Warfare "+self.name+"!");
	wait 5;
	if(getDvarInt("bots_main_menu"))
		self iPrintln("Press [{+actionslot 2}] to open menu!");
}

watchPlayerOpenMenu()
{
	self endon ( "disconnect" );
	self endon ( "bots_kill_menu" );
	
	self notifyOnPlayerCommand( "bots_open_menu", "+actionslot 2" );
	for(;;)
	{
		self waittill( "bots_open_menu" );
		if(!self.menuOpen)
		{
			if(getdvarint("bots_main_menu"))
			{
				self playLocalSound( "mouse_click" );
				self thread OpenSub(self.SubMenu);
			}
		}
		else
		{
			self playLocalSound( "mouse_click" );
			if(self.SubMenu != "Main")
				self ExitSub();
			else
			{
				self ExitMenu();
				if((!bots_gameFlag( "prematch_done" ) || level.gameEnded) && !getDvarInt("bots_main_debug") && !getDvarInt("bots_main_fun"))
					self freezeControls(true);
				else
					self freezecontrols(false);
			}
		}
	}
}

MenuSelect()
{
	self endon ( "disconnect" );
	self endon ( "bots_kill_menu" );
	
	self notifyOnPlayerCommand("bots_select", "+gostand");
	for(;;)
	{
		self waittill( "bots_select" );
		if(self.MenuOpen && getdvarint("bots_main_menu"))
		{
			self playLocalSound( "mouse_click" );
			if(self.SubMenu == "Main")
				self thread [[self.Option["Function"][self.SubMenu][self.Curs["Main"]["X"]]]](self.Option["Arg1"][self.SubMenu][self.Curs["Main"]["X"]],self.Option["Arg2"][self.SubMenu][self.Curs["Main"]["X"]]);
			else
				self thread [[self.Option["Function"][self.SubMenu][self.Curs[self.SubMenu]["Y"]]]](self.Option["Arg1"][self.SubMenu][self.Curs[self.SubMenu]["Y"]],self.Option["Arg2"][self.SubMenu][self.Curs[self.SubMenu]["Y"]]);
		}
	}
}

LeftMenu()
{
	self endon ( "disconnect" );
	self endon ( "bots_kill_menu" );

	self notifyOnPlayerCommand( "bots_left", "+moveleft" ); 
	for(;;)
	{
		self waittill( "bots_left" );
		if(self.MenuOpen && self.SubMenu == "Main")
		{
			self playLocalSound("mouse_over");
			self.Curs["Main"]["X"]--;

			if(self.Curs["Main"]["X"] < 0)
				self.Curs["Main"]["X"] = self.Option["Name"][self.SubMenu].size -1;

			self CursMove("X");
		}
	}
}

RightMenu()
{
	self endon ( "disconnect" );
	self endon ( "bots_kill_menu" );

	self notifyOnPlayerCommand("bots_right", "+moveright");
	for(;;)
	{
		self waittill( "bots_right" );
		if(self.MenuOpen && self.SubMenu == "Main")
		{
			self playLocalSound("mouse_over");
			self.Curs["Main"]["X"]++;

			if(self.Curs["Main"]["X"] > self.Option["Name"][self.SubMenu].size -1)
				self.Curs["Main"]["X"] = 0;

			self CursMove("X");
		}
	}
}

UpMenu()
{
	self endon ( "disconnect" );
	self endon ( "bots_kill_menu" );
	
	self notifyOnPlayerCommand( "bots_up", "+forward" );
	for(;;)
	{
		self waittill( "bots_up" );
		if(self.MenuOpen && self.SubMenu != "Main")
		{
			self playLocalSound("mouse_over");
			self.Curs[self.SubMenu]["Y"]--;

			if(self.Curs[self.SubMenu]["Y"] < 0)
				self.Curs[self.SubMenu]["Y"] = self.Option["Name"][self.SubMenu].size -1;

			self CursMove("Y");
		}
	}
}

DownMenu()
{
	self endon ( "disconnect" );
	self endon ( "bots_kill_menu" );

	self notifyOnPlayerCommand( "bots_down", "+back" );
	for(;;)
	{
		self waittill( "bots_down" );
		if(self.MenuOpen && self.SubMenu != "Main")
		{
			self playLocalSound("mouse_over");
			self.Curs[self.SubMenu]["Y"]++;

			if(self.Curs[self.SubMenu]["Y"] > self.Option["Name"][self.SubMenu].size -1)
				self.Curs[self.SubMenu]["Y"] = 0;

			self CursMove("Y");
		}
	}
}

OpenSub(menu, menu2)
{
	if(menu != "Main" && (!isDefined(self.Menu[menu]) || !!isDefined(self.Menu[menu]["FirstOpen"])))
	{
		self.Curs[menu]["Y"] = 0;
		self.Menu[menu]["FirstOpen"] = true;
	}
	
	logoldi = true;
	self.SubMenu = menu;
	
	if(self.SubMenu == "Main")
	{
		if(isDefined(self.MenuText))
			for(i = 0; i < self.MenuText.size; i++)
				if(isDefined(self.MenuText[i]))
					self.MenuText[i] destroy();
		
		if(isDefined(self.Menu) && isDefined(self.Menu["X"]))
		{
			if(isDefined(self.Menu["X"]["Shader"]))
				self.Menu["X"]["Shader"] destroy();
			
			if(isDefined(self.Menu["X"]["Scroller"]))
				self.Menu["X"]["Scroller"] destroy();
		}
		
		for(i=0 ; i < self.Option["Name"][self.SubMenu].size ; i++)
		{
			self.MenuText[i] = self createfontstring("default", 1.6);
			self.MenuText[i] setpoint("CENTER", "CENTER", -300+(i*100), -226);
			self.MenuText[i] settext(self.Option["Name"][self.SubMenu][i]);
			if(logOldi)
				self.oldi = i;
			
			if(self.MenuText[i].x > 300)
			{
				logOldi = false;
				x = i - self.oldi;
				self.MenuText[i] setpoint("CENTER", "CENTER", (((-300)-(i*100))+(i*100))+(x*100), -196);
			}
			self.MenuText[i].alpha = 1;
			self.MenuText[i].sort = 999;
		}

		if(!logOldi)
			self.Menu["X"]["Shader"] = self createRectangle("CENTER","CENTER",0,-225,1000,90, (0,0,0), -2, 1,"white");
		else
			self.Menu["X"]["Shader"] = self createRectangle("CENTER","CENTER",0,-225,1000,30, (0,0,0), -2, 1,"white");

		self.Menu["X"]["Scroller"] = self createRectangle("CENTER","CENTER", self.MenuText[self.Curs["Main"]["X"]].x,-225,105,22, (1,0,0), -1, 1,"white");
		
		self CursMove("X");
		self.MenuOpen = true;
	}
	else
	{
		if(isDefined(self.MenuTextY))
			for(i=0 ; i < self.MenuTextY.size ; i++)
				if(isDefined(self.MenuTextY[i]))
					self.MenuTextY[i] destroy();
		
		for(i=0 ; i < self.Option["Name"][self.SubMenu].size ; i++)
		{
			self.MenuTextY[i] = self createfontstring("default", 1.6);
			self.MenuTextY[i] setpoint("CENTER", "CENTER", self.MenuText[self.Curs["Main"]["X"]].x, -160+(i*20));
			self.MenuTextY[i] settext(self.Option["Name"][self.SubMenu][i]);
			self.MenuTextY[i].alpha = 1;
			self.MenuTextY[i].sort = 999;
		}
		
		self CursMove("Y");
	}
}

CursMove(direction)
{
	self notify("scrolled");
	if(self.SubMenu == "Main")
	{
		self.Menu["X"]["Scroller"].x = self.MenuText[self.Curs["Main"]["X"]].x;
		self.Menu["X"]["Scroller"].y = self.MenuText[self.Curs["Main"]["X"]].y;
		
		if(isDefined(self.MenuText))
		{
			for(i = 0; i < self.MenuText.size; i++)
			{
				if(isDefined(self.MenuText[i]))
				{
					self.MenuText[i].fontscale = 1.5;
					self.MenuText[i].color = (1,1,1);
					self.MenuText[i].glowAlpha = 0;
				}
			}
		}
		
		self thread ShowOptionOn(direction);
	}
	else
	{
		if(isDefined(self.MenuTextY))
		{
			for(i = 0; i < self.MenuTextY.size; i++)
			{
				if(isDefined(self.MenuTextY[i]))
				{
					self.MenuTextY[i].fontscale = 1.5;
					self.MenuTextY[i].color = (1,1,1);
					self.MenuTextY[i].glowAlpha = 0;
				}
			}
		}
		
		if(isDefined(self.MenuText))
		{
			for(i = 0; i < self.MenuText.size; i++)
			{
				if(isDefined(self.MenuText[i]))
				{
					self.MenuText[i].fontscale = 1.5;
					self.MenuText[i].color = (1,1,1);
					self.MenuText[i].glowAlpha = 0;
				}
			}
		}
		
		self thread ShowOptionOn(direction);
	}
}

ShowOptionOn(variable)
{
	self endon("scrolled");
	self endon("disconnect");
	self endon("exit");
	self endon("bots_kill_menu");
	
	for(;;)
	{
		if(!getDvarInt("bots_main_debug") && !getDvarInt("bots_main_fun") && !self isOnGround() && bots_gameFlag( "prematch_done" ) && !level.gameEnded)
			self freezecontrols(false);
		else
			self freezecontrols(true);
		
		self setClientDvar( "r_blur", "5" ); 
		self setClientDvar( "sc_blur", "15" );
		self addOptions();
		
		if(self.SubMenu == "Main")
		{
			if(isDefined(self.Curs[self.SubMenu][variable]) && isDefined(self.MenuText) && isDefined(self.MenuText[self.Curs[self.SubMenu][variable]]))
			{
				self.MenuText[self.Curs[self.SubMenu][variable]].fontscale = 2.0;
				self.MenuText[self.Curs[self.SubMenu][variable]].color = (randomInt(256)/255, randomInt(256)/255, randomInt(256)/255);
			}
			
			if(isDefined(self.MenuText))
			{
				for(i = 0; i < self.Option["Name"][self.SubMenu].size; i++)
				{
					if(isDefined(self.MenuText[i]))
						self.MenuText[i] settext(self.Option["Name"][self.SubMenu][i]);
				}
			}
		}
		else
		{
			if(isDefined(self.Curs[self.SubMenu][variable]) && isDefined(self.MenuTextY) && isDefined(self.MenuTextY[self.Curs[self.SubMenu][variable]]))
			{
				self.MenuTextY[self.Curs[self.SubMenu][variable]].fontscale = 2.0;
				self.MenuTextY[self.Curs[self.SubMenu][variable]].color = (randomInt(256)/255, randomInt(256)/255, randomInt(256)/255);
			}
			
			if(isDefined(self.MenuTextY))
			{
				for(i = 0; i < self.Option["Name"][self.SubMenu].size; i++)
				{
					if(isDefined(self.MenuTextY[i]))
						self.MenuTextY[i] settext(self.Option["Name"][self.SubMenu][i]);
				}
			}
		}
		
		wait 0.05;
	}
}

AddMenu(menu, num, text, function, arg1, arg2)
{
	self.Option["Name"][menu][num] = text;
	self.Option["Function"][menu][num] = function;
	self.Option["Arg1"][menu][num] = arg1;
	self.Option["Arg2"][menu][num] = arg2;
}

AddBack(menu, back)
{
	self.Menu["Back"][menu] = back;
}

ExitSub()
{
	if(isDefined(self.MenuTextY))
		for(i = 0; i < self.MenuTextY.size; i++)
			if(isDefined(self.MenuTextY[i]))
				self.MenuTextY[i] destroy();
			
	self.SubMenu = self.Menu["Back"][self.Submenu];
	
	if(self.SubMenu == "Main")
		self CursMove("X");
	else
		self CursMove("Y");
}

ExitMenu()
{
	if(isDefined(self.MenuText))
		for(i = 0; i < self.MenuText.size; i++)
			if(isDefined(self.MenuText[i]))
				self.MenuText[i] destroy();
	
	if(isDefined(self.Menu) && isDefined(self.Menu["X"]))
	{
		if(isDefined(self.Menu["X"]["Shader"]))
			self.Menu["X"]["Shader"] destroy();
		
		if(isDefined(self.Menu["X"]["Scroller"]))
			self.Menu["X"]["Scroller"] destroy();
	}
	
	self.MenuOpen = false;
	self notify("exit");
	
	self setClientDvar( "r_blur", "0" );
	self setClientDvar( "sc_blur", "2" );
}

createRectangle(align,relative,x,y,width,height,color,sort,alpha,shader)
{
	barElemBG = newClientHudElem( self );
	barElemBG.elemType = "bar_";
	barElemBG.width = width;
	barElemBG.height = height;
	barElemBG.align = align;
	barElemBG.relative = relative;
	barElemBG.xOffset = 0;
	barElemBG.yOffset = 0;
	barElemBG.children = [];
	barElemBG.sort = sort;
	barElemBG.color = color;
	barElemBG.alpha = alpha;
	barElemBG setParent( level.uiParent );
	barElemBG setShader( shader, width , height );
	barElemBG.hidden = false;
	barElemBG setPoint(align, relative, x, y);
	return barElemBG;
}

AddOptions()
{
	isDebug = getDvarInt("bots_main_debug");
	isFun = getDvarInt("bots_main_fun");
	
	self AddMenu("Main", 0, "Manage bots", ::OpenSub, "man_bots", "");
	self AddBack("man_bots", "Main");
	
	_tempDvar = getDvarInt("bots_manage_add");
	self AddMenu("man_bots", 0, "Add 1 bot", ::bot_func, "add", 1 + _tempDvar);
	self AddMenu("man_bots", 1, "Add 3 bot", ::bot_func, "add", 3 + _tempDvar);
	self AddMenu("man_bots", 2, "Add 7 bot", ::bot_func, "add", 7 + _tempDvar);
	self AddMenu("man_bots", 3, "Add 11 bot", ::bot_func, "add", 11 + _tempDvar);
	self AddMenu("man_bots", 4, "Add 17 bot", ::bot_func, "add", 17 + _tempDvar);
	self AddMenu("man_bots", 5, "Kick a bot", ::bot_func, "kick", 0);
	self AddMenu("man_bots", 6, "Kick all bots", ::bot_func, "kick", 1);
	
	_tempDvar = getDvarInt("bots_manage_fill_kick");
	if(_tempDvar)
		_temp = "true";
	else
		_temp = "false";
	self AddMenu("man_bots", 7, "Toggle auto bot kicking: " + _temp, ::bot_func, "autokick", _tempDvar);
	
	_tempDvar = getDvarInt("bots_manage_fill_mode");
	switch(_tempDvar)
	{
		case 0:
			_temp = "everyone";
		break;
		case 1:
			_temp = "just bots";
		break;
		case 2:
			_temp = "everyone, adjust to map";
		break;
		case 3:
			_temp = "just bots, adjust to map";
		break;
		case 4:
			_temp = "bots used as balance";
		break;
		default:
			_temp = "out of range";
		break;
	}
	self AddMenu("man_bots", 8, "Change bot_fill_mode: " + _temp, ::bot_func, "fillmode", _tempDvar);
	
	_tempDvar = getDvarInt("bots_manage_fill");
	self AddMenu("man_bots", 9, "Increase bots to keep in-game: " + _tempDvar, ::bot_func, "fillup", _tempDvar);
	self AddMenu("man_bots", 10, "Decrease bots to keep in-game: " + _tempDvar, ::bot_func, "filldown", _tempDvar);
	
	_tempDvar = getDvarInt("bots_manage_fill_spec");
	if(_tempDvar)
		_temp = "true";
	else
		_temp = "false";
	self AddMenu("man_bots", 11, "Count players for fill on spectator: " + _temp, ::bot_func, "fillspec", _tempDvar);
	
	self AddMenu("man_bots", 12, "Reset all bots", ::bot_func, "reset", 0);
	
	//
	
	self AddMenu("Main", 1, "Teams and difficulty", ::OpenSub, "man_team", "");
	self AddBack("man_team", "Main");
	
	_tempDvar = getdvar("bots_team");
	self AddMenu("man_team", 0, "Change bot team: "+_tempDvar, ::bot_func, "team", _tempDvar);
	
	_tempDvar = getDvarInt("bots_team_amount");
	self AddMenu("man_team", 1, "Increase bots to be on axis team: "+_tempDvar, ::bot_func, "teamup", _tempDvar);
	self AddMenu("man_team", 2, "Decrease bots to be on axis team: "+_tempDvar, ::bot_func, "teamdown", _tempDvar);
	
	_tempDvar = getDvarInt("bots_team_force");
	if(_tempDvar)
		_temp = "true";
	else
		_temp = "false";
	self AddMenu("man_team", 3, "Toggle forcing bots on team: " + _temp, ::bot_func, "teamforce", _tempDvar);
	
	_tempDvar = getDvarInt("bots_team_mode");
	if(_tempDvar)
		_temp = "only bots";
	else
		_temp = "everyone";
	self AddMenu("man_team", 4, "Toggle bot_team_bot: " + _temp, ::bot_func, "teammode", _tempDvar);
	
	_tempDvar = getdvarint("bots_skill");
	switch(_tempDvar)
	{
		case 0:
			_temp = "random for all";
		break;
		case 1:
			_temp = "too easy";
		break;
		case 2:
			_temp = "easy";
		break;
		case 3:
			_temp = "easy-medium";
		break;
		case 4:
			_temp = "medium";
		break;
		case 5:
			_temp = "hard";
		break;
		case 6:
			_temp = "very hard";
		break;
		case 7:
			_temp = "hardest";
		break;
		case 8:
			_temp = "custom";
		break;
		case 9:
			_temp = "complete random";
		break;
		default:
			_temp = "out of range";
		break;
	}
	self AddMenu("man_team", 5, "Change bot difficulty: "+_temp, ::bot_func, "skill", _tempDvar);
	
	_tempDvar = getDvarInt("bots_skill_axis_hard");
	self AddMenu("man_team", 6, "Increase amount of hard bots on axis team: " + _tempDvar, ::bot_func, "axishardup", _tempDvar);
	self AddMenu("man_team", 7, "Decrease amount of hard bots on axis team: " + _tempDvar, ::bot_func, "axisharddown", _tempDvar);
	
	_tempDvar = getDvarInt("bots_skill_axis_med");
	self AddMenu("man_team", 8, "Increase amount of med bots on axis team: " + _tempDvar, ::bot_func, "axismedup", _tempDvar);
	self AddMenu("man_team", 9, "Decrease amount of med bots on axis team: " + _tempDvar, ::bot_func, "axismeddown", _tempDvar);
	
	_tempDvar = getDvarInt("bots_skill_allies_hard");
	self AddMenu("man_team", 10, "Increase amount of hard bots on allies team: " + _tempDvar, ::bot_func, "allieshardup", _tempDvar);
	self AddMenu("man_team", 11, "Decrease amount of hard bots on allies team: " + _tempDvar, ::bot_func, "alliesharddown", _tempDvar);
	
	_tempDvar = getDvarInt("bots_skill_allies_med");
	self AddMenu("man_team", 12, "Increase amount of med bots on allies team: " + _tempDvar, ::bot_func, "alliesmedup", _tempDvar);
	self AddMenu("man_team", 13, "Decrease amount of med bots on allies team: " + _tempDvar, ::bot_func, "alliesmeddown", _tempDvar);
	
	//
	
	self AddMenu("Main", 2, "Bot settings", ::OpenSub, "set1", "");
	self AddBack("set1", "Main");
	
	_tempDvar = getdvarfloat("bots_play_talk");
	self AddMenu("set1", 0, "Increase bot talk rate: "+_tempDvar, ::bot_func, "talkup", _tempDvar);
	self AddMenu("set1", 1, "Decrease bot talk rate: "+_tempDvar, ::bot_func, "talkdown", _tempDvar);
	
	_tempDvar = getDvarInt("bots_play_rageQuit");
	if(_tempDvar)
		_temp = "true";
	else
		_temp = "false";
	self AddMenu("set1", 2, "Toggle bot rage quitting: "+_temp, ::bot_func, "rage", _tempDvar);
	
	_tempDvar = getDvarInt("bots_play_watchKillcam");
	switch(_tempDvar)
	{
		case 0:
			_temp = "false";
		break;
		case 1:
			_temp = "true(chance)";
		break;
		case 2:
			_temp = "true(always)";
		break;
		default:
			_temp = "out of range";
		break;
	}
	self AddMenu("set1", 3, "Toggle bot watching killcams: "+_temp, ::bot_func, "killcam", _tempDvar);
	
	_tempDvar = getDvarInt("bots_play_fakeAnims");
	switch(_tempDvar)
	{
		case 0:
			_temp = "false";
		break;
		case 1:
			_temp = "true";
		break;
		case 2:
			_temp = "true(alt)";
		break;
		default:
			_temp = "out of range";
		break;
	}
	self AddMenu("set1", 4, "Toggle bot using fake animations: "+_temp, ::bot_func, "anims", _tempDvar);
	
	_tempDvar = getDvarInt("bots_play_destroyEq");
	if(_tempDvar)
		_temp = "true";
	else
		_temp = "false";
	self AddMenu("set1", 5, "Toggle bots targeting equipment: "+_temp, ::bot_func, "equ", _tempDvar);
	
	_tempDvar = getDvarInt("bots_play_tdks");
	if(_tempDvar)
		_temp = "true";
	else
		_temp = "false";
	self AddMenu("set1", 6, "Toggle bots taking out killstreaks: "+_temp, ::bot_func, "tdks", _tempDvar);
	
	_tempDvar = getDvarFloat("bots_play_outOfMyWay");
	if(_tempDvar <= 0)
		_temp = "false";
	else
		_temp = _tempDvar;
	self AddMenu("set1", 7, "Toggle bots moving out of the way: "+_temp, ::bot_func, "oomw", _tempDvar);
	
	_tempDvar = getDvarInt("bots_play_doStuck");
	if(_tempDvar)
		_temp = "true";
	else
		_temp = "false";
	self AddMenu("set1", 8, "Toggle anti stuck thread: "+_temp, ::bot_func, "stuck", _tempDvar);
	
	_tempDvar = getDvarInt("bots_play_move");
	if(_tempDvar)
		_temp = "true";
	else
		_temp = "false";
	self AddMenu("set1", 9, "Toggle bots moving: "+_temp, ::bot_func, "move", _tempDvar);
	
	_tempDvar = getDvarInt("bots_play_camp");
	if(_tempDvar)
		_temp = "true";
	else
		_temp = "false";
	self AddMenu("set1", 10, "Toggle bots camping: "+_temp, ::bot_func, "camp", _tempDvar);
	
	_tempDvar = getDvarInt("bots_play_attack");
	if(_tempDvar)
		_temp = "true";
	else
		_temp = "false";
	self AddMenu("set1", 11, "Toggle bots attacking: "+_temp, ::bot_func, "attack", _tempDvar);
	
	_tempDvar = getDvarInt("bots_play_takeCare");
	if(_tempDvar)
		_temp = "true";
	else
		_temp = "false";
	self AddMenu("set1", 12, "Toggle bots taking carepackages: "+_temp, ::bot_func, "care", _tempDvar);
	
	_tempDvar = getDvarInt("bots_play_run");
	if(_tempDvar)
		_temp = "true";
	else
		_temp = "false";
	self AddMenu("set1", 13, "Toggle bots running: "+_temp, ::bot_func, "run", _tempDvar);
	
	_tempDvar = getDvarInt("bots_play_obj");
	if(_tempDvar)
		_temp = "true";
	else
		_temp = "false";
	self AddMenu("set1", 14, "Toggle bots doing objectives: "+_temp, ::bot_func, "obj", _tempDvar);
	
	_tempDvar = getDvarInt("bots_play_throwback");
	if(_tempDvar)
		_temp = "true";
	else
		_temp = "false";
	self AddMenu("set1", 15, "Toggle bots throwingback: "+_temp, ::bot_func, "tb", _tempDvar);
	
	_tempDvar = getDvarInt("bots_play_footsounds");
	if(_tempDvar)
		_temp = "true";
	else
		_temp = "false";
	self AddMenu("set1", 16, "Toggle bots footsounds: "+_temp, ::bot_func, "foot", _tempDvar);
	
	//
	
	self AddMenu("Main", 3, "Bot settings 2", ::OpenSub, "set2", "");
	self AddBack("set2", "Main");
	
	_tempDvar = getdvar("bots_loadout");
	self AddMenu("set2", 0, "Change bot class mode: "+_tempDvar, ::bot_func, "loadout", _tempDvar);
	
	_tempDvar = getdvar("bots_loadout_killstreak");
	self AddMenu("set2", 1, "Change bot killstreak mode: "+_tempDvar, ::bot_func, "ks", _tempDvar);
	
	_tempDvar = getDvarInt("bots_loadout_change");
	if(_tempDvar)
		_temp = "true";
	else
		_temp = "false";
	self AddMenu("set2", 2, "Toggle bot changing classes: "+_temp, ::bot_func, "cclass", _tempDvar);
	
	_tempDvar = getDvarInt("bots_loadout_remember");
	if(_tempDvar)
		_temp = "true";
	else
		_temp = "false";
	self AddMenu("set2", 3, "Toggle bot remember classes: "+_temp, ::bot_func, "rclass", _tempDvar);
	
	_tempDvar = getDvarInt("bots_loadout_secondary");
	if(_tempDvar)
		_temp = "true";
	else
		_temp = "false";
	self AddMenu("set2", 4, "Toggle bots using secondary: "+_temp, ::bot_func, "secondary", _tempDvar);
	
	_tempDvar = getDvarInt("bots_loadout_deathstreak");
	if(_tempDvar)
		_temp = "true";
	else
		_temp = "false";
	self AddMenu("set2", 5, "Toggle bots using deathstreaks: "+_temp, ::bot_func, "ds", _tempDvar);
	
	_tempDvar = getDvarInt("bots_loadout_lastStand");
	if(_tempDvar)
		_temp = "true";
	else
		_temp = "false";
	self AddMenu("set2", 6, "Toggle bots using laststand perk: "+_temp, ::bot_func, "ls", _tempDvar);
	
	_tempDvar = getDvarInt("bots_loadout_riot");
	if(_tempDvar)
		_temp = "true";
	else
		_temp = "false";
	self AddMenu("set2", 7, "Toggle bots using riots: "+_temp, ::bot_func, "riot", _tempDvar);
	
	_tempDvar = getDvarInt("bots_loadout_nuke");
	if(_tempDvar)
		_temp = "true";
	else
		_temp = "false";
	self AddMenu("set2", 8, "Toggle bots using nukes: "+_temp, ::bot_func, "nuke", _tempDvar);
	
	_tempDvar = getDvarInt("bots_loadout_nade");
	if(_tempDvar)
		_temp = "true";
	else
		_temp = "false";
	self AddMenu("set2", 9, "Toggle bots using nades: "+_temp, ::bot_func, "nade", _tempDvar);
	
	_tempDvar = getDvarInt("bots_loadout_tube");
	if(_tempDvar)
		_temp = "true";
	else
		_temp = "false";
	self AddMenu("set2", 10, "Toggle bots tubing: "+_temp, ::bot_func, "tube", _tempDvar);
	
	_tempDvar = getDvarInt("bots_loadout_knife");
	if(_tempDvar)
		_temp = "true";
	else
		_temp = "false";
	self AddMenu("set2", 11, "Toggle bots knifing: "+_temp, ::bot_func, "knife", _tempDvar);
	
	_tempDvar = getDvarInt("bots_loadout_sniper");
	if(_tempDvar)
		_temp = "true";
	else
		_temp = "false";
	self AddMenu("set2", 12, "Toggle bots use snipers: "+_temp, ::bot_func, "sniper", _tempDvar);
	
	_tempDvar = getDvarInt("bots_loadout_shotgun");
	if(_tempDvar)
		_temp = "true";
	else
		_temp = "false";
	self AddMenu("set2", 13, "Toggle bots use shotguns: "+_temp, ::bot_func, "shotgun", _tempDvar);
	
	_tempDvar = getDvarInt("bots_loadout_akimbo");
	if(_tempDvar)
		_temp = "true";
	else
		_temp = "false";
	self AddMenu("set2", 14, "Toggle bots use akimbo: "+_temp, ::bot_func, "akimbo", _tempDvar);
	
	//
	
	if(isDebug)
	{
		self AddMenu("Main", 4, "Dump DVARs", ::DUMP, "", "");
		
		//
		
		self AddMenu("Main", 5, "Edit which bot?", ::OpenSub, "_editBot", "");
		self AddBack("_editBot", "Main");
		
		if(isDefined(self.menu_player))
			self AddMenu("_editBot", 0, "Current: "+self.menu_player.name, ::_edit, 1, 0);
		else
			self AddMenu("_editBot", 0, "Current: ", ::_edit, 1, 0);
		for(i=0;i<level.players.size;i++)
		{
			self AddMenu("_editBot", i+1, "Edit "+level.players[i].name+".", ::_edit, 0, level.players[i]);
		}
		
		//
		
		self AddMenu("Main", 6, "Dump current bot", ::DUMPBOT, "", "");
		
		//
		
		self AddMenu("Main", 7, "Edit bot", ::OpenSub, "editBot", "");
		self AddBack("editBot", "Main");
		
		self AddMenu("editBot", 0, "waypointCount: "+level.waypointCount, ::_edit, 1, "waypointCount: "+level.waypointCount);
		
		if(isDefined(self.menu_player))
		{
			self AddMenu("editBot", 1, "Bot base skill: "+self.menu_player.pers["bots"]["skill"]["base"], ::__edit, 0, 0);
			self AddMenu("editBot", 2, "Up bot viewDis: "+self.menu_player.pers["bots"]["skill"]["viewDis"], ::__edit, 1, 0);
			self AddMenu("editBot", 3, "Down bot viewDis: "+self.menu_player.pers["bots"]["skill"]["viewDis"], ::__edit, 1, 1);
			self AddMenu("editBot", 4, "Up bot aimSpeed: "+self.menu_player.pers["bots"]["skill"]["aimSpeed"], ::__edit, 2, 0);
			self AddMenu("editBot", 5, "Down bot aimSpeed: "+self.menu_player.pers["bots"]["skill"]["aimSpeed"], ::__edit, 2, 1);
			self AddMenu("editBot", 6, "Up bot accuracy: "+self.menu_player.pers["bots"]["skill"]["acc"], ::__edit, 3, 0);
			self AddMenu("editBot", 7, "Down bot accuracy: "+self.menu_player.pers["bots"]["skill"]["acc"], ::__edit, 3, 1);
			self AddMenu("editBot", 8, "Up bot spawnWait: "+self.menu_player.pers["bots"]["skill"]["spawnWait"], ::__edit, 5, 0);
			self AddMenu("editBot", 9, "Down bot spawnWait: "+self.menu_player.pers["bots"]["skill"]["spawnWait"], ::__edit, 5, 1);
			self AddMenu("editBot", 10, "Up bot newTarg: "+self.menu_player.pers["bots"]["skill"]["newTarg"], ::__edit, 6, 0);
			self AddMenu("editBot", 11, "Down bot newTarg: "+self.menu_player.pers["bots"]["skill"]["newTarg"], ::__edit, 6, 1);
			self AddMenu("editBot", 12, "Up bot shootDelay: "+self.menu_player.pers["bots"]["skill"]["shootDelay"], ::__edit, 10, 0);
			self AddMenu("editBot", 13, "Down bot shootDelay: "+self.menu_player.pers["bots"]["skill"]["shootDelay"], ::__edit, 10, 1);
			self AddMenu("editBot", 14, "Up bot perfView: "+self.menu_player.pers["bots"]["skill"]["perfView"], ::__edit, 11, 0);
			self AddMenu("editBot", 15, "Down bot perfView: "+self.menu_player.pers["bots"]["skill"]["perfView"], ::__edit, 11, 1);
			self AddMenu("editBot", 16, "Up bot seenTime: "+self.menu_player.pers["bots"]["skill"]["seenTime"], ::__edit, 4, 0);
			self AddMenu("editBot", 17, "Down bot seenTime: "+self.menu_player.pers["bots"]["skill"]["seenTime"], ::__edit, 4, 1);
		}
		
		//
		
		self AddMenu("Main", 8, "Edit bot2", ::OpenSub, "editBot2", "");
		self AddBack("editBot2", "Main");
		
		if(isDefined(level.bots_goalPoint))
			self AddMenu("editBot2", 0, "bots_goalPoint: "+level.bots_goalPoint.origin, ::_edit, 1, "bots_goalPoint: "+level.bots_goalPoint.origin);
		else
			self AddMenu("editBot2", 0, "bots_goalPoint: undefined", ::_edit, 1, "bots_goalPoint: undefined");
		
		if(isDefined(self.menu_player))
		{
			self AddMenu("editBot2", 1, "Up bot talk: "+self.menu_player.pers["bots"]["trait"]["talk"], ::__edit, 14, 0);
			self AddMenu("editBot2", 2, "Down bot talk: "+self.menu_player.pers["bots"]["trait"]["talk"], ::__edit, 14, 1);
			self AddMenu("editBot2", 3, "Up bot camp: "+self.menu_player.pers["bots"]["trait"]["camp"], ::__edit, 15, 0);
			self AddMenu("editBot2", 4, "Down bot camp: "+self.menu_player.pers["bots"]["trait"]["camp"], ::__edit, 15, 1);
			self AddMenu("editBot2", 5, "Up bot follow: "+self.menu_player.pers["bots"]["trait"]["follow"], ::__edit, 16, 0);
			self AddMenu("editBot2", 6, "Down bot follow: "+self.menu_player.pers["bots"]["trait"]["follow"], ::__edit, 16, 1);
			self AddMenu("editBot2", 7, "Bot playStyle: "+self.menu_player.pers["bots"]["trait"]["playStyle"], ::__edit, 17, 0);
			self AddMenu("editBot2", 8, "Bot vengeful: "+self.menu_player.pers["bots"]["trait"]["vengeful"], ::__edit, 7, 0);
			self AddMenu("editBot2", 9, "Bot killsOverObj: "+self.menu_player.pers["bots"]["trait"]["killsOverObj"], ::__edit, 8, 0);
			self AddMenu("editBot2", 10, "Bot randomTrait: "+self.menu_player.bots_traitRandom, ::__edit, 9, 0);
		}
		
		//
		
		self AddMenu("Main", 9, "Edit bot3", ::OpenSub, "editBot3", "");
		self AddBack("editBot3", "Main");
		
		self AddMenu("editBot3", 0, "bots_fragList: "+level.bots_fragList.size, ::_edit, 1, "bots_fragList: "+level.bots_fragList.size);
		if(isDefined(self.menu_player))
		{
			self AddMenu("editBot3", 1, "Up bot cfTime: "+self.menu_player.pers["bots"]["trait"]["cfTime"], ::__edit, 18, 0);
			self AddMenu("editBot3", 2, "Down bot cfTime: "+self.menu_player.pers["bots"]["trait"]["cfTime"], ::__edit, 18, 1);
			self AddMenu("editBot3", 3, "Up bot knife: "+self.menu_player.pers["bots"]["trait"]["knife"], ::__edit, 19, 0);
			self AddMenu("editBot3", 4, "Down bot knife: "+self.menu_player.pers["bots"]["trait"]["knife"], ::__edit, 19, 1);
			self AddMenu("editBot3", 5, "Up bot nade: "+self.menu_player.pers["bots"]["trait"]["nade"], ::__edit, 20, 0);
			self AddMenu("editBot3", 6, "Down bot nade: "+self.menu_player.pers["bots"]["trait"]["nade"], ::__edit, 20, 1);
			self AddMenu("editBot3", 7, "Up bot switch: "+self.menu_player.pers["bots"]["trait"]["switch"], ::__edit, 21, 0);
			self AddMenu("editBot3", 8, "Down bot switch: "+self.menu_player.pers["bots"]["trait"]["switch"], ::__edit, 21, 1);
			self AddMenu("editBot3", 9, "Up bot rage: "+self.menu_player.pers["bots"]["trait"]["rage"], ::__edit, 22, 0);
			self AddMenu("editBot3", 10, "Down bot rage: "+self.menu_player.pers["bots"]["trait"]["rage"], ::__edit, 22, 1);
			self AddMenu("editBot3", 11, "Up bot change: "+self.menu_player.pers["bots"]["trait"]["change"], ::__edit, 23, 0);
			self AddMenu("editBot3", 12, "Down bot change: "+self.menu_player.pers["bots"]["trait"]["change"], ::__edit, 23, 1);
			self AddMenu("editBot3", 13, "Up bot watch: "+self.menu_player.pers["bots"]["trait"]["watch"], ::__edit, 24, 0);
			self AddMenu("editBot3", 14, "Down bot watch: "+self.menu_player.pers["bots"]["trait"]["watch"], ::__edit, 24, 1);
			self AddMenu("editBot3", 15, "Up bot run: "+self.menu_player.pers["bots"]["trait"]["run"], ::__edit, 25, 0);
			self AddMenu("editBot3", 16, "Down bot run: "+self.menu_player.pers["bots"]["trait"]["run"], ::__edit, 25, 1);
		}
		
		//
		
		self AddMenu("Main", 10, "Debug", ::OpenSub, "editBot4", "");
		self AddBack("editBot4", "Main");
		
		self AddMenu("editBot4", 0, "bots_smokeList: "+level.bots_smokeList.size, ::_edit, 1, "bots_smokeList: "+level.bots_smokeList.size);
		self AddMenu("editBot4", 1, "bots_knifeDis: "+level.bots_knifeDis, ::_edit, 1, "bots_knifeDis: "+level.bots_knifeDis);
		self AddMenu("editBot4", 2, "bots_knifeDisPerk: "+level.bots_knifeDisPerk, ::_edit, 1, "bots_knifeDisPerk: "+level.bots_knifeDisPerk);
		self AddMenu("editBot4", 3, "bots_moveSpeedBase: "+level.bots_moveSpeedBase, ::_edit, 1, "bots_moveSpeedBase: "+level.bots_moveSpeedBase);
		if(isDefined(self.menu_player))
		{
			self AddMenu("editBot4", 4, "bots_firing: "+self.menu_player.bots_firing, ::_edit, 1, "bots_firing: "+self.menu_player.bots_firing);
			self AddMenu("editBot4", 5, "bots_isHost: "+self.menu_player.pers["bots_isHost"], ::_edit, 1, "bots_isHost: "+self.menu_player.pers["bots_isHost"]);
			self AddMenu("editBot4", 6, "bots_vObjectivePos: "+self.menu_player.bots_vObjectivePos, ::_edit, 1, "bots_vObjectivePos: "+self.menu_player.bots_vObjectivePos);
			self AddMenu("editBot4", 7, "ks1: "+self.menu_player.pers["bots"]["killstreaks"][0], ::_edit, 1, "ks1: "+self.menu_player.pers["bots"]["killstreaks"][0]);
			self AddMenu("editBot4", 8, "ks2: "+self.menu_player.pers["bots"]["killstreaks"][1], ::_edit, 1, "ks2: "+self.menu_player.pers["bots"]["killstreaks"][1]);
			self AddMenu("editBot4", 9, "ks3: "+self.menu_player.pers["bots"]["killstreaks"][2], ::_edit, 1, "ks3: "+self.menu_player.pers["bots"]["killstreaks"][2]);
			self AddMenu("editBot4", 10, "bots_currentStaticWp: "+self.menu_player.bots_currentStaticWp, ::_edit, 1, "bots_currentStaticWp: "+self.menu_player.bots_currentStaticWp);
			self AddMenu("editBot4", 11, "bots_tempwp: "+self.menu_player.bots_tempwp, ::_edit, 1, "bots_tempwp: "+self.menu_player.bots_tempwp);
			self AddMenu("editBot4", 12, "bots_fMoveSpeed: "+self.menu_player.bots_fMoveSpeed, ::_edit, 1, "bots_fMoveSpeed: "+self.menu_player.bots_fMoveSpeed);
			self AddMenu("editBot4", 13, "bots_runDelay: "+self.menu_player.bots_runDelay, ::_edit, 1, "bots_runDelay: "+self.menu_player.bots_runDelay);
			if(isDefined(self.menu_player.bots_anime.animation))
				self AddMenu("editBot4", 14, "bots_anime.animation: "+self.menu_player.bots_anime.animation, ::_edit, 1, "bots_anime.animation: "+self.menu_player.bots_anime.animation);
			else
				self AddMenu("editBot4", 14, "bots_anime.animation: undefined", ::_edit, 1, "bots_anime.animation: undefined");
		}
		
		//
		
		self AddMenu("Main", 11, "Debug2", ::OpenSub, "editBot5", "");
		self AddBack("editBot5", "Main");
		
		if(isDefined(level.bots_goalRad))
			self AddMenu("editBot5", 0, "bots_goalRad: "+level.bots_goalRad, ::_edit, 1, "bots_goalRad: "+level.bots_goalRad);
		else
			self AddMenu("editBot5", 0, "bots_goalRad: undefined", ::_edit, 1, "bots_goalRad: undefined");
		
		if(isDefined(self.menu_player))
		{
			self AddMenu("editBot5", 1, "primary: "+self.menu_player.pers["bots"]["class"]["primary"], ::_edit, 1, "primary: "+self.menu_player.pers["bots"]["class"]["primary"]);
			self AddMenu("editBot5", 2, "primarycamo: "+self.menu_player.pers["bots"]["class"]["primaryCamo"], ::_edit, 1, "primarycamo: "+self.menu_player.pers["bots"]["class"]["primaryCamo"]);
			self AddMenu("editBot5", 3, "secondary: "+self.menu_player.pers["bots"]["class"]["secondary"], ::_edit, 1, "secondary: "+self.menu_player.pers["bots"]["class"]["secondary"]);
			self AddMenu("editBot5", 4, "secondaryCamo: "+self.menu_player.pers["bots"]["class"]["secondaryCamo"], ::_edit, 1, "secondaryCamo: "+self.menu_player.pers["bots"]["class"]["secondaryCamo"]);
			self AddMenu("editBot5", 5, "perk1: "+self.menu_player.pers["bots"]["class"]["perk1"], ::_edit, 1, "perk1: "+self.menu_player.pers["bots"]["class"]["perk1"]);
			self AddMenu("editBot5", 6, "perk1pro: "+self.menu_player.pers["bots"]["class"]["perk1pro"], ::_edit, 1, "perk1pro: "+self.menu_player.pers["bots"]["class"]["perk1pro"]);
			self AddMenu("editBot5", 7, "perk2: "+self.menu_player.pers["bots"]["class"]["perk2"], ::_edit, 1, "perk2: "+self.menu_player.pers["bots"]["class"]["perk2"]);
			self AddMenu("editBot5", 8, "perk2pro: "+self.menu_player.pers["bots"]["class"]["perk2pro"], ::_edit, 1, "perk2pro: "+self.menu_player.pers["bots"]["class"]["perk2pro"]);
			self AddMenu("editBot5", 9, "perk3: "+self.menu_player.pers["bots"]["class"]["perk3"], ::_edit, 1, "perk3: "+self.menu_player.pers["bots"]["class"]["perk3"]);
			self AddMenu("editBot5", 10, "perk3pro: "+self.menu_player.pers["bots"]["class"]["perk3pro"], ::_edit, 1, "perk3pro: "+self.menu_player.pers["bots"]["class"]["perk3pro"]);
			self AddMenu("editBot5", 11, "deathPerk: "+self.menu_player.pers["bots"]["class"]["deathPerk"], ::_edit, 1, "deathPerk: "+self.menu_player.pers["bots"]["class"]["deathPerk"]);
			self AddMenu("editBot5", 12, "grenade: "+self.menu_player.pers["bots"]["class"]["grenade"], ::_edit, 1, "grenade: "+self.menu_player.pers["bots"]["class"]["grenade"]);
			self AddMenu("editBot5", 13, "offhand: "+self.menu_player.pers["bots"]["class"]["offhand"], ::_edit, 1, "offhand: "+self.menu_player.pers["bots"]["class"]["offhand"]);
			self AddMenu("editBot5", 14, "classSet: "+self.menu_player.pers["bots"]["class"]["set"], ::_edit, 1, "set: "+self.menu_player.pers["bots"]["class"]["set"]);
			self AddMenu("editBot5", 15, "bots_lastKS: "+self.menu_player.bots_lastKS, ::_edit, 1, "bots_lastKS: "+self.menu_player.bots_lastKS);
			self AddMenu("editBot5", 16, "ksSet: "+self.menu_player.pers["bots"]["killstreaks"]["set"], ::_edit, 1, "ksSet: "+self.menu_player.pers["bots"]["killstreaks"]["set"]);
			if(isDefined(self.menu_player.bots_realEqu))
				self AddMenu("editBot5", 17, "bots_realEqu: "+self.menu_player.bots_realEqu.bots_EquipmentType, ::_edit, 1, "bots_realEqu: "+self.menu_player.bots_realEqu.bots_EquipmentType);
			else
				self AddMenu("editBot5", 17, "bots_realEqu: undefined", ::_edit, 1, "bots_realEqu: undefined");
			if(isDefined(self.menu_player.bots_omaChange))
				self AddMenu("editBot5", 18, "bots_omaChange: defined", ::_edit, 1, "bots_omaChange: defined");
			else
				self AddMenu("editBot5", 18, "bots_omaChange: undefined", ::_edit, 1, "bots_omaChange: undefined");
		}
		
		//
		
		self AddMenu("Main", 12, "Debug3", ::OpenSub, "editBot6", "");
		self AddBack("editBot6", "Main");
		
		self AddMenu("editBot6", 0, "bots_minNadeDis: "+level.bots_minNadeDis, ::_edit, 1, "bots_minNadeDis: "+level.bots_minNadeDis);
		if(isDefined(self.menu_player))
		{
			self AddMenu("editBot6", 1, "bots_objDoing: "+self.menu_player.bots_objDoing, ::_edit, 1, "bots_objDoing: "+self.menu_player.bots_objDoing);
			self AddMenu("editBot6", 2, "bots_aimDoing: "+self.menu_player.bots_aimDoing, ::_edit, 1, "bots_aimDoing: "+self.menu_player.bots_aimDoing);
			self AddMenu("editBot6", 3, "bots_doing: "+self.menu_player.bots_doing, ::_edit, 1, "bots_doing: "+self.menu_player.bots_doing);
			self AddMenu("editBot6", 4, "bots_camping: "+self.menu_player.bots_camping, ::_edit, 1, "bots_camping: "+self.menu_player.bots_camping);
			if(isDefined(self.menu_player.bots_campingAngles))
				self AddMenu("editBot6", 5, "bots_campingAngles: "+self.menu_player.bots_campingAngles, ::_edit, 1, "bots_campingAngles: "+self.menu_player.bots_campingAngles);
			else
				self AddMenu("editBot6", 5, "bots_campingAngles: undefined", ::_edit, 1, "bots_campingAngles: undefined");
			if(isDefined(self.menu_player.bots_isCare))
				self AddMenu("editBot6", 6, "bots_isCare: "+self.menu_player.bots_isCare.bots_reachable, ::_edit, 1, "bots_isCare: "+self.menu_player.bots_isCare.bots_reachable);
			else
				self AddMenu("editBot6", 6, "bots_isCare: undefined", ::_edit, 1, "bots_isCare: undefined");
			self AddMenu("editBot6", 7, "bots_running: "+self.menu_player.bots_running, ::_edit, 1, "bots_running: "+self.menu_player.bots_running);
			self AddMenu("editBot6", 8, "bots_runTime: "+self.menu_player.bots_runTime, ::_edit, 1, "bots_runTime: "+self.menu_player.bots_runTime);
			if(isdefined(self.menu_player.bots_realSeen))
				self AddMenu("editBot6", 9, "bots_realSeen: "+self.menu_player.bots_realSeen.name, ::_edit, 1, "bots_realSeen: "+self.menu_player.bots_realSeen.name);
			else
				self AddMenu("editBot6", 9, "bots_realSeen: undefined", ::_edit, 1, "bots_realSeen: undefined");
			self AddMenu("editBot6", 10, "bots_shootTime: "+self.menu_player.bots_shootTime, ::_edit, 1, "bots_shootTime: "+self.menu_player.bots_shootTime);
			self AddMenu("editBot6", 11, "bots_switchTime: "+self.menu_player.bots_switchTime, ::_edit, 1, "bots_switchTime: "+self.menu_player.bots_switchTime);
			self AddMenu("editBot6", 12, "bots_atDeathLoc: "+self.menu_player.bots_atDeathLoc, ::_edit, 1, "bots_wasAtDeathLoc: "+self.menu_player.bots_atDeathLoc);
			if(isDefined(self.menu_player.bots_realTarKS))
				self AddMenu("editBot6", 13, "bots_realTarKS: defined", ::_edit, 1, "bots_realTarKS: defined");
			else
				self AddMenu("editBot6", 13, "bots_realTarKS: undefined", ::_edit, 1, "bots_realTarKS: undefined");
			self AddMenu("editBot6", 14, "bots_lastStaticWP: "+self.menu_player.bots_lastStaticWP, ::_edit, 1, "bots_lastStaticWP: "+self.menu_player.bots_lastStaticWP);
			self AddMenu("editBot6", 15, "bots_targetWpIdx: "+self.menu_player.bots_targetWpIdx, ::_edit, 1, "bots_targetWpIdx: "+self.menu_player.bots_targetWpIdx);
			self AddMenu("editBot6", 16, "bots_secondNextWp: "+self.menu_player.bots_secondNextWp, ::_edit, 1, "bots_secondNextWp: "+self.menu_player.bots_secondNextWp);
		}
	}
	else if(isFun)
	{
		self AddMenu("Main", 4, "Bot target", ::OpenSub, "target", "");
		self AddBack("target", "Main");
		
		self AddMenu("target", 0, "Bots will not target: "+getdvar("bots_main_target"), ::cheats, "target", "");
		for(i = 0; i < level.players.size; i++)
		{
			self AddMenu("target", i+1, "Bots will target "+level.players[i].name+".", ::cheats, "target", level.players[i].name);
		}
		
		//
		
		self AddMenu("Main", 5, "Give bot powers", ::OpenSub, "giveBot", "");
		self AddBack("giveBot", "Main");
		
		for(i = 0; i < level.players.size; i++)
		{
			if(isDefined(level.players[i].pers["isBot"]))
				self AddMenu("giveBot", i, "Toggle bot to "+level.players[i].name+": "+level.players[i].pers["isBot"], ::cheats, "togglebot", level.players[i]);
			else
				self AddMenu("giveBot", i, "Toggle bot to "+level.players[i].name+": 0", ::cheats, "togglebot", level.players[i]);
		}
		
		//
		
		self AddMenu("Main", 6, "Cheats", ::OpenSub, "cheats", "");
		self AddBack("cheats", "Main");
		
		_tempDvar = getDvarInt("bots_main_target_host");
		if(_tempDvar)
			_temp = "true";
		else
			_temp = "false";
		self AddMenu("cheats", 0, "Toggle bots can target host: "+_temp, ::cheats, "host", _tempDvar);
		
		_tempDvar = getDvarInt("bots_main_fun_who");
		switch(_tempDvar)
		{
			case 0:
				_temp = "players only";
			break;
			case 1:
				_temp = "everyone";
			break;
			case 2:
				_temp = "bots only";
			break;
			case 3:
				_temp = "hosts only";
			break;
			default:
				_temp = "out of range";
			break;
		}
		self AddMenu("cheats", 1, "Toggle who gets cheats: "+_temp, ::cheats, "who", _tempDvar);
		
		_tempDvar = getDvarInt("bots_main_fun_aim");
		switch(_tempDvar)
		{
			case 0:
				_temp = "off";
			break;
			case 1:
				_temp = "smooth";
			break;
			case 2:
				_temp = "snap";
			break;
			case 3:
				_temp = "unfair";
			break;
			default:
				_temp = "out of range";
			break;
		}
		self AddMenu("cheats", 2, "Toggle aimbot: "+_temp, ::cheats, "aim", _tempDvar);
		
		_tempDvar = getDvarInt("bots_main_fun_ks");
		switch(_tempDvar)
		{
			case 0:
				_temp = "off";
			break;
			case 1:
				_temp = "on";
			break;
			case 2:
				_temp = "on(limited)";
			break;
			default:
				_temp = "out of range";
			break;
		}
		self AddMenu("cheats", 3, "Toggle infinite killstreak: "+_temp, ::cheats, "ks", _tempDvar);
		
		_tempDvar = getDvarInt("missileMacross");
		if(_tempDvar)
			_temp = "true";
		else
			_temp = "false";
		self AddMenu("cheats", 4, "Missile Macross: "+_temp, ::cheats, "mm", _tempDvar);
		
		_tempDvar = getDvarFloat("player_burstFireCooldown");
		if(_tempDvar == 0.0)
			_temp = "true";
		else
			_temp = "false";
		self AddMenu("cheats", 5, "No burst cool down: "+_temp, ::cheats, "burst", _tempDvar);
		
		_tempDvar = getDvarInt("bg_forceDualWield");
		if(_tempDvar)
			_temp = "true";
		else
			_temp = "false";
		self AddMenu("cheats", 6, "Force dual wield: "+_temp, ::cheats, "fdw", _tempDvar);
		
		_tempDvar = getDvarInt("scr_maxPerPlayerExplosives");
		if(_tempDvar == 100)
			_temp = "true";
		else
			_temp = "false";
		self AddMenu("cheats", 7, "Infinite explosives: "+_temp, ::cheats, "explosives", _tempDvar);
		
		_tempDvar = getDvarInt("scr_deleteexplosivesonspawn");
		if(_tempDvar)
			_temp = "true";
		else
			_temp = "false";
		self AddMenu("cheats", 8, "Delete explosives on spawn: "+_temp, ::cheats, "deleteexplosives", _tempDvar);
		
		_tempDvar = getDvarInt("perk_extendedMeleeRange");
		if(_tempDvar == 255)
			_temp = "true";
		else
			_temp = "false";
		self AddMenu("cheats", 9, "Extended commando: "+_temp, ::cheats, "commando", _tempDvar);
		
		_tempDvar = getDvarFloat("perk_weapReloadMultiplier");
		if(_tempDvar == 0.0)
			_temp = "true";
		else
			_temp = "false";
		self AddMenu("cheats", 10, "Instant reload: "+_temp, ::cheats, "reload", _tempDvar);
		
		_tempDvar = getDvar("perk_quickDrawSpeedScale");
		if(_tempDvar == "2.14748e+009")
			_temp = "true";
		else
			_temp = "false";
		self AddMenu("cheats", 11, "Instant aim sights: "+_temp, ::cheats, "qd", _tempDvar);
		
		_tempDvar = getDvarInt("bots_main_fun_ammo");
		switch(_tempDvar)
		{
			case 0:
				_temp = "off";
			break;
			case 1:
				_temp = "on";
			break;
			case 2:
				_temp = "on(clip only)";
			break;
			case 3:
				_temp = "on(stock only)";
			break;
			default:
				_temp = "out of range";
			break;
		}
		self AddMenu("cheats", 12, "Toggle infinite ammo: "+_temp, ::cheats, "ammo", _tempDvar);
		
		_tempDvar = getDvarInt("g_speed");
		self AddMenu("cheats", 13, "Up walk speed: "+_tempDvar, ::cheats, "upspeed", _tempDvar);
		self AddMenu("cheats", 14, "Down walk speed: "+_tempDvar, ::cheats, "downspeed", _tempDvar);
		
		_tempDvar = getDvarInt("jump_height");
		self AddMenu("cheats", 15, "Up jump height: "+_tempDvar, ::cheats, "upjump", _tempDvar);
		self AddMenu("cheats", 16, "Down jump height: "+_tempDvar, ::cheats, "downjump", _tempDvar);
		
		_tempDvar = getDvarInt("bots_main_fun_ufo");
		if(_tempDvar)
			_temp = "true";
		else
			_temp = "false";
		self AddMenu("cheats", 17, "Toggle ufo mode: "+_temp, ::cheats, "ufo", _tempDvar);
		
		//
		
		self AddMenu("Main", 7, "Cheats2", ::OpenSub, "cheats2", "");
		self AddBack("cheats2", "Main");
		
		_tempDvar = getDvarInt("bots_main_fun_freeze");
		if(_tempDvar)
			_temp = "true";
		else
			_temp = "false";
		self AddMenu("cheats2", 0, "Toggle never freeze: "+_temp, ::cheats, "freeze", _tempDvar);
		
		_tempDvar = getDvarInt("bots_main_fun_perks");
		if(_tempDvar)
			_temp = "true";
		else
			_temp = "false";
		self AddMenu("cheats2", 1, "Toggle all perks: "+_temp, ::cheats, "perks", _tempDvar);
		
		_tempDvar = getDvarInt("bots_main_fun_wh");
		if(_tempDvar)
			_temp = "true";
		else
			_temp = "false";
		self AddMenu("cheats2", 2, "Toggle wallhacks: "+_temp, ::cheats, "wh", _tempDvar);
		
		_tempDvar = getDvarInt("bots_main_fun_recoil");
		if(_tempDvar)
			_temp = "true";
		else
			_temp = "false";
		self AddMenu("cheats2", 3, "Toggle recoil: "+_temp, ::cheats, "recoil", _tempDvar);
		
		_tempDvar = getDvarInt("bots_main_fun_defaultweapon");
		if(_tempDvar)
			_temp = "true";
		else
			_temp = "false";
		self AddMenu("cheats2", 4, "Toggle defaultweapon on spawn: "+_temp, ::cheats, "defaultweapon", _tempDvar);
		
		_tempDvar = getDvarInt("bots_main_fun_laser");
		if(_tempDvar)
			_temp = "true";
		else
			_temp = "false";
		self AddMenu("cheats2", 5, "Toggle laser: "+_temp, ::cheats, "laser", _tempDvar);
		
		_tempDvar = getDvarInt("bots_main_fun_god");
		if(_tempDvar)
			_temp = "true";
		else
			_temp = "false";
		self AddMenu("cheats2", 6, "Toggle godmode: "+_temp, ::cheats, "god", _tempDvar);
		
		_tempDvar = getDvarInt("bots_main_fun_walkingac130");
		if(_tempDvar)
			_temp = "true";
		else
			_temp = "false";
		self AddMenu("cheats2", 7, "Walking ac130: " + _temp, ::cheats, "ac130", _tempDvar);
		
		_tempDvar = getDvarInt("bots_main_fun_mb_stinger");
		if(_tempDvar)
			_temp = "true";
		else
			_temp = "false";
		self AddMenu("cheats2", 8, "Magic bullet stinger missiles: "+_temp, ::cheats, "magicbullet", _tempDvar);
		
		self AddMenu("cheats2", 9, "Teleport to crosshairs", ::cheats, "teletocross", 0);
		
		self AddMenu("cheats2", 10, "Teleport everyone to crosshairs", ::cheats, "teleelsetocross", 0);
		
		self AddMenu("cheats2", 11, "Teleport everyone to you", ::cheats, "teleelsetoyou", 0);
		
		_tempDvar = getDvarInt("g_knockback");
		self AddMenu("cheats2", 12, "Up knockback: "+_tempDvar, ::cheats, "knockup", _tempDvar);
		self AddMenu("cheats2", 13, "Down knockback: "+_tempDvar, ::cheats, "knockdown", _tempDvar);
		
		_tempDvar = getDvarInt("g_gravity");
		self AddMenu("cheats2", 14, "Up gravity: "+_tempDvar, ::cheats, "gravup", _tempDvar);
		self AddMenu("cheats2", 15, "Down gravity: "+_tempDvar, ::cheats, "gravdown", _tempDvar);
		
		self AddMenu("cheats2", 16, "Give Level 70", ::cheats, "xp", 0);
		self AddMenu("cheats2", 17, "Unlock all challenges", ::cheats, "unlock", 0);
		self AddMenu("cheats2", 18, "10th Prestige", ::cheats, "pres", 0);
		
		//
		
		self AddMenu("Main", 8, "Teleport to player", ::OpenSub, "tele", "");
		self AddBack("tele", "Main");
		
		for(i = 0; i < level.players.size; i++)
			self AddMenu("tele", i, "Teleport to "+level.players[i].name, ::cheats, "tele", level.players[i]);
		
		self AddMenu("Main", 9, "Toggle hosts", ::OpenSub, "hosts", "");
		self AddBack("hosts", "Main");
		
		for(i = 0; i < level.players.size; i++)
			self AddMenu("hosts", i, "Toggle " + level.players[i].name + " from being a host: " + (level.players[i].pers["bots_isHost"] && isDefined(level.players[i].menuInit)), ::cheats, "togglehost", level.players[i]);
		
		self AddMenu("Main", 10, "Kill player", ::OpenSub, "kill", "");
		self AddBack("kill", "Main");
		
		for(i = 0; i < level.players.size; i++)
			self AddMenu("kill", i, "Kill " + level.players[i].name, ::cheats, "suicide", level.players[i]);
	}
}

bot_func(a, b)
{
	switch(a)
	{
		case "add":
			setdvar("bots_manage_add", b);
			if(b == 1)
			{
				self iPrintln("Adding "+b+" bot.");
			}
			else
			{
				self iPrintln("Adding "+b+" bots.");
			}
		break;
		case "kick":
			result = false;
			foreach(player in level.players)
			{
				if(player bots_playerIsABot())
				{
					result = true;
					kick( player getEntityNumber(), "EXE_PLAYERKICKED" );
					if(!b)
						break;
				}
			}
			if(!result)
				self iPrintln("No bots to kick");
		break;
		case "autokick":
			setDvar("bots_manage_fill_kick", !b);
			self iPrintln("Kicking bots when bots_fill is exceeded: " + !b);
		break;
		case "fillmode":
			switch(b)
			{
				case 0:
					setdvar("bots_manage_fill_mode", 1);
					self iPrintln("bot_fill will now count only bots.");
				break;
				case 1:
					setdvar("bots_manage_fill_mode", 2);
					self iPrintln("bot_fill will now count everyone, adjusting to map.");
				break;
				case 2:
					setdvar("bots_manage_fill_mode", 3);
					self iPrintln("bot_fill will now count only bots, adjusting to map.");
				break;
				case 3:
					setdvar("bots_manage_fill_mode", 4);
					self iPrintln("bots will be used as team balance.");
				break;
				case 4:
					setdvar("bots_manage_fill_mode", 0);
					self iPrintln("bot_fill will now count everyone.");
				break;
				default:
					setdvar("bots_manage_fill_mode", 0);
					self iPrintln("bot_fill will now count everyone.");
				break;
			}
		break;
		case "fillup":
			setdvar("bots_manage_fill", b+1);
			self iPrintln("Increased to maintain "+(b+1)+" bot(s).");
		break;
		case "filldown":
			setdvar("bots_manage_fill", b-1);
			self iPrintln("Decreased to maintain "+(b-1)+" bot(s).");
		break;
		case "fillspec":
			setDvar("bots_manage_fill_spec", !b);
			self iPrintln("Count players on spectator for bots_fill: " + !b);
		break;
		case "reset":
			setdvar("bots_manage_reset", true);
			self iPrintlnBold("Resetting all bots...");
		break;
		case "team":
			switch(b)
			{
				case "autoassign":
					setdvar("bots_team", "allies");
					self iPrintlnBold("Changed bot team to allies.");
				break;
				case "allies":
					setdvar("bots_team", "axis");
					self iPrintlnBold("Changed bot team to axis.");
				break;
				case "axis":
					setdvar("bots_team", "custom");
					self iPrintlnBold("Changed bot team to custom.");
				break;
				case "custom":
					setdvar("bots_team", "autoassign");
					self iPrintlnBold("Changed bot team to autoassign.");
				break;
				default:
					setdvar("bots_team", "autoassign");
					self iPrintlnBold("Changed bot team to autoassign.");
				break;
			}
		break;
		case "teamup":
			setdvar("bots_team_amount", b+1);
			self iPrintln((b+1)+" bot(s) will try to be on axis team.");
		break;
		case "teamdown":
			setdvar("bots_team_amount", b-1);
			self iPrintln((b-1)+" bot(s) will try to be on axis team.");
		break;
		case "teamforce":
			setDvar("bots_team_force", !b);
			self iPrintln("Forcing bots to team: " + !b);
		break;
		case "teammode":
			setDvar("bots_team_mode", !b);
			self iPrintln("Only count bots on team: " + !b);
		break;
		case "skill":
			switch(b)
			{
				case 0:
					self iPrintlnBold("Changed bot skill to easy.");
					setDvar("bots_skill", 1);
				break;
				case 1:
					self iPrintlnBold("Changed bot skill to easy-med.");
					setDvar("bots_skill", 2);
				break;
				case 2:
					self iPrintlnBold("Changed bot skill to medium.");
					setDvar("bots_skill", 3);
				break;
				case 3:
					self iPrintlnBold("Changed bot skill to med-hard.");
					setDvar("bots_skill", 4);
				break;
				case 4:
					self iPrintlnBold("Changed bot skill to hard.");
					setDvar("bots_skill", 5);
				break;
				case 5:
					self iPrintlnBold("Changed bot skill to very hard.");
					setDvar("bots_skill", 6);
				break;
				case 6:
					self iPrintlnBold("Changed bot skill to hardest.");
					setDvar("bots_skill", 7);
				break;
				case 7:
					self iPrintlnBold("Changed bot skill to custom. Base is easy.");
					setDvar("bots_skill", 8);
				break;
				case 8:
					self iPrintlnBold("Changed bot skill to complete random. Takes effect at restart.");
					setDvar("bots_skill", 9);
				break;
				case 9:
					self iPrintlnBold("Changed bot skill to random. Takes effect at restart.");
					setDvar("bots_skill", 0);
				break;
				default:
					self iPrintlnBold("Changed bot skill to random. Takes effect at restart.");
					setDvar("bots_skill", 0);
				break;
			}
		break;
		case "axishardup":
			setdvar("bots_skill_axis_hard", (b+1));
			self iPrintln(((b+1))+" hard bots will be on axis team.");
		break;
		case "axisharddown":
			setdvar("bots_skill_axis_hard", (b-1));
			self iPrintln(((b-1))+" hard bots will be on axis team.");
		break;
		case "axismedup":
			setdvar("bots_skill_axis_med", (b+1));
			self iPrintln(((b+1))+" med bots will be on axis team.");
		break;
		case "axismeddown":
			setdvar("bots_skill_axis_med", (b-1));
			self iPrintln(((b-1))+" med bots will be on axis team.");
		break;
		case "allieshardup":
			setdvar("bots_skill_allies_hard", (b+1));
			self iPrintln(((b+1))+" hard bots will be on allies team.");
		break;
		case "alliesharddown":
			setdvar("bots_skill_allies_hard", (b-1));
			self iPrintln(((b-1))+" hard bots will be on allies team.");
		break;
		case "alliesmedup":
			setdvar("bots_skill_allies_med", (b+1));
			self iPrintln(((b+1))+" med bots will be on allies team.");
		break;
		case "alliesmeddown":
			setdvar("bots_skill_allies_med", (b-1));
			self iPrintln(((b-1))+" med bots will be on allies team.");
		break;
		case "talkup":
			setdvar("bots_play_talk", b+0.1);
			self iPrintln((b+0.1)+" bot talk rate.");
		break;
		case "talkdown":
			setdvar("bots_play_talk", b-0.1);
			self iPrintln((b-0.1)+" bot talk rate.");
		break;
		case "rage":
			setDvar("bots_play_rageQuit", !b);
			self iPrintln("Bots will rage quit: " + !b);
		break;
		case "killcam":
			switch(b)
			{
				case 0:
					setDvar("bots_play_watchKillcam", 1);
					self iPrintln("Bots will watch killcams by chance");
				break;
				case 1:
					setDvar("bots_play_watchKillcam", 2);
					self iPrintln("Bots will always watch killcams");
				break;
				case 2:
					setDvar("bots_play_watchKillcam", 0);
					self iPrintln("Bots will not watch killcams");
				break;
				default:
					setDvar("bots_play_watchKillcam", 1);
					self iPrintln("Bots will watch killcams by chance");
				break;
			}
		break;
		case "anims":
			switch(b)
			{
				case 0:
					setDvar("bots_play_fakeAnims", 1);
					self iPrintln("Bots will play fake animations");
				break;
				case 1:
					setDvar("bots_play_fakeAnims", 2);
					self iPrintln("Bots will look like they are walking");
				break;
				case 2:
					setDvar("bots_play_fakeAnims", 0);
					self iPrintln("Bots will not use fake animations");
				break;
				default:
					setDvar("bots_play_fakeAnims", 1);
					self iPrintln("Bots will play fake animations");
				break;
			}
		break;
		case "equ":
			setDvar("bots_play_destroyEq", !b);
			self iPrintln("Bots will destroy equipment: " + !b);
		break;
		case "tdks":
			setDvar("bots_play_tdks", !b);
			self iPrintln("Bots will destroy killstreaks: " + !b);
		break;
		case "oomw":
			if(b <= 0)
			{
				setDvar("bots_play_outOfMyWay", 60.0);
				self iPrintln("Bots will move out of the way: true");
			}
			else
			{
				setDvar("bots_play_outOfMyWay", 0.0);
				self iPrintln("Bots will move out of the way: false");
			}
		break;
		case "stuck":
			setDvar("bots_play_doStuck", !b);
			self iPrintln("Bots will suicide if stuck: " + !b);
		break;
		case "move":
			setDvar("bots_play_move", !b);
			self iPrintln("Bots will move: " + !b);
		break;
		case "camp":
			setDvar("bots_play_camp", !b);
			self iPrintln("Bots will camp: " + !b);
		break;
		case "attack":
			setDvar("bots_play_attack", !b);
			self iPrintln("Bots will attack: " + !b);
		break;
		case "care":
			setDvar("bots_play_takeCare", !b);
			self iPrintln("Bots will take carepackages: " + !b);
		break;
		case "run":
			setDvar("bots_play_run", !b);
			self iPrintln("Bots will run: " + !b);
		break;
		case "obj":
			setDvar("bots_play_obj", !b);
			self iPrintln("Bots will do gametype objectives: " + !b);
		break;
		case "tb":
			setDvar("bots_play_throwback", !b);
			self iPrintln("Bots will throwback grenades: " + !b);
		break;
		case "foot":
			setDvar("bots_play_footsounds", !b);
			self iPrintln("Bots will use fake footsounds: " + !b);
		break;
		case "loadout":
			switch(b)
			{
				case "random":
					self iPrintlnBold("Changed bot mode to default.");
					setDvar("bots_loadout", "default");
				break;
				case "default":
					self iPrintlnBold("Changed bot mode to snipe.");
					setDvar("bots_loadout", "snipe");
				break;
				case "snipe":
					self iPrintlnBold("Changed bot mode to tube.");
					setDvar("bots_loadout", "tube");
				break;
				case "tube":
					self iPrintlnBold("Changed bot mode to knife.");
					setDvar("bots_loadout", "knife");
				break;
				case "knife":
					self iPrintlnBold("Changed bot mode to none.");
					setDvar("bots_loadout", "none");
				break;
				case "none":
					self iPrintlnBold("Changed bot mode to fmj.");
					setDvar("bots_loadout", "fmj");
				break;
				case "fmj":
					self iPrintlnBold("Changed bot mode to mod.");
					setDvar("bots_loadout", "mod");
				break;
				case "mod":
					self iPrintlnBold("Changed bot mode to level.");
					setDvar("bots_loadout", "level");
				break;
				case "level":
					self iPrintlnBold("Changed bot mode to random.");
					setDvar("bots_loadout", "random");
				break;
				default:
					self iPrintlnBold("Changed bot mode to random.");
					setDvar("bots_loadout", "random");
				break;
			}
		break;
		case "ks":
			switch(b)
			{
				case "random":
					self iPrintlnBold("Changed bot killstreak mode to default.");
					setDvar("bots_loadout_killstreak", "default");
				break;
				case "default":
					self iPrintlnBold("Changed bot killstreak mode to none.");
					setDvar("bots_loadout_killstreak", "none");
				break;
				case "none":
					self iPrintlnBold("Changed bot killstreak mode to level.");
					setDvar("bots_loadout_killstreak", "level");
				break;
				case "level":
					self iPrintlnBold("Changed bot killstreak mode to random.");
					setDvar("bots_loadout_killstreak", "random");
				break;
				default:
					self iPrintlnBold("Changed bot killstreak mode to random.");
					setDvar("bots_loadout_killstreak", "random");
				break;
			}
		break;
		case "cclass":
			setDvar("bots_loadout_change", !b);
			self iPrintln("Bots will have a chance in changing their class: " + !b);
		break;
		case "rclass":
			setDvar("bots_loadout_remember", !b);
			self iPrintln("Bots will remember their class: " + !b);
		break;
		case "secondary":
			setDvar("bots_loadout_secondary", !b);
			self iPrintln("Bots will use secondaries: " + !b);
		break;
		case "ds":
			setDvar("bots_loadout_deathstreak", !b);
			self iPrintln("Bots will use deathstreaks: " + !b);
		break;
		case "ls":
			setDvar("bots_loadout_lastStand", !b);
			self iPrintln("Bots will use laststand: " + !b);
		break;
		case "riot":
			setDvar("bots_loadout_riot", !b);
			self iPrintln("Bots will use riot shields: " + !b);
		break;
		case "nuke":
			setDvar("bots_loadout_nuke", !b);
			self iPrintln("Bots will use nukes: " + !b);
		break;
		case "nade":
			setDvar("bots_loadout_nade", !b);
			self iPrintln("Bots will use grenades: " + !b);
		break;
		case "tube":
			setDvar("bots_loadout_tube", !b);
			self iPrintln("Bots will use explosives: " + !b);
		break;
		case "knife":
			setDvar("bots_loadout_knife", !b);
			self iPrintln("Bots will knife: " + !b);
		break;
		case "sniper":
			setDvar("bots_loadout_sniper", !b);
			self iPrintln("Bots will use snipers: " + !b);
		break;
		case "shotgun":
			setDvar("bots_loadout_shotgun", !b);
			self iPrintln("Bots will use shotguns: " + !b);
		break;
		case "akimbo":
			setDvar("bots_loadout_akimbo", !b);
			self iPrintln("Bots will use akimbo guns: " + !b);
		break;
	}
}

dump(a,b)
{
	logprint("Bot Warfare DVAR DUMP\n");
	dvars = strTok("bots_manage_add,bots_manage_fill,bots_manage_fill_mode,bots_manage_fill_kick,bots_manage_reset,bots_team,bots_team_amount,bots_team_force,bots_team_mode,bots_skill,bots_skill_axis_hard,bots_skill_axis_med,bots_skill_allies_hard,bots_skill_allies_med,bots_play_talk,bots_play_watchKillcam,bots_loadout_remember,bots_loadout_change,bots_play_rageQuit,bots_loadout_tube,bots_loadout_shotgun,bots_loadout_sniper,bots_loadout_knife,bots_loadout_nade,bots_play_camp,bots_play_obj,bots_play_run,bots_play_tdks,bots_play_takeCare,bots_loadout_killstreak,bots_loadout,bots_loadout_deathstreak,bots_play_outOfMyWay,bots_loadout_secondary,bots_play_attack,bots_play_move,bots_play_doStuck,bots_loadout_nuke,bots_loadout_riot,bots_loadout_lastStand,bots_play_destroyEq,bots_play_fakeAnims,bots_main_menu,bots_main_GUIDs,bots_main,bots_main_Names,bots_main_experience,bots_main_prestige,bots_main_debug,bots_main_target,bots_main_title,bots_main_emblem,bots_play_throwback,bots_loadout_akimbo,bots_manage_fill_spec,bots_play_footsounds,bots_main_fun", ",");
	i = 0;
	newList = [];
	newList2 = [];
	newList3 = [];
	newList4 = [];
	newList5 = [];
	newList6 = [];
	newList7 = [];
	foreach(dvar in dvars)
	{
		if(i <= 10)
			newList[newList.size] = "set "+dvar+" \""+getdvar(dvar)+"\"\n";
		else if (i <= 20)
			newList2[newList2.size] = "set "+dvar+" \""+getdvar(dvar)+"\"\n";
		else if (i <= 30)
			newList3[newList3.size] = "set "+dvar+" \""+getdvar(dvar)+"\"\n";
		else if (i <= 40)
			newList4[newList4.size] = "set "+dvar+" \""+getdvar(dvar)+"\"\n";
		else if (i <= 50)
			newList5[newList5.size] = "set "+dvar+" \""+getdvar(dvar)+"\"\n";
		else if( i <= 60 )
			newList6[newList6.size] = "set "+dvar+" \""+getdvar(dvar)+"\"\n";
		else if( i <= 70 )
			newList7[newList7.size] = "set "+dvar+" \""+getdvar(dvar)+"\"\n";
		i++;
	}
	_list = "";
	foreach(list in newList)
	{
		_list = _list + list;
	}
	logprint(_list);
	_list = "";
	foreach(list in newList2)
	{
		_list = _list + list;
	}
	logprint(_list);
	_list = "";
	foreach(list in newList3)
	{
		_list = _list + list;
	}
	logprint(_list);
	_list = "";
	foreach(list in newList4)
	{
		_list = _list + list;
	}
	logprint(_list);
	_list = "";
	foreach(list in newList5)
	{
		_list = _list + list;
	}
	logprint(_list);
	_list = "";
	foreach(list in newList6)
	{
		_list = _list + list;
	}
	logprint(_list);
	_list = "";
	foreach(list in newList7)
	{
		_list = _list + list;
	}
	logprint(_list);
	self iPrintln("DUMPED DVARS to games_mp.log");
}

checkButtons()
{
	self endon("disconnect");
	
	self waittill("spawned_player");
	
	wait 0.25;
	
	if(getDvarInt("bots_main_menu"))
	{
		if(self adsButtonPressed() && self useButtonPressed() && self fragButtonPressed())
			setDvar("bots_main_fun", true);
		else if(self SecondaryOffhandButtonPressed() && self meleeButtonPressed() && self attackButtonPressed())
			setDvar("bots_main_debug", true);
	}
}

cheats(a, b)
{
	switch(a)
	{
		case "togglebot":
			if(!b bots_playerIsABot())
			{
				b.pers["isBot"] = true;
				b.bots_fixOnce = 1;
				
				b thread bots\bots::bots_watchDisconnect();
				b thread bots\bots::bots_StartBots();
				self iPrintln(b.name+" is now a bot.");
			}
			else
			{
				b bots\bots_anim::bots_deleteFakeAnim();
				b bots_clearStructs();
				
				b.pers["isBot"] = undefined;
				b.bots_fixOnce = undefined;
				b freezeControls(false);
				b notify("bot_reset");
				
				self iPrintln(b.name+" is now not a bot.");
			}
		break;
		case "togglehost":
			if(b.pers["bots_isHost"] && isDefined(b.menuInit))
			{
				b.pers["bots_isHost"] = false;
				b.menuInit = undefined;
				b notify("bots_kill_menu");
				
				if(isDefined(b.menuOpen) && b.menuOpen)
				{
					b setClientDvar( "r_blur", "0" ); 
					b setClientDvar( "sc_blur", "2" );
					b freezeControls(false);
				}
				
				self iPrintln("Removing "+b.name+" from being a host.");
			}
			else
			{
				b.pers["bots_isHost"] = true;
				
				b.menuInit = undefined;
				b notify("bots_kill_menu");
				
				if(isDefined(b.menuOpen) && b.menuOpen)
				{
					b setClientDvar( "r_blur", "0" ); 
					b setClientDvar( "sc_blur", "2" );
					b freezeControls(false);
				}
				
				b thread init();
				
				self iPrintln("Making "+b.name+" a host.");
			}
		break;
		case "target":
			setdvar("bots_main_target", b);
			self iPrintln("Bots will target "+b+".");
		break;
		case "host":
			setDvar("bots_main_target_host", !b);
			self iPrintln("Target host = " + !b);
		break;
		case "who":
			switch(b)
			{
				case 0:
					setdvar("bots_main_fun_who", 1);
					self iPrintln("Cheats for everyone.");
				break;
				case 1:
					setdvar("bots_main_fun_who", 2);
					self iPrintln("Cheats for bots only.");
				break;
				case 2:
					setdvar("bots_main_fun_who", 3);
					self iPrintln("Cheats for host(s) only.");
				break;
				case 3:
					setdvar("bots_main_fun_who", 0);
					self iPrintln("Cheats for players only.");
				break;
				default:
					setdvar("bots_main_fun_who", 0);
					self iPrintln("Cheats for players only.");
				break;
			}
		break;
		case "mm":
			setdvar("missileMacross", !b);
			self iPrintln("missileMacross = " + !b);
		break;
		case "burst":
			if(b == 0.2)
				setdvar("player_burstFireCooldown", 0.0);
			else
				setdvar("player_burstFireCooldown", 0.2);
			
			self iPrintln("BurstFire = " + (b == 0.2));
		break;
		case "fdw":
			setdvar("bg_forceDualWield", !b);
			self iPrintln("ForceDualWield = " + !b);
		break;
		case "explosives":
			if(b == 2)
				setDvar("scr_maxPerPlayerExplosives", 100);
			else
				setDvar("scr_maxPerPlayerExplosives", 2);
			
			level.maxPerPlayerExplosives = max( getIntProperty( "scr_maxPerPlayerExplosives", 2 ), 1 );
			
			self iPrintln("Infinite Explosives = " + (b == 2));
		break;
		case "deleteexplosives":
			setdvar("scr_deleteexplosivesonspawn", !b);
			self iPrintln("DeleteExplosives = " + !b);
		break;
		case "commando":
			if(b == 176)
				setDvar("perk_extendedMeleeRange", 255);
			else
				setDvar("perk_extendedMeleeRange", 176);
			
			self iPrintln("Commando = " + (b == 176));
		break;
		case "reload":
			if(b == 0.5)
				setDvar("perk_weapReloadMultiplier", 0.0);
			else
				setDvar("perk_weapReloadMultiplier", 0.5);
			
			self iPrintln("Reload = " + (b == 0.5));
		break;
		case "qd":
			if(b == "1.5")
				setDvar("perk_quickDrawSpeedScale", 2147483647.0);//max cash stack
			else
				setDvar("perk_quickDrawSpeedScale", 1.5);
			
			self iPrintln("Quickdraw = " + (b == "1.5"));
		break;
		case "upspeed":
			setDvar("g_speed", b+1);
			self iPrintln("Speed at " + (b+1));
		break;
		case "downspeed":
			setDvar("g_speed", b-1);
			self iPrintln("Speed at " + (b-1));
		break;
		case "upjump":
			setDvar("jump_height", b+1);
			self iPrintln("Jump at " + (b+1));
		break;
		case "downjump":
			setDvar("jump_height", b-1);
			self iPrintln("Jump at " + (b-1));
		break;
		case "ufo":
			setDvar("bots_main_fun_ufo", !b);
			self iPrintln("Ufo = " + !b);
		break;
		case "ammo":
			switch(b)
			{
				case 0:
					setdvar("bots_main_fun_ammo", 1);
					self iPrintln("Infinite ammo");
				break;
				case 1:
					setdvar("bots_main_fun_ammo", 2);
					self iPrintln("Infinite ammo (clip)");
				break;
				case 2:
					setdvar("bots_main_fun_ammo", 3);
					self iPrintln("Infinite ammo (stock)");
				break;
				case 3:
					setdvar("bots_main_fun_ammo", 0);
					self iPrintln("No infinite ammo");
				break;
				default:
					setdvar("bots_main_fun_ammo", 0);
					self iPrintln("No infinite ammo");
				break;
			}
		break;
		case "freeze":
			setDvar("bots_main_fun_freeze", !b);
			self iPrintln("Never freeze = " + !b);
		break;
		case "perks":
			setDvar("bots_main_fun_perks", !b);
			self iPrintln("Perks = " + !b);
		break;
		case "wh":
			setDvar("bots_main_fun_wh", !b);
			self iPrintln("Wallhacks = " + !b);
		break;
		case "defaultweapon":
			setDvar("bots_main_fun_defaultweapon", !b);
			self iPrintln("Defaultweapon = " + !b);
		break;
		case "recoil":
			setDvar("bots_main_fun_recoil", !b);
			self iPrintln("Recoil = " + !b);
		break;
		case "god":
			setDvar("bots_main_fun_god", !b);
			self iPrintln("God = " + !b);
		break;
		case "laser":
			setDvar("bots_main_fun_laser", !b);
			self iPrintln("Laser = " + !b);
		break;
		case "aim":
			switch(b)
			{
				case 0:
					setdvar("bots_main_fun_aim", 1);
					self iPrintln("Smooth aimbot");
				break;
				case 1:
					setdvar("bots_main_fun_aim", 2);
					self iPrintln("Aimbot snap");
				break;
				case 2:
					setdvar("bots_main_fun_aim", 3);
					self iPrintln("Unfair aimbot");
				break;
				case 3:
					setdvar("bots_main_fun_aim", 0);
					self iPrintln("No aimbot");
				break;
				default:
					setdvar("bots_main_fun_aim", 0);
					self iPrintln("No aimbot");
				break;
			}
		break;
		case "ks":
			switch(b)
			{
				case 0:
					setdvar("bots_main_fun_ks", 1);
					self iPrintln("Infinite killstreaks");
				break;
				case 1:
					setdvar("bots_main_fun_ks", 2);
					self iPrintln("Infinite killstreaks (limited)");
				break;
				case 2:
					setdvar("bots_main_fun_ks", 0);
					self iPrintln("No infinite killstreaks");
				break;
				default:
					setdvar("bots_main_fun_ks", 0);
					self iPrintln("No infinite killstreaks");
				break;
			}
		break;
		case "ac130":
			setDvar("bots_main_fun_walkingac130", !b);
			self iPrintln("Walking ac130 = " + !b);
		break;
		case "magicbullet":
			setDvar("bots_main_fun_mb_stinger", !b);
			self iPrintln("MagicBullet stinger = " + !b);
		break;
		case "teletocross":
			if(isReallyAlive(self))
			{
				pos = bots_GetCursorPosition();
				
				if(isDefined(pos))
				{
					self setOrigin(pos);
				
					self iPrintln("Teleported to " + pos);
				}
			}
			else
				self iPrintln("You need to be spawned.");
		break;
		case "teleelsetocross":
			if(isReallyAlive(self))
			{
				pos = bots_GetCursorPosition();
				
				if(isDefined(pos))
				{
					foreach(player in level.players)
					{
						if(player == self)
							continue;
						if(!isReallyAlive(player))
							continue;
						
						if(player bots_playerIsABot())
						{
							player notify( "BotMovementComplete" );
							player notify("BotMovementCompleteDyn");
							player.bots_lastStaticWP = player.bots_currentStaticWp;
						}
						
						player setOrigin(pos);
					}
					
					self iPrintln("Teleported everyone to " + pos);
				}
			}
			else
				self iPrintln("You need to be spawned.");
		break;
		case "teleelsetoyou":
			if(isReallyAlive(self))
			{
				foreach(player in level.players)
				{
					if(player == self)
						continue;
					if(!isReallyAlive(player))
						continue;
					
					if(player bots_playerIsABot())
					{
						player notify( "BotMovementComplete" );
						player notify("BotMovementCompleteDyn");
						player.bots_lastStaticWP = player.bots_currentStaticWp;
					}
						
					player setOrigin(self.origin);
				}
				
				self iPrintln("Teleported everyone to " + self.origin);
			}
			else
				self iPrintln("You need to be spawned.");
		break;
		case "tele":
			if(isReallyAlive(self))
			{
				self iPrintln("Teleported to " + b.origin);
				self setOrigin(b.origin);
			}
			else
				self iPrintln("You need to be spawned.");
		break;
		case "suicide":
			if(isReallyAlive(b))
				b _suicide();
			else
				self iPrintln(b.name + " needs to be spawned.");
		break;
		case "knockup":
			setdvar("g_knockback", b+1);
			self iPrintln((b+1)+" knockback.");
		break;
		case "knockdown":
			setdvar("g_knockback", b-1);
			self iPrintln((b-1)+" knockback.");
		break;
		case "gravup":
			setdvar("g_gravity", b+1);
			self iPrintln((b+1)+" gravity.");
		break;
		case "gravdown":
			setdvar("g_gravity", b-1);
			self iPrintln((b-1)+" gravity.");
		break;
		case "xp":
			self thread xpCheat();
		break;
		case "pres":
			self setPlayerData("prestige", 10);
			self sayall("DONE");
		break;
		case "unlock":
			self thread completeAllChallenges();
		break;
	}
}

xpCheat()
{
	self notify("xp_overlap");
	self endon("xp_overlap");
	
	self endon("disconnect");
	//pezbot
	
	self iPrintln("Make sure another player or bot is playing.");
	
	while(level.players.size < 2)
		wait 0.05;
	
	self iPrintln("Giving XP...");
	
	while(self.pers["rank"] < 69)
	{
	    self thread maps\mp\gametypes\_rank::giveRankXP( "kill", 1000 );
	    wait 0.05;
	}
	
	self iPrintln("Now make sure to play until the end of the game.");
}

destroyElemOnDeath(elem)
{
	elem endon("death");
	
	self waittill_either( "xp_cheat", "disconnect" );
	
	elem destroyElem();
	elem notify("death");
}

completeAllChallenges()
{
	self notify( "xp_cheat" );
	self endon( "xp_cheat" );
	
    self endon( "disconnect" );
	
    chalProgress = 0;
    useBar = createPrimaryProgressBar( 25 );
	self thread destroyElemOnDeath(useBar);
    useBarText = createPrimaryProgressBarText( 25 );
	self thread destroyElemOnDeath(useBarText);
	
    foreach ( challengeRef, challengeData in level.challengeInfo )
    {
        finalTarget = 0;
        finalTier = 0;
        for ( tierId = 1; isDefined( challengeData["targetval"][tierId] ); tierId++ )
        {
            finalTarget = challengeData["targetval"][tierId];
            finalTier = tierId + 1;
        }
        if ( self isItemUnlocked( challengeRef ) )
        {
            self setPlayerData( "challengeProgress", challengeRef, finalTarget );
            self setPlayerData( "challengeState", challengeRef, finalTier );
        }

        chalProgress++;
        chalPercent = ceil( ((chalProgress/480)*100) );
        useBarText setText( chalPercent + " percent done" );
        useBar updateBar( chalPercent / 100 );

        wait ( 0.05 );
    }
	
    useBar destroyElem();
	useBar notify("death");
    useBarText destroyElem();
	useBarText notify("death");
}

doMagicBullets(weapon)
{
	self endon("death");
	self endon("disconnect");
	
	for(;;)
	{
		self waittill( "weapon_fired" );
		MagicBullet( weapon, self getTagOrigin("tag_eye"), self bots_GetCursorPosition(), self );
	}
}

waitSwitchAC130()
{
	self endon("disconnect");
	self endon("death");
	wait 0.05;
	self setSpawnWeapon("ac130_105mm_mp");
}

onPlayerSpawn()
{
	self endon("disconnect");
	
	for(;;)
	{
		self waittill("spawned_player");
		
		if(getdvarint("bots_main_fun"))
		{
			isBot = (self bots_playerIsABot());
			_temp = getdvarint("bots_main_fun_who");
			
			if(_temp == 1 || (!isBot && _temp == 0) || (isBot && _temp == 2) || (self.pers["bots_isHost"] && _temp == 3))
			{
				if(getdvarint("bots_main_fun_ufo"))
					self thread oUfo();
				
				if(getdvarint("bots_main_fun_ammo"))
					self thread infiniteAmmo();
				
				if(getdvarint("bots_main_fun_ks"))
					self thread infiniteKS();
				
				if(getdvarint("bots_main_fun_freeze"))
					self thread neverFreeze();
				
				if(getdvarint("bots_main_fun_perks"))
					self giveAllPerks();
				
				if(getdvarint("bots_main_fun_aim"))
				{
					if(getDvarInt("bots_main_fun_aim") != 1)
						self thread unfairAimbot();
					else
						self thread aimbutt();
				}
				
				if(getdvarint("bots_main_fun_wh"))
					self thread wallhacks();
				
				if(getdvarint("bots_main_fun_defaultweapon"))
					self _giveWeapon("defaultweapon_mp", 0);
				
				if(getdvarint("bots_main_fun_walkingac130"))
				{
					self giveWeapon( "ac130_105mm_mp", 0, false );
					self giveWeapon( "ac130_40mm_mp", 0, false );
					self giveWeapon( "ac130_25mm_mp", 0, false );
					self thread waitSwitchAC130();
				}
				
				if(getdvarint("bots_main_fun_mb_stinger"))
					self thread doMagicBullets("stinger_mp");
				
				if(getdvarint("bots_main_fun_recoil"))
					self player_recoilScaleOn(0);
				
				if(getDvarInt("bots_main_fun_god"))
					self thread doGod();
				
				self setClientDvar("player_burstFireCooldown", getDvarFloat("player_burstFireCooldown"));
				self setClientDvar("perk_extendedMeleeRange", getDvarInt("perk_extendedMeleeRange"));
				self setClientDvar("perk_weapReloadMultiplier", getDvarFloat("perk_weapReloadMultiplier"));
				self setClientDvar("perk_quickDrawSpeedScale", getDvarFloat("perk_quickDrawSpeedScale"));
				self setClientDvar("laserForceOn", getDvarInt("bots_main_fun_laser"));
			}
			else
			{
				if(self _hasPerk("specialty_coldblooded"))
					self _unsetPerk("specialty_coldblooded");
			}
		}
	}
}

wallhacks()
{
	self endon ( "disconnect" );
	self endon ( "death" );
	
	for(;;)
	{
		self ThermalVisionFOFOverlayOn();
		wait 1;
	}
}

infiniteKS()
{
	self endon ( "disconnect" );
	self endon ( "death" );
	
	lastKS = "";
	for(;;)
	{
		if(isDefined(self.pers["killstreaks"][0]) && self.pers["killstreaks"][0].streakName != "")
		{
			lastKS = self.pers["killstreaks"][0].streakName;
			if(self.pers["killstreaks"].size > 1)
			{
				self maps\mp\killstreaks\_killstreaks::clearKillstreaks();
				self maps\mp\killstreaks\_killstreaks::giveKillstreak( lastKS, false );
			}
		}
		else if(lastKS != "" && (getdvarint("bots_main_fun_ks") == 1 || (lastKS != "nuke" && lastKS != "ac130" && lastKS != "helicopter" && lastKS != "helicopter_flares" && lastKS != "helicopter_minigun")))
		{
			self maps\mp\killstreaks\_killstreaks::giveKillstreak( lastKS, false );
		}
		
		wait 0.05;
	}
}

doGod()
{
    self endon ( "disconnect" );
    self endon ( "death" );
	
    self.maxhealth = 2147000000;
    self.health = self.maxhealth;

    while ( getDvarInt("bots_main_fun_god") )
    {
        wait 0.05;
        if ( self.health < self.maxhealth )
            self.health = self.maxhealth;
    }
	
	self.maxhealth = 100;
    self.health = self.maxhealth;
}

neverFreeze()
{
	self endon ( "disconnect" );
	self endon ( "death" );
	
	for(;;)
	{
		self freezeControls(false);
		wait 0.05;
	}
}

giveAllPerks()
{
	//self _setPerk("specialty_bulletaccuracy");
	self _setPerk("specialty_steelnerves");
	self _setPerk("specialty_extendedmelee");
	self _setPerk("specialty_localjammer");
	//self _setPerk("specialty_delaymine");
	self _setPerk("specialty_quieter");
	self _setPerk("specialty_heartbreaker");
	self _setPerk("specialty_selectivehearing");
	self _setPerk("specialty_falldamage");
	self _setPerk("specialty_detectexplosive");
	self _setPerk("specialty_dangerclose");
	self _setPerk("specialty_explosivedamage");
	self _setPerk("specialty_spygame");
	self _setPerk("specialty_coldblooded");
	self _setPerk("specialty_hardline");
	self _setPerk("specialty_lightweight");
	self _setPerk("specialty_fastsprintrecovery");
	self _setPerk("specialty_armorpiercing");
	self _setPerk("specialty_bulletdamage");
	self _setPerk("specialty_fastmantle");
	self _setPerk("specialty_marathon");
	self _setPerk("specialty_quickdraw");
	self _setPerk("specialty_fastreload");
	self _setPerk("specialty_finalstand");
	self _setPerk("specialty_grenadepulldeath");
	self _setPerk("specialty_copycat");
	
	self _setPerk("specialty_rollover");
}

oUfo()
{
	self endon ( "disconnect" );
	self endon ( "death" );
	
	self notifyOnPlayerCommand("dpad_up", "+actionslot 1");
	maps\mp\gametypes\_spectating::setSpectatePermissions();
	for(;;)
	{
		self waittill("dpad_up");
		if(!self attackButtonPressed())
		{
			self allowSpectateTeam( "freelook", true );
			self.sessionstate = "spectator";
			self setContents( 0 );
			self waittill("dpad_up");
			self.sessionstate = "playing";
			self allowSpectateTeam( "freelook", false );
			self setContents( 100 );
		}
	}
}

infiniteAmmo()
{
	self endon ( "disconnect" );
	self endon ( "death" );
	
	for(;;)
	{
		what = getdvarint("bots_main_fun_ammo");
		
		weapons = self GetWeaponsListAll();
		foreach(weapon in weapons)
		{
			if(what == 1 || what == 3)
				self SetWeaponAmmoStock(weapon, 999);
			
			if(what == 1 || what == 2)
			{
				self SetWeaponAmmoClip(weapon, 999);
				self SetWeaponAmmoClip(weapon, 999, "left");
				self SetWeaponAmmoClip(weapon, 999, "right");
			}
		}
		wait 0.05;
	}
}

unfairAimbot()
{
	self endon( "disconnect" );
	self endon( "death" );
	for(;;)
	{
		wait 0.05;
		
		while( self adsButtonPressed() )
		{
			target = undefined;
			myEye = self getEye();
			daDvar = getDvarInt("bots_main_fun_aim");
			
			foreach(player in level.players)
			{
				if(player == self)
					continue;
				if(level.teamBased && self.pers["team"] == player.pers["team"])
					continue;
				if(!isReallyAlive(player))
					continue;
				if(!bulletTracePassed(myEye, player getTagOrigin( "j_head" ), false, player) && daDvar == 2)
					continue;
				
				target = player;
				break;
			}
			
			if(isDefined(target))
			{
				self setplayerangles( VectorToAngles( ( target getTagOrigin( "j_head" ) ) - ( myEye ) ) );
				if(daDvar == 3 && self attackButtonPressed())
					target thread [[level.callbackPlayerDamage]]( self, self, 999999, 8, "MOD_HEAD_SHOT", self getCurrentWeapon(), (0,0,0), (0,0,0), "head", 0 );
			}
			
			wait 0.05;
		}
	}
}

aimbutt()
{
	self endon( "disconnect" );
	self endon( "death" );
	for(;;)
	{
		if ( self useButtonPressed() )
		{
			target = undefined;
			
			while( self useButtonPressed() )
			{
				myEye = self getEye();
				if(!isDefined(target))
				{
					closest = undefined;
					foreach(player in level.players)
					{
						if(player == self)
							continue;
						if(level.teamBased && self.pers["team"] == player.pers["team"])
							continue;
						if(!isReallyAlive(player))
							continue;
						where = player getTagOrigin( "j_spineupper" );
						if(!bulletTracePassed(myEye, where, false, player))
							continue;
						
						dot = bots_getConeDot(where);
						if(dot >= 0.85)
						{
							if(!isDefined(closest) || dot > closest)
							{
								target = player;
								closest = dot;
							}
						}
					}
				}
				if(isDefined(target))
				{
					if(!isReallyAlive(target) || !bulletTracePassed(myEye, target getTagOrigin( "j_spineupper" ), false, target))
						target = undefined;
					else
					{
						weapon = self getCurrentWeapon();
						lookLoc = target getTagOrigin( "j_spineupper" );
						dis = Distance(myEye, target.origin);
						
						if(weaponClass(weapon) == "grenade" || weapon == "throwingknife_mp")
						{
							if(getWeaponClass(weapon) == "weapon_projectile")
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
						
						if(isDefined(target))
						{
							self thread doAim(angles, 4);
						}
					}
				}
				wait 0.05;
			}
		}
		else
		{
			self notify("aim_overlap");
		}
		wait 0.05;
	}
}

doAim(angles, speed)
{
	self notify("aim_overlap");
	self endon("aim_overlap");
	self endon("disconnect");
	self endon("death");
	
	self bots\bots_aim::bots_setPlayerAngesReal(angles, speed);
}

_edit(a, b)
{
	if(!a)
		self.menu_player = b;
	else
		self iPrintln(b);
}

DUMPBOT(a, b)
{
	if(!isDefined(self.menu_player))
		return;
	
	player = self.menu_player;
	
	logprint("Bot Warfare Bot DUMP\n");
	
	logprint("self.team = " + player.team + "\n");
	logprint("self.name = " + player.name + "\n");
	logprint("self.guid = " + player.guid + "\n");
	
	logprint("self.pers[\"isBot\"] = " + player.pers["isBot"] + "\n");
	
	logprint("self.pers[\"bots_isHost\"] = " + player.pers["bots_isHost"] + "\n");
	logprint("self.bots_firing = " + player.bots_firing + "\n");
	
	logprint("self.pers[\"bots\"][\"class\"][\"primary\"] = " + player.pers["bots"]["class"]["primary"] + "\n");
	logprint("self.pers[\"bots\"][\"class\"][\"primaryCamo\"] = " + player.pers["bots"]["class"]["primaryCamo"] + "\n");
	logprint("self.pers[\"bots\"][\"class\"][\"secondary\"] = " + player.pers["bots"]["class"]["secondary"] + "\n");
	logprint("self.pers[\"bots\"][\"class\"][\"secondaryCamo\"] = " + player.pers["bots"]["class"]["secondaryCamo"] + "\n");
	logprint("self.pers[\"bots\"][\"class\"][\"perk1\"] = " + player.pers["bots"]["class"]["perk1"] + "\n");
	logprint("self.pers[\"bots\"][\"class\"][\"perk1pro\"] = " + player.pers["bots"]["class"]["perk1pro"] + "\n");
	logprint("self.pers[\"bots\"][\"class\"][\"perk2\"] = " + player.pers["bots"]["class"]["perk2"] + "\n");
	logprint("self.pers[\"bots\"][\"class\"][\"perk2pro\"] = " + player.pers["bots"]["class"]["perk2pro"] + "\n");
	logprint("self.pers[\"bots\"][\"class\"][\"perk3\"] = " + player.pers["bots"]["class"]["perk3"] + "\n");
	logprint("self.pers[\"bots\"][\"class\"][\"perk3pro\"] = " + player.pers["bots"]["class"]["perk3pro"] + "\n");
	logprint("self.pers[\"bots\"][\"class\"][\"deathPerk\"] = " + player.pers["bots"]["class"]["deathPerk"] + "\n");
	logprint("self.pers[\"bots\"][\"class\"][\"grenade\"] = " + player.pers["bots"]["class"]["grenade"] + "\n");
	logprint("self.pers[\"bots\"][\"class\"][\"offhand\"] = " + player.pers["bots"]["class"]["offhand"] + "\n");
	logprint("self.pers[\"bots\"][\"class\"][\"set\"] = " + player.pers["bots"]["class"]["set"] + "\n");
	logprint("self.pers[\"bots\"][\"killstreaks\"][0] = " + player.pers["bots"]["killstreaks"][0] + "\n");
	logprint("self.pers[\"bots\"][\"killstreaks\"][1] = " + player.pers["bots"]["killstreaks"][1] + "\n");
	logprint("self.pers[\"bots\"][\"killstreaks\"][2] = " + player.pers["bots"]["killstreaks"][2] + "\n");
	logprint("self.pers[\"bots\"][\"killstreaks\"][\"set\"] = " + player.pers["bots"]["killstreaks"]["set"] + "\n");
	logprint("self.pers[\"bots\"][\"trait\"][\"vengeful\"] = " + player.pers["bots"]["trait"]["vengeful"] + "\n");
	logprint("self.pers[\"bots\"][\"trait\"][\"talk\"] = " + player.pers["bots"]["trait"]["talk"] + "\n");
	logprint("self.pers[\"bots\"][\"trait\"][\"killsOverObj\"] = " + player.pers["bots"]["trait"]["killsOverObj"] + "\n");
	logprint("self.pers[\"bots\"][\"trait\"][\"camp\"] = " + player.pers["bots"]["trait"]["camp"] + "\n");
	logprint("self.pers[\"bots\"][\"trait\"][\"follow\"] = " + player.pers["bots"]["trait"]["follow"] + "\n");
	logprint("self.pers[\"bots\"][\"trait\"][\"cfTime\"] = " + player.pers["bots"]["trait"]["cfTime"] + "\n");
	logprint("self.pers[\"bots\"][\"trait\"][\"knife\"] = " + player.pers["bots"]["trait"]["knife"] + "\n");
	logprint("self.pers[\"bots\"][\"trait\"][\"nade\"] = " + player.pers["bots"]["trait"]["nade"] + "\n");
	logprint("self.pers[\"bots\"][\"trait\"][\"switch\"] = " + player.pers["bots"]["trait"]["switch"] + "\n");
	logprint("self.pers[\"bots\"][\"trait\"][\"rage\"] = " + player.pers["bots"]["trait"]["rage"] + "\n");
	logprint("self.pers[\"bots\"][\"trait\"][\"change\"] = " + player.pers["bots"]["trait"]["change"] + "\n");
	logprint("self.pers[\"bots\"][\"trait\"][\"watch\"] = " + player.pers["bots"]["trait"]["watch"] + "\n");
	logprint("self.pers[\"bots\"][\"trait\"][\"run\"] = " + player.pers["bots"]["trait"]["run"] + "\n");
	logprint("self.pers[\"bots\"][\"trait\"][\"playStyle\"] = " + player.pers["bots"]["trait"]["playStyle"] + "\n");
	logprint("self.pers[\"bots\"][\"skill\"][\"base\"] = " + player.pers["bots"]["skill"]["base"] + "\n");
	logprint("self.pers[\"bots\"][\"skill\"][\"viewDis\"] = " + player.pers["bots"]["skill"]["viewDis"] + "\n");
	logprint("self.pers[\"bots\"][\"skill\"][\"aimSpeed\"] = " + player.pers["bots"]["skill"]["aimSpeed"] + "\n");
	logprint("self.pers[\"bots\"][\"skill\"][\"acc\"] = " + player.pers["bots"]["skill"]["acc"] + "\n");
	logprint("self.pers[\"bots\"][\"skill\"][\"spawnWait\"] = " + player.pers["bots"]["skill"]["spawnWait"] + "\n");
	logprint("self.pers[\"bots\"][\"skill\"][\"shootDelay\"] = " + player.pers["bots"]["skill"]["shootDelay"] + "\n");
	logprint("self.pers[\"bots\"][\"skill\"][\"perfView\"] = " + player.pers["bots"]["skill"]["perfView"] + "\n");
	logprint("self.pers[\"bots\"][\"skill\"][\"newTarg\"] = " + player.pers["bots"]["skill"]["newTarg"] + "\n");
	logprint("self.pers[\"bots\"][\"skill\"][\"seenTime\"] = " + player.pers["bots"]["skill"]["seenTime"] + "\n");
	
	logprint("self.bots_fixOnce = " + player.bots_fixOnce + "\n");
	logprint("self.bots_atDeathLoc = " + player.bots_atDeathLoc + "\n");
	logprint("self.bots_doing = " + player.bots_doing + "\n");
	logprint("self.bots_objDoing = " + player.bots_objDoing + "\n");
	logprint("self.bots_isCare = " + player.bots_isCare + "\n");//
	logprint("self.bots_aimDoing = " + player.bots_aimDoing + "\n");
	logprint("self.bots_campingAngles = " + player.bots_campingAngles + "\n");
	logprint("self.bots_lastKS = " + player.bots_lastKS + "\n");
	logprint("self.bots_switchTime = " + player.bots_switchTime + "\n");
	logprint("self.bots_shootTime = " + player.bots_shootTime + "\n");
	logprint("self.bots_running = " + player.bots_running + "\n");
	logprint("self.bots_runDelay = " + player.bots_runDelay + "\n");
	logprint("self.bots_runTime = " + player.bots_runTime + "\n");
	logprint("self.bots_camping = " + player.bots_camping + "\n");
	logprint("self.bots_realSeen = " + player.bots_realSeen + "\n");//
	logprint("self.bots_realEqu = " + player.bots_realEqu + "\n");//
	logprint("self.bots_realTarKS = " + player.bots_realTarKS + "\n");//
	logprint("self.bots_omaChange = " + player.bots_omaChange + "\n");
	logprint("self.bots_lastSeen = " + player.bots_lastSeen + "\n");//
	logprint("self.bots_anime.headmodel = " + player.bots_anime.headmodel + "\n");//
	logprint("self.bots_anime.animation = " + player.bots_anime.animation + "\n");
	logprint("self.bots_anime = " + player.bots_anime + "\n");//
	logprint("self.bots_devwalk = " + player.bots_devwalk + "\n");//
	logprint("self.bots_currentStaticWp = " + player.bots_currentStaticWp + "\n");
	logprint("self.bots_lastStaticWP = " + player.bots_lastStaticWP + "\n");
	logprint("self.bots_tempwp = " + player.bots_tempwp + "\n");
	logprint("self.bots_vObjectivePos = " + player.bots_vObjectivePos + "\n");
	logprint("self.bots_fMoveSpeed = " + player.bots_fMoveSpeed + "\n");
	logprint("self.bots_traitRandom = " + player.bots_traitRandom + "\n");
	logprint("self.bots_targetWpIdx = " + player.bots_targetWpIdx + "\n");
	logprint("self.bots_secondNextWp = " + player.bots_secondNextWp + "\n");
	
	self iPrintln("DUMPED Bot VARS to games_mp.log");
}

__edit(a, b)
{
	switch(a)
	{
		case 0:
			if(self.menu_player.pers["bots"]["skill"]["base"] <= 5)
				self.menu_player.pers["bots"]["skill"]["base"] = self.menu_player.pers["bots"]["skill"]["base"] + 1;
			else
				self.menu_player.pers["bots"]["skill"]["base"] = 0;
			self iPrintln("base "+self.menu_player.pers["bots"]["skill"]["base"]);
		break;
		case 1:
			if(!b)
				self.menu_player.pers["bots"]["skill"]["viewDis"] = self.menu_player.pers["bots"]["skill"]["viewDis"] + 10;
			else
				self.menu_player.pers["bots"]["skill"]["viewDis"] = self.menu_player.pers["bots"]["skill"]["viewDis"] - 10;
			
			self iPrintln("viewDis "+self.menu_player.pers["bots"]["skill"]["viewDis"]);
		break;
		case 2:
			if(!b)
				self.menu_player.pers["bots"]["skill"]["aimSpeed"] = self.menu_player.pers["bots"]["skill"]["aimSpeed"] + 1;
			else 
				self.menu_player.pers["bots"]["skill"]["aimSpeed"] = self.menu_player.pers["bots"]["skill"]["aimSpeed"] - 1;
			
			self iPrintln("aimSpeed "+self.menu_player.pers["bots"]["skill"]["aimSpeed"]);
		break;
		case 3:
			if(!b)
				self.menu_player.pers["bots"]["skill"]["acc"] = self.menu_player.pers["bots"]["skill"]["acc"] + 1;
			else 
				self.menu_player.pers["bots"]["skill"]["acc"] = self.menu_player.pers["bots"]["skill"]["acc"] - 1;
			
			self iPrintln("acc "+self.menu_player.pers["bots"]["skill"]["acc"]);
		break;
		case 4:
			if(!b)
				self.menu_player.pers["bots"]["skill"]["seenTime"] = self.menu_player.pers["bots"]["skill"]["seenTime"] + 250;
			else
				self.menu_player.pers["bots"]["skill"]["seenTime"] = self.menu_player.pers["bots"]["skill"]["seenTime"] - 250;
			
			self iPrintln("seenTime "+self.menu_player.pers["bots"]["skill"]["seenTime"]);
		break;
		case 5:
			if(!b)
				self.menu_player.pers["bots"]["skill"]["spawnWait"] = self.menu_player.pers["bots"]["skill"]["spawnWait"] + 0.1;
			else
				self.menu_player.pers["bots"]["skill"]["spawnWait"] = self.menu_player.pers["bots"]["skill"]["spawnWait"] - 0.1;
			
			self iPrintln("spawnWait "+self.menu_player.pers["bots"]["skill"]["spawnWait"]);
		break;
		case 6:
			if(!b)
				self.menu_player.pers["bots"]["skill"]["newTarg"] = self.menu_player.pers["bots"]["skill"]["newTarg"] + 0.1;
			else
				self.menu_player.pers["bots"]["skill"]["newTarg"] = self.menu_player.pers["bots"]["skill"]["newTarg"] - 0.1;
			
			self iPrintln("newTarg "+self.menu_player.pers["bots"]["skill"]["newTarg"]);
		break;
		case 7:
			if(self.menu_player.pers["bots"]["trait"]["vengeful"] <= 1)
				self.menu_player.pers["bots"]["trait"]["vengeful"] = self.menu_player.pers["bots"]["trait"]["vengeful"] + 1;
			else
				self.menu_player.pers["bots"]["trait"]["vengeful"] = 0;
			self iPrintln("vengeful "+self.menu_player.pers["bots"]["trait"]["vengeful"]);
		break;
		case 8:
			if(self.menu_player.pers["bots"]["trait"]["killsOverObj"] <= 1)
				self.menu_player.pers["bots"]["trait"]["killsOverObj"] = self.menu_player.pers["bots"]["trait"]["killsOverObj"] + 1;
			else
				self.menu_player.pers["bots"]["trait"]["killsOverObj"] = 0;
			self iPrintln("killsOverObj "+self.menu_player.pers["bots"]["trait"]["killsOverObj"]);
		break;
		case 9:
			if(self.menu_player.bots_traitRandom <= 4)
				self.menu_player.bots_traitRandom = self.menu_player.bots_traitRandom + 1;
			else
				self.menu_player.bots_traitRandom = 0;
			self iPrintln("bots_traitRandom "+self.menu_player.bots_traitRandom);
		break;
		case 10:
			if(!b)
				self.menu_player.pers["bots"]["skill"]["shootDelay"] = self.menu_player.pers["bots"]["skill"]["shootDelay"] + 0.1;
			else
				self.menu_player.pers["bots"]["skill"]["shootDelay"] = self.menu_player.pers["bots"]["skill"]["shootDelay"] - 0.1;
			
			self iPrintln("shootDelay "+self.menu_player.pers["bots"]["skill"]["shootDelay"]);
		break;
		case 11:
			if(!b)
				self.menu_player.pers["bots"]["skill"]["perfView"] = self.menu_player.pers["bots"]["skill"]["perfView"] + 0.05;
			else
				self.menu_player.pers["bots"]["skill"]["perfView"] = self.menu_player.pers["bots"]["skill"]["perfView"] - 0.05;
			
			self iPrintln("perfView "+self.menu_player.pers["bots"]["skill"]["perfView"]);
		break;
		case 14:
			if(!b)
				self.menu_player.pers["bots"]["trait"]["talk"] = self.menu_player.pers["bots"]["trait"]["talk"] + 1;
			else
				self.menu_player.pers["bots"]["trait"]["talk"] = self.menu_player.pers["bots"]["trait"]["talk"] - 1;
			
			self iPrintln("talk "+self.menu_player.pers["bots"]["trait"]["talk"]);
		break;
		case 15:
			if(!b)
				self.menu_player.pers["bots"]["trait"]["camp"] = self.menu_player.pers["bots"]["trait"]["camp"] + 1;
			else
				self.menu_player.pers["bots"]["trait"]["camp"] = self.menu_player.pers["bots"]["trait"]["camp"] - 1;
			
			self iPrintln("camp "+self.menu_player.pers["bots"]["trait"]["camp"]);
		break;
		case 16:
			if(!b)
				self.menu_player.pers["bots"]["trait"]["follow"] = self.menu_player.pers["bots"]["trait"]["follow"] + 1;
			else
				self.menu_player.pers["bots"]["trait"]["follow"] = self.menu_player.pers["bots"]["trait"]["follow"] - 1;
			
			self iPrintln("follow "+self.menu_player.pers["bots"]["trait"]["follow"]);
		break;
		case 17:
			if(self.menu_player.pers["bots"]["trait"]["playStyle"] <= 1)
				self.menu_player.pers["bots"]["trait"]["playStyle"] = self.menu_player.pers["bots"]["trait"]["playStyle"] + 1;
			else
				self.menu_player.pers["bots"]["trait"]["playStyle"] = 0;
			self iPrintln("playStyle "+self.menu_player.pers["bots"]["trait"]["playStyle"]);
		break;
		case 18:
			if(!b)
				self.menu_player.pers["bots"]["trait"]["cfTime"] = self.menu_player.pers["bots"]["trait"]["cfTime"] + 1;
			else
				self.menu_player.pers["bots"]["trait"]["cfTime"] = self.menu_player.pers["bots"]["trait"]["cfTime"] - 1;
			
			self iPrintln("cfTime "+self.menu_player.pers["bots"]["trait"]["cfTime"]);
		break;
		case 19:
			if(!b)
				self.menu_player.pers["bots"]["trait"]["knife"] = self.menu_player.pers["bots"]["trait"]["knife"] + 1;
			else
				self.menu_player.pers["bots"]["trait"]["knife"] = self.menu_player.pers["bots"]["trait"]["knife"] - 1;
			
			self iPrintln("knife "+self.menu_player.pers["bots"]["trait"]["knife"]);
		break;
		case 20:
			if(!b)
				self.menu_player.pers["bots"]["trait"]["nade"] = self.menu_player.pers["bots"]["trait"]["nade"] + 1;
			else
				self.menu_player.pers["bots"]["trait"]["nade"] = self.menu_player.pers["bots"]["trait"]["nade"] - 1;
			
			self iPrintln("nade "+self.menu_player.pers["bots"]["trait"]["nade"]);
		break;
		case 21:
			if(!b)
				self.menu_player.pers["bots"]["trait"]["switch"] = self.menu_player.pers["bots"]["trait"]["switch"] + 1;
			else
				self.menu_player.pers["bots"]["trait"]["switch"] = self.menu_player.pers["bots"]["trait"]["switch"] - 1;
			
			self iPrintln("switch "+self.menu_player.pers["bots"]["trait"]["switch"]);
		break;
		case 22:
			if(!b)
				self.menu_player.pers["bots"]["trait"]["rage"] = self.menu_player.pers["bots"]["trait"]["rage"] + 1;
			else
				self.menu_player.pers["bots"]["trait"]["rage"] = self.menu_player.pers["bots"]["trait"]["rage"] - 1;
			
			self iPrintln("rage "+self.menu_player.pers["bots"]["trait"]["rage"]);
		break;
		case 23:
			if(!b)
				self.menu_player.pers["bots"]["trait"]["change"] = self.menu_player.pers["bots"]["trait"]["change"] + 1;
			else
				self.menu_player.pers["bots"]["trait"]["change"] = self.menu_player.pers["bots"]["trait"]["change"] - 1;
			
			self iPrintln("change "+self.menu_player.pers["bots"]["trait"]["change"]);
		break;
		case 24:
			if(!b)
				self.menu_player.pers["bots"]["trait"]["watch"] = self.menu_player.pers["bots"]["trait"]["watch"] + 1;
			else
				self.menu_player.pers["bots"]["trait"]["watch"] = self.menu_player.pers["bots"]["trait"]["watch"] - 1;
			
			self iPrintln("watch "+self.menu_player.pers["bots"]["trait"]["watch"]);
		break;
		case 25:
			if(!b)
				self.menu_player.pers["bots"]["trait"]["run"] = self.menu_player.pers["bots"]["trait"]["run"] + 1;
			else
				self.menu_player.pers["bots"]["trait"]["run"] = self.menu_player.pers["bots"]["trait"]["run"] - 1;
			
			self iPrintln("run "+self.menu_player.pers["bots"]["trait"]["run"]);
		break;
	}
}