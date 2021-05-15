
instance DIA_Kervo_EXIT(C_Info)
{
	npc = STRF_1116_Kervo;
	nr = 999;
	condition = DIA_Kervo_EXIT_Condition;
	information = DIA_Kervo_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Kervo_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Kervo_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Kervo_WASIST(C_Info)
{
	npc = STRF_1116_Kervo;
	nr = 4;
	condition = DIA_Kervo_WASIST_Condition;
	information = DIA_Kervo_WASIST_Info;
	description = "What's wrong?";
};


func int DIA_Kervo_WASIST_Condition()
{
	return TRUE;
};

func void DIA_Kervo_WASIST_Info()
{
	AI_Output (other, self, "DIA_Kervo_WASIST_15_00");	//What's wrong with you?
	AI_Output (self, other, "DIA_Kervo_WASIST_13_01");	//You have to ask that? Just look around you.
	AI_Output (self, other, "DIA_Kervo_WASIST_13_02");	//These damned lurkers have spread across the entire river since I've come here.
	AI_Output (self, other, "DIA_Kervo_WASIST_13_03");	//First, there were only two. Since yesterday, I've counted five at least.
	AI_Output (self, other, "DIA_Kervo_WASIST_13_04");	//No idea how I'm ever going to get out of here.
};


instance DIA_Kervo_HILFE(C_Info)
{
	npc = STRF_1116_Kervo;
	nr = 5;
	condition = DIA_Kervo_HILFE_Condition;
	information = DIA_Kervo_HILFE_Info;
	description = "Have you tried getting through to the pass?";
};


func int DIA_Kervo_HILFE_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Kervo_WASIST))
	{
		return TRUE;
	};
};

func void DIA_Kervo_HILFE_Info()
{
	AI_Output (other, self, "DIA_Kervo_HILFE_15_00");	//Have you tried getting through to the pass?
	AI_Output (self, other, "DIA_Kervo_HILFE_13_01");	//Do I look insane to you? 20 soldiers couldn't drag me out of here as long as those beasts are out there. I despise those things.
	AI_Output (self, other, "DIA_Kervo_HILFE_13_02");	//(completely unnerved) I only have to smell them and I break out in a cold sweat. And their constant gurgling makes the blood freeze in my veins.
	AI_Output (self, other, "DIA_Kervo_HILFE_13_03");	//If you're that eager to have them skin you alive, go right ahead.
	Info_ClearChoices (DIA_Kervo_HILFE);
	Info_AddChoice (DIA_Kervo_HILFE, "Well, I'm off, then.", DIA_Kervo_HILFE_tschau);
	Info_AddChoice (DIA_Kervo_HILFE, "But you can't stay here forever.", DIA_Kervo_HILFE_ewig);
	Info_AddChoice(DIA_Kervo_HILFE,"What would you give me if I killed the things?",DIA_Kervo_HILFE_Problem);
	/*if(Kervo_GotStuff == TRUE)
	{
		Info_AddChoice(DIA_Kervo_HILFE,"What would you give me if I killed the things?",DIA_Kervo_HILFE_Problem);
	};
	MIS_Kervo_KillLurker = LOG_Running;*/
};

func void DIA_Kervo_HILFE_ewig()
{
	AI_Output (other, self, "DIA_Kervo_HILFE_ewig_15_00");	//But you can't stay here forever.
	AI_Output (self, other, "DIA_Kervo_HILFE_ewig_13_01");	//I've no idea what it is you want from me, but I can tell you this: you're not going to get me to leave here.
};


func void DIA_Kervo_HILFE_Problem()
{
	AI_Output (other, self, "DIA_Kervo_HILFE_Problem_15_00");	//What would you give me if I killed the things?
	AI_Output (self, other, "DIA_Kervo_HILFE_Problem_13_01");	//Mmh. Well. It would be enough if those lurkers in front of the cave would disappear.
	MIS_Kervo_KillLurker = LOG_Running;
	Log_CreateTopic(TOPIC_KervoLurkers,LOG_MISSION);
	Log_SetTopicStatus(TOPIC_KervoLurkers,LOG_Running);
	if(hero.guild == GIL_KDF)
	{
		AI_Output(self,other,"DIA_Kervo_HILFE_Problem_13_02");	//I found a blank runestone. Since you're a magician, I'm sure you can make use of it.
		B_LogEntry(TOPIC_KervoLurkers,"Kervo the fugitive convict promised to give me a blank rune if I kill all the lurkers surrounding his hideout.");
	}
	else
	{
		AI_Output(self,other,"DIA_Kervo_HILFE_Problem_13_03");	//I found a lump of ore.
		B_LogEntry(TOPIC_KervoLurkers,"Kervo the fugitive convict promised to give me a lump of ore if I kill all the lurkers surrounding his hideout.");
	};
	AI_Output(self,other,"DIA_Kervo_HILFE_Problem_13_04");	//I would give it to you in exchange.
	AI_StopProcessInfos(self);
};

func void DIA_Kervo_HILFE_tschau()
{
	AI_Output (other, self, "DIA_Kervo_HILFE_tschau_15_00");	//Well, I'm off, then.
	AI_Output (self, other, "DIA_Kervo_HILFE_tschau_13_01");	//Sure. I won't keep you.
	AI_StopProcessInfos (self);
};


instance DIA_Kervo_LurkerPlatt(C_Info)
{
	npc = STRF_1116_Kervo;
	condition = DIA_Kervo_LurkerPlatt_Condition;
	information = DIA_Kervo_LurkerPlatt_Info;
	description = "The lurkers in front of the cave are gone.";
};


func int DIA_Kervo_LurkerPlatt_Condition()
{
//	if((MIS_Kervo_KillLurker == LOG_Running) && Npc_IsDead(Kervo_Lurker1) && Npc_IsDead(Kervo_Lurker2) && Npc_IsDead(Kervo_Lurker3) && Npc_IsDead(Kervo_Lurker4) && Npc_IsDead(Kervo_Lurker5) && Npc_IsDead(Kervo_Lurker6))
	if(Npc_KnowsInfo(other,DIA_Kervo_HILFE) && Npc_IsDead(Kervo_Lurker1) && Npc_IsDead(Kervo_Lurker2) && Npc_IsDead(Kervo_Lurker3) && Npc_IsDead(Kervo_Lurker4) && Npc_IsDead(Kervo_Lurker5) && Npc_IsDead(Kervo_Lurker6))
	{
		return TRUE;
	};
};

func void DIA_Kervo_LurkerPlatt_Info()
{
	AI_Output (other, self, "DIA_Kervo_LurkerPlatt_15_00");	//The lurkers in front of the cave are gone.
	AI_Output (self, other, "DIA_Kervo_LurkerPlatt_13_01");	//Great. Now I can breathe again at last.
	if(MIS_Kervo_KillLurker == LOG_Running)
	{
		MIS_Kervo_KillLurker = LOG_SUCCESS;
		AI_Output(self,other,"DIA_Kervo_LurkerPlatt_13_02");	//Here's what I promised you.
		if(hero.guild == GIL_KDF)
		{
			CreateInvItems(self,ItMi_RuneBlank,1);
			B_GiveInvItems(self,other,ItMi_RuneBlank,1);
		}
		else
		{
			CreateInvItems(self,ItMi_Nugget,1);
			B_GiveInvItems(self,other,ItMi_Nugget,1);
		};
		B_GivePlayerXP(100);
	}
	else
	{
		B_GivePlayerXP(XP_KervoKillLurker);
	};
};


instance DIA_Kervo_VERGISSES(C_Info)
{
	npc = STRF_1116_Kervo;
	condition = DIA_Kervo_VERGISSES_Condition;
	information = DIA_Kervo_VERGISSES_Info;
	permanent = TRUE;
	description = "Will you cross the pass now?";
};


func int DIA_Kervo_VERGISSES_Condition()
{
//	if(MIS_Kervo_KillLurker == LOG_SUCCESS)
	if(Npc_KnowsInfo(other,DIA_Kervo_LurkerPlatt))
	{
		return TRUE;
	};
};

func void DIA_Kervo_VERGISSES_Info()
{
	AI_Output (other, self, "DIA_Kervo_VERGISSES_15_00");	//Will you cross the pass now?
	AI_Output (self, other, "DIA_Kervo_VERGISSES_13_01");	//Forget it, man. If they catch me, they'll take me back to the mines. I'm staying put.
	AI_StopProcessInfos (self);
};


instance DIA_Kervo_PICKPOCKET(C_Info)
{
	npc = STRF_1116_Kervo;
	nr = 900;
	condition = DIA_Kervo_PICKPOCKET_Condition;
	information = DIA_Kervo_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_40;
};


func int DIA_Kervo_PICKPOCKET_Condition()
{
	return C_Beklauen(34,10);
};

func void DIA_Kervo_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Kervo_PICKPOCKET);
	Info_AddChoice(DIA_Kervo_PICKPOCKET,Dialog_Back,DIA_Kervo_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Kervo_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Kervo_PICKPOCKET_DoIt);
};

func void DIA_Kervo_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Kervo_PICKPOCKET);
};

func void DIA_Kervo_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Kervo_PICKPOCKET);
};

