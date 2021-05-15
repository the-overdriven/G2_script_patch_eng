
instance DIA_Jesper_EXIT(C_Info)
{
	npc = VLK_446_Jesper;
	nr = 999;
	condition = DIA_Jesper_EXIT_Condition;
	information = DIA_Jesper_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Jesper_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Jesper_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Jesper_PICKPOCKET(C_Info)
{
	npc = VLK_446_Jesper;
	nr = 900;
	condition = DIA_Jesper_PICKPOCKET_Condition;
	information = DIA_Jesper_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_80;
};


func int DIA_Jesper_PICKPOCKET_Condition()
{
	return C_Beklauen(80,180);
};

func void DIA_Jesper_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Jesper_PICKPOCKET);
	Info_AddChoice(DIA_Jesper_PICKPOCKET,Dialog_Back,DIA_Jesper_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Jesper_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Jesper_PICKPOCKET_DoIt);
};

func void DIA_Jesper_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Jesper_PICKPOCKET);
};

func void DIA_Jesper_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Jesper_PICKPOCKET);
};


instance DIA_Jesper_Hallo(C_Info)
{
	npc = VLK_446_Jesper;
	nr = 1;
	condition = DIA_Jesper_Hallo_Condition;
	information = DIA_Jesper_Hallo_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Jesper_Hallo_Condition()
{
	if(!Npc_IsDead(Cassia) && !Npc_IsDead(Ramirez))
	{
		return TRUE;
	};
};

func void DIA_Jesper_Hallo_Info()
{
	AI_Output (self, other, "DIA_Jesper_Hallo_09_00");	//Hey, what are you doing down here? There's nothing here for you.
	AI_Output (self, other, "DIA_Jesper_Hallo_09_01");	//So, out with it, what are you doing here?
	Info_ClearChoices (DIA_Jesper_Hallo);
	Info_AddChoice (DIA_Jesper_Hallo, "I have come to kill you.", DIA_Jesper_Hallo_Kill);
	Info_AddChoice (DIA_Jesper_Hallo, "I wanted to have a little look around.", DIA_Jesper_Hallo_NurSo);
	if(Npc_KnowsInfo(other,DIA_Kardif_SENDATTILA))
	{
		if(Attila_Key == TRUE)
		{
			Info_AddChoice(DIA_Jesper_Hallo,"Attila gave me a key. That's why I'm here. So what do you want of me?",DIA_Jesper_Hallo_Willkommen);
		}
		else if(Npc_IsDead(Attila))
		{
			Info_AddChoice(DIA_Jesper_Hallo,"I've done in Attila. He had the key to the sewers on him..",DIA_Jesper_Hallo_Umgelegt);
		};
	};
};

func void DIA_Jesper_Hallo_Kill()
{
	AI_Output (other, self, "DIA_Jesper_Hallo_Kill_15_00");	//I have come to kill you.
	AI_Output (self, other, "DIA_Jesper_Hallo_Kill_09_01");	//What a marvelous idea. Thought that up all by yourself, did you? Ah, so what. I'll make it short.
	AI_StopProcessInfos (self);
	Npc_ExchangeRoutine (self, "START");
	B_Attack (self, other, AR_NONE, 1);
};

func void DIA_Jesper_Hallo_NurSo()
{
	AI_Output (other, self, "DIA_Jesper_Hallo_NurSo_15_00");	//I wanted to have a little look around.
	AI_Output (self, other, "DIA_Jesper_Hallo_NurSo_09_01");	//There's nothing here to look at. You're walking on dangerous ground, understand?
	AI_Output (self, other, "DIA_Jesper_Hallo_NurSo_09_02");	//So leave your weapon where it is and tell me why you're here.
	if(!Npc_KnowsInfo(other,DIA_Kardif_SENDATTILA))
	{
		Info_AddChoice(DIA_Jesper_Hallo,"Take me to your leader.",DIA_Jesper_Hallo_Anfuehrer);
	}
	else if(!Npc_IsDead(Attila))
	{
		if(Npc_HasItems(Attila,ItKe_ThiefGuildKey_MIS))
		{
			Info_AddChoice(DIA_Jesper_Hallo,"Take me to your leader.",DIA_Jesper_Hallo_Anfuehrer);
		};
	};
};

func void DIA_Jesper_Hallo_Willkommen()
{
	AI_Output (other, self, "DIA_Jesper_Hallo_Willkommen_15_00");	//Attila gave me a key. That's why I'm here. So what do you want of me?
	AI_Output (self, other, "DIA_Jesper_Hallo_Willkommen_09_01");	//Wouldn't you like to know? Keep your cool.
	AI_Output (self, other, "DIA_Jesper_Hallo_Willkommen_09_02");	//Go see Cassia. You're expected.
	AI_StopProcessInfos (self);
	Npc_ExchangeRoutine (self, "START");
};

func void DIA_Jesper_Hallo_Umgelegt()
{
	AI_Output (other, self, "DIA_Jesper_Hallo_Umgelegt_15_00");	//I've done in Attila. He had the key to the sewers on him.
	AI_Output (self, other, "DIA_Jesper_Hallo_Umgelegt_09_01");	//(disbelieving) YOU killed Attila?! (scornfully) So what, he was a lousy dog anyway.
	AI_Output (self, other, "DIA_Jesper_Hallo_Umgelegt_09_02");	//But I'll tell you something. If you attack me, I'll kill you.
	Info_ClearChoices (DIA_Jesper_Hallo);
	Info_AddChoice (DIA_Jesper_Hallo, "What are you doing here ...", DIA_Jesper_Hallo_Was);
	Info_AddChoice (DIA_Jesper_Hallo, "Take me to your leader.", DIA_Jesper_Hallo_Anfuehrer);
};

func void DIA_Jesper_Hallo_Was()
{
	AI_Output (other, self, "DIA_Jesper_Hallo_Was_15_00");	//What are you doing here in this dark, dank hole?
	AI_Output (self, other, "DIA_Jesper_Hallo_Was_09_01");	//(growls) I live here. One more stupid question and I'll cut a design in your hide.
};

func void DIA_Jesper_Hallo_Anfuehrer()
{
	AI_Output (other, self, "DIA_Jesper_Hallo_Anfuehrer_15_00");	//Take me to your leader.
	AI_Output (self, other, "DIA_Jesper_Hallo_Anfuehrer_09_01");	//(laughs dirtily) HA - my leader? I'm sure Cassia will want to talk to you.
	AI_Output (self, other, "DIA_Jesper_Hallo_Anfuehrer_09_02");	//Go ahead - and don't try to fool me.
	AI_StopProcessInfos (self);
	Npc_ExchangeRoutine (self, "START");
};


instance DIA_Jesper_Bezahlen(C_Info)
{
	npc = VLK_446_Jesper;
	nr = 1;
	condition = DIA_Jesper_Bezahlen_Condition;
	information = DIA_Jesper_Bezahlen_Info;
	permanent = TRUE;
	description = "Can you teach me something?";
};


func int DIA_Jesper_Bezahlen_Condition()
{
	if((Join_Thiefs == TRUE) && (Jesper_TeachSneak == FALSE) && Npc_KnowsInfo(other,DIA_Cassia_Lernen))
	{
		return TRUE;
	};
};

func void DIA_Jesper_Bezahlen_Info()
{
	AI_Output(other,self,"DIA_Jesper_Bezahlen_15_00");	//Can you teach me something?
	if(!Npc_GetTalentSkill(other,NPC_TALENT_SNEAK))
	{
		if(MIS_ThiefGuild_sucked == FALSE)
		{
		AI_Output (self, other, "DIA_Jesper_Bezahlen_09_01");	//Sure, I'll show you how to sneak - free of charge for you.
			Jesper_TeachSneak = TRUE;
			Info_ClearChoices(DIA_Jesper_Bezahlen);
		}
		else
		{
		AI_Output (self, other, "DIA_Jesper_Bezahlen_09_02");	//You want to learn how to move without making a sound? That'll cost you 100 gold pieces.
	//		B_Say_Gold(self,other,Jesper_Cost);
			Info_ClearChoices(DIA_Jesper_Bezahlen);
			Info_AddChoice(DIA_Jesper_Bezahlen,"Maybe later... (BACK)",DIA_Jesper_Bezahlen_Spaeter);
			Info_AddChoice(DIA_Jesper_Bezahlen,"OK, I want to learn how to sneak around (pay 100 gold).",DIA_Jesper_Bezahlen_Okay);
		};
	}
	else
	{
		B_Say(self,other,"$NOLEARNYOUREBETTER");
		Jesper_TeachSneak = TRUE;
	};
};

func void DIA_Jesper_Bezahlen_Spaeter()
{
	DIA_Common_MaybeLater();
	Info_ClearChoices(DIA_Jesper_Bezahlen);
};

func void DIA_Jesper_Bezahlen_Okay()
{
	AI_Output (other, self, "DIA_Jesper_Bezahlen_Okay_15_00");	//OK, I want to learn how to sneak.
	if (B_GiveInvItems (other, self, ItMi_Gold, 100))
	{
		AI_Output (other, self, "DIA_Jesper_Bezahlen_Okay_15_01");	//Here's the gold.
		AI_Output (self, other, "DIA_Jesper_Bezahlen_Okay_09_02");	//So, then tell me when you're ready.
		Jesper_TeachSneak = TRUE;
		Info_ClearChoices(DIA_Jesper_Bezahlen);
	}
	else
	{
		AI_Output (self, other, "DIA_Jesper_Bezahlen_Okay_09_03");	//You can't learn anything without gold.
		Info_ClearChoices (DIA_Jesper_Bezahlen);
	};
};


instance DIA_Jesper_Schleichen(C_Info)
{
	npc = VLK_446_Jesper;
	nr = 10;
	condition = DIA_Jesper_Schleichen_Condition;
	information = DIA_Jesper_Schleichen_Info;
	permanent = TRUE;
//	description = B_BuildLearnString("����� ���� ��������",B_GetLearnCostTalent(other,NPC_TALENT_SNEAK,1));
	description = B_BuildLearnString(NAME_Skill_Sneak,B_GetLearnCostTalent(other,NPC_TALENT_SNEAK,1));
};


func int DIA_Jesper_Schleichen_Condition()
{
	if((Jesper_TeachSneak == TRUE) && !Npc_GetTalentSkill(other,NPC_TALENT_SNEAK))
	{
		return TRUE;
	};
};

func void DIA_Jesper_Schleichen_Info()
{
	AI_Output (other, self, "DIA_Jesper_Schleichen_15_00");	//Teach me the art of sneaking.
	if (B_TeachThiefTalent (self, other, NPC_TALENT_SNEAK))
	{
		AI_Output (self, other, "DIA_Jesper_Schleichen_09_01");	//Sneaking is essential for every thief. Above all, when you're moving around in somebody else's house.
		AI_Output (self, other, "DIA_Jesper_Schleichen_09_02");	//Don't just tramp on in like that. Most people sleep very lightly.
		AI_Output (self, other, "DIA_Jesper_Schleichen_09_03");	//Only when you sneak will no one hear you - and you can work unhindered.
	};
};


instance DIA_Jesper_Killer(C_Info)
{
	npc = VLK_446_Jesper;
	nr = 1;
	condition = DIA_Jesper_Killer_Condition;
	information = DIA_Jesper_Killer_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Jesper_Killer_Condition()
{
	if(Npc_IsDead(Cassia) || Npc_IsDead(Ramirez))
	{
		return TRUE;
	};
};

func void DIA_Jesper_Killer_Info()
{
	if(Npc_IsDead(Cassia) && Npc_IsDead(Ramirez))
	{
		AI_Output (self, other, "DIA_Jesper_Killer_09_00");	//You killed my friends. Why did you do that, you murderer?
		AI_Output (self, other, "DIA_Jesper_Killer_09_01");	//I'll send you to Beliar's realm.
	}
	else if(Npc_IsDead(Cassia))
	{
		AI_Output (self, other, "DIA_Jesper_Killer_09_02");	//You killed Cassia, you dirty murderer. But you won't get past me!
	}
	else if(Npc_IsDead(Ramirez))
	{
		AI_Output (self, other, "DIA_Jesper_Killer_09_03");	//I've done more things for Ramirez and collected more cash than you'll ever see.
		AI_Output (self, other, "DIA_Jesper_Killer_09_04");	//And you just killed him, you filthy dog! It's time to pay the piper!
	};
	B_ThievesKiller();
};


instance DIA_Jesper_Bogen(C_Info)
{
	npc = VLK_446_Jesper;
	nr = 10;
	condition = DIA_Jesper_Bogen_Condition;
	information = DIA_Jesper_Bogen_Info;
	permanent = FALSE;
	description = "Say, would you know anything about Bosper's bow?";
};


func int DIA_Jesper_Bogen_Condition()
{
	if(Mob_HasItems("BOW_CHEST",ItRw_Bow_L_03_MIS) && (MIS_Bosper_Bogen == LOG_Running) && (Join_Thiefs == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Jesper_Bogen_Info()
{
	AI_Output (other, self, "DIA_Jesper_Bogen_15_00");	//Say, would you know anything about Bosper's bow?
	AI_Output (self, other, "DIA_Jesper_Bogen_09_01");	//You mean the bow from the bowyer? Yeah, I've got it packed somewhere up front in a chest.
	AI_Output (self, other, "DIA_Jesper_Bogen_09_02");	//But there's rats scurrying around there. You can fetch it, if the critters don't bother you.
	AI_Output (self, other, "DIA_Jesper_Bogen_09_03");	//Oh, well of course the chest is locked. You just have to break into it. (grins) Hopefully, you still have lock picks.
	Wld_InsertNpc (Giant_Rat, "NW_CITY_KANAL_ROOM_01_01");
	Wld_InsertNpc (Giant_Rat, "NW_CITY_KANAL_ROOM_01_02");
	Wld_InsertNpc (Giant_Rat, "NW_CITY_KANAL_ROOM_01_03");
};


instance DIA_Jesper_Tuer(C_Info)
{
	npc = VLK_446_Jesper;
	nr = 10;
	condition = DIA_Jesper_Tuer_Condition;
	information = DIA_Jesper_Tuer_Info;
	permanent = FALSE;
	description = "What's behind that locked door?";
};


func int DIA_Jesper_Tuer_Condition()
{
//	if((MIS_CassiaRing == LOG_SUCCESS) && (Kapitel >= 3))
	if(Join_Thiefs == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Jesper_Tuer_Info()
{
	AI_Output (other, self, "DIA_Jesper_Tuer_15_00");	//What's behind that locked door?
	AI_Output (self, other, "DIA_Jesper_Tuer_09_01");	//(grins) Behind that is the chest - the chest of the master lock picker. Fingers.
	AI_Output (self, other, "DIA_Jesper_Tuer_09_02");	//He put such an unbelievably complicated lock on it that, till now, no one has been able to open it.
	AI_Output (self, other, "DIA_Jesper_Tuer_09_03");	//Unfortunately, he got nabbed - they tossed him through the Barrier, where he probably died.
	if(Npc_HasItems(self,ItKe_Fingers))
	{
		AI_Output(self,other,"DIA_Jesper_Tuer_09_04");	//But if you want to try opening the chest, here's the key to the room.
		B_GiveInvItems(self,other,ItKe_Fingers,1);
	};
};


instance DIA_Jesper_Truhe(C_Info)
{
	npc = VLK_446_Jesper;
	nr = 10;
	condition = DIA_Jesper_Truhe_Condition;
	information = DIA_Jesper_Truhe_Info;
	permanent = FALSE;
	description = "I managed to open the chest.";
};


func int DIA_Jesper_Truhe_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Jesper_Tuer))
	{
		if(Mob_HasItems("MOB_FINGERS",ItMi_Gold) < 300)
		{
			return TRUE;
		};
		if(Mob_HasItems("MOB_FINGERS",ItMi_SilverCup) < 5)
		{
			return TRUE;
		};
		if(!Mob_HasItems("MOB_FINGERS",ItMi_GoldCup))
		{
			return TRUE;
		};
		if(!Mob_HasItems("MOB_FINGERS",ItAm_Strg_01))
		{
			return TRUE;
		};
		if(!Mob_HasItems("MOB_FINGERS",ItPo_Perm_DEX))
		{
			return TRUE;
		};
	};
};

func void DIA_Jesper_Truhe_Info()
{
	AI_Output (other, self, "DIA_Jesper_Truhe_15_00");	//I managed to open the chest.
	AI_Output (self, other, "DIA_Jesper_Truhe_09_01");	//That's impossible! It looks like we've got a new master lock picker.
	AI_Output (self, other, "DIA_Jesper_Truhe_09_02");	//Congratulations on this accomplishment.
	B_GivePlayerXP (XP_JesperTruhe);
};

