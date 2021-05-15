
instance DIA_Bronko_EXIT(C_Info)
{
	npc = BAU_935_Bronko;
	nr = 999;
	condition = DIA_Bronko_EXIT_Condition;
	information = DIA_Bronko_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Bronko_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Bronko_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Bronko_HALLO(C_Info)
{
	npc = BAU_935_Bronko;
	nr = 1;
	condition = DIA_Bronko_HALLO_Condition;
	information = DIA_Bronko_HALLO_Info;
	important = TRUE;
};


func int DIA_Bronko_HALLO_Condition()
{
	if(self.aivar[AIV_LastFightAgainstPlayer] != FIGHT_LOST)
	{
		return TRUE;
	};
};

func void DIA_Bronko_HALLO_Info()
{
	AI_Output (self, other, "DIA_Bronko_HALLO_06_00");	//(fatherly) So, where are we headed, then?
	AI_Output (other, self, "DIA_Bronko_HALLO_15_01");	//Are you the foreman here?
	if (hero.guild == GIL_NONE)
	{
		AI_Output (self, other, "DIA_Bronko_HALLO_06_02");	//I'll give you one upside the head, you rascal.
	};
	AI_Output (self, other, "DIA_Bronko_HALLO_06_03");	//If you want to go ambling across my land, you'll pay me 5 gold coins, or you're in for a good thrashing!
	Info_ClearChoices (DIA_Bronko_HALLO);
	Info_AddChoice (DIA_Bronko_HALLO, "Forget it. You won't get anything from me.", DIA_Bronko_HALLO_vergisses);
	Info_AddChoice (DIA_Bronko_HALLO, "If I have no choice - here's your money.", DIA_Bronko_HALLO_hiergeld);
	Info_AddChoice (DIA_Bronko_HALLO, "Your land? Are you the farmer here?", DIA_Bronko_HALLO_deinland);
};

func void DIA_Bronko_HALLO_deinland()
{
	AI_Output (other, self, "DIA_Bronko_HALLO_deinland_15_00");	//Your land? Are you the farmer here?
	AI_Output (self, other, "DIA_Bronko_HALLO_deinland_06_01");	//You can bet on that. Why else would I make you pay me a toll?
	AI_Output (self, other, "DIA_Bronko_HALLO_deinland_06_02");	//I don't mind if you go ask the others about me. Heh heh!
	AI_StopProcessInfos(self);
};

func void DIA_Bronko_HALLO_hiergeld()
{
	AI_Output (other, self, "DIA_Bronko_HALLO_hiergeld_15_00");	//If I have no choice - here's your money.
	if (Npc_HasItems (other, ItMi_Gold) >= 5)
	{
		B_GiveInvItems (other, self, ItMi_Gold, 5);
		AI_Output (self, other, "DIA_Bronko_HALLO_hiergeld_06_01");	//(mischievously) Thank you. And have a nice day.
		AI_StopProcessInfos (self);
	}
	else
	{
		AI_Output (self, other, "DIA_Bronko_HALLO_hiergeld_06_02");	//You don't even have 5 gold coins. Trying to pull a fast one, are you?
		AI_StopProcessInfos (self);
		B_Attack (self, other, AR_NONE, 1);
	};
};

func void DIA_Bronko_HALLO_vergisses()
{
	AI_Output(other,self,"DIA_Bronko_HALLO_vergisses_15_00");	//Forget it. You won't get anything from me.
	if(hero.guild == GIL_KDF)
	{
		AI_Output(self,other,"DIA_Bronko_HALLO_vergisses_06_03");	//I don't care if you are a magician. You'll have to pay. Understood?
	}
	else
	{
		if(hero.guild == GIL_MIL)
		{
			AI_Output(self,other,"DIA_Bronko_HALLO_vergisses_06_02");	//You boys from the city guard are short of money, huh?
		};
		AI_Output(self,other,"DIA_Bronko_HALLO_vergisses_06_01");	//Then, I'm afraid, I'm going to have to tan your hide.
	};
	Info_ClearChoices (DIA_Bronko_HALLO);
	Info_AddChoice (DIA_Bronko_HALLO, "If I have no choice - here's your money.", DIA_Bronko_HALLO_hiergeld);
	Info_AddChoice (DIA_Bronko_HALLO, "Come on and try it, then.", DIA_Bronko_HALLO_attack);
};

func void DIA_Bronko_HALLO_attack()
{
	AI_Output (other, self, "DIA_Bronko_HALLO_attack_15_00");	//Come on and try it, then.
	AI_Output (self, other, "DIA_Bronko_HALLO_attack_06_01");	//Well, in that case...
	AI_StopProcessInfos (self);
	B_Attack (self, other, AR_NONE, 1);
};


instance DIA_Bronko_KEINBAUER(C_Info)
{
	npc = BAU_935_Bronko;
	nr = 2;
	condition = DIA_Bronko_KEINBAUER_Condition;
	information = DIA_Bronko_KEINBAUER_Info;
	permanent = TRUE;
	description = "You, the farmer? Don't make me laugh. You're nobody, really.";
};


var int DIA_Bronko_KEINBAUER_noPerm;

func int DIA_Bronko_KEINBAUER_Condition()
{
	if(((MIS_Sekob_Bronko_eingeschuechtert == LOG_Running) || (Babera_BronkoKeinBauer == TRUE)) && (self.aivar[AIV_LastFightAgainstPlayer] != FIGHT_LOST) && (DIA_Bronko_KEINBAUER_noPerm == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Bronko_KEINBAUER_Info()
{
	AI_Output(other,self,"DIA_Bronko_KEINBAUER_15_00");	//��?! ������?! �� ����� ����. �� �� ������ �����.
	AI_Output(self,other,"DIA_Bronko_KEINBAUER_06_01");	//������? ������ �������� �� �����?
	Info_ClearChoices(DIA_Bronko_KEINBAUER);
	if(Babera_BronkoKeinBauer == TRUE)
	{
		if((other.guild == GIL_SLD) || (other.guild == GIL_DJG))
		{
			Info_AddChoice(DIA_Bronko_KEINBAUER,"I could tell the mercenaries where you live.",DIA_Bronko_KEINBAUER_SLD);
		}
		else
		{
			Info_AddChoice(DIA_Bronko_KEINBAUER,"(threaten Bronco to fetch mercenaries)",DIA_Bronko_KEINBAUER_SLD);
		};
	};
	if(MIS_Sekob_Bronko_eingeschuechtert == LOG_Running)
	{
		Info_AddChoice(DIA_Bronko_KEINBAUER,"Sekob is the farmer here, and you're nothing but a small-time crook.",DIA_Bronko_KEINBAUER_sekobderbauer);
	};
	Info_AddChoice(DIA_Bronko_KEINBAUER,"Well, let's see then what you've got.",DIA_Bronko_KEINBAUER_attack);
	Info_AddChoice(DIA_Bronko_KEINBAUER,"Never mind!",DIA_Bronko_KEINBAUER_schongut);
};

func void DIA_Bronko_KEINBAUER_attack()
{
	AI_Output (other, self, "DIA_Bronko_KEINBAUER_attack_15_00");	//Well, let's see then what you've got.
	AI_Output (self, other, "DIA_Bronko_KEINBAUER_attack_06_01");	//I hoped you would say that.
	AI_StopProcessInfos (self);
	B_Attack (self, other, AR_NONE, 1);
};

func void DIA_Bronko_KEINBAUER_sekobderbauer()
{
	AI_Output (other, self, "DIA_Bronko_KEINBAUER_sekobderbauer_15_00");	//Sekob is the farmer here, and you're nothing but a small-time crook who's trying to wangle money out of people's pockets.
	AI_Output (self, other, "DIA_Bronko_KEINBAUER_sekobderbauer_06_01");	//Says who?
	AI_Output (other, self, "DIA_Bronko_KEINBAUER_sekobderbauer_15_02");	//Says me. Sekob wants you to go back to work instead of loafing around here.
	AI_Output (self, other, "DIA_Bronko_KEINBAUER_sekobderbauer_06_03");	//So what? What are you going to do now?
};

func void DIA_Bronko_KEINBAUER_schongut()
{
	AI_Output (other, self, "DIA_Bronko_KEINBAUER_schongut_15_00");	//Never mind!
	AI_Output (self, other, "DIA_Bronko_KEINBAUER_schongut_06_01");	//Scram!
	AI_StopProcessInfos (self);
};

func void DIA_Bronko_KEINBAUER_SLD()
{
	if((other.guild == GIL_SLD) || (other.guild == GIL_DJG))
	{
		AI_Output(other,self,"DIA_Cornelius_DontBelieveYou_KnowYourHome_15_00");	//I could tell the mercenaries where you live.
		AI_Output(self,other,"DIA_Bronko_KEINBAUER_schongut_06_01");	//Scram!
	};
	AI_Output(other,self,"DIA_Bronko_KEINBAUER_SLD_15_00");	//All right, then I guess I'll have to tell Onar the landowner that there's a farmer mouthing off here who refuses to pay his rent.
	AI_Output(self,other,"DIA_Bronko_KEINBAUER_SLD_06_01");	//Ahem. Wait a minute. Onar will send all his mercenaries after me.
	AI_Output(other,self,"DIA_Bronko_KEINBAUER_SLD_15_02");	//So what?
	AI_Output(self,other,"DIA_Bronko_KEINBAUER_SLD_06_03");	//All right, all right. I'll give you whatever you want, but leave the mercenaries out of this, OK?
	if(B_GiveInvItems(self,other,ItMi_Gold,Npc_HasItems(self,ItMi_Gold)))
	{
		AI_Output(self,other,"DIA_Bronko_KEINBAUER_SLD_06_04");	//Here, I'll even give you all my gold.
	};
	if(Wld_IsTime(8,0,22,0))
	{
		AI_Output(self,other,"DIA_Bronko_KEINBAUER_SLD_06_05");	//And I'll go back to my field. Anything but the mercenaries.
	}
	else
	{
		AI_Output(self,other,"DIA_Bronko_FLEISSIG_06_05");	//I'll even go back to work, OK?
	};
	AI_StopProcessInfos(self);
	DIA_Bronko_KEINBAUER_noPerm = TRUE;
	if((Kapitel == 3) && (TOPIC_END_SekobDMT == FALSE))
	{
		Npc_ExchangeRoutine(self,"FleeDMT_Field");
	}
	else
	{
		Npc_ExchangeRoutine(self,"Start");
	};
	MIS_Sekob_Bronko_eingeschuechtert = LOG_SUCCESS;
	B_GivePlayerXP(XP_Ambient);
};


instance DIA_Bronko_FLEISSIG(C_Info)
{
	npc = BAU_935_Bronko;
	nr = 3;
	condition = DIA_Bronko_FLEISSIG_Condition;
	information = DIA_Bronko_FLEISSIG_Info;
	permanent = FALSE;
	description = "(taunt Bronco)";
};


func int DIA_Bronko_FLEISSIG_Condition()
{
	if((self.aivar[AIV_LastFightAgainstPlayer] == FIGHT_LOST) && Npc_KnowsInfo(other,DIA_Bronko_HALLO) && (MIS_Sekob_Bronko_eingeschuechtert != LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Bronko_FLEISSIG_Info()
{
	AI_Output(other,self,"DIA_Bronko_FLEISSIG_15_01");	//So? Still got that big mouth?
	AI_Output(self,other,"DIA_Bronko_FLEISSIG_06_04");	//Don't beat me, please.
	AI_Output(self,other,"DIA_Bronko_FLEISSIG_06_05");	//I'll even go back to work, okay?
	MIS_Sekob_Bronko_eingeschuechtert = LOG_SUCCESS;
	AI_StopProcessInfos(self);
	if((Kapitel == 3) && (TOPIC_END_SekobDMT == FALSE))
	{
		Npc_ExchangeRoutine(self,"FleeDMT_Field");
	}
	else
	{
		Npc_ExchangeRoutine(self,"Start");
	};
};


instance DIA_Bronko_FLEISSIG2(C_Info)
{
	npc = BAU_935_Bronko;
	nr = 3;
	condition = DIA_Bronko_FLEISSIG2_Condition;
	information = DIA_Bronko_FLEISSIG2_Info;
	permanent = TRUE;
	description = "So? Busy as a bee, are you?";
};


func int DIA_Bronko_FLEISSIG2_Condition()
{
	if(MIS_Sekob_Bronko_eingeschuechtert == LOG_SUCCESS)
	{
		return TRUE;
	};
};

func void DIA_Bronko_FLEISSIG2_Info()
{
	AI_Output(other,self,"DIA_Bronko_FLEISSIG_15_00");	//So? Busy as a bee, are you?
	if((hero.guild == GIL_SLD) || (hero.guild == GIL_DJG))
	{
		AI_Output(self,other,"DIA_Bronko_FLEISSIG_06_02");	//You're a mercenary, aren't you? I might have known.
	}
	else if(DIA_Bronko_KEINBAUER_noPerm == TRUE)
	{
		AI_Output(self,other,"DIA_Bronko_FLEISSIG_06_03");	//(fearfully) You won't go fetch those mercenaries, huh?
	}
	else
	{
		AI_Output(self,other,"DIA_Bronko_FLEISSIG_06_04");	//Don't beat me, please.
	};
	AI_StopProcessInfos(self);
};


instance DIA_Bronko_PICKPOCKET(C_Info)
{
	npc = BAU_935_Bronko;
	nr = 900;
	condition = DIA_Bronko_PICKPOCKET_Condition;
	information = DIA_Bronko_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_60;
};


func int DIA_Bronko_PICKPOCKET_Condition()
{
	return C_Beklauen(54,80);
};

func void DIA_Bronko_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Bronko_PICKPOCKET);
	Info_AddChoice(DIA_Bronko_PICKPOCKET,Dialog_Back,DIA_Bronko_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Bronko_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Bronko_PICKPOCKET_DoIt);
};

func void DIA_Bronko_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Bronko_PICKPOCKET);
};

func void DIA_Bronko_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Bronko_PICKPOCKET);
};

