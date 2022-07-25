var int r_union_strength;
var int r_union_dexterity;
var int r_union_mana;

var int r_union_talent_1h;
var int r_union_talent_2h;
var int r_union_talent_bow;
var int r_union_talent_cbow;


const int T_GOD = 3000;
const int T_MEGA = 1000;
const int T_MAX = 600;
const int T_HIGH = 400;
const int T_MED = 200;
const int T_LOW = 120;








func int B_GetLearnCostAttribute(var c_npc oth, var int attribut) 
{
    var int kosten;

    kosten = 0;
    if (attribut == ATR_STRENGTH) {
        if (r_union_strength >= 120) {
            kosten = 5;
        }
        else if (r_union_strength >= 90) {
            kosten = 4;
        }
        else if (r_union_strength >= 60) {
            kosten = 3;
        }
        else if (r_union_strength >= 30) {
            kosten = 2;
        }
        else {
            kosten = 1;
        };
    };
    if (attribut == ATR_DEXTERITY) {
        if (r_union_dexterity >= 120) {
            kosten = 5;
        }
        else if (r_union_dexterity >= 90) {
            kosten = 4;
        }
        else if (r_union_dexterity >= 60) {
            kosten = 3;
        }
        else if (r_union_dexterity >= 30) {
            kosten = 2;
        }
        else {
            kosten = 1;
        };
    };
    if (attribut == ATR_MANA_MAX) {
        if (r_union_mana >= 120) {
            kosten = 5;
        }
        else if (r_union_mana >= 90) {
            kosten = 4;
        }
        else if (r_union_mana >= 60) {
            kosten = 3;
        }
        else if (r_union_mana >= 30) {
            kosten = 2;
        }
        else {
            kosten = 1;
        };
    };
    if (attribut == ATR_HITPOINTS_MAX) {
        if (oth.aivar[92] >= 120) {
            kosten = 1;
        }
        else if (oth.aivar[92] >= 90) {
            kosten = 1;
        }
        else if (oth.aivar[92] >= 60) {
            kosten = 1;
        }
        else if (oth.aivar[92] >= 30) {
            kosten = 1;
        }
        else {
            kosten = 1;
        };
    };
    return kosten;
};









func int B_TeachAttributePoints(var c_npc slf, var c_npc oth, var int attrib, var int points, var int teachermax) 
{
    var string concattext;
    var int kosten;
    var int realattribute;

    kosten = B_GetLearnCostAttribute(oth, attrib) * points;
	
	
    if ((attrib != ATR_STRENGTH) && (attrib != ATR_DEXTERITY) && (attrib != ATR_MANA_MAX)) {
        Print("*** ERROR: Wrong Parameter ***");
        return FALSE;
    };
    if (attrib == ATR_STRENGTH) {
        realattribute = r_union_strength;
    }
    else if (attrib == ATR_DEXTERITY) {
        realattribute = r_union_dexterity;
    }
    else if (attrib == ATR_MANA_MAX) {
        realattribute = r_union_mana;
    };
    if (realattribute >= teachermax) {
        concattext = ConcatStrings(PRINT_NOLEARNOVERPERSONALMAX, IntToString(teachermax));
        PrintScreen(concattext, -1, -1, FONT_SCREEN, 2);
        B_Say(slf, oth, "$NOLEARNYOUREBETTER");
        return FALSE;
    };
    if ((realattribute + points) > teachermax) {
        concattext = ConcatStrings(PRINT_NOLEARNOVERPERSONALMAX, IntToString(teachermax));
        PrintScreen(concattext, -1, -1, FONT_SCREEN, 2);
        B_Say(slf, oth, "$NOLEARNOVERPERSONALMAX");
        return FALSE;
    };
    if (hero.lp < kosten) {
        PrintScreen(PRINT_NOTENOUGHLP, -1, -1, FONT_SCREEN, 2);
        B_Say(slf, hero, "$NOLEARNNOPOINTS");
        return FALSE;
    };
	
    hero.lp = hero.lp - kosten;
	
	if (attrib == ATR_STRENGTH) {
		if (r_union_strength == 0) {
			r_union_strength = 10;
		};
        r_union_strength += points;
    }
    else if (attrib == ATR_DEXTERITY) {
		if (r_union_dexterity == 0) {
			r_union_dexterity = 10;
		};
        r_union_dexterity += points;
    }
    else if (attrib == ATR_MANA_MAX) {
		if (r_union_mana == 0) {
			r_union_mana = 10;
		};
        r_union_mana += points;
    };
	
	
	
    B_RaiseAttribute(oth, attrib, points);
    return TRUE;
};























func int B_GetLearnCostTalent(var c_npc oth, var int talent, var int skill) 
{
    var int kosten;

    kosten = 0;
    if (talent == NPC_TALENT_MAGE) {
        if ((skill >= 1) && (skill <= 6)) {
            kosten = 5;
        };
    };
    if (talent == NPC_TALENT_1H) {
        if (r_union_talent_1h >= 120) {
            kosten = 5;
        }
        else if (r_union_talent_1h >= 90) {
            kosten = 4;
        }
        else if (r_union_talent_1h >= 60) {
            kosten = 3;
        }
        else if (r_union_talent_1h >= 30) {
            kosten = 2;
        }
        else {
            kosten = 1;
        };
        kosten = kosten * skill;
    };
    if (talent == NPC_TALENT_2H) {
        if (r_union_talent_2h >= 120) {
            kosten = 5;
        }
        else if (r_union_talent_2h >= 90) {
            kosten = 4;
        }
        else if (r_union_talent_2h >= 60) {
            kosten = 3;
        }
        else if (r_union_talent_2h >= 30) {
            kosten = 2;
        }
        else {
            kosten = 1;
        };
        kosten = kosten * skill;
    };
    if (talent == NPC_TALENT_BOW) {
        if (r_union_talent_bow >= 120) {
            kosten = 5;
        }
        else if (r_union_talent_bow >= 90) {
            kosten = 4;
        }
        else if (r_union_talent_bow >= 60) {
            kosten = 3;
        }
        else if (r_union_talent_bow >= 30) {
            kosten = 2;
        }
        else {
            kosten = 1;
        };
        kosten = kosten * skill;
    };
    if (talent == NPC_TALENT_CROSSBOW) {
        if (r_union_talent_cbow >= 120) {
            kosten = 5;
        }
        else if (r_union_talent_cbow >= 90) {
            kosten = 4;
        }
        else if (r_union_talent_cbow >= 60) {
            kosten = 3;
        }
        else if (r_union_talent_cbow >= 30) {
            kosten = 2;
        }
        else {
            kosten = 1;
        };
        kosten = kosten * skill;
    };
    if ((talent == NPC_TALENT_SNEAK) || (talent == NPC_TALENT_ACROBAT)) {
        kosten = 5;
    };
    if ((talent == NPC_TALENT_PICKLOCK) || (talent == NPC_TALENT_PICKPOCKET)) {
        kosten = 10;
    };
    if (talent == NPC_TALENT_SMITH) {
        if (skill == WEAPON_COMMON) {
            kosten = 3;
        }
        else if (skill == WEAPON_1H_SPECIAL_01) {
            kosten = 6;
        }
        else if (skill == WEAPON_2H_SPECIAL_01) {
            kosten = 6;
        }
        else if (skill == WEAPON_1H_SPECIAL_02) {
            kosten = 8;
        }
        else if (skill == WEAPON_2H_SPECIAL_02) {
            kosten = 8;
        }
        else if (skill == WEAPON_1H_SPECIAL_03) {
            kosten = 10;
        }
        else if (skill == WEAPON_2H_SPECIAL_03) {
            kosten = 10;
        }
        else if (skill == WEAPON_1H_SPECIAL_04) {
            kosten = 15;
        }
        else if (skill == WEAPON_2H_SPECIAL_04) {
            kosten = 15;
        }
        else if (skill == WEAPON_1H_HARAD_01) {
            kosten = 6;
        }
        else if (skill == WEAPON_1H_HARAD_02) {
            kosten = 8;
        }
        else if (skill == WEAPON_1H_HARAD_03) {
            kosten = 10;
        }
        else if (skill == WEAPON_1H_HARAD_04) {
            kosten = 15;
        };
    };
    if (talent == NPC_TALENT_ALCHEMY) {
        if (skill == POTION_HEALTH_01) {
            kosten = 3;
        }
        else if (skill == POTION_HEALTH_02) {
            kosten = 5;
        }
        else if (skill == POTION_HEALTH_03) {
            kosten = 8;
        }
        else if (skill == POTION_HEALTH_04) {
            kosten = 10;
        }
        else if (skill == POTION_MANA_01) {
            kosten = 3;
        }
        else if (skill == POTION_MANA_02) {
            kosten = 5;
        }
        else if (skill == POTION_MANA_03) {
            kosten = 6;
        }
        else if (skill == POTION_MANA_04) {
            kosten = 10;
        }
        else if (skill == POTION_SPEED) {
            kosten = 5;
        }
        else if (skill == POTION_PERM_STR) {
            kosten = 25;
        }
        else if (skill == POTION_PERM_DEX) {
            kosten = 25;
        }
        else if (skill == POTION_PERM_MANA) {
            kosten = 15;
        }
        else if (skill == POTION_PERM_HEALTH) {
            kosten = 15;
        }
        else if (skill == POTION_STAMINA) {
            kosten = 5;
        }
        else if (skill == POTION_PERM_STAMINA) {
            kosten = 10;
        }
        else if (skill == POTION_MEGADRINK) {
            kosten = 25;
        };
    };
    if (talent == NPC_TALENT_TAKEANIMALTROPHY) {
        if (skill == TROPHY_TEETH) {
            kosten = 5;
        }
        else if (skill == TROPHY_CLAWS) {
            kosten = 5;
        }
        else if (skill == TROPHY_FUR) {
            kosten = 5;
        }
        else if (skill == TROPHY_HEART) {
            kosten = 5;
        }
        else if (skill == TROPHY_SHADOWHORN) {
            kosten = 5;
        }
        else if (skill == TROPHY_FIRETONGUE) {
            kosten = 3;
        }
        else if (skill == TROPHY_BFWING) {
            kosten = 2;
        }
        else if (skill == TROPHY_BFSTING) {
            kosten = 2;
        }
        else if (skill == TROPHY_MANDIBLES) {
            kosten = 2;
        }
        else if (skill == TROPHY_CRAWLERPLATE) {
            kosten = 5;
        }
        else if (skill == TROPHY_DRGSNAPPERHORN) {
            kosten = 2;
        }
        else if (skill == TROPHY_DRAGONSCALE) {
            kosten = 10;
        }
        else if (skill == TROPHY_DRAGONBLOOD) {
            kosten = 10;
        }
        else if (skill == TROPHY_REPTILESKIN) {
            kosten = 3;
        };
    };
    if (talent == NPC_TALENT_FOREIGNLANGUAGE) {
        if (skill == LANGUAGE_1) {
            kosten = 10;
        }
        else if (skill == LANGUAGE_2) {
            kosten = 15;
        }
        else if (skill == LANGUAGE_3) {
            kosten = 20;
        };
    };
    if (talent == NPC_TALENT_DEMENTORLANGUAGE) {
        if (skill == DMTLANGUAGE_1) {
            kosten = 3;
        }
        else if (skill == DMTLANGUAGE_2) {
            kosten = 5;
        }
        else if (skill == DMTLANGUAGE_3) {
            kosten = 10;
        };
    };
    if (talent == NPC_TALENT_WISPDETECTOR) {
        if (skill == WISPSKILL_NF) {
            kosten = 0;
        }
        else if (skill == WISPSKILL_FF) {
            kosten = 1;
        }
        else if (skill == WISPSKILL_NONE) {
            kosten = 1;
        }
        else if (skill == WISPSKILL_RUNE) {
            kosten = 1;
        }
        else if (skill == WISPSKILL_MAGIC) {
            kosten = 1;
        }
        else if (skill == WISPSKILL_FOOD) {
            kosten = 1;
        }
        else if (skill == WISPSKILL_POTIONS) {
            kosten = 1;
        };
    };
    if (talent == NPC_TALENT_RUNES) {
        if (skill == SPL_PALLIGHT) {
            kosten = 1;
        }
        else if (skill == SPL_PALLIGHTHEAL) {
            kosten = 5;
        }
        else if (skill == SPL_PALHOLYBOLT) {
            kosten = 3;
        }
        else if (skill == SPL_PALMEDIUMHEAL) {
            kosten = 10;
        }
        else if (skill == SPL_PALREPELEVIL) {
            kosten = 5;
        }
        else if (skill == SPL_PALFULLHEAL) {
            kosten = 15;
        }
        else if (skill == SPL_PALDESTROYEVIL) {
            kosten = 10;
        }
        else if (skill == SPL_PALTELEPORTSECRET) {
            kosten = 5;
        }
        else if (skill == SPL_LIGHT) {
            kosten = 1;
        }
        else if (skill == SPL_FIREBOLT) {
            kosten = 5;
        }
        else if (skill == SPL_LIGHTHEAL) {
            kosten = 5;
        }
        else if (skill == SPL_SUMMONGOBLINSKELETON) {
            kosten = 3;
        }
        else if (skill == SPL_ZAP) {
            kosten = 3;
        }
        else if (skill == SPL_ICEBOLT) {
            kosten = 5;
        }
        else if (skill == SPL_INSTANTFIREBALL) {
            kosten = 10;
        }
        else if (skill == SPL_SUMMONWOLF) {
            kosten = 5;
        }
        else if (skill == SPL_WINDFIST) {
            kosten = 5;
        }
        else if (skill == SPL_SLEEP) {
            kosten = 5;
        }
        else if (skill == SPL_CHARM) {
            kosten = 5;
        }
        else if (skill == SPL_ICELANCE) {
            kosten = 5;
        }
        else if (skill == SPL_WHIRLWIND) {
            kosten = 5;
        }
        else if (skill == SPL_MEDIUMHEAL) {
            kosten = 10;
        }
        else if (skill == SPL_LIGHTNINGFLASH) {
            kosten = 5;
        }
        else if (skill == SPL_CHARGEFIREBALL) {
            kosten = 10;
        }
        else if (skill == SPL_SUMMONSKELETON) {
            kosten = 10;
        }
        else if (skill == SPL_FEAR) {
            kosten = 5;
        }
        else if (skill == SPL_ICECUBE) {
            kosten = 10;
        }
        else if (skill == SPL_THUNDERSTORM) {
            kosten = 5;
        }
        else if (skill == SPL_GEYSER) {
            kosten = 10;
        }
        else if (skill == SPL_CHARGEZAP) {
            kosten = 10;
        }
        else if (skill == SPL_SUMMONGOLEM) {
            kosten = 15;
        }
        else if (skill == SPL_DESTROYUNDEAD) {
            kosten = 10;
        }
        else if (skill == SPL_PYROKINESIS) {
            kosten = 15;
        }
        else if (skill == SPL_WATERFIST) {
            kosten = 10;
        }
        else if (skill == SPL_FIRESTORM) {
            kosten = 10;
        }
        else if (skill == SPL_ICEWAVE) {
            kosten = 20;
        }
        else if (skill == SPL_SUMMONDEMON) {
            kosten = 20;
        }
        else if (skill == SPL_FULLHEAL) {
            kosten = 15;
        }
        else if (skill == SPL_MASTEROFDISASTER) {
            kosten = 15;
        }
        else if (skill == SPL_FIRERAIN) {
            kosten = 20;
        }
        else if (skill == SPL_BREATHOFDEATH) {
            kosten = 20;
        }
        else if (skill == SPL_MASSDEATH) {
            kosten = 20;
        }
        else if (skill == SPL_ARMYOFDARKNESS) {
            kosten = 20;
        }
        else if (skill == SPL_SHRINK) {
            kosten = 20;
        }
        else {
            kosten = 5;
        };
    };
    return kosten;
};








func int B_TeachFightTalentPercent(var c_npc slf, var c_npc oth, var int talent, var int percent, var int teachermax) 
{
    var string concattext;
    var int kosten;
    var int realhitchance;

    kosten = B_GetLearnCostTalent(oth, talent, 1) * percent;
	
	
    if ((talent != NPC_TALENT_1H) && (talent != NPC_TALENT_2H) && (talent != NPC_TALENT_BOW) && (talent != NPC_TALENT_CROSSBOW)) {
        Print("*** ERROR: Wrong Parameter ***");
        return FALSE;
    };
    if (talent == NPC_TALENT_1H) {
        realhitchance = r_union_talent_1h;
    }
    else if (talent == NPC_TALENT_2H) {
        realhitchance = r_union_talent_2h;
    }
    else if (talent == NPC_TALENT_BOW) {
        realhitchance = r_union_talent_bow;
    }
    else if (talent == NPC_TALENT_CROSSBOW) {
        realhitchance = r_union_talent_cbow;
    };
    if (realhitchance >= teachermax) {
        concattext = ConcatStrings(PRINT_NOLEARNOVERPERSONALMAX, IntToString(teachermax));
        PrintScreen(concattext, -1, -1, FONT_SCREEN, 2);
        B_Say(slf, oth, "$NOLEARNYOUREBETTER");
        return FALSE;
    };
    if ((realhitchance + percent) > teachermax) {
        concattext = ConcatStrings(PRINT_NOLEARNOVERPERSONALMAX, IntToString(teachermax));
        PrintScreen(concattext, -1, -1, FONT_SCREEN, 2);
        B_Say(slf, oth, "$NOLEARNOVERPERSONALMAX");
        return FALSE;
    };
    if (hero.lp < kosten) {
        PrintScreen(PRINT_NOTENOUGHLP, -1, -1, FONT_SCREEN, 2);
        B_Say(slf, hero, "$NOLEARNNOPOINTS");
        return FALSE;
    };
	
	
    hero.lp = hero.lp - kosten;
	
	
	if (talent == NPC_TALENT_1H) {
		if (r_union_talent_1h == 0) {
			r_union_talent_1h = 5;
		};
        r_union_talent_1h += percent;
    }
    else if (talent == NPC_TALENT_2H) {
		if (r_union_talent_2h == 0) {
			r_union_talent_2h = 5;
		};
        r_union_talent_2h += percent;
    }
    else if (talent == NPC_TALENT_BOW) {
		if (r_union_talent_bow == 0) {
			r_union_talent_bow = 5;
		};
        r_union_talent_bow += percent;
    }
    else if (talent == NPC_TALENT_CROSSBOW) {
		if (r_union_talent_cbow == 0) {
			r_union_talent_cbow = 5;
		};
        r_union_talent_cbow += percent;
    };
	
	
    if (talent == NPC_TALENT_1H) {
        B_RaiseFightTalent(oth, NPC_TALENT_1H, percent);
        if (oth.aivar[84] >= (oth.aivar[85] + 30)) {
            B_RaiseFightTalent(oth, NPC_TALENT_2H, percent);
            PrintScreen(PRINT_LEARN1H_AND_2H, -1, -1, FONT_SCREEN, 2);
        }
        else {
            PrintScreen(PRINT_LEARN1H, -1, -1, FONT_SCREEN, 2);
        };
        return TRUE;
    };
    if (talent == NPC_TALENT_2H) {
        B_RaiseFightTalent(oth, NPC_TALENT_2H, percent);
        if (oth.aivar[85] >= (oth.aivar[84] + 30)) {
            B_RaiseFightTalent(oth, NPC_TALENT_1H, percent);
            PrintScreen(PRINT_LEARN2H_AND_1H, -1, -1, FONT_SCREEN, 2);
        }
        else {
            PrintScreen(PRINT_LEARN2H, -1, -1, FONT_SCREEN, 2);
        };
        return TRUE;
    };
    if (talent == NPC_TALENT_BOW) {
        B_RaiseFightTalent(oth, NPC_TALENT_BOW, percent);
        if (oth.aivar[86] >= (oth.aivar[87] + 30)) {
            B_RaiseFightTalent(oth, NPC_TALENT_CROSSBOW, percent);
            PrintScreen(PRINT_LEARNBOW_AND_CROSSBOW, -1, -1, FONT_SCREEN, 2);
        }
        else {
            PrintScreen(PRINT_LEARNBOW, -1, -1, FONT_SCREEN, 2);
        };
        return TRUE;
    };
    if (talent == NPC_TALENT_CROSSBOW) {
        B_RaiseFightTalent(oth, NPC_TALENT_CROSSBOW, percent);
        if (oth.aivar[87] >= (oth.aivar[86] + 30)) {
            B_RaiseFightTalent(oth, NPC_TALENT_BOW, percent);
            PrintScreen(PRINT_LEARNCROSSBOW_AND_BOW, -1, -1, FONT_SCREEN, 2);
        }
        else {
            PrintScreen(PRINT_LEARNCROSSBOW, -1, -1, FONT_SCREEN, 2);
        };
        return TRUE;
    };
};

