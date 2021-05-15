
instance DIA_Hodges_Kap1_EXIT(C_Info)
{
	npc = BAU_908_Hodges;
	nr = 999;
	condition = DIA_Hodges_Kap1_EXIT_Condition;
	information = DIA_Hodges_Kap1_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Hodges_Kap1_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Hodges_Kap1_EXIT_Info()
{
	B_EquipTrader(self);
	AI_StopProcessInfos(self);
};


instance DIA_Hodges_HALLO(C_Info)
{
	npc = BAU_908_Hodges;
	nr = 1;
	condition = DIA_Hodges_HALLO_Condition;
	information = DIA_Hodges_HALLO_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Hodges_HALLO_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (self.aivar[AIV_TalkedToPlayer] == FALSE) && ((Kapitel != 3) || (MIS_RescueBennet == LOG_SUCCESS)))
	{
		return TRUE;
	};
};

func void DIA_Hodges_HALLO_Info()
{
	if(other.guild == GIL_NONE)
	{
		AI_Output(other,self,"DIA_Hodges_HALLO_15_00");	//Hello, I'm new here.
	}
	else
	{
		AI_Output(other,self,"DIA_Addon_BDT_10004_Finn_Hi_15_00");	//Hi!
	};
	AI_Output (self, other, "DIA_Hodges_HALLO_03_01");	//Don't take this the wrong way, but I'm really not in the mood for conversation - I'm totally wrecked.
	AI_Output (other, self, "DIA_Hodges_HALLO_15_02");	//You're awfully busy, huh?
	AI_Output (self, other, "DIA_Hodges_HALLO_03_03");	//You can say that again. Bennet makes so many weapons that I can hardly keep up with the polishing.
};


instance DIA_Hodges_TellAboutFarm(C_Info)
{
	npc = BAU_908_Hodges;
	nr = 2;
	condition = DIA_Hodges_TellAboutFarm_Condition;
	information = DIA_Hodges_TellAboutFarm_Info;
	permanent = FALSE;
	description = "What can you tell me about the farm?";
};


func int DIA_Hodges_TellAboutFarm_Condition()
{
	if((Kapitel != 3) || (MIS_RescueBennet == LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Hodges_TellAboutFarm_Info()
{
	AI_Output (other, self, "DIA_Hodges_TellAboutFarm_15_00");	//What can you tell me about the farm?
	AI_Output (self, other, "DIA_Hodges_TellAboutFarm_03_01");	//This is Onar's farm.
	AI_Output (self, other, "DIA_Hodges_TellAboutFarm_03_02");	//That big building is his house. He vacated a wing for the mercenaries.
	AI_Output (self, other, "DIA_Hodges_TellAboutFarm_03_03");	//We farmers have had to bunk in the barn ever since.
	AI_Output (self, other, "DIA_Hodges_TellAboutFarm_03_04");	//(hastily) But it's all right with me, it's good that we have people who guard the farm.
	if (Npc_GetDistToWP (self, "NW_BIGFARM_SMITH_SHARP") < 500)
	{
		AI_Output (self, other, "DIA_Hodges_TellAboutFarm_03_05");	//The building here is the kitchen.
	}
	else
	{
		AI_Output (self, other, "DIA_Hodges_TellAboutFarm_03_06");	//The kitchen is in the building with the smithy in front.
	};
	AI_Output (self, other, "DIA_Hodges_TellAboutFarm_03_07");	//Maybe you'll be lucky and Thekla will have something for you to eat.
};


instance DIA_Hodges_AboutSld(C_Info)
{
	npc = BAU_908_Hodges;
	nr = 2;
	condition = DIA_Hodges_AboutSld_Condition;
	information = DIA_Hodges_AboutSld_Info;
	permanent = FALSE;
	description = "What about the mercenaries?";
};


func int DIA_Hodges_AboutSld_Condition()
{
	if((hero.guild != GIL_SLD) && (hero.guild != GIL_DJG) && ((Kapitel != 3) || (MIS_RescueBennet == LOG_SUCCESS)))
	{
		return TRUE;
	};
};

func void DIA_Hodges_AboutSld_Info()
{
	AI_Output (other, self, "DIA_Hodges_AboutSld_15_00");	//What about the mercenaries?
	AI_Output (self, other, "DIA_Hodges_AboutSld_03_01");	//Onar hired them to keep the city militia off our backs.
	AI_Output (self, other, "DIA_Hodges_AboutSld_03_02");	//But they also guard the farm, the sheep and us farmers.
	AI_Output (self, other, "DIA_Hodges_AboutSld_03_03");	//So don't even think about stealing anything or rummaging around in somebody's chest.
	AI_Output (self, other, "DIA_Hodges_AboutSld_03_04");	//They're just waiting for a chance to knock you down.
};


var int Hodges_Trader;

instance DIA_Hodges_TRADE(C_Info)
{
	npc = BAU_908_Hodges;
	nr = 2;
	condition = DIA_Hodges_TRADE_Condition;
	information = DIA_Hodges_TRADE_Info;
	permanent = TRUE;
	description = "Can I buy weapons from you?";
	trade = TRUE;
};


func int DIA_Hodges_TRADE_Condition()
{
	return TRUE;
};

func void DIA_Hodges_TRADE_Info()
{
	AI_Output (other, self, "DIA_Hodges_TRADE_15_00");	//Can I buy weapons from you?
	AI_Output (self, other, "DIA_Hodges_TRADE_03_01");	//I don't have much. We take almost all the swords and axes into Onar's house.
	Npc_RemoveInvItems(self,ItMiSwordblade,Npc_HasItems(self,ItMiSwordblade));
	B_GiveTradeInv(self);
	if(Hodges_Trader == FALSE)
	{
		Log_CreateTopic(TOPIC_SoldierTrader,LOG_NOTE);
		B_LogEntry(TOPIC_SoldierTrader,"Hodges can sell me some basic weapons.");
		Hodges_Trader = TRUE;
	};
	Trade_IsActive = TRUE;
};


instance DIA_Hodges_DontWork(C_Info)
{
	npc = BAU_908_Hodges;
	nr = 31;
	condition = DIA_Hodges_DontWork_Condition;
	information = DIA_Hodges_DontWork_Info;
	permanent = FALSE;
	description = "Why aren't you working?";
};


func int DIA_Hodges_DontWork_Condition()
{
	if((Kapitel == 3) && (MIS_RescueBennet != LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Hodges_DontWork_Info()
{
	AI_Output (other, self, "DIA_Hodges_DontWork_15_00");	//Why aren't you working?
	AI_Output (self, other, "DIA_Hodges_DontWork_03_01");	//Haven't you heard yet? The paladins have arrested Bennet.
	if(MIS_RescueBennet != LOG_Running)
	{
		MIS_RescueBennet = LOG_Running;
		Log_CreateTopic(TOPIC_RescueBennet,LOG_MISSION);
		Log_SetTopicStatus(TOPIC_RescueBennet,LOG_Running);
		B_LogEntry(TOPIC_RescueBennet,"Bennet the smith has been arrested by the paladins in the city.");
	};
};


instance DIA_Hodges_WhatHappened(C_Info)
{
	npc = BAU_908_Hodges;
	nr = 31;
	condition = DIA_Hodges_WhatHappened_Condition;
	information = DIA_Hodges_WhatHappened_Info;
	permanent = FALSE;
	description = "What happened?";
};


func int DIA_Hodges_WhatHappened_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Hodges_DontWork) && (MIS_RescueBennet != LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Hodges_WhatHappened_Info()
{
	AI_Output (other, self, "DIA_Hodges_WhatHappened_15_00");	//What happened?
	AI_Output (self, other, "DIA_Hodges_WhatHappened_03_01");	//Well, we were in the city to shop, when all of a sudden we heard a scream. Someone yelled: There they are, get them!
	AI_Output (self, other, "DIA_Hodges_WhatHappened_03_02");	//Boy, was I scared! I took to my heels and ran like the demons were after me.
	AI_Output (self, other, "DIA_Hodges_WhatHappened_03_03");	//Bennet was right behind me. I don't know what happened, but when I got outside the city, he had disappeared.
	AI_Output (self, other, "DIA_Hodges_WhatHappened_03_04");	//I must have lost him in the city.
};


instance DIA_Hodges_BennetsCrime(C_Info)
{
	npc = BAU_908_Hodges;
	nr = 32;
	condition = DIA_Hodges_BennetsCrime_Condition;
	information = DIA_Hodges_BennetsCrime_Info;
	permanent = FALSE;
	description = "So why was Bennet arrested?";
};


func int DIA_Hodges_BennetsCrime_Condition()
{
//	if(Npc_KnowsInfo(other,DIA_Hodges_DontWork) && (MIS_RescueBennet != LOG_SUCCESS))
	if(Npc_KnowsInfo(other,DIA_Hodges_WhatHappened) && (MIS_RescueBennet != LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Hodges_BennetsCrime_Info()
{
	AI_Output (other, self, "DIA_Hodges_BennetsCrime_15_00");	//So why was Bennet arrested?
	AI_Output (self, other, "DIA_Hodges_BennetsCrime_03_01");	//Murder! Bennet is supposed to have murdered a paladin. What nonsense. I was with him the whole time.
	AI_Output (other, self, "DIA_Hodges_BennetsCrime_15_02");	//So why don't you go to town and explain the whole thing?
	AI_Output (self, other, "DIA_Hodges_BennetsCrime_03_03");	//They'd stick me in the slammer as his accomplice. Naah, certainly not in the current situation.
	AI_Output (other, self, "DIA_Hodges_BennetsCrime_15_04");	//Situation?
	AI_Output (self, other, "DIA_Hodges_BennetsCrime_03_05");	//You know, Onar and the city, that's bound to come to a bad end.
	B_LogEntry (TOPIC_RescueBennet, "They say Bennet murdered a paladin. His apprentice Hodges says he's innocent, but he daren't enter the city.");
};


instance DIA_Hodges_BennetAndSLD(C_Info)
{
	npc = BAU_908_Hodges;
	nr = 33;
	condition = DIA_Hodges_BennetAndSLD_Condition;
	information = DIA_Hodges_BennetAndSLD_Info;
	permanent = FALSE;
	description = "How did the mercenaries here on the farm react?";
};


func int DIA_Hodges_BennetAndSLD_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Hodges_DontWork) && (MIS_RescueBennet != LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Hodges_BennetAndSLD_Info()
{
	AI_Output (other, self, "DIA_Hodges_BennetAndSLD_15_00");	//How did the mercenaries here on the farm react?
	AI_Output (self, other, "DIA_Hodges_BennetAndSLD_03_01");	//Naturally, I don't know exactly what they're planning, but some of them are really pissed off.
	AI_Output (other, self, "DIA_Hodges_BennetAndSLD_15_02");	//I can understand that.
	AI_Output (self, other, "DIA_Hodges_BennetAndSLD_03_03");	//If it were up to them, they'd rather attack the city today than tomorrow to get Bennet out.
	AI_Output (self, other, "DIA_Hodges_BennetAndSLD_03_04");	//Talk to Lee, maybe there's something you can do.
};


instance DIA_Hodges_PICKPOCKET(C_Info)
{
	npc = BAU_908_Hodges;
	nr = 900;
	condition = DIA_Hodges_PICKPOCKET_Condition;
	information = DIA_Hodges_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_20;
};


func int DIA_Hodges_PICKPOCKET_Condition()
{
	return C_Beklauen(15,10);
};

func void DIA_Hodges_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Hodges_PICKPOCKET);
	Info_AddChoice(DIA_Hodges_PICKPOCKET,Dialog_Back,DIA_Hodges_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Hodges_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Hodges_PICKPOCKET_DoIt);
};

func void DIA_Hodges_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Hodges_PICKPOCKET);
};

func void DIA_Hodges_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Hodges_PICKPOCKET);
};

