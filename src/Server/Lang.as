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