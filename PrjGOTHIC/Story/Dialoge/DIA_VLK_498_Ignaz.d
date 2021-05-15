
instance DIA_Ignaz_EXIT(C_Info)
{
	npc = VLK_498_Ignaz;
	nr = 999;
	condition = DIA_Ignaz_EXIT_Condition;
	information = DIA_Ignaz_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Ignaz_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Ignaz_EXIT_Info()
{
	B_EquipTrader(self);
	AI_StopProcessInfos(self);
};


instance DIA_Ignaz_PICKPOCKET(C_Info)
{
	npc = VLK_498_Ignaz;
	nr = 900;
	condition = DIA_Ignaz_PICKPOCKET_Condition;
	information = DIA_Ignaz_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_40;
};


func int DIA_Ignaz_PICKPOCKET_Condition()
{
	return C_Beklauen(38,50);
};

func void DIA_Ignaz_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Ignaz_PICKPOCKET);
	Info_AddChoice(DIA_Ignaz_PICKPOCKET,Dialog_Back,DIA_Ignaz_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Ignaz_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Ignaz_PICKPOCKET_DoIt);
};

func void DIA_Ignaz_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Ignaz_PICKPOCKET);
};

func void DIA_Ignaz_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Ignaz_PICKPOCKET);
};


instance DIA_Ignaz_Hallo(C_Info)
{
	npc = VLK_498_Ignaz;
	nr = 2;
	condition = DIA_Ignaz_Hallo_Condition;
	information = DIA_Ignaz_Hallo_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Ignaz_Hallo_Condition()
{
	if(Npc_IsInState(self,ZS_Talk))
	{
		return TRUE;
	};
};

func void DIA_Ignaz_Hallo_Info()
{
	AI_Output (self, other, "DIA_Ignaz_Hallo_14_00");	//Ah - you've come just in time. I'm in need of an assistant for a magic experiment.
	AI_Output (self, other, "DIA_Ignaz_Hallo_14_01");	//I'm sure you're eager to do me a favor for science's sake.
	AI_Output (other, self, "DIA_Ignaz_Hallo_15_02");	//Easy, my friend. First tell me what this is all about.
	AI_Output (self, other, "DIA_Ignaz_Hallo_14_03");	//I have developed a new spell. A Spell of Oblivion.
	AI_Output (self, other, "DIA_Ignaz_Hallo_14_04");	//I've already successfully carried out a few practical applications, but I don't have the time to conduct one final test.
};


instance DIA_Ignaz_Traenke(C_Info)
{
	npc = VLK_498_Ignaz;
	nr = 3;
	condition = DIA_Ignaz_Traenke_Condition;
	information = DIA_Ignaz_Traenke_Info;
	permanent = FALSE;
	description = "What's in it for me if I help you?";
};


func int DIA_Ignaz_Traenke_Condition()
{
	if(MIS_Ignaz_Charm != LOG_SUCCESS)
	{
		return TRUE;
	};
};

func void DIA_Ignaz_Traenke_Info()
{
	AI_Output (other, self, "DIA_Ignaz_Traenke_15_00");	//What's in it for me if I help you?
	AI_Output (self, other, "DIA_Ignaz_Traenke_14_01");	//I could teach you how to brew potions.
	AI_Output (self, other, "DIA_Ignaz_Traenke_14_02");	//I know the recipes for healing and mana essences and for speed potions.
};


instance DIA_Ignaz_Experiment(C_Info)
{
	npc = VLK_498_Ignaz;
	nr = 4;
	condition = DIA_Ignaz_Experiment_Condition;
	information = DIA_Ignaz_Experiment_Info;
	permanent = FALSE;
	description = "Tell me more about the experiment and the spell.";
};


func int DIA_Ignaz_Experiment_Condition()
{
	return TRUE;
};

func void DIA_Ignaz_Experiment_Info()
{
	AI_Output (other, self, "DIA_Ignaz_Experiment_15_00");	//Tell me more about the experiment and the spell.
	AI_Output (self, other, "DIA_Ignaz_Experiment_14_01");	//The spell serves to make somebody disremember various events.
	AI_Output (self, other, "DIA_Ignaz_Experiment_14_02");	//So far, I have only found it to work when the person in question is angry - for instance, if he has just been knocked down, or robbed.
	AI_Output (self, other, "DIA_Ignaz_Experiment_14_03");	//Even if he has only witnessed such a deed, he will scratch it from his memory.
	AI_Output (other, self, "DIA_Ignaz_Experiment_15_04");	//So I'm supposed to knock somebody down and then put a spell on him?
	AI_Output (other, self, "DIA_Ignaz_Add_15_00");	//That would only make sense if that person were REALLY mad after beating him up.
	AI_Output (other, self, "DIA_Ignaz_Add_15_01");	//(to himself) But fistfights are nothing out of the ordinary in the harbor district. I guess I'd have to find a victim elsewhere...
	AI_Output (self, other, "DIA_Ignaz_Experiment_14_05");	//Yes, I think you get the point. But to make somebody angry, it is enough to attack him - you don't have to knock him down.
	AI_Output (self, other, "DIA_Ignaz_Experiment_14_06");	//So you should pick somebody who's by himself - if there are other people around, you'll just get into trouble with Lord Andre.
	AI_Output (self, other, "DIA_Ignaz_Experiment_14_07");	//Also, it makes no sense to cast the spell on someone who's busy attacking you. Wait for the right moment.
};


instance DIA_Ignaz_teilnehmen(C_Info)
{
	npc = VLK_498_Ignaz;
	nr = 5;
	condition = DIA_Ignaz_teilnehmen_Condition;
	information = DIA_Ignaz_teilnehmen_Info;
	permanent = FALSE;
	description = "All right, I'll try out that spell.";
};


func int DIA_Ignaz_teilnehmen_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Ignaz_Experiment))
	{
		return TRUE;
	};
};

func void DIA_Ignaz_teilnehmen_Info()
{
	AI_Output (other, self, "DIA_Ignaz_teilnehmen_15_00");	//All right, I'll try out that spell.
	AI_Output (self, other, "DIA_Ignaz_teilnehmen_14_01");	//Then take this spell scroll and find yourself a suitable guinea pig.
	AI_Output (self, other, "DIA_Ignaz_teilnehmen_14_02");	//Once you're done, come back and tell me how it went.
	B_GiveInvItems (self, other, ItSc_Charm, 1);
	MIS_Ignaz_Charm = LOG_Running;
	Log_CreateTopic(TOPIC_Ignaz,LOG_MISSION);
	Log_SetTopicStatus(TOPIC_Ignaz,LOG_Running);
//	B_LogEntry(TOPIC_Ignaz,"� ������ �������� ����� ���������� ������. ��� ���������� ���������� ��������. ������ ���-������ ������� �� ���� � ���������� ����� ��� �� ������ ������� � ������ �� ����� �������� �� ����. ��� ��������� ������ ��� ������������� ����� ����������.");
//	B_LogEntry(TOPIC_Ignaz,"��� ��������� ����������� �������� ����������. ���������� ����� ������� �������� � ������������ �������. � �� �����, ��� ���-���� � �������� �������� ������ ��������, ���� � ������� ���.");
	B_LogEntry(TOPIC_Ignaz,"I'm to test a new spell for Ignaz. It's an Oblivion spell. When anyone gets angry about a fight or for some other reason, he won't want to speak to me any more. This would be an ideal point to cast this spell.");
	Log_AddEntry(TOPIC_Ignaz,"This is the ideal opportunity for testing that spell. Then he'll forget he reported the matter too. I don't think anyone in the harbor district will get cross if I knock him down.");
	AI_StopProcessInfos(self);
};


func void B_IgnazScrolls()
{
	AI_Output(self,other,"DIA_Ignaz_Running_14_02");	//If you need more spell scrolls, you can buy them from me.
	Log_CreateTopic(TOPIC_CityTrader,LOG_NOTE);
	B_LogEntry(TOPIC_CityTrader,"Ignaz from the harbor district is selling spell scrolls.");
};

instance DIA_Ignaz_Running(C_Info)
{
	npc = VLK_498_Ignaz;
	nr = 2;
	condition = DIA_Ignaz_Running_Condition;
	information = DIA_Ignaz_Running_Info;
	permanent = FALSE;
	description = "About the experiment ...";
};


func int DIA_Ignaz_Running_Condition()
{
	if((MIS_Ignaz_Charm == LOG_Running) && (Charm_Test == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Ignaz_Running_Info()
{
	AI_Output (other, self, "DIA_Ignaz_Running_15_00");	//About the experiment ...
	AI_Output (self, other, "DIA_Ignaz_Running_14_01");	//Have you been successful, then? Or have you just wasted the spell scroll? Huh?
	B_IgnazScrolls();
};


instance DIA_Ignaz_Danach(C_Info)
{
	npc = VLK_498_Ignaz;
	nr = 6;
	condition = DIA_Ignaz_Danach_Condition;
	information = DIA_Ignaz_Danach_Info;
	permanent = FALSE;
	description = "� ����������� ������.";
};


func int DIA_Ignaz_Danach_Condition()
{
	if((Charm_Test == TRUE) && (MIS_Ignaz_Charm == LOG_Running))
	{
		return TRUE;
	};
};

func void DIA_Ignaz_Danach_Info()
{
	AI_Output (other, self, "DIA_Ignaz_Danach_15_00");	//I used the spell scroll.
	AI_Output (self, other, "DIA_Ignaz_Danach_14_01");	//Fine, fine. And were you successful?
	AI_Output (other, self, "DIA_Ignaz_Danach_15_02");	//Yes, it worked.
	AI_Output (self, other, "DIA_Ignaz_Danach_14_03");	//Excellent. One small success for science, but a big one for me!
	AI_Output (self, other, "DIA_Ignaz_Danach_14_04");	//Now I can use my time to instruct you in the arts of alchemy.
	AI_Output (self, other, "DIA_Ignaz_Danach_14_05");	//I could also give you some useful things if you want.
	Ignaz_TeachAlchemy = TRUE;
	if(!Npc_KnowsInfo(other,DIA_Ignaz_Running))
	{
		B_IgnazScrolls();
	};
	if(DIA_Kardif_Lernen_permanent == FALSE)
	{
		Log_CreateTopic(TOPIC_CityTeacher,LOG_NOTE);
		B_LogEntry(TOPIC_CityTeacher,"Ignaz can show me some recipes for brewing potions. He lives in the harbor district.");
	};
	MIS_Ignaz_Charm = LOG_SUCCESS;
	B_GivePlayerXP(XP_MIS_Ignaz_Charm);
	CreateInvItems(self,ItSc_Charm,3);
};


instance DIA_Ignaz_Trade(C_Info)
{
	npc = VLK_498_Ignaz;
	nr = 6;
	condition = DIA_Ignaz_Trade_Condition;
	information = DIA_Ignaz_Trade_Info;
	permanent = TRUE;
	trade = TRUE;
	description = DIALOG_TRADE_v4;
};


func int DIA_Ignaz_Trade_Condition()
{
	if((MIS_Ignaz_Charm == LOG_SUCCESS) || Npc_KnowsInfo(other,DIA_Ignaz_Running))
	{
		return TRUE;
	};
};

func void DIA_Ignaz_Trade_Info()
{
	if(Ignaz_flag == TRUE)
	{
		B_ClearAlchemyInv(self);
		if(Ignaz_flasks > 0)
		{
			CreateInvItems(self,ItMi_Flask,Ignaz_flasks);
		};
		Ignaz_flag = FALSE;
	};
	AI_Output(other,self,"DIA_Ignaz_Trade_15_00");	//Show me your wares.
	B_GiveTradeInv(self);
	Trade_IsActive = TRUE;
};


instance DIA_Ignaz_Teach(C_Info)
{
	npc = VLK_498_Ignaz;
	nr = 2;
	condition = DIA_Ignaz_Teach_Condition;
	information = DIA_Ignaz_Teach_Info;
	permanent = TRUE;
	description = "Instruct me in the art of alchemy.";
};


var int DIA_Ignaz_Teach_permanent;

func int DIA_Ignaz_Teach_Condition()
{
	if((DIA_Ignaz_Teach_permanent == FALSE) && (Ignaz_TeachAlchemy == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Ignaz_Teach_Info()
{
	var int talente;
	talente = 0;
	AI_Output (other, self, "DIA_Ignaz_Teach_15_00");	//Instruct me in the art of alchemy.
	if ((PLAYER_TALENT_ALCHEMY[POTION_Speed] == FALSE) || (PLAYER_TALENT_ALCHEMY[POTION_Mana_01] == FALSE) || (PLAYER_TALENT_ALCHEMY[POTION_Health_01] == FALSE))
	{
		Info_ClearChoices(DIA_Ignaz_Teach);
		Info_AddChoice(DIA_Ignaz_Teach,Dialog_Back,DIA_Ignaz_Teach_BACK);
	};
	if(PLAYER_TALENT_ALCHEMY[POTION_Speed] == FALSE)
	{
		Info_AddChoice(DIA_Ignaz_Teach,B_BuildLearnString(NAME_Speed_Elixier,B_GetLearnCostTalent(other,NPC_TALENT_ALCHEMY,POTION_Speed)),DIA_Ignaz_Teach_Speed);
		talente += 1;
	};
	if(PLAYER_TALENT_ALCHEMY[POTION_Mana_01] == FALSE)
	{
		Info_AddChoice(DIA_Ignaz_Teach,B_BuildLearnString(NAME_Mana_Essenz,B_GetLearnCostTalent(other,NPC_TALENT_ALCHEMY,POTION_Mana_01)),DIA_Ignaz_Teach_Mana);
		talente += 1;
	};
	if(PLAYER_TALENT_ALCHEMY[POTION_Health_01] == FALSE)
	{
		Info_AddChoice(DIA_Ignaz_Teach,B_BuildLearnString(NAME_HP_Essenz,B_GetLearnCostTalent(other,NPC_TALENT_ALCHEMY,POTION_Health_01)),DIA_Ignaz_Teach_Health);
		talente += 1;
	};
	if(talente > 0)
	{
		if(Alchemy_Explain == FALSE)
		{
			AI_Output (self, other, "DIA_Ignaz_Teach_14_01");	//To prepare a potion at the alchemist's bench, you need a laboratory flask.
			AI_Output (self, other, "DIA_Ignaz_Teach_14_02");	//And you're going to need different plants or other ingredients for each potion.
			Alchemy_Explain = TRUE;
		};
		AI_Output(self,other,"DIA_Ignaz_Teach_14_04");	//��� �� ������ ������?
	}
	else
	{
		AI_Output (self, other, "DIA_Ignaz_Teach_14_05");	//You have learned all that I can teach you.
		DIA_Ignaz_Teach_permanent = TRUE;
	};
};

func void DIA_Ignaz_Teach_Health()
{
	B_TeachPlayerTalentAlchemy(self,other,POTION_Health_01);
};

func void DIA_Ignaz_Teach_Mana()
{
	B_TeachPlayerTalentAlchemy(self,other,POTION_Mana_01);
};

func void DIA_Ignaz_Teach_Speed()
{
	B_TeachPlayerTalentAlchemy(self,other,POTION_Speed);
};

func void DIA_Ignaz_Teach_BACK()
{
	Info_ClearChoices(DIA_Ignaz_Teach);
};

