
instance DIA_Matteo_EXIT(C_Info)
{
	npc = VLK_416_Matteo;
	nr = 999;
	condition = DIA_Matteo_EXIT_Condition;
	information = DIA_Matteo_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Matteo_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Matteo_EXIT_Info()
{
	B_EquipTrader(self);
	AI_StopProcessInfos(self);
};


instance DIA_Matteo_PICKPOCKET(C_Info)
{
	npc = VLK_416_Matteo;
	nr = 900;
	condition = DIA_Matteo_PICKPOCKET_Condition;
	information = DIA_Matteo_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_80;
};


func int DIA_Matteo_PICKPOCKET_Condition()
{
	return C_Beklauen(80,150);
};

func void DIA_Matteo_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Matteo_PICKPOCKET);
	Info_AddChoice(DIA_Matteo_PICKPOCKET,Dialog_Back,DIA_Matteo_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Matteo_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Matteo_PICKPOCKET_DoIt);
};

func void DIA_Matteo_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Matteo_PICKPOCKET);
};

func void DIA_Matteo_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Matteo_PICKPOCKET);
};


instance DIA_Matteo_Hallo(C_Info)
{
	npc = VLK_416_Matteo;
	nr = 1;
	condition = DIA_Matteo_Hallo_Condition;
	information = DIA_Matteo_Hallo_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Matteo_Hallo_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (other.guild != GIL_PAL))
	{
		return TRUE;
	};
};

func void DIA_Matteo_Hallo_Info()
{
	AI_Output (self, other, "DIA_Matteo_Hallo_09_00");	//What can I do for you?
};


instance DIA_Matteo_SellWhat(C_Info)
{
	npc = VLK_416_Matteo;
	nr = 1;
	condition = DIA_Matteo_SellWhat_Condition;
	information = DIA_Matteo_SellWhat_Info;
	permanent = FALSE;
	description = "What are you selling?";
};


func int DIA_Matteo_SellWhat_Condition()
{
	return TRUE;
};

func void DIA_Matteo_SellWhat_Info()
{
	AI_Output(other,self,"DIA_Matteo_SellWhat_15_00");	//What are you selling?
	if(Kapitel < 4)
	{
	AI_Output (self, other, "DIA_Matteo_SellWhat_09_01");	//I can offer you everything you need to survive in the wild. Weapons, torches, provisions ... even armor.
	AI_Output (self, other, "DIA_Matteo_SellWhat_09_02");	//I still have a special piece in stock.
	AI_Output (self, other, "DIA_Matteo_SellWhat_09_03");	//Double hardened armor of snapper leather - still unused. Interested?
	}
	else
	{
		AI_Output(self,other,"DIA_Canthar_TRADE_09_01");	//Take your pick.
	};
	if(Knows_Matteo == FALSE)
	{
		Log_CreateTopic(TOPIC_CityTrader,LOG_NOTE);
		B_LogEntry(TOPIC_CityTrader,"Matteo's shop is at the south gate of the city. He sells equipment, weapons and supplies.");
		Knows_Matteo = TRUE;
	};
};


instance DIA_Matteo_TRADE(C_Info)
{
	npc = VLK_416_Matteo;
	nr = 800;
	condition = DIA_Matteo_TRADE_Condition;
	information = DIA_Matteo_TRADE_Info;
	permanent = TRUE;
	description = DIALOG_TRADE_v4;
	trade = TRUE;
};


func int DIA_Matteo_TRADE_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Matteo_SellWhat))
	{
		return TRUE;
	};
};


var int Matteo_TradeNewsPermanent;

func void B_MatteoAboutLothar()
{
	AI_Output(self,other,"DIA_Matteo_TRADE_09_01");	//Since the mercenaries did in the paladin Lothar, the paladins' inspections have gotten a lot tougher.
	AI_Output(self,other,"DIA_Matteo_TRADE_09_02");	//I hope that will ease up once they've hanged the murderer.
	Matteo_TradeNewsPermanent = 1;
};

func void DIA_Matteo_TRADE_Info()
{
	AI_Output(other,self,"DIA_Matteo_TRADE_15_00");	//Show me your wares.
	if((Kapitel == 3) && (MIS_RescueBennet != LOG_SUCCESS) && (Matteo_TradeNewsPermanent == 0))
	{
		B_MatteoAboutLothar();
	};
	if((Kapitel == 4) && (Matteo_TradeNewsPermanent < 2))
	{
		AI_Output(self,other,"DIA_Matteo_TRADE_09_04");	//It's a good thing you're refreshing your supplies again, who knows if the city will still be standing next week.
		Matteo_TradeNewsPermanent = 2;
	};
	if((Kapitel == 5) && (Matteo_TradeNewsPermanent < 3))
	{
		AI_Output(self,other,"DIA_Matteo_TRADE_09_03");	//It looks like the paladins are really serious this time, they've even withdrawn their ship guards.
		if(Matteo_TradeNewsPermanent != 2)
		{
			AI_Output(self,other,"DIA_Matteo_TRADE_09_04");	//It's a good thing you're refreshing your supplies again, who knows if the city will still be standing next week.
		};
		Matteo_TradeNewsPermanent = 3;
	};
	B_GiveTradeInv(self);
	if(MIS_Serpentes_MinenAnteil_KDF == LOG_Running)
	{
		MatteoMinenAnteil = TRUE;
	};
	if(!Npc_HasItems(self,ItMi_Pan) && !Npc_HasItems(other,ItMi_Pan))
	{
		CreateInvItems(self,ItMi_Pan,1);
	};
	Trade_IsActive = TRUE;
};


var int Matteo_LeatherBought;

instance DIA_Matteo_LEATHER(C_Info)
{
	npc = VLK_416_Matteo;
	nr = 850;
	condition = DIA_Matteo_LEATHER_Condition;
	information = DIA_Matteo_LEATHER_Info;
	permanent = TRUE;
	description = "Buy Leather Armor. Protection: 25/20/5/0. (250 gold)";
};


func int DIA_Matteo_LEATHER_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Matteo_SellWhat) && (Matteo_LeatherBought == FALSE) && (Kapitel < 4))
	{
		return TRUE;
	};
};

func void DIA_Matteo_LEATHER_Info()
{
	AI_Output (other, self, "DIA_Matteo_LEATHER_15_00");	//All right, give me the armor.
	if (B_GiveInvItems (other, self, ItMi_Gold, 250))
	{
		AI_Output(self,other,"DIA_Matteo_LEATHER_09_01");	//You'll love it. (grins)
		B_GiveArmor(ITAR_Leather_L);
		Matteo_LeatherBought = TRUE;
	}
	else
	{
		AI_Output (self, other, "DIA_Matteo_LEATHER_09_02");	//The armor has its price - and it's worth it. So, come back when you have enough gold.
	};
};


var int Matteo_Confiscated;

instance DIA_Matteo_Paladine(C_Info)
{
	npc = VLK_416_Matteo;
	nr = 2;
	condition = DIA_Matteo_Paladine_Condition;
	information = DIA_Matteo_Paladine_Info;
	permanent = FALSE;
	description = "What do you know about paladins?";
};


func int DIA_Matteo_Paladine_Condition()
{
	return TRUE;
};

func void DIA_Matteo_Paladine_Info()
{
	AI_Output(other,self,"DIA_Matteo_Paladine_15_00");	//What do you know about paladins?
	if((Kapitel == 3) && (MIS_RescueBennet != LOG_SUCCESS) && (Matteo_TradeNewsPermanent == 0))
	{
		B_MatteoAboutLothar();
	}
	else if(other.guild == GIL_PAL)
	{
		AI_Output(self,other,"DIA_Landstreicher_HALLO_wer_vorsicht_09_02");	//No offense. Be on your way. You're a busy man, don't let me keep you.
		B_EquipTrader(self);
		AI_StopProcessInfos(self);
	}
	else
	{
	AI_Output (self, other, "DIA_Matteo_Paladine_09_01");	//Since these bastards have come to the city, I've had nothing but trouble.
	AI_Output (self, other, "DIA_Matteo_Paladine_09_02");	//The last time I was headed for the upper end of town, the guards flat out stopped me and asked me what was my business there!
	AI_Output (other, self, "DIA_Matteo_Paladine_15_03");	//And?
	AI_Output (self, other, "DIA_Matteo_Paladine_09_04");	//Of course they let me in!
	AI_Output (self, other, "DIA_Matteo_Paladine_09_05");	//I had my shop in the city when most of those pompous asses were still chasing pigs with wooden swords!
	AI_Output (self, other, "DIA_Matteo_Paladine_09_06");	//And yesterday the bastards came and confiscated half of my goods!
		Matteo_Confiscated = TRUE;
	};
};


instance DIA_Matteo_Confiscated(C_Info)
{
	npc = VLK_416_Matteo;
	nr = 2;
	condition = DIA_Matteo_Confiscated_Condition;
	information = DIA_Matteo_Confiscated_Info;
	permanent = FALSE;
	description = "The paladins seized your goods?";
};


func int DIA_Matteo_Confiscated_Condition()
{
	if(Matteo_Confiscated == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Matteo_Confiscated_Info()
{
	AI_Output (other, self, "DIA_Matteo_Confiscated_15_00");	//The paladins seized your goods?
	AI_Output (self, other, "DIA_Matteo_Confiscated_09_01");	//Everything I had stored in the back yard.
	AI_Output (self, other, "DIA_Matteo_Confiscated_09_02");	//They simply posted a guard in front of the entrance to the yard.
	if(other.guild != GIL_PAL)
	{
		AI_Output(self,other,"DIA_Matteo_Confiscated_09_03");	//If I'm lucky, they won't take everything. At least they might leave the armor here.
	};
};


instance DIA_Matteo_HelpMeToOV(C_Info)
{
	npc = VLK_416_Matteo;
	nr = 3;
	condition = DIA_Matteo_HelpMeToOV_Condition;
	information = DIA_Matteo_HelpMeToOV_Info;
	permanent = FALSE;
	description = "Can you help me get into the upper quarter?";
};


func int DIA_Matteo_HelpMeToOV_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Matteo_Paladine) && (Player_IsApprentice == APP_NONE))
	{
		if((other.guild == GIL_NONE) || (other.guild == GIL_NOV))
		{
			return TRUE;
		};
	};
};

func void DIA_Matteo_HelpMeToOV_Info()
{
	AI_Output (other, self, "DIA_Matteo_HelpMeToOV_15_00");	//Can you help me get into the upper quarter?
	AI_Output (self, other, "DIA_Matteo_HelpMeToOV_09_01");	//(stunned) What? What are you going to do THERE?
	AI_Output (other, self, "DIA_Matteo_HelpMeToOV_15_02");	//I've got an important message ...
	AI_Output (self, other, "DIA_Matteo_HelpMeToOV_09_03");	//Well, well...Have you tried getting past the guards?
	if (Torwache_305.aivar[AIV_TalkedToPlayer] == TRUE)
	{
		AI_Output (other, self, "DIA_Matteo_HelpMeToOV_15_04");	//(bitter laugh) Oh man, forget it!
		AI_Output (self, other, "DIA_Matteo_HelpMeToOV_09_05");	//(laughs) That's TYPICAL of those beggars!
	}
	else
	{
		AI_Output (other, self, "DIA_Matteo_HelpMeToOV_15_06");	//I don't see why I should even try.
		AI_Output (self, other, "DIA_Matteo_HelpMeToOV_09_07");	//You're probably right.
	};
	AI_Output (self, other, "DIA_Matteo_HelpMeToOV_09_08");	//I don't know HOW important your message is - and it's none of my business.
	AI_Output (self, other, "DIA_Matteo_HelpMeToOV_09_09");	//But even if you told them that a ship full of orcs just anchored in the harbor, they'd send you away.
	AI_Output (self, other, "DIA_Matteo_HelpMeToOV_09_10");	//Because they have their ORDERS.
};

func void B_Matteo_Preis()
{
	AI_Output (self, other, "DIA_Matteo_HelpMeNow_09_01");	//It seems to be really important to you.
	AI_Output (self, other, "DIA_Matteo_HelpMeNow_09_02");	//(slyly) The question is: HOW important is it to you?
	AI_Output (other, self, "DIA_Matteo_HelpMeNow_15_03");	//What are you getting at?
	AI_Output (self, other, "DIA_Matteo_HelpMeNow_09_04");	//I can help you - after all, I am one of the most influential people here.
	AI_Output (self, other, "DIA_Matteo_HelpMeNow_09_05");	//But it'll cost you.
};


instance DIA_Matteo_HelpMeNow(C_Info)
{
	npc = VLK_416_Matteo;
	nr = 3;
	condition = DIA_Matteo_HelpMeNow_Condition;
	information = DIA_Matteo_HelpMeNow_Info;
	permanent = FALSE;
	description = "So can you help me get into the upper quarter?";
};


func int DIA_Matteo_HelpMeNow_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Matteo_HelpMeToOV) && (Player_IsApprentice == APP_NONE))
	{
		if((other.guild == GIL_NONE) || (other.guild == GIL_NOV))
		{
			return TRUE;
		};
	};
};

func void DIA_Matteo_HelpMeNow_Info()
{
	AI_Output (other, self, "DIA_Matteo_HelpMeNow_15_00");	//So can you help me get into the upper quarter?
	B_Matteo_Preis ();
};


instance DIA_Matteo_LehrlingLater(C_Info)
{
	npc = VLK_416_Matteo;
	nr = 3;
	condition = DIA_Matteo_LehrlingLater_Condition;
	information = DIA_Matteo_LehrlingLater_Info;
	permanent = FALSE;
	description = "Help me to become an apprentice to one of the masters.";
};


func int DIA_Matteo_LehrlingLater_Condition()
{
	if(Player_IsApprentice == APP_NONE)
	{
		if((other.guild != GIL_NONE) && (other.guild != GIL_NOV))
		{
			return TRUE;
		};
	};
};

func void DIA_Matteo_LehrlingLater_Info()
{
	AI_Output (other, self, "DIA_Matteo_LehrlingLater_15_00");	//So can you help me get into the upper quarter?
	B_Matteo_Preis ();
};


instance DIA_Matteo_PriceOfHelp(C_Info)
{
	npc = VLK_416_Matteo;
	nr = 3;
	condition = DIA_Matteo_PriceOfHelp_Condition;
	information = DIA_Matteo_PriceOfHelp_Info;
	permanent = FALSE;
	description = "What are you asking for your help?";
};


func int DIA_Matteo_PriceOfHelp_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Matteo_HelpMeNow) || Npc_KnowsInfo(other,DIA_Matteo_LehrlingLater))
	{
		return TRUE;
	};
};

func void DIA_Matteo_PriceOfHelp_Info()
{
	AI_Output (other, self, "DIA_Matteo_PriceOfHelp_15_00");	//What are you asking for your help?
	AI_Output (self, other, "DIA_Matteo_PriceOfHelp_09_01");	//100 gold pieces.
	Info_ClearChoices (DIA_Matteo_PriceOfHelp);
	Info_AddChoice (DIA_Matteo_PriceOfHelp, "That's a whole damn lot ...", DIA_Matteo_PriceOfHelp_Wow);
	Info_AddChoice (DIA_Matteo_PriceOfHelp, "You shark!", DIA_Matteo_PriceOfHelp_Cutthroat);
};

func void B_Matteo_RegDichAb()
{
	AI_Output (self, other, "B_Matteo_RegDichAb_09_00");	//Take it easy! It isn't YOUR gold I have in mind.
	AI_Output (other, self, "B_Matteo_RegDichAb_15_01");	//But?
	AI_Output (self, other, "B_Matteo_RegDichAb_09_02");	//In principle, it's MY gold.
	AI_Output (self, other, "B_Matteo_RegDichAb_09_03");	//Gritta, the carpenter's niece, hasn't paid what she owes me in ages.
	AI_Output (self, other, "B_Matteo_RegDichAb_09_04");	//But the little brat is constantly running around in new clothes - that means she has the money.
	AI_Output (self, other, "B_Matteo_RegDichAb_09_05");	//I'd like to beat it out of her, but Master Thorben - the carpenter - is also a very influential man.
	AI_Output (self, other, "B_Matteo_RegDichAb_09_06");	//Get me the money and I'll help you.
	MIS_Matteo_Gold = LOG_Running;
	Log_CreateTopic (TOPIC_Matteo, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_Matteo, LOG_Running);
	B_LogEntry (TOPIC_Matteo, "Carpenter Thorben's niece Gritta owes Matteo 100 pieces of gold. If I get them back for him, he'll help me to get into the upper quarter.");
};

func void DIA_Matteo_PriceOfHelp_Cutthroat()
{
	AI_Output (other, self, "DIA_Matteo_PriceOfHelp_Cutthroat_15_00");	//You shark!
	B_Matteo_RegDichAb ();
	Info_ClearChoices (DIA_Matteo_PriceOfHelp);
};

func void DIA_Matteo_PriceOfHelp_Wow()
{
	AI_Output (other, self, "DIA_Matteo_PriceOfHelp_Wow_15_00");	//That's a whole damn lot ...
	B_Matteo_RegDichAb ();
	Info_ClearChoices (DIA_Matteo_PriceOfHelp);
};


instance DIA_Matteo_WoGritta(C_Info)
{
	npc = VLK_416_Matteo;
	nr = 2;
	condition = DIA_Matteo_WoGritta_Condition;
	information = DIA_Matteo_WoGritta_Info;
	permanent = FALSE;
	description = "Where can I find this Gritta?";
};


func int DIA_Matteo_WoGritta_Condition()
{
	if(MIS_Matteo_Gold == LOG_Running)
	{
		return TRUE;
	};
};

func void DIA_Matteo_WoGritta_Info()
{
	AI_Output (other, self, "DIA_Matteo_WoGritta_15_00");	//Where can I find this Gritta?
	AI_Output (self, other, "DIA_Matteo_WoGritta_09_01");	//Like I said - she's the carpenter's niece - his house is down the street, the last house on the right before the smithy.
};


instance DIA_Matteo_GoldRunning(C_Info)
{
	npc = VLK_416_Matteo;
	nr = 500;
	condition = DIA_Matteo_GoldRunning_Condition;
	information = DIA_Matteo_GoldRunning_Info;
	permanent = TRUE;
	description = "Here's your 100 gold pieces!";
};


func int DIA_Matteo_GoldRunning_Condition()
{
	if((MIS_Matteo_Gold == LOG_Running) && (Npc_KnowsInfo(other,DIA_Gritta_WantsMoney) || Npc_IsDead(Gritta)))
	{
		return TRUE;
	};
};

func void DIA_Matteo_GoldRunning_Info()
{
	AI_Output (other, self, "DIA_Matteo_GoldRunning_15_00");	//Here's your 100 gold pieces!
	if (Npc_IsDead (Gritta))
	{
		AI_Output (self, other, "DIA_Matteo_GoldRunning_09_01");	//That gold has Gritta's blood on it! I didn't say anything about you killing her!
		AI_Output (self, other, "DIA_Matteo_GoldRunning_09_02");	//I don't want anything to do with this business. You can forget our deal! And never speak to me about it again!
		MIS_Matteo_Gold = LOG_FAILED;
		B_CheckLog();
		B_EquipTrader(self);
		AI_StopProcessInfos(self);
		return;
	};
	if(B_GiveInvItems(other,self,ItMi_Gold,100))
	{
		if(Npc_HasItems(Gritta,ItMi_Gold) < 80)
		{
			AI_Output (self, other, "DIA_Matteo_GoldRunning_09_03");	//And? Did she cause any problems?
			AI_Output (other, self, "DIA_Matteo_GoldRunning_15_04");	//None to speak of.
			AI_Output (self, other, "DIA_Matteo_GoldRunning_09_05");	//Good! You've held up your part of the deal.
		}
		else
		{
			AI_Output (self, other, "DIA_Matteo_GoldRunning_09_06");	//You want to pay for her? Hm - I'd have preferred it if you'd squeezed it out of her!
			AI_Output (self, other, "DIA_Matteo_GoldRunning_09_07");	//Still - 100 gold pieces is 100 gold pieces.
			AI_Output (self, other, "DIA_Matteo_GoldRunning_09_08");	//You've held up your part of the deal.
		};
		MIS_Matteo_Gold = LOG_SUCCESS;
		B_GivePlayerXP(XP_Matteo_Gold);
	}
	else
	{
		AI_Output (self, other, "DIA_Matteo_GoldRunning_09_09");	//Counting isn't your strong suit, is it? You don't have 100 gold pieces.
	};
};


instance DIA_Matteo_Zustimmung(C_Info)
{
	npc = VLK_416_Matteo;
	nr = 4;
	condition = DIA_Matteo_Zustimmung_Condition;
	information = DIA_Matteo_Zustimmung_Info;
	permanent = TRUE;
	description = "Help me to become an apprentice to one of the masters.";
};


var int DIA_Matteo_Zustimmung_perm;

func int DIA_Matteo_Zustimmung_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Matteo_HowCanYouHelp) && ((MIS_Matteo_Gold == LOG_Running) || (MIS_Matteo_Gold == LOG_SUCCESS)) && (Player_IsApprentice == APP_NONE) && (DIA_Matteo_Zustimmung_perm == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Matteo_Zustimmung_Info()
{
	AI_Output (other, self, "DIA_Matteo_Zustimmung_15_00");	//Help me sign on as an apprentice with one of the masters!
	if (MIS_Matteo_Gold == LOG_SUCCESS)
	{
		AI_Output (self, other, "DIA_Matteo_Zustimmung_09_01");	//Don't worry. I'll keep my part of the bargain.
		AI_Output (self, other, "DIA_Matteo_Zustimmung_09_02");	//The other masters will only hear the best about you from me.
		B_GivePlayerXP (XP_Zustimmung);
		B_LogEntry (TOPIC_Lehrling, "Matteo will give his approval if I want to start as an apprentice somewhere.");
		DIA_Matteo_Zustimmung_perm = TRUE;
	}
	else
	{
		AI_Output (self, other, "DIA_Matteo_Zustimmung_09_03");	//One thing at a time. First fulfill your part of the deal and bring me the gold!
	};
};


instance DIA_Matteo_HowCanYouHelp(C_Info)
{
	npc = VLK_416_Matteo;
	nr = 4;
	condition = DIA_Matteo_HowCanYouHelp_Condition;
	information = DIA_Matteo_HowCanYouHelp_Info;
	permanent = FALSE;
	description = "How EXACTLY can you help me?";
};


func int DIA_Matteo_HowCanYouHelp_Condition()
{
	if((Npc_KnowsInfo(other,DIA_Matteo_HelpMeNow) || Npc_KnowsInfo(other,DIA_Matteo_LehrlingLater)) && (Player_IsApprentice == APP_NONE) && (MIS_Matteo_Gold != LOG_FAILED))
	{
		return TRUE;
	};
};

func void DIA_Matteo_HowCanYouHelp_Info()
{
	AI_Output (other, self, "DIA_Matteo_HowCanYouHelp_15_00");	//How EXACTLY can you help me?
	AI_Output (self, other, "DIA_Matteo_HowCanYouHelp_09_01");	//Quite simple. I'll use my influence to see to it that one of the master craftsmen here takes you on as an apprentice.
	if((other.guild == GIL_NONE) || (other.guild == GIL_NOV))
	{
		AI_Output (self, other, "DIA_Matteo_HowCanYouHelp_09_02");	//As such, you'll practically be a citizen of the city and can enter the upper quarter. Besides which, you'll earn something while you're at it.
	};
	Log_CreateTopic (TOPIC_Lehrling, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_Lehrling, LOG_Running);
	B_LogEntry (TOPIC_Lehrling, "Matteo can help me to be accepted as an apprentice by one of the master craftsmen.");
};


instance DIA_Matteo_WoAlsLehrling(C_Info)
{
	npc = VLK_416_Matteo;
	nr = 4;
	condition = DIA_Matteo_WoAlsLehrling_Condition;
	information = DIA_Matteo_WoAlsLehrling_Info;
	permanent = FALSE;
	description = "Where could I sign on as an apprentice, then?";
};


func int DIA_Matteo_WoAlsLehrling_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Matteo_HowCanYouHelp) && (Player_IsApprentice == APP_NONE))
	{
		return TRUE;
	};
};

func void DIA_Matteo_WoAlsLehrling_Info()
{
	AI_Output (other, self, "DIA_Matteo_WoAlsLehrling_15_00");	//Where could I sign on as an apprentice, then?
	AI_Output (self, other, "DIA_Matteo_WoAlsLehrling_09_01");	//Basically, with any master here on the main street.
	AI_Output (self, other, "DIA_Matteo_WoAlsLehrling_09_02");	//That would be Harad the smith, Bosper the bowyer, Thorben the carpenter or Constantino the alchemist.
	AI_Output (self, other, "DIA_Matteo_WoAlsLehrling_09_03");	//One of them is bound to take you on.
	AI_Output (self, other, "DIA_Matteo_WoAlsLehrling_09_04");	//But it's important that the other masters agree. That's always been the custom here in Khorinis.
	Log_CreateTopic (TOPIC_Lehrling, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_Lehrling, LOG_Running);
	B_LogEntry (TOPIC_Lehrling, "I could start work as an apprentice for Bosper the bowmaker, Harad the smith, Thorben the carpenter or Constantino the alchemist.");
	Log_AddEntry(TOPIC_Lehrling,"Before I can become an apprentice, I have to get the approval of the other masters.");
};


instance DIA_Matteo_WieZustimmung(C_Info)
{
	npc = VLK_416_Matteo;
	nr = 5;
	condition = DIA_Matteo_WieZustimmung_Condition;
	information = DIA_Matteo_WieZustimmung_Info;
	permanent = FALSE;
	description = "How do I get the approval of the other masters?";
};


func int DIA_Matteo_WieZustimmung_Condition()
{
	if((Npc_KnowsInfo(other,DIA_Matteo_WoAlsLehrling) || Npc_KnowsInfo(other,DIA_Matteo_WarumNichtBeiDir)) && (Player_IsApprentice == APP_NONE))
	{
		return TRUE;
	};
};

func void DIA_Matteo_WieZustimmung_Info()
{
	AI_Output (other, self, "DIA_Matteo_WieZustimmung_15_00");	//How do I get the approval of the other masters?
	AI_Output (self, other, "DIA_Matteo_WieZustimmung_09_01");	//You just have to convince them. Go and talk to them.
	AI_Output (self, other, "DIA_Matteo_WieZustimmung_09_02");	//But if more than one of them is against you, you don't stand a chance! So behave yourself!
	B_LogEntry (TOPIC_Lehrling, "I can only get the masters' approval if I can prove myself to them.");
};


instance DIA_Matteo_WarumNichtBeiDir(C_Info)
{
	npc = VLK_416_Matteo;
	nr = 6;
	condition = DIA_Matteo_WarumNichtBeiDir_Condition;
	information = DIA_Matteo_WarumNichtBeiDir_Info;
	permanent = FALSE;
	description = "Why don't YOU take me on as an apprentice?";
};


func int DIA_Matteo_WarumNichtBeiDir_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Matteo_HowCanYouHelp) && (Player_IsApprentice == APP_NONE))
	{
		return TRUE;
	};
};

func void DIA_Matteo_WarumNichtBeiDir_Info()
{
	AI_Output(other,self,"DIA_Matteo_WarumNichtBeiDir_15_00");	//Why don't YOU take me on as an apprentice?
	if(MIS_Matteo_Gold != LOG_FAILED)
	{
	AI_Output (self, other, "DIA_Matteo_WarumNichtBeiDir_09_01");	//I would - but the other masters wouldn't agree.
	AI_Output (self, other, "DIA_Matteo_WarumNichtBeiDir_09_02");	//I just recently took on another apprentice.
	}
	else
	{
		B_Say(self,other,"$NOTNOW");
		B_EquipTrader(self);
		AI_StopProcessInfos(self);
	};
};


instance DIA_Matteo_OtherWay(C_Info)
{
	npc = VLK_416_Matteo;
	nr = 6;
	condition = DIA_Matteo_OtherWay_Condition;
	information = DIA_Matteo_OtherWay_Info;
	permanent = FALSE;
	description = "Is there another way to get into the upper quarter?";
};


func int DIA_Matteo_OtherWay_Condition()
{
	if((Npc_KnowsInfo(other,DIA_Matteo_HowCanYouHelp) || (MIS_Matteo_Gold == LOG_FAILED)) && (Mil_305_schonmalreingelassen == FALSE) && (Player_IsApprentice == APP_NONE))
	{
		if((other.guild == GIL_NONE) || (other.guild == GIL_NOV))
		{
			return TRUE;
		};
	};
};

func void DIA_Matteo_OtherWay_Info()
{
	AI_Output (other, self, "DIA_Matteo_OtherWay_15_00");	//Is there another way to get into the upper quarter?
	if(MIS_Matteo_Gold != LOG_FAILED)
	{
		AI_Output(self,other,"DIA_Matteo_OtherWay_09_01");	//Perhaps ... if I think of anything, I'll let you know.
	}
	else
	{
		AI_Output(self,other,"DIA_Matteo_GoldRunning_09_02");	//I don't want anything to do with this business. You can forget our deal! And never speak to me about it again!
		B_EquipTrader(self);
		AI_StopProcessInfos(self);
	};
};


instance DIA_Matteo_Minenanteil(C_Info)
{
	npc = VLK_416_Matteo;
	nr = 3;
	condition = DIA_Matteo_Minenanteil_Condition;
	information = DIA_Matteo_Minenanteil_Info;
	description = "You've got some mining shares among your wares.";
};


func int DIA_Matteo_Minenanteil_Condition()
{
	if((other.guild == GIL_KDF) && (MIS_Serpentes_MinenAnteil_KDF == LOG_Running) && (MatteoMinenAnteil == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Matteo_Minenanteil_Info()
{
	AI_Output (other, self, "DIA_Matteo_Minenanteil_15_00");	//You've got some mining shares among your wares. Who sold them to you?
	AI_Output (self, other, "DIA_Matteo_Minenanteil_09_01");	//(nervously) Mining shares? Oops. Where did they come from? No idea where I got them. Honestly, your honor.
	B_GivePlayerXP (XP_Ambient);
};

