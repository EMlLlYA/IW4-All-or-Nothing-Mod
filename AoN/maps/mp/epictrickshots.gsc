#include maps\mp\gametypes\_hud;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\_utility;
#include common_scripts\utility;

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
		self.vel = level.player GetVelocity();
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
	//else if(getDvar("mapname") == "mp_nighshift")
	//{
	//	level thread Skidrow();
	//}
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
}