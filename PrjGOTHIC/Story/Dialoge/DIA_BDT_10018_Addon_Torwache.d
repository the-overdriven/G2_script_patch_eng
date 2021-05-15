
instance DIA_Addon_BDT_10018_Torwache_EXIT(C_Info)
{
	npc = BDT_10018_Addon_Torwache;
	nr = 999;
	condition = DIA_Addon_BDT_10018_Torwache_EXIT_Condition;
	information = DIA_Addon_BDT_10018_Torwache_EXIT_Info;
	permanent = TRUE;
	description = "We'll talk again.";
};


func int DIA_Addon_BDT_10018_Torwache_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Addon_BDT_10018_Torwache_EXIT_Info()
{
	AI_Output (other, self, "DIA_Addon_BDT_10018_Torwache_EXIT_15_00");	//We'll talk again.
	if (BDT_100018_Einmal == FALSE)
	{
		AI_Output (self, other, "DIA_Addon_BDT_10018_Torwache_EXIT_04_01");	//You already know what I'll tell you then...
		BDT_100018_Einmal = TRUE;
	}
	else
	{
		AI_Output (self, other, "DIA_Addon_BDT_10018_Torwache_EXIT_04_02");	//Beat it.
	};
	AI_StopProcessInfos(self);
};


const string BDT_10018_Checkpoint = "BL_RAVEN_CHECK";

instance DIA_Addon_BDT_10018_Torwache_FirstWarn(C_Info)
{
	npc = BDT_10018_Addon_Torwache;
	nr = 1;
	condition = DIA_Addon_BDT_10018_Torwache_FirstWarn_Condition;
	information = DIA_Addon_BDT_10018_Torwache_FirstWarn_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Addon_BDT_10018_Torwache_FirstWarn_Condition()
{
	/*if(Npc_GetDistToWP(other,BDT_10018_Checkpoint) <= 700)
	{
		Npc_SetRefuseTalk(self,5);
		return FALSE;
	};*/
	if((self.aivar[AIV_Guardpassage_Status] == GP_NONE) && (self.aivar[AIV_PASSGATE] == FALSE) && Hlp_StrCmp(Npc_GetNearestWP(self),self.wp) && !Npc_RefuseTalk(self))
	{
		return TRUE;
	};
};

func void DIA_Addon_BDT_10018_Torwache_FirstWarn_Info()
{
	if(Npc_GetDistToWP(other,BDT_10018_Checkpoint) <= 500)
	{
		other.aivar[AIV_LastDistToWP] = 0;
		self.aivar[AIV_Guardpassage_Status] = GP_NONE;
		B_Say(self,other,"$ALARM");
		AI_StopProcessInfos(self);
		B_Attack(self,other,AR_GuardStopsIntruder,0);
	}
	else if(BDT_100018_Tells == FALSE)
	{
		AI_Output (self, other, "DIA_Addon_BDT_10018_Torwache_FirstWarn_04_00");	//Hey, slow down! You aren't getting in there - so beat it!
		AI_Output (other, self, "DIA_Addon_BDT_10018_Torwache_FirstWarn_15_01");	//Get out of my way - I have to see Raven.
		AI_Output (self, other, "DIA_Addon_BDT_10018_Torwache_FirstWarn_04_02");	//No one enters these quarters. Direct orders from Raven himself.
		BDT_100018_Tells = TRUE;
		Log_CreateTopic (Topic_Addon_Tempel, LOG_MISSION);
		Log_SetTopicStatus (Topic_Addon_Tempel, LOG_Running);
		B_LogEntry (Topic_Addon_Tempel, "The gatekeeper in front of the temple won't let me in. I'll have to find a way to get inside.");
	}
	else
	{
		AI_Output (self, other, "DIA_Addon_BDT_10018_Torwache_FirstWarn_04_03");	//You again? You're getting on my nerves!
	};
	EnteredBanditsCamp = TRUE;
	other.aivar[AIV_LastDistToWP] = Npc_GetDistToWP(other,BDT_10018_Checkpoint);
	self.aivar[AIV_Guardpassage_Status] = GP_FirstWarnGiven;
};


instance DIA_Addon_BDT_10018_Torwache_SecondWarn(C_Info)
{
	npc = BDT_10018_Addon_Torwache;
	nr = 2;
	condition = DIA_Addon_BDT_10018_Torwache_SecondWarn_Condition;
	information = DIA_Addon_BDT_10018_Torwache_SecondWarn_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Addon_BDT_10018_Torwache_SecondWarn_Condition()
{
	if((self.aivar[AIV_Guardpassage_Status] == GP_FirstWarnGiven) && (self.aivar[AIV_PASSGATE] == FALSE) && Hlp_StrCmp(Npc_GetNearestWP(self),self.wp) && (Npc_GetDistToWP(other,BDT_10018_Checkpoint) < (other.aivar[AIV_LastDistToWP] - 50)))
	{
		return TRUE;
	};
};

func void DIA_Addon_BDT_10018_Torwache_SecondWarn_Info()
{
	if(Npc_GetDistToWP(other,BDT_10018_Checkpoint) <= 500)
	{
		other.aivar[AIV_LastDistToWP] = 0;
		self.aivar[AIV_Guardpassage_Status] = GP_NONE;
		B_Say(self,other,"$ALARM");
		AI_StopProcessInfos(self);
		B_Attack(self,other,AR_GuardStopsIntruder,0);
	}
	else
	{
		AI_Output(self,other,"DIA_Addon_BDT_10018_Torwache_SecondWarn_04_00");	//One more step and it'll be your last!
		other.aivar[AIV_LastDistToWP] = Npc_GetDistToWP(other,BDT_10018_Checkpoint);
		self.aivar[AIV_Guardpassage_Status] = GP_SecondWarnGiven;
		AI_StopProcessInfos(self);
	};
};


instance DIA_Addon_BDT_10018_Torwache_Attack(C_Info)
{
	npc = BDT_10018_Addon_Torwache;
	nr = 3;
	condition = DIA_Addon_BDT_10018_Torwache_Attack_Condition;
	information = DIA_Addon_BDT_10018_Torwache_Attack_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Addon_BDT_10018_Torwache_Attack_Condition()
{
	if((self.aivar[AIV_Guardpassage_Status] == GP_SecondWarnGiven) && (self.aivar[AIV_PASSGATE] == FALSE) && Hlp_StrCmp(Npc_GetNearestWP(self),self.wp) && (Npc_GetDistToWP(other,BDT_10018_Checkpoint) < (other.aivar[AIV_LastDistToWP] - 50)))
	{
		return TRUE;
	};
};

func void DIA_Addon_BDT_10018_Torwache_Attack_Info()
{
	if(Npc_GetDistToWP(other,BDT_10018_Checkpoint) <= 500)
	{
		other.aivar[AIV_LastDistToWP] = 0;
		self.aivar[AIV_Guardpassage_Status] = GP_NONE;
		B_Say(self,other,"$ALARM");
		AI_StopProcessInfos(self);
		B_Attack(self,other,AR_GuardStopsIntruder,0);
	}
	else
	{
		other.aivar[AIV_LastDistToWP] = 0;
		self.aivar[AIV_Guardpassage_Status] = GP_NONE;
		AI_Output(self,other,"DIA_Addon_BDT_10018_Torwache_Attack_04_00");	//For Raven!
		AI_StopProcessInfos(self);
		B_Attack(self,other,AR_GuardStopsIntruder,0);
	};
};


instance DIA_Addon_BDT_10018_Torwache_Hi(C_Info)
{
	npc = BDT_10018_Addon_Torwache;
	nr = 2;
	condition = DIA_Addon_10018_Torwache_Hi_Condition;
	information = DIA_Addon_10018_Torwache_Hi_Info;
	permanent = FALSE;
	description = "It is damned important that I get to him.";
};


func int DIA_Addon_10018_Torwache_Hi_Condition()
{
	if(!Npc_IsDead(Bloodwyn))
	{
		return TRUE;
	};
};

func void DIA_Addon_10018_Torwache_Hi_Info()
{
	AI_Output (other, self, "DIA_Addon_BDT_10018_Torwache_Hi_15_00");	//It is damned important that I get to him.
	AI_Output (self, other, "DIA_Addon_BDT_10018_Torwache_Hi_04_01");	//No. It isn't. Only Bloodwyn has permission to stay in there.
	B_LogEntry (Topic_Addon_Tempel, "Only Bloodwyn is allowed to stay in the temple. Maybe I can get into the temple through him.");
};


instance DIA_Addon_BDT_10018_Torwache_Bloodwyn(C_Info)
{
	npc = BDT_10018_Addon_Torwache;
	nr = 2;
	condition = DIA_Addon_10018_Torwache_Bloodwyn_Condition;
	information = DIA_Addon_10018_Torwache_Bloodwyn_Info;
	permanent = FALSE;
	description = "Bloodwyn? Isn't he supposed to be dead?";
};


func int DIA_Addon_10018_Torwache_Bloodwyn_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_BDT_10018_Torwache_Hi) && !Npc_IsDead(Bloodwyn))
	{
		return TRUE;
	};
};

func void DIA_Addon_10018_Torwache_Bloodwyn_Info()
{
	AI_Output (other, self, "DIA_Addon_BDT_10018_Torwache_Bloodwyn_15_00");	//Bloodwyn? Isn't he supposed to be dead?
	AI_Output (self, other, "DIA_Addon_BDT_10018_Torwache_Bloodwyn_04_01");	//He's stronger than ever before. And if he finds out that someone is causing trouble out here, he'll make mincemeat out of you.
};


instance DIA_Addon_BDT_10018_Torwache_Bribe(C_Info)
{
	npc = BDT_10018_Addon_Torwache;
	nr = 9;
	condition = DIA_Addon_10018_Torwache_Bribe_Condition;
	information = DIA_Addon_10018_Torwache_Bribe_Info;
	permanent = FALSE;
	description = "I'll give you a thousand gold pieces if you let me in.";
};


func int DIA_Addon_10018_Torwache_Bribe_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_BDT_10018_Torwache_Hi) && !Npc_IsDead(Bloodwyn))
	{
		return TRUE;
	};
};

func void DIA_Addon_10018_Torwache_Bribe_Info()
{
	AI_Output (other, self, "DIA_Addon_BDT_10018_Torwache_Bribe_15_00");	//I'll give you a thousand gold pieces if you let me in.
	AI_Output (self, other, "DIA_Addon_BDT_10018_Torwache_Bribe_04_01");	//You're wasting your time, bum.
};


instance DIA_Addon_BDT_10018_Torwache_Drin(C_Info)
{
	npc = BDT_10018_Addon_Torwache;
	nr = 90;
	condition = DIA_Addon_10018_Torwache_Drin_Condition;
	information = DIA_Addon_10018_Torwache_Drin_Info;
	permanent = FALSE;
	description = "Bloodwyn is in there? Then get him out.";
};


func int DIA_Addon_10018_Torwache_Drin_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_BDT_10018_Torwache_Hi) && !Npc_IsDead(Bloodwyn) && (Bloodwyn_Spawn == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_10018_Torwache_Drin_Info()
{
	AI_Output (other, self, "DIA_Addon_BDT_10018_Torwache_Drin_15_00");	//Bloodwyn is in there? Then get him out.
	AI_Output (self, other, "DIA_Addon_BDT_10018_Torwache_Drin_04_01");	//Ha! Do you seriously believe I'd do that?
	AI_Output (self, other, "DIA_Addon_BDT_10018_Torwache_Drin_04_02");	//Maybe you're an important man in the camp now. But your power ends RIGHT HERE. Got it?
	AI_Output (self, other, "DIA_Addon_BDT_10018_Torwache_Drin_04_03");	//So go to the mine and dig for gold or do something else - but don't stand in the way here!
	MIS_BloodwynRaus = LOG_Running;
	B_LogEntry (Topic_Addon_Tempel, "Bloodwyn is in the temple. But I'm not getting anywhere here. Maybe I should have a look around in the mine.");
};


instance DIA_Addon_BDT_10018_Torwache_kopf(C_Info)
{
	npc = BDT_10018_Addon_Torwache;
	nr = 90;
	condition = DIA_Addon_10018_Torwache_kopf_Condition;
	information = DIA_Addon_10018_Torwache_kopf_Info;
	permanent = FALSE;
	description = DIALOG_BloodwynHead;
};


func int DIA_Addon_10018_Torwache_kopf_Condition()
{
	if(Npc_HasItems(other,ItMi_Addon_Bloodwyn_Kopf))
	{
		return TRUE;
	};
};

func void DIA_Addon_10018_Torwache_kopf_Info()
{
	CreateInvItem(other,ItMi_FakeBloodwynHead);
	AI_UseItemToState(other,ItMi_FakeBloodwynHead,1);
	//��� ������� �����, ����� �� �� ������� �� ������ ��������, �� �������� ��� �����������
	B_LookAtNpc(other,self);
	AI_Output(other,self,"DIA_Addon_BDT_10018_Torwache_kopf_15_00");	//Here! Do you still want to stop me now!?
	AI_UseItemToState(other,ItMi_FakeBloodwynHead,-1);
	AI_Output (self, other, "DIA_Addon_BDT_10018_Torwache_kopf_04_01");	//Is that... is that... Bloodwyn? ... bleah, that's...
	AI_Output (self, other, "DIA_Addon_BDT_10018_Torwache_kopf_04_02");	//Uh...yes, uh no. I mean... uh... you can go in...
	MIS_BloodwynRaus = LOG_SUCCESS;
	self.aivar[AIV_PASSGATE] = TRUE;
	AI_StopProcessInfos(self);
};

