package Server 
{
	import report.Report;
	public class Lang 
	{
		public static var lang:int = 0;
		private static var lang_table:Array = new Array();
		
		public static function init():void
		{
			Lang.lang_table[0] = new Array();
			lang_table[0][0] = ["Начало пути", "", "", ""];
			lang_table[0][1] = ["Зеленая тропа", "", "", ""];
			lang_table[0][2] = ["В поисках истины", "", "", ""];
			lang_table[0][3] = ["Туман войны", "", "", ""];
			lang_table[0][4] = ["Поворот не туда", "", "", ""];
			lang_table[0][5] = ["Проклятая река", "", "", ""];
			lang_table[0][6] = ["Верная стража", "", "", ""];
			lang_table[0][7] = ["Звон монет", "", "", ""];
			lang_table[0][8] = ["Шепото дракона", "", "", ""];
			lang_table[0][9] = ["Клыкастая месть", "", "", ""];
			lang_table[0][10] = ["БОСС", "", "", ""];
			lang_table[0][11] = ["Земля проклятых", "", "", ""];
			lang_table[0][12] = ["Шелест листьев", "", "", ""];
			lang_table[0][13] = ["Две башни", "", "", ""];
			lang_table[0][14] = ["Лесные шелесты", "", "", ""];
			lang_table[0][15] = ["Вулканическая пыль", "", "", ""];
			lang_table[0][16] = ["Крик орков", "", "", ""];
			lang_table[0][17] = ["Лужайка единорогов", "", "", ""];
			lang_table[0][18] = ["Сердце кошмара", "", "", ""];
			lang_table[0][19] = ["Кровавый прибой", "", "", ""];
			lang_table[0][20] = ["Прах и ярость", "", "", ""];
			lang_table[0][21] = ["БОСС", "", "", ""];
			Lang.lang_table[1] = new Array();
			Lang.lang_table[1][0] = ["Шлем", "", ""];
			Lang.lang_table[1][1] = ["Кольчуга", "", ""];
			Lang.lang_table[1][2] = ["Сапоги", "", ""];
			Lang.lang_table[1][3] = ["Наплечники", "", ""];
			Lang.lang_table[1][4] = ["Перчатки", "", ""];
			Lang.lang_table[1][5] = ["Оружие", "", ""];
			Lang.lang_table[1][6] = ["Щиты", "", ""];
			Lang.lang_table[1][7] = ["Инвентарь", "", ""];
			Lang.lang_table[2] = ["У одного из вашых воинов повысился уровень, зайдите  в замок, чтобы улучшить его.", "", "" ];
			Lang.lang_table[3] = [["Банк", "", ""], ["Топ", "", ""], ["Замок", "", ""], ["Арена", "", ""], ['Кузница', "", ""], ["Карта", "", ""]];
			Lang.lang_table[4] = ["У вас недостаточно ресурсов для этой покупки.", "", ""];
			Lang.lang_table[5] = ["Критический урон", "", ""];
			Lang.lang_table[6] = ["Уворот", "", ""];
			Lang.lang_table[7] = ["Двойная атака", "", ""];
			Lang.lang_table[8] = ["Бешенсво", "", ""];
			Lang.lang_table[9] = ["Ответный удар", "", ""];
			Lang.lang_table[10] = ["шанс нанести двойной урон</font>\n Следующий уровень", "", ""];
			Lang.lang_table[11] = ["шанс уклониться от удара</font>\n Следующий уровень", "", ""];
			Lang.lang_table[12] = ["шанс атаковать два раза</font>\n Следующий уровень", "", ""];
			Lang.lang_table[13] = ["шанс атаковать сквозь защиту</font>\n Следующий уровень", "", ""];
			Lang.lang_table[14] = ["шанс нанести ответный удар</font>\n Следующий уровень", "", ""];
			Lang.lang_table[15] = ["Ярость", "", ""];
			Lang.lang_table[16] = ["Лечение", "", ""];
			Lang.lang_table[17] = ["Огненная стрела", "", ""];
			Lang.lang_table[18] = ["Молния", "", ""];
			Lang.lang_table[19] = [" увеличивает урон юнита на ", "", ""];
			Lang.lang_table[20] = ["на текущий ход", "", ""];
			Lang.lang_table[21] = [" востанавливает ", "", ""];
			Lang.lang_table[22] = [" единиц здоровья любому союзному юниту", "", ""];
			Lang.lang_table[23] = [" Оглушает вражеского юнита огненной стрелой и наносит ", "", ""];
			Lang.lang_table[24] = [" урона", "", ""];
			Lang.lang_table[25] = [" Поражает вражеского юнита молнией при этом наносит ему ", "", ""];
			Lang.lang_table[26] = ["Следующий уровень - ", "", ""];
			Lang.lang_table[27] = [" единиц", "", ""];
			Lang.lang_table[28] = ["Стоимость заклинания ", "", ""];
			Lang.lang_table[29] = [" манны", "", ""];
			Lang.lang_table[30] = ["Нажмите что бы улучшить!", "", ""];
			Lang.lang_table[31] = ["Навык", "", ""];
			Lang.lang_table[32] = ["Я хочу продать", "", ""];
			Lang.lang_table[33] = ["Нажмите, чтобы\n купить вещь", "", ""];
			Lang.lang_table[34] = [" Убил: ", "", ""];
			Lang.lang_table[35] = [" Умер: ", "", ""];
			Lang.lang_table[36] = ["Вы не сможете победить! \n Наймите воина. Если у вас уже есть воин - купите ему оружие", "", ""];
			Lang.lang_table[37] = ["Миссия еще не доступна, ожидайте ее в скором времени!!", "", ""];
			Lang.lang_table[38] = [["Варвар", "", ""], ["Омник", "", ""], ["Лучник", "", ""], ["Маг", "", ""]];
			Lang.lang_table[39] = ["", "", ""];
			Lang.lang_table[40] = ["", "", ""];
			Lang.lang_table[41] = ["", "", ""];
			Lang.lang_table[42] = ["", "", ""];
			Lang.lang_table[43] = ["", "", ""];
			Lang.lang_table[44] = ["", "", ""];
			Lang.lang_table[45] = ["", "", ""];
			Lang.lang_table[46] = ["", "", ""];
			Lang.lang_table[47] = ["", "", ""];
			Lang.lang_table[48] = ["", "", ""];
			
			
			
			
			
			
			
			
			
			
		}
		
		public function Lang()
		{
			
		}
		
		public static function getTitle(id1:int, id2:int = -1, id3:int = -1):String
		{
			if (id3 > -1)
			{
				if (Lang.lang_table[id1] != null && Lang.lang_table[id1][id2] != null && Lang.lang_table[id1][id2][id3] != null && Lang.lang_table[id1][id2][id3][Lang.lang] != null)
					return Lang.lang_table[id1][id2][id3][Lang.lang];
				else
					return "";
			}
			else if (id2 > -1)
			{
				if (Lang.lang_table[id1] != null && Lang.lang_table[id1][id2] != null && Lang.lang_table[id1][id2][Lang.lang] != null)
					return Lang.lang_table[id1][id2][Lang.lang];
				else
					return "";
			}
			else
			{
				if (Lang.lang_table[id1] != null && Lang.lang_table[id1][Lang.lang] != null)
					return Lang.lang_table[id1][Lang.lang];
				else
					return "";
			}
		}
	}
}