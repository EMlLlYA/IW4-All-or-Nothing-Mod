#include bots\bots_funcs;

bots_killAnimOnTime(waitTime)
{
	self endon("killed_player");
	self endon("bot_reset");
	self endon("bot_kill_anime");
	
	wait waitTime;
	
	self notify("bot_kill_anime");
}

bots_doAnimation(animation, waitTime, func)
{
	if(!isDefined(self.bots_anime) || (isDefined(self.bots_anime.animation) && self.bots_anime.animation == animation))
		return;
	
	self endon("bot_kill_anime");
	
	self thread bots_killAnimOnTime(waitTime);
	
	self.bots_anime.animation = animation;
	self.bots_anime scriptModelPlayAnim(animation);
	
	while(self [[func]]())
		bots_waitFrame();
	
	self notify("bot_kill_anime");
}

bots_doBotAnimDeath()
{
	self endon("bot_reset");
	self endon("spawned_player");
	if(isDefined(self.bots_anime))
	{
		self.body hide();
		if(isDefined(self.laststand))
		{
			self.bots_anime.animation = "pb_laststand_death";
			self.bots_anime scriptModelPlayAnim("pb_laststand_death");
		}
		else
		{
			if(self GetStance() == "prone")
			{
				self.bots_anime.animation = "pb_prone_death_quickdeath";
				self.bots_anime scriptModelPlayAnim("pb_prone_death_quickdeath");
			}
			else
			{
				switch(randomInt(6))
				{
					case 0:
						self.bots_anime.animation = "pb_death_run_stumble";
						self.bots_anime scriptModelPlayAnim("pb_death_run_stumble");
					break;
					case 1:
						self.bots_anime.animation = "pb_stand_death_leg_kickup";
						self.bots_anime scriptModelPlayAnim("pb_stand_death_leg_kickup");
					break;
					case 2:
						self.bots_anime.animation = "pb_stand_death_shoulderback";
						self.bots_anime scriptModelPlayAnim("pb_stand_death_shoulderback");
					break;
					case 3:
						self.bots_anime.animation = "pb_stand_death_chest_blowback";
						self.bots_anime scriptModelPlayAnim("pb_stand_death_chest_blowback");
					break;
					case 4:
						self.bots_anime.animation = "pb_death_run_onfront";
						self.bots_anime scriptModelPlayAnim("pb_death_run_onfront");
					break;
					case 5:
						self.bots_anime.animation = "pb_stand_death_legs";
						self.bots_anime scriptModelPlayAnim("pb_stand_death_legs");
					break;
				}
			}
		}
		wait 2;
		self bots_deleteFakeAnim();
	}
}

bots_animSwitch()
{
	return (isDefined(level.bots_animSwitch[self.bots_doing]) && !isDefined(self.lastStand));
}

bots_animKnifeLS()
{
	return (isDefined(level.bots_animKnife[self.bots_doing]) && isDefined(self.lastStand));
}

bots_animKnife()
{
	return (isDefined(level.bots_animKnife[self.bots_doing]) && !isDefined(self.lastStand) && self.bots_doing != "knifebig");
}

bots_animClimb()
{
	return (isDefined(level.bots_animClimb[self.bots_doing]) && !isDefined(self.lastStand));
}

bots_animCrawl()
{
	if(self.bots_fMoveSpeed < 0.05 || self bots\bots_aim::bots_IsStunned() || self bots\bots_aim::bots_isArtShocked())
		return false;
	
	return (isDefined(level.bots_animNone[self.bots_doing]) && isDefined(self.lastStand));
}

bots_animSprint()
{
	if(self.bots_fMoveSpeed < 0.05 || self bots\bots_aim::bots_IsStunned() || self bots\bots_aim::bots_isArtShocked())
		return false;
	
	return (isDefined(level.bots_animNone[self.bots_doing]) && !isDefined(self.lastStand) && self.bots_running);
}

bots_animCrouch()
{
	if(self.bots_fMoveSpeed < 0.05 || self bots\bots_aim::bots_IsStunned() || self bots\bots_aim::bots_isArtShocked())
		return false;
	
	return (isDefined(level.bots_animNone[self.bots_doing]) && !isDefined(self.lastStand) && !self.bots_running && self GetStance() == "crouch");
}

bots_animStand()
{
	if(self.bots_fMoveSpeed < 0.05 || self bots\bots_aim::bots_IsStunned() || self bots\bots_aim::bots_isArtShocked())
		return false;
	
	return (isDefined(level.bots_animNone[self.bots_doing]) && !isDefined(self.lastStand) && !self.bots_running && self GetStance() == "stand");
}

bots_animProne()
{
	if(self.bots_fMoveSpeed < 0.05 || self bots\bots_aim::bots_IsStunned() || self bots\bots_aim::bots_isArtShocked())
		return false;
	
	return (isDefined(level.bots_animNone[self.bots_doing]) && !isDefined(self.lastStand) && !self.bots_running && self GetStance() == "prone");
}

bots_animKnifeBig()
{
	return (!isDefined(self.lastStand) && self.bots_doing == "knifebig");
}

bots_doAnimations()
{
	self endon("bot_reset");
	self endon("killed_player");
	lastDo = "none";
	
	for(;;)
	{
		if(level.bots_varPlayAnim == 1)
		{
			if(isDefined(level.bots_animSwitch[self.bots_doing]))
			{
				if(!isDefined(level.bots_animSwitch[lastDo]))
				{
					if(!isDefined(self.lastStand))
					{
						self bots_makeFakeAnim();
						self bots_doAnimation("pt_stand_core_pullout", 0.5, ::bots_animSwitch);
					}
					else
					{
						self bots_deleteFakeAnim();
					}
					lastDo = "switch";
				}
			}
			else if(isDefined(level.bots_animKnife[self.bots_doing]))
			{
				if(self.bots_doing != "knifebig")
				{
					if (!isDefined(level.bots_animKnife[lastDo]))
					{
						if(isDefined(self.lastStand))
						{
							if(self.hasRiotShieldEquipped)
							{
								self bots_deleteFakeAnim();
							}
							else
							{
								self bots_makeFakeAnim();
								self bots_doAnimation("pt_laststand_melee", 1.5, ::bots_animKnifeLS);
							}
						}
						else
						{
							self bots_makeFakeAnim();
							if(self.hasRiotShieldEquipped)
							{
								self bots_doAnimation("pt_melee_shield", 1, ::bots_animKnife);
							}
							else
							{
								switch(self GetStance())
								{
									case "prone":
										self bots_doAnimation("pt_melee_prone_pistol", 1, ::bots_animKnife);
									break;
									default:
										self bots_doAnimation("pt_melee_pistol_1", 1, ::bots_animKnife);
									break;
								}
							}
						}
						lastDo = "knife";
					}
				}
				else
				{
					if(lastDo != "knifebig")
					{
						self bots_makeFakeAnim();
						self bots_doAnimation("pt_melee_pistol_2", 1.5, ::bots_animKnifeBig);
						lastDo = "knifebig";
					}
				}
			}
			else if(isDefined(level.bots_animClimb[self.bots_doing]))
			{
				if(!isDefined(self.lastStand))
				{
					self bots_makeFakeAnim();
					self bots_doAnimation("pb_climbup", 1, ::bots_animClimb);
				}
				else
				{
					self bots_deleteFakeAnim();
				}
				lastDo = "none";
			}
			else if(isDefined(level.bots_animNone[self.bots_doing]))
			{
				if(self.bots_fMoveSpeed < 0.05 || self bots\bots_aim::bots_IsStunned() || self bots\bots_aim::bots_isArtShocked())
				{
					self bots_deleteFakeAnim();
				}
				else
				{
					self bots_makeFakeAnim();
					if(isDefined(self.lastStand))
					{
						self bots_doAnimation("pb_laststand_crawl", 0.75, ::bots_animCrawl);
					}
					else
					{
						if(self.bots_running)
						{
							if(!level.bots_isNotLessAnimMap)
							{
								self bots_doAnimation("pb_sprint", 1, 1, ::bots_animSprint);
							}
							else
							{
								weapon = self getCurrentWeapon();
								if(isSubStr(weapon, "akimbo_"))
								{
									self bots_doAnimation("pb_sprint_akimbo", 1, ::bots_animSprint);
								}
								else
								{
									switch(weaponClass(weapon))
									{
										case "rifle":
											if(self.hasRiotShieldEquipped)
												self bots_doAnimation("pb_sprint_shield", 1, ::bots_animSprint);
											else
												self bots_doAnimation("pb_sprint", 1, ::bots_animSprint);
										break;
										case "pistol":
											self bots_doAnimation("pb_sprint_pistol", 1, ::bots_animSprint);
										break;
										case "rocketlauncher":
											self bots_doAnimation("pb_sprint_RPG", 1, ::bots_animSprint);
										break;
										default:
											self bots_doAnimation("pb_sprint", 1, 1, ::bots_animSprint);
										break;
									}
								}
							}
						}
						else
						{
							switch(self GetStance())
							{
								case "crouch":
									if(!level.bots_isNotLessAnimMap)
									{
										self bots_doAnimation("pb_crouch_run_forward", 0.5, ::bots_animCrouch);
									}
									else
									{
										weapon = self getCurrentWeapon();
										if(isSubStr(weapon, "akimbo_"))
										{
											self bots_doAnimation("pb_crouch_walk_forward_akimbo", 0.5, ::bots_animCrouch);
										}
										else
										{
											switch(weaponClass(weapon))
											{
												case "rifle":
													if(self.hasRiotShieldEquipped)
														self bots_doAnimation("pb_crouch_walk_forward_shield", 0.5, ::bots_animCrouch);
													else
														self bots_doAnimation("pb_crouch_run_forward", 0.5, ::bots_animCrouch);
												break;
												case "pistol":
													self bots_doAnimation("pb_crouch_run_forward_pistol", 0.5, ::bots_animCrouch);
												break;
												case "rocketlauncher":
													self bots_doAnimation("pb_crouch_run_forward_RPG", 0.5, ::bots_animCrouch);
												break;
												default:
													self bots_doAnimation("pb_crouch_run_forward", 0.5, ::bots_animCrouch);
												break;
											}
										}
									}
								break;
								case "stand":
									if(!level.bots_isNotLessAnimMap)
									{
										self bots_doAnimation("pb_combatrun_forward_loop", 0.5, ::bots_animStand);
									}
									else
									{
										weapon = self getCurrentWeapon();
										if(isSubStr(weapon, "akimbo_"))
										{
											self bots_doAnimation("pb_combatrun_forward_akimbo", 0.5, ::bots_animStand);
										}
										else
										{
											switch(weaponClass(weapon))
											{
												case "rifle":
													if(self.hasRiotShieldEquipped)
														self bots_doAnimation("pb_combatrun_forward_shield", 0.5, ::bots_animStand);
													else
														self bots_doAnimation("pb_combatrun_forward_loop", 0.5, ::bots_animStand);
												break;
												case "pistol":
													self bots_doAnimation("pb_pistol_run_fast", 0.5, ::bots_animStand);
												break;
												case "rocketlauncher":
													self bots_doAnimation("pb_combatrun_forward_RPG", 0.5, ::bots_animStand);
												break;
												default:
													self bots_doAnimation("pb_combatrun_forward_loop", 0.5, ::bots_animStand);
												break;
											}
										}
									}
								break;
								case "prone":
									self bots_doAnimation("pb_prone_crawl", 1, ::bots_animProne);
								break;
							}
						}
					}
				}
				lastDo = "none";
			}
			else
			{
				self bots_deleteFakeAnim();
				lastDo = "none";
			}
		}
		else
		{
			self bots_deleteFakeAnim();
			wait 1;
		}
		bots_waitFrame();
	}
}

bots_makeFakeAnim()
{
	if(!isDefined(self.bots_anime))
	{
		self.bots_anime = spawn("script_model", self.origin);
		self.bots_anime setModel(self.model);
		self.bots_anime LinkTo(self, "tag_origin", (0, 0, 0), (0, 0, 0));
		
		self.bots_anime.headmodel = spawn( "script_model", self.bots_anime getTagOrigin( "j_spine4" ));
		self.bots_anime.headmodel setModel(self.headmodel);
		self.bots_anime.headmodel.angles = (270, 0, 270);
		self.bots_anime.headmodel linkto( self.bots_anime, "j_spine4" );
		
		self.bots_anime.animation = "pb_crouch_run_forward";
		self.bots_anime ScriptModelPlayAnim("pb_crouch_run_forward");
		
		self thread maps\mp\gametypes\_weapons::detach_all_weapons();
		self bots_HideParts();
	}
}

bots_deleteFakeAnim()
{
	if(isDefined(self.bots_anime))
	{
		self.bots_anime.headmodel delete();
		self.bots_anime.headmodel = undefined;
		self.bots_anime.animation = undefined;
		self.bots_anime delete();
		self.bots_anime = undefined;
		
		if(isDefined(self) && bots_isReallyAlive(self))
		{
			self bots_showParts();
			self thread maps\mp\gametypes\_weapons::stowedWeaponsRefresh();
		}
	}
}

bots_boneTest()
{
	self endon("disconnect");
	
	bones = strtok("j_mainroot,j_coatfront_le,j_coatfront_ri,j_coatrear_le,,j_hip_le,j_hip_ri,j_spinelower,j_hiptwist_le,j_hiptwist_ri,j_knee_le,j_knee_ri,j_shorts_le,j_shorts_lift_le,j_shorts_lift_ri,j_shorts_ri,j_spineupper,j_ankle_le,j_ankle_ri,j_knee_bulge_le,j_knee_bulge_ri,j_spine4,j_ball_le,j_ball_ri,j_clavicle_le,j_clavicle_ri,j_neck,j_shoulderraise_le,j_shoulderraise_ri,j_head,j_shoulder_le,j_shoulder_ri,j_brow_le,j_brow_ri,j_cheek_le,j_cheek_ri,j_elbow_bulge_le,j_elbow_bulge_ri,j_elbow_le,j_elbow_ri,j_eye_lid_bot_le,j_eye_lid_bot_ri,j_eye_lid_top_le,j_eye_lid_top_ri,j_eyeball_le,j_eyeball_ri,j_head_end,j_jaw,j_levator_le,j_levator_ri,j_lip_top_le,j_lip_top_ri,j_mouth_le,j_mouth_ri,j_shouldertwist_le,j_shouldertwist_ri,j_chin_skinroll,j_helmet,j_lip_bot_le,j_lip_bot_ri,j_wrist_le,j_wrist_ri,j_wristtwist_le,j_wristtwist_ri,j_gun,j_index_le_1,j_index_ri_1,j_mid_le_1,j_mid_ri_1,j_pinky_le_1,j_pinky_ri_1,j_ring_le_1,j_ring_ri_1,j_thumb_le_,j_thumb_ri_1,j_index_le_2,j_index_ri_2,j_mid_le_2,j_mid_ri_2,j_pinky_le_2,j_pinky_ri_2,j_ring_le_2,j_ring_ri_2,j_thumb_le_2,j_thumb_ri_2,j_index_le_3,j_index_ri_3,j_mid_le_3,j_mid_ri_3,j_pinky_le_3,j_pinky_ri_3,j_ring_le_3,j_ring_ri_3,j_thumb_le_3,j_thumb_ri_3", ",");
	cur = 0;
	for(;;)
	{
		while(!self attackButtonPressed() && !self adsButtonPressed())
			wait 0.05;
		
		if(self attackButtonPressed())
		{
			if(cur == 0)
				cur = bones.size;
			
			cur -= 1;
		}
		else
		{
			if(cur == bones.size-1)
				cur = -1;
			
			cur += 1;
		}
		
		self sayall(bones[cur]);
		
		foreach(player in level.players)
		{
			player showallparts();
			player hidepart(bones[cur]);
		}
		
		while(self attackButtonPressed() || self adsButtonPressed())
			wait 0.05;
	}
}

bots_HideParts()
{
	//hideallparts
	self hidepart("j_ankle_le");//this is the only place where bot cannot be shot at...
	self hidepart("j_hiptwist_le");
	self hidepart("j_head");
	self hidepart("j_helmet");
	self hidepart("j_eyeball_le");
	self hidepart("j_clavicle_le");
}

bots_showParts()
{
	self showpart("j_ankle_le");
	self showpart("j_hiptwist_le");
	self showpart("j_head");
	self showpart("j_helmet");
	self showpart("j_eyeball_le");
	self showpart("j_clavicle_le");
	//showallparts
}