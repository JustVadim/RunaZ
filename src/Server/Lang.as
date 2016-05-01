package Server 
{
	import Utils.BuffsVars;
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
			lang_table[0][0]  = ["Начало пути", 		"The beginning of the way",	""];
			lang_table[0][1]  = ["Зелёная тропа", 		"The green trail", 		""];
			lang_table[0][2]  = ["В поисках истины", 	"In search of truth",   ""];
			lang_table[0][3]  = ["Туман войны", 		"Fog of war", 			""];
			lang_table[0][4]  = ["Поворот не туда", 	"Wrong turn",			""];
			lang_table[0][5]  = ["Проклятая река", 		"Cursed river",			""];
			lang_table[0][6]  = ["Верная стража", 		"Faithful guardian",	""];
			lang_table[0][7]  = ["Звон монет", 			"Coins ringing",		""];
			lang_table[0][8]  = ["Шёпот дракона", 		"Dragon whisper",		""];
			lang_table[0][9]  = ["Клыкастая месть", 	"Fanged revenge",		""];
			lang_table[0][10] = ["БОСС", 				"BOSS", 				""];
			lang_table[0][11] = ["Земля проклятых", 	"Curse land", 			""];
			lang_table[0][12] = ["Шелест листьев", 		"Rustles of leaves",	""];
			lang_table[0][13] = ["Две башни", 			"Two towers",			""];
			lang_table[0][14] = ["Лесные ветра", 		"Forest wings",			""];
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
			lang_table[0][33] = ["Верхние земли",		"Higher Ground",		""];
			lang_table[0][34] = ["Во тьму",				"Into the Darkness",	""];
			lang_table[0][35] = ["Глаз шторма",			"",						""];
			lang_table[0][36] = ["Подземелья и дьяволы","Dungeons and Devils",	""];
			lang_table[0][37] = ["Отголоски войны",		"Spoils of War",		""];
			lang_table[0][38] = ["Испорченное cолнце",	"Tainted Sun",			""];
			lang_table[0][39] = ["Забытая башня",		"The Forgotten Tower",	""];
			lang_table[0][40] = ["Демоны из ада",		"",						""];
			lang_table[0][41] = ["Вторжение",			"BOSS",					""];
			lang_table[0][42] = ["Вождь клана",			"BOSS",					""];
			lang_table[0][43] = ["БОСС",				"BOSS",					""];
			lang_table[0][44] = ["Кровавая луна",				"BOSS",					""];
			lang_table[0][45] = ["Пожиратель грехов",				"BOSS",					""];
			lang_table[0][46] = ["Дурная кровь",				"BOSS",					""];
			lang_table[0][47] = ["Потерянный рай",				"BOSS",					""];
			lang_table[0][48] = ["Шёпот во тьме",				"BOSS",					""];
			lang_table[0][49] = ["Кровь и страх",				"BOSS",					""];
			lang_table[0][50] = ["В диких условиях",				"BOSS",					""];
			lang_table[0][51] = ["Ранний свет рассвета",				"BOSS",					""];
			lang_table[0][52] = ["Одна жизнь",				"BOSS",					""];
			lang_table[0][53] = ["Время летит",				"BOSS",					""];
			lang_table[0][54] = ["БОСС",				"BOSS",					""];
			
			
			
			
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
			Lang.lang_table[8] = ["Бешенство", "Rage", ""];
			Lang.lang_table[9] = ["Ответный удар", "Counter attack", ""];
			Lang.lang_table[10] = 	[
										["шанс нанести двойной урон",				"",				""],
										["шанс уклониться от удара",				"",				""],
										["шанс атаковать дважды",					"",				""],
										["шанс атаковать сквозь защиту",			"",				""],
										["шанс нанести ответный удар",				"",				""]
			
			
									];
			Lang.lang_table[11] = ["Слудующий уровень",	 			"", ""];
			Lang.lang_table[12] = ["Этот навык прокачан максимально", 				"", 			""];
			
			Lang.lang_table[13] = 	[
										["Ярость",									"",				""],
										["Лечение",									"",				""],
										["Огненная стрела",							"",				""],
										["Молния",									"",				""]
									];
			Lang.lang_table[14] = 	[
										[	"Увеличивает урон Варвара в процентном соотношении",
											"",
											""
										],
										[
											"Востанавливает здоровье любому союзному юниту в команде",
											"",
											""
										],
										[
											"Оглушает вражеского юнита огненной стрелой при єтом наносит ему урон",
											"",
											""
										],
										[
											"Поражает вражеского юнита молнией при этом наносит ему урон",
											"",
											""
										],
									];
			Lang.lang_table[15] = ["Новый уровень","",""];
			Lang.lang_table[16] = ["Уровень","",""];
			Lang.lang_table[17] = ["Вы не набрали нужный уровень что бы купить эту вещь. Набрать больше опыта Вы можете в миссиях или на арене.", "", ""];
			Lang.lang_table[18] = [];
			Lang.lang_table[19] = [];
			Lang.lang_table[20] = [];
			Lang.lang_table[21] = [];
			Lang.lang_table[22] = [];
			Lang.lang_table[23] = [];
			Lang.lang_table[24] = [];
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
			Lang.lang_table[60][1] = ["Зайдите в замок, что бы нанять юнита и купить ему артефакты", "Go to the castle to hire unit and buy him artifacts", ""];
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
			Lang.lang_table[102] = 	[ 
										["Купить второго юнита.", "", ""], 
										["Что бы быть сильнее в бою, зайдите в замок и наймите еще одного юнита. Внимательно присмотритесь какой тип юнита вам подойдет лучше.", "", ""]
									];
			Lang.lang_table[103] = 	[ 
										["Выиграйте 5 миссий на уровне сложности \"Воин\".", "", ""], 
										["Что бы выполнить это задание Вам нужно повторно пройти миссию но уже на уровне сложности \"Воин\". Выиграйте 5 раз на уровне сложности \"Воин\" и награда Ваша.", "", ""]
									];
			Lang.lang_table[104] = 	[ 
										["Закажите 5 раз драгоценный камень.", "", ""], 
										["Зайдите в кузницу и закажите 5 раз драгоценный камень. Каждый камень имеет свое время добывания. Заказывать камни можно только по очереди.", "", ""]
									];
			Lang.lang_table[105] = 	[
										["Провести 10 сражений на арене.","",""],
										["Что бы получить награду надо провести 10 сражений на арене. Для этого зайдите на арену и нажмите поиск игры.","",""],
									]
			Lang.lang_table[106] = 	[
										["Купить третьего юнита.","",""],
										["Что бы быть сильнее в бою, зайдите в замок и наймите еще одного юнита. Внимательно присмотритесь какой тип юнита вам подойдет лучше.","",""]
									]
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
			Lang.lang_table[171] = ["Ваш рейтинг: ", "", ""];
			Lang.lang_table[172] = [	["", "", ""], 
										["Малая баночка здоровья\n\nВосстанавливает 20 единиц или 20% здоровья в бою. Использовать можно только 1 раз.", "", ""], 
										["Средняя баночка здоровья\n\nВосстанавливает 35 единиц или 35% здоровья в бою. Использовать можно только 1 раз.", "", ""], 
										["Большая баночка здоровья\n\nВосстанавливает 45 единиц или 45% здоровья в бою. Использовать можно только 1 раз.", "", ""], 
										["Малая баночка манны\n\nВосстанавливает 20 единиц или 20% манны в бою. Использовать можно только 1 раз.", "", ""], 
										["Средняя баночка манны\n\nВосстанавливает 35 единиц или 35% манны в бою. Использовать можно только 1 раз.", "", ""],
										["Большая баночка манны\n\nВосстанавливает 50 единиц или 50% манны в бою. Использовать можно только 1 раз.", "", ""], 
										["Свиток защиты\n\nПоднимает защиту юнита в бою на 45%. Использовать можно только 1 раз.", "", ""], 
										["Свиток атаки\n\nПоднимает атаку юнита в бою на 45%. Использовать можно только 1 раз.","",""]];
			Lang.lang_table[173] = ["Показывать жизни", "", ""];
			Lang.lang_table[174] = 	[
										//0 - шлемы
										[
											/*0*/[],
											/*0*/["Шлем ур.1", "", ""],
											/*0*/["Шлем ур.2", "", ""],
											/*0*/["Шлем ур.3", "", ""],
											/*0*/["Шлем ур.4", "", ""],
											/*0*/["Шлем ур.5", "", ""],
											/*0*/["Шлем ур.6", "", ""],
											/*0*/["Шлем ур.7", "", ""],
											/*0*/["Шлем ур.8", "", ""],
											/*0*/["Шлем ур.9", "", ""],
											/*0*/["Шлем ур.10", "", ""],
											/*0*/["Шлем ур.11", "", ""],
											/*0*/["Шлем ур.12", "", ""]
										],
										//1 - 
										[
											/*0*/[],
											/*0*/["Броня ур.1", "", ""],
											/*0*/["Броня ур.2", "", ""],
											/*0*/["Броня ур.3", "", ""],
											/*0*/["Броня ур.4", "", ""],
											/*0*/["Броня ур.5", "", ""],
											/*0*/["Броня ур.6", "", ""],
											/*0*/["Броня ур.7", "", ""],
											/*0*/["Броня ур.8", "", ""],
											/*0*/["Броня ур.9", "", ""],
											/*0*/["Броня ур.10", "", ""],
											/*0*/["Броня ур.11", "", ""],
											/*0*/["Броня ур.12", "", ""]
										],
										//2
										[
											/*0*/[],
											/*0*/["Сапог ур.1", "", ""],
											/*0*/["Сапог ур.2", "", ""],
											/*0*/["Сапог ур.3", "", ""],
											/*0*/["Сапог ур.4", "", ""],
											/*0*/["Сапог ур.5", "", ""],
											/*0*/["Сапог ур.6", "", ""],
											/*0*/["Сапог ур.7", "", ""],
											/*0*/["Сапог ур.8", "", ""],
											/*0*/["Сапог ур.9", "", ""],
											/*0*/["Сапог ур.10", "", ""],
											/*0*/["Сапог ур.11", "", ""],
											/*0*/["Сапог ур.12", "", ""]
										],
										//3
										[
											/*0*/[],
											/*0*/["Плечи ур.1", "", ""],
											/*0*/["Плечи ур.2", "", ""],
											/*0*/["Плечи ур.3", "", ""],
											/*0*/["Плечи ур.4", "", ""],
											/*0*/["Плечи ур.5", "", ""],
											/*0*/["Плечи ур.6", "", ""],
											/*0*/["Плечи ур.7", "", ""],
											/*0*/["Плечи ур.8", "", ""],
											/*0*/["Плечи ур.9", "", ""],
											/*0*/["Плечи ур.10", "", ""],
											/*0*/["Плечи ур.11", "", ""],
											/*0*/["Плечи ур.12", "", ""]
										],
										//4
										[
											/*0*/[],
											/*0*/["Перчатки ур.1", "", ""],
											/*0*/["Перчатки ур.2", "", ""],
											/*0*/["Перчатки ур.3", "", ""],
											/*0*/["Перчатки ур.4", "", ""],
											/*0*/["Перчатки ур.5", "", ""],
											/*0*/["Перчатки ур.6", "", ""],
											/*0*/["Перчатки ур.7", "", ""],
											/*0*/["Перчатки ур.8", "", ""],
											/*0*/["Перчатки ур.9", "", ""],
											/*0*/["Перчатки ур.10", "", ""],
											/*0*/["Перчатки ур.11", "", ""],
											/*0*/["Перчатки ур.12", "", ""]
										],
									]
			Lang.lang_table[175] = 	[
										/*0 */[],
										/*1 */["Баночка","",""],
										/*2 */["Баночка","",""],
										/*3 */["Баночка","",""],
										/*4 */["Баночка","",""],
										/*5 */["Баночка","",""],
										/*6 */["Баночка","",""],
										/*7 */["Свиток защиты","",""],
										/*8 */["Свиток атаки", "", ""],
										/*9 */["Свиток атаки","",""],
										/*10*/["Свиток атаки","",""]
									]
			Lang.lang_table[176] =	[
										/*0 - barbarian*/
										[ 
											/*0*/[],
											/*1*/["Топор ур.1","",""],
											/*2*/["Топор ур.2","",""],
											/*3*/["Топор ур.3","",""],
											/*4*/["Топор ур.4","",""],
											/*5*/["Топор ур.5","",""],
											/*6*/["Топор ур.6","",""],
											/*7*/["Топор ур.7","",""],
											/*8*/["Топор ур.8","",""],
										], 
										/*1 - paladin*/
										[ 
											/*0*/[],
											/*1*/["Меч ур.1","",""],
											/*2*/["Меч ур.2","",""],
											/*3*/["Меч ур.3","",""],
											/*4*/["Меч ур.4","",""],
											/*5*/["Меч ур.5","",""],
											/*6*/["Меч ур.6","",""],
											/*7*/["Меч ур.7","",""],
											/*8*/["Меч ур.8","",""],
										],
										/*3 - bow*/
										[ 
											/*0*/[],
											/*1*/["Лук ур.1","",""],
											/*2*/["Лук ур.2","",""],
											/*3*/["Лук ур.3","",""],
											/*4*/["Лук ур.4","",""],
											/*5*/["Лук ур.5","",""],
											/*6*/["Лук ур.6","",""],
											/*7*/["Лук ур.7","",""],
											/*8*/["Лук ур.8","",""],
										],

										/*2 - Mag*/
										[ 
											/*0*/[],
											/*1*/["Посох ур.1","",""],
											/*2*/["Посох ур.2","",""],
											/*3*/["Посох ур.3","",""],
											/*4*/["Посох ур.4","",""],
											/*5*/["Посох ур.5","",""],
											/*6*/["Посох ур.6","",""],
											/*7*/["Посох ур.7","",""],
											/*8*/["Посох ур.8","",""],
										],
									]
			Lang.lang_table[177] =	[
										/*0 - barbarian*/
										[ 
											
										], 
										/*1 - paladin*/
										[ 
											/*0*/[],
											/*1*/["Щит ур.1","",""],
											/*2*/["Щит ур.2","",""],
											/*3*/["Щит ур.3","",""],
											/*4*/["Щит ур.4","",""],
											/*5*/["Щит ур.5","",""],
											/*6*/["Щит ур.6","",""],
											/*7*/["Щит ур.7","",""],
											/*8*/["Щит ур.8","",""],
										],
										/*3 - bow*/
										[ 
											
										],

										/*2 - Mag*/
										[ 
											
										],
									]
			Lang.lang_table[178] = 	[
										/*0*/["Атака","",""],
										/*1*/["Защита","",""],
										/*2*/["Магия","",""],
										/*3*/["Выносливость","",""]
									]
			Lang.lang_table[179] = 	[
										/*0*/[" атаки получает каждый Ваш юнит в бою","",""],
										/*1*/[" к магической и физической защите получает каждый Ваш юнит в бою","",""],
										/*2*/[" к запасу манны получит каждый Ваш юнит в бою","",""],
										/*3*/[" энергии это Ваш максимальный запас восстанавливаемой энергии","",""]
									]
			Lang.lang_table[180] = ["Ресурсы", "", ""];
			Lang.lang_table[181] = ["Ваши ресурсы.\nНажмите что бы купить ресурсы.", "", ""];
			Lang.lang_table[182] = ["Энергия", "", ""];
			Lang.lang_table[183] = ["Ваша энергия. Вовстанавливается 1 единица в минуту. Для входа в бой надо 10 энергии.","",""];
			Lang.lang_table[184] = ["Опыт", "", ""];
			Lang.lang_table[185] = ["Ваш опыт. Увеличивается по мере прохождения миссий.", "", ""];
			Lang.lang_table[186] = ["Сообщение", "", ""];
			Lang.lang_table[187] = ["Прив. сообщ.", "", ""];
			Lang.lang_table[188] = ["Профиль", "", ""];
			Lang.lang_table[189] = ["Рейтинг", "", ""];
			Lang.lang_table[190] = ["Винрейт", "", ""];
			Lang.lang_table[191] = ["без оружия", "", ""];
			Lang.lang_table[192] =	[
										["Убийца монстров","",""],
										["Убийца юнитов","",""],
										["Победитель арены","",""],
										["Победитель миссий","",""],
										["Непобедимый на арене","",""],
										["Непобедимый в миссиях", "", ""],
										["Великий маг", "", ""],
										["Искустный алхимик", "", ""],
										["Кузнец", "", ""],
										["Донатер золото", "", ""],
										["Донатер серебро", "", ""],
										["Царь карты","",""]
									];
			Lang.lang_table[193] = [
										["Убейте нужное количество монстров в миссиях.","",""],
										["Убейте нужное количество юнитов в бою на Арене.","",""],
										["Выиграйте нужное количество сражений на Арене.","",""],
										["Выиграйте нужное количество сражений в миссиях.","",""],
										["Выиграйте нужное количество сражений на Арене подряд.","",""],
										["Выиграйте нужное количество сражений в миссиях подряд", "", ""],
										["Используйте свитки нужное количество раз.", "", ""],
										["Используйте баночки нужное количество раз.", "", ""],
										["Закажите нужное количество камне в кузнице.", "", ""],
										["Купите нужное количество золота в банке.", "", ""],
										["Купите нужное количество серебра в банке.", "", ""],
										["Пройдите нужное количество миссий на уровне \"Царь\".","",""]
									];
			Lang.lang_table[194] = [
										["Уровень 1","",""],
										["Уровень 2","",""],
										["Уровень 3","",""],
									];
			Lang.lang_table[195] = ["Текущий прогресс", "", ""];
			Lang.lang_table[196] = ["Текущий уровень", "", ""];
			
			
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
		
		static public function getItemTitle(itemType:int, itemId:int, heroType:int = 0):String {
			var res:String = "";
			if(itemType == 7) {
				res = Lang.getTitle(175, itemId);
			} else if(itemType!=5 && itemType!=6) {
				res = Lang.getTitle(174, itemType, itemId);
			} else {
				if (itemType == 5) {
					res = Lang.getTitle(176, heroType, itemId);
				} else {
					res = Lang.getTitle(177, heroType, itemId);
				}
			}
			return res;
		}
		
		static public function getMyAchieveText(index:int):String {
			var str:String = "";
			var achiev:Object = (UserStaticData.achievments_table[index] != null) ? UserStaticData.achievments_table[index]:[0, 0, 0];
			str += "<font color=\"#00FF40\">" + Lang.getTitle(192, index) + "</font>" + "\n" + Lang.getTitle(193, index);
			str += "\n\n<font color=\"#11B1FF\">" + Lang.getTitle(194, 0) + ": " + achiev[0] + "</font>";
			str += "\n<font color=\"#11B1FF\">" + Lang.getTitle(194, 1) + ": " + achiev[1] + "</font>";
			str += "\n<font color=\"#11B1FF\">" + Lang.getTitle(194, 2) + ": " + achiev[2] + "</font>";
			var prog:int = UserStaticData.hero.ach[index].q;
			var lvl:int = UserStaticData.hero.ach[index].s
			if (lvl != 3) {
				var all:int = achiev[lvl];
				str += "\n\n<font color=\"#FF8040\">" + Lang.getTitle(195) + ": " + " " + int(prog * 100 / all) + "% (" + prog + "/" + all + ")</font>";
			} else {
				str += "\n\n<font color=\"#FF8040\">" + Lang.getTitle(195) + ": 100% (" + prog + "/" + achiev[2] + ")</font>";
			}
			str += "\n<font color=\"#FF8040\">" + Lang.getTitle(196) + ": " + " " + lvl + "</font>";
			return str
		}
	}
}