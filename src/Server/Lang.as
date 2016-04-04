package Server 
{
	import adobe.utils.CustomActions;
	import artur.win.WinArena;
	import report.Report;
	public class Lang 
	{
		public static var lang:int = 0;
		private static var lang_table:Array = new Array();
		
		public static function init():void
		{
			Lang.lang_table[0] = new Array();
			lang_table[0][0] = ["Начало пути", 			"The beginning of the way",	""];
			lang_table[0][1] = ["Зелёная тропа", 		"The green trail", 		""];
			lang_table[0][2] = ["В поисках истины", 	"In search of truth",   ""];
			lang_table[0][3] = ["Туман войны", 			"Fog of war", 			""];
			lang_table[0][4] = ["Поворот не туда", 		"Wrong turn",			""];
			lang_table[0][5] = ["Проклятая река", 		"Cursed river",			""];
			lang_table[0][6] = ["Верная стража", 		"Faithful guardian",	""];
			lang_table[0][7] = ["Звон монет", 			"Coins ringing",		""];
			lang_table[0][8] = ["Шёпот дракона", 		"Dragon whisper",		""];
			lang_table[0][9] = ["Клыкастая месть", 		"Fanged revenge",		""];
			lang_table[0][10] = ["БОСС", 				"BOSS", 				""];
			lang_table[0][11] = ["Земля проклятых", 	"Curse land", 			""];
			lang_table[0][12] = ["Шелест листьев", 		"Rustles of leaves",	""];
			lang_table[0][13] = ["Две башни", 			"Two towers",			""];
			lang_table[0][14] = ["Лесные ветра", 		"Forest wings",		""];
			lang_table[0][15] = ["Вулканическая пыль", 	"Volcanic dust",		""];
			lang_table[0][16] = ["Крик орков", 			"Orcs scream",			""];
			lang_table[0][17] = ["Лужайка единорогов", 	"Unicorns lawn", 		""];
			lang_table[0][18] = ["Сердце кошмара", 		"Nightmare heart", 		""];
			lang_table[0][19] = ["Кровавый прибой", 	"Blood surf",			""];
			lang_table[0][20] = ["Прах и ярость", 		"Remains and fury", 	""];
			lang_table[0][21] = ["БОСС", 				"BOSS",					""];
			lang_table[0][22] = ["Демоническая грань", 	"Demon edge", 			""];
			lang_table[0][23] = ["Секреты короля", 		"Secrets of the King",	""];
			lang_table[0][24] = ["Гром богов", 			"Gods thunder", 		""];
			lang_table[0][25] = ["Дерево мудрости", 	"Wisdom tree", 			""];
			lang_table[0][26] = ["Песня сирены", 		"Siren song",			""];
			lang_table[0][27] = ["Отчаянный союз", 		"Desperate Alliance", 	""];
			lang_table[0][28] = ["Пустоши", 			"Wasteland", 			""];
			lang_table[0][29] = ["Падение молота", 		"The Hammer Falls", 	""];
			lang_table[0][30] = ["Среди руин",			"Among the Ruins",		""];
			lang_table[0][31] = ["Око за око",			"Eye for an Eye",		""];
			lang_table[0][32] = ["БОСС",				"BOSS",					""];
			
			Lang.lang_table[1] = new Array();
			Lang.lang_table[1][0] = ["Шлем", 		"Helmet", 		""];
			Lang.lang_table[1][1] = ["Кольчуга", 	"Аrmor", 		""];
			Lang.lang_table[1][2] = ["Сапоги", 		"Boots", 		""];
			Lang.lang_table[1][3] = ["Наплечники", 	"Shoulders", 	""];
			Lang.lang_table[1][4] = ["Перчатки", 	"Gloves", 		""];
			Lang.lang_table[1][5] = ["Оружие", 		"Weapon", 		""];
			Lang.lang_table[1][6] = ["Щиты", 		"Shields", 		""];
			Lang.lang_table[1][7] = ["Инвентарь", 	"Inventory", 	""];
			Lang.lang_table[2] = ["У одного из Ваших юнитов повысился уровень, зайдите  в замок, чтобы улучшить его.", "One of your unit has increased the level, go to the castle to improve it.", "" ];
			Lang.lang_table[3] = [
									["Банк", "Bank", ""], 
									["Доска лидеров", "LeaderBoard", ""], 
									["Замок", "Castle", ""], 
									["Арена", "Arena", ""], 
									["Кузница", "Smithy", ""], 
									["Миссии", "Missions", ""],
									["В город","Vilagge",""]
								];
			Lang.lang_table[4] = ["У Вас недостаточно ресурсов для этой покупки. Вы можете купить ресурсы в банке или же заработать в миссиях.", "You do not have the resources for this purchase. You can buy the resources at the bank or the earn in missions.", ""];
			Lang.lang_table[5] = ["Критический урон", "Critical strike", ""];
			Lang.lang_table[6] = ["Уворот", "Dodge", ""];
			Lang.lang_table[7] = ["Двойная атака", "Double attack", ""];
			Lang.lang_table[8] = ["Бешенсво", "Rage", ""];
			Lang.lang_table[9] = ["Ответный удар", "Counter attack", ""];
			Lang.lang_table[10] = ["шанс нанести двойной урон</font>\n Следующий уровень", "chance to inflict double damage</font>\n Next level", ""];
			Lang.lang_table[11] = ["шанс уклониться от удара</font>\n Следующий уровень", "chance to dodge</font>\n Next level", ""];
			Lang.lang_table[12] = ["шанс атаковать дважды</font>\n Следующий уровень", "chance to attack twice</font>\n Next level", ""];
			Lang.lang_table[13] = ["шанс атаковать сквозь защиту</font>\n Следующий уровень", "chance to attack through the defense</font>\n Next level", ""];
			Lang.lang_table[14] = ["шанс нанести ответный удар</font>\n Следующий уровень", "chance to strike back</font>\n Next level", ""];
			Lang.lang_table[15] = ["Ярость", "Fury", ""];
			Lang.lang_table[16] = ["Лечение", "Heal", ""];
			Lang.lang_table[17] = ["Огненная стрела", "Fire arrow", ""];
			Lang.lang_table[18] = ["Молния", "Lightning", ""];
			Lang.lang_table[19] = [" увеличивает урон юнита на ", " increases the damage to the unit for ", ""];
			Lang.lang_table[20] = ["на текущий ход", "for current step", ""];
			Lang.lang_table[21] = [" востанавливает ", " restores ", ""];
			Lang.lang_table[22] = [" единиц здоровья любому союзному юниту", " health points for any unit you chose", ""];
			Lang.lang_table[23] = [" Оглушает вражеского юнита огненной стрелой и наносит ", " Stuns enemy unit Firebolt and deals", ""];
			Lang.lang_table[24] = [" урона", " damage", ""];
			Lang.lang_table[25] = [" Поражает вражеского юнита молнией при этом наносит ему ", " Lightning strikes an enemy unit at the same time causing him", ""];
			Lang.lang_table[26] = ["Следующий уровень - ", "Next level - ", ""];
			Lang.lang_table[27] = [" единиц", " points", ""];
			Lang.lang_table[28] = ["Стоимость заклинания ", "Manna cost ", ""];
			Lang.lang_table[29] = [" манны", " mannas", ""];
			Lang.lang_table[30] = ["Нажмите, что бы улучшить!", "Click to improve!", ""];
			Lang.lang_table[31] = ["Навык", "Skill", ""];
			Lang.lang_table[32] = ["Я хочу продать", "I want to sell", ""];
			Lang.lang_table[33] = ["Нажмите, что бы купить вещь", "Press for buy item", ""];
			Lang.lang_table[34] = [" Убил: ", " Killed:", ""];
			Lang.lang_table[35] = [" Умер: ", " Died:", ""];
			Lang.lang_table[36] = ["Вы не сможете победить! Наймите воина. Если у вас уже есть воин - купите ему оружие.", "You can not win! Hire a warrior. If you already have a warrior - buy him a weapon.", ""];
			Lang.lang_table[37] = ["Миссия еще не доступна, ожидайте её в скором времени!!", "The mission is not yet available, expect it soon!!", ""];
			Lang.lang_table[38] = [["Варвар", "Barbarin", ""], ["Омник", "Omnic", ""], ["Лучник", "Archer", ""], ["Маг", "Wizard", ""]];
			Lang.lang_table[39] = ["Я хочу нанять", "I want to hire", ""];
			Lang.lang_table[40] = [["Новичок","Beginer",""], ["Воин","Warrior","",],["Стратег","Strategist",""],["Царь","King",""]];
			Lang.lang_table[41] = ["Что бы улучшить, надо вещь и как минимум один камeнь.", "In order to improve, you have an item and at least one stone", ""];
			Lang.lang_table[42] = ["У Вас недостаточно золота для улучшения. Вы можете купить золото в банке или заработать в миссиях.", "You do not have gold to improve. You can buy gold in a bank or earn it in the missions.", ""];
			Lang.lang_table[43] = new Array();
			Lang.lang_table[43][0] = ["Рубин ур.1", "Ruby lvl.1", ""];
			Lang.lang_table[43][1] = ["Изумруд ур.1", "Emerald lvl.1", ""];
			Lang.lang_table[43][2] = ["Аметист ур.1", "Amethyst lvl.1", ""];
			Lang.lang_table[43][3] = ["Сапфир ур.1", "Sapphire lvl.1", ""];
			Lang.lang_table[43][4] = ["Топаз ур.1", "Topaz lvl.1", ""];
			
			Lang.lang_table[43][5] = ["Рубин ур.2", "Ruby lvl.1", ""];
			Lang.lang_table[43][6] = ["Изумруд ур.2", "Emerald lvl.2", ""];
			Lang.lang_table[43][7] = ["Аметист ур.2", "Amethyst lvl.2", ""];
			Lang.lang_table[43][8] = ["Сапфир ур.2", "Sapphire lvl.2", ""];
			Lang.lang_table[43][9] = ["Топаз ур.2", "Topaz lvl.2", ""];
			
			Lang.lang_table[43][10] = ["Рубин ур.3", "Ruby lvl.3", ""];
			Lang.lang_table[43][11] = ["Изумруд ур.3", "Emerald lvl.3", ""];
			Lang.lang_table[43][12] = ["Аметист ур.3", "Amethyst lvl.3", ""];
			Lang.lang_table[43][13] = ["Сапфир ур.3", "Sapphire lvl.3", ""];
			Lang.lang_table[43][14] = ["Топаз ур.3", "Topaz lvl.3", ""];
			
			Lang.lang_table[44] = ["Что бы участвовать в поединкe нужен уровень " + WinArena.NEEDED_LVL + ". Уровень Вы можете заработать в миссиях.", "To participate in the match level " + WinArena.NEEDED_LVL + " is needed. Pass the missions to get it.", ""];
			Lang.lang_table[45] = ["У Вас недостаточно золота для этой покупки. Вы можете купить золото в банке или заработать в миссиях.", "You do not have enough gold for this purchase. You can buy gold in a bank or earn it in the missions.", ""];
			Lang.lang_table[46] = ["У Вас недостаточно серебра для этой покупки. Вы можете купить серебро в банке или заработать в миссиях.", "You do not have enough silver for this purchase. You can buy enough in a bank or money in the missions.", ""];
			Lang.lang_table[47] = ["Закрыть", "Close", ""];
			Lang.lang_table[48] = ["Купить за золото", "Buy for gold", ""];
			Lang.lang_table[49] = ["Купить за серебро", "Buy for silver", ""];
			Lang.lang_table[50] = ["Продать за серебро", "Sell for silver", ""];
			Lang.lang_table[51] = ["Искать игру", "Find game", ""];
			Lang.lang_table[52] = ["Заказать камeнь", "Order stone", ""];
			Lang.lang_table[53] = ["Улучшить вещь", "Improve item", ""];
			Lang.lang_table[54] = ["Добавить в сундук", "", ""];
			//Lang.lang_table[55] = [" в сундук", "", ""];
			//Lang.lang_table[56] = ["Забрать ", "", ""];
			Lang.lang_table[57] = ["Забрать из сундука", "Pick up from the chest", ""];
			
			Lang.lang_table[58] = new Array();
			Lang.lang_table[58][0] = ["Добавит +1 к здоровью", "Add 1 to health", ""];
			Lang.lang_table[58][1] = ["Добавит +1 к манне", "Add 1 to manna", ""];
			Lang.lang_table[58][2] = ["Добавит +1 к урону", "Add 1 to damage", ""];
			Lang.lang_table[58][3] = ["Добавит +1 к физ. защите", "Add 1 to phys. protection", ""];
			Lang.lang_table[58][4] = ["Добавит +1 к маг. защите", "Add 1 to mag. protection", ""];
			
			Lang.lang_table[58][5] = ["Добавит +2 к здоровью", "Add +2 to health", ""];
			Lang.lang_table[58][6] = ["Добавит +2 к манне", "Add 2 to manna", ""];
			Lang.lang_table[58][7] = ["Добавит +2 к урону", "Add 2 to damage", ""];
			Lang.lang_table[58][8] = ["Добавит +2 к физ. защите", "Add 2 to phys. protection", ""];
			Lang.lang_table[58][9] = ["Добавит +2 к маг. защите", "Add 2 to to mag. protection", ""];
			
			Lang.lang_table[58][10] = ["Добавит +3 к здоровью", "Add 3 to health", ""];
			Lang.lang_table[58][11] = ["Добавит +3 к манне", "Add 3 to manna", ""];
			Lang.lang_table[58][12] = ["Добавит +3 к урону", "Add 3 to damage", ""];
			Lang.lang_table[58][13] = ["Добавит +3 к физ. защите", "Add 3 to phys. protection", ""];
			Lang.lang_table[58][14] = ["Добавит +3 к маг. защите", "Add 3 to to mag. protection", ""];
			
			Lang.lang_table[59] = new Array();
			Lang.lang_table[59][0] = ["10 камней добавят +1 к здоровью ", "10 stones add 1 to health ", ""];
			Lang.lang_table[59][1] = ["10 камней добавят +1 к манне", "10 stones add 1 to manna ", ""];
			Lang.lang_table[59][2] = ["10 камней добавят +1 к урону", "10 stones add 1 to damage ", ""];
			Lang.lang_table[59][3] = ["10 камней добавят +1 к физ. защите", "10 stones add 1 to phys. protection ", ""];
			Lang.lang_table[59][4] = ["10 камней добавят +1 к маг. защите", "10 stones add 1 to mag. protection ", ""];
			
			Lang.lang_table[59][5] = ["10 камней добавят +2 к здоровью", "10 stones add 2 to health ", ""];
			Lang.lang_table[59][6] = ["10 камней добавят +2 к манне", "10 stones add 2 to manna ", ""];
			Lang.lang_table[59][7] = ["10 камней добавят +2 к урону", "10 stones add 2 to damage ", ""];
			Lang.lang_table[59][8] = ["10 камней добавят +2 к физ. защите", "10 stones add 2 to phys. protection ", ""];
			Lang.lang_table[59][9] = ["10 камней добавят +2 к маг. защите", "10 stones add 2 to mag. protection ", ""];
			
			Lang.lang_table[59][10] = ["10 камней добавят +3 к здоровью", "10 stones add 3 to health ", ""];
			Lang.lang_table[59][11] = ["10 камней добавят +3 к манне", "10 stones add 3 to manna ", ""];
			Lang.lang_table[59][12] = ["10 камней добавят +3 к урону", "10 stones add 3 to damage ", ""];
			Lang.lang_table[59][13] = ["10 камней добавят +3 к физ. защите", "10 stones add 3 to phys. protection ", ""];
			Lang.lang_table[59][14] = ["10 камней добавят +3 к маг. защите", "10 stones add 3 to mag. protection ", ""];
			Lang.lang_table[60] = new Array();
			Lang.lang_table[60][1] = ["Зайдите в замок, что бы нанять юинита и купить ему артефакты", "Go to the castle to hire units and buy him artifacts", ""];
			Lang.lang_table[60][2] = ["Нажмите, что бы открыть таверну с юнитами", "Click to open a tavern with units", ""];
			Lang.lang_table[60][3] = ["Наймите юнита", "Hire unit"];
			Lang.lang_table[60][4] = ["У Вас есть юнит, но ему надо оружие", "You have unit, but he needs weapon", ""];
			Lang.lang_table[60][7] = ["Время выполнить миссию", "Time to complete mission"];
			Lang.lang_table[61] = ["Нанять", "Hire", ""];
			Lang.lang_table[62] = ["Я хочу продать", "I want to sell", ""];
			Lang.lang_table[63] = ["Жизни", "Health", ""];
			Lang.lang_table[64] = ["Манна", "Manna", ""];
			Lang.lang_table[65] = ["Урон", "Damage", ""];
			Lang.lang_table[66] = ["Физ. Защита", "Phys. prot.", ""];
			Lang.lang_table[67] = ["Маг. Защита", "Mag. prot.", ""];
			Lang.lang_table[68] = ["Скорость", "Speed", ""];
			Lang.lang_table[69] = ["Инициатива", "Initiative", ""];
			Lang.lang_table[70] = ["Поражение", "Defeat", ""];
			Lang.lang_table[71] = ["Победа", "Victory", ""];
			Lang.lang_table[72] = ["Я хочу купить", "I want to buy", ""];
			Lang.lang_table[73] = ["ПРОДАТЬ", "SELL", ""];
			Lang.lang_table[74] = ["Я хочу улучшить", "I want to improve", ""];
			Lang.lang_table[75] = ["Я хочу заказать", "I want to order", ""];
			Lang.lang_table[76] = ["Убил", "Killed", ""];
			Lang.lang_table[77] = ["Доступно", "Available", ""];
			Lang.lang_table[78] = ["Заказать", "Order", ""];
			Lang.lang_table[79] = ["шанс ударить указанную цель 2 раза", "chance to attack target 2 times", ""];
			Lang.lang_table[80] = ["шанс нанести двойной урон", "chance for double damage", ""];
			Lang.lang_table[81] = ["шанс нанести урон сквозь броню", "chance to deal damage through armor", ""];
			Lang.lang_table[82] = ["шанс уклонится от удара", "chance to dodge", ""];
			Lang.lang_table[83] = ["шанс контр атаки", "the chance to counter-attack", ""];
			Lang.lang_table[84] = ["Купить", "Buy", ""];
			Lang.lang_table[85] = ["Цена:", "Price:", ""];
			Lang.lang_table[86] = ["или", "or", ""];
			Lang.lang_table[87] = ["Нанять юнита", "Hire  unit", ""];
			Lang.lang_table[88] = ["Выключить музыку", "Turn off music", ""];
			Lang.lang_table[89] = ["Включить музыку", "Turn on music", ""];
			Lang.lang_table[90] = ["Выключить звук", "Turn off sound", ""];
			Lang.lang_table[91] = ["Включить звук", "Turn on sound", ""];
			Lang.lang_table[92] = ["Полный экран", "Fullscreen", ""];
			Lang.lang_table[93] = ["Оконный режим", "Window mode", ""];
			Lang.lang_table[94] = ["Удержание", "Hold", ""];
			Lang.lang_table[95] = ["Автобой", "Autobattle", ""];
			Lang.lang_table[96] = ["Сдаться", "Surrender", ""];
			Lang.lang_table[97] = 	[ 
										["Использовать 4 раза магию.", "", ""], 
										["Для этого Вам надо зайти в карту миссий или в арену и начать бой. В бою любым юнитом надо использовать его магию, которая находится в правом нижнем углу. Проделав это 4 раза вы получите награду.", "", ""]
									];
			Lang.lang_table[98] = 	[ 
										["Использовать 3 раза баночку востановления здоровья.", "", ""], 
										["Положите в инвентарь юнита баночку востановления здоровья и в бою используйте их по необходимости. Такой тактический ход может увеличить сильно ваши шансы на победу.", "", ""]
									];
			Lang.lang_table[99] = 	[ 
										["Использовать 3 раза баночку востановления манны.", "", ""], 
										["Положите в инвентарь юнита баночку востановления манны и в бою используйте их по необходимости. Такой тактический ход может увеличить сильно ваши шансы на победу.", "", ""]
									];
			Lang.lang_table[100] = 	[ 
										["Использовать 2 раза свиток атаки.", "", ""], 
										["Свиток атаки повысит вам на один ход атаку юнита. Что бы получить награду используйте свиток атаки 2 раза.", "", ""]
									];
			Lang.lang_table[101] = 	[ 
										["Использовать 2 раза свиток защиты.", "", ""], 
										["Свиток защиты повысит вам на один ход защиту юнита. Что бы получить награду используйте свиток защиты 2 раза.", "", ""]
									];
			///
			Lang.lang_table[152] = ["Задание выполнено!!!\nВы можете забрать награду.", "", ""];
			Lang.lang_table[153] = ["Награда:", "", ""];
			Lang.lang_table[154] = ["У вас недостаточно энергии для входа в миссию. Вы можете купить её или со временем она восстановится.", "", ""];
			Lang.lang_table[155] = ["Повторить миссию", "", ""];
			Lang.lang_table[156] = ["Следующая миссия", "", ""];
			Lang.lang_table[157] = ["Вы можете походить в любую выделенную ячейку. Вам необходимо дойти к монстру и ударить его.", "", ""];
			Lang.lang_table[158] = ["Наведя курсор на монстра, правым кликом вы можете ударить его. Что бы выиграть бой - надо его убить.", "", ""];
			Lang.lang_table[159] = ["На Ваш счет было зачислено ", "", ""];
			Lang.lang_table[160] = [" серебряных монет", "", ""];
			Lang.lang_table[161] = [" золотых монет", "", ""];
			Lang.lang_table[162] = ["Купить энергию", "", ""];
			Lang.lang_table[163] = ["В Арену", "", ""];
			Lang.lang_table[164] = ["БОНУС\nЛИДЕР", "", ""];
			Lang.lang_table[165] = ["За выполнение всех условий получения бонуса \"Лидер\" вы получаете 5 золотых монет и 50 энергии.\n\nВ следующий раз бонус вы сможете получить через 24 часа.", "", ""];
			Lang.lang_table[166] = ["Переместить юнита", "", ""];
			Lang.lang_table[167] = ["Удалить юнита", "", ""];
			Lang.lang_table[168] = ["Я хочу уволить", "", ""];
			Lang.lang_table[169] = [["Варвара", "Barbarin", ""], ["Омника", "Omnic", ""], ["Лучника", "Archer", ""], ["Мага", "Wizard", ""]];
			Lang.lang_table[170] = ["У вас недостаточно энергии для входа в бой. Вы можете купить её или со временем она восстановится.", "", ""];
			
			
		}
		
		public function Lang() {
			
		}
		
		public static function getTitle(id1:int, id2:int = -1, id3:int = -1):String {
			if (id3 > -1) {
				if (Lang.lang_table[id1] != null && Lang.lang_table[id1][id2] != null && Lang.lang_table[id1][id2][id3] != null && Lang.lang_table[id1][id2][id3][Lang.lang] != null) {
					return Lang.lang_table[id1][id2][id3][Lang.lang];
				} else {
					return "";
				}
			} else if (id2 > -1) {
				if (Lang.lang_table[id1] != null && Lang.lang_table[id1][id2] != null && Lang.lang_table[id1][id2][Lang.lang] != null) {
					return Lang.lang_table[id1][id2][Lang.lang];
				} else {
					return "";
				}
			} else {
				if (Lang.lang_table[id1] != null && Lang.lang_table[id1][Lang.lang] != null) {
					return Lang.lang_table[id1][Lang.lang];
				} else {
					return "";
				}
			}
		}
		
		static public function getPaymentText(res:*):String {
			if(Lang.lang == 0) {
				return Lang.getTitle(159) + String(res.q) + Lang.getTitle(160 + int(res.v));
			} else if(Lang.lang == 1) {
				return "";
			} else if(Lang.lang == 2) {
				return "";
			}
			return "";
		}
	}
}