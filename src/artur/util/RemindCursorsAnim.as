package artur.util 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.BitmapData;
	import flash.ui.*;
	import flash.utils.*;
	import flash.geom.*;
	
	/**
	 * ...
	 * @author Alexandr [ReMind] Balabanovich
	 *   [alexandr.balabanovich@gmail.com]
	 * 	            remindgames.com
	 */
	public class RemindCursorsAnim extends Object
	{
		public var name:String; 					// Имя курсора
		private var fps: Number; 					// FPS курсора
		private var hotSpot: Point;				// Точка клика
		private var data:Vector.<BitmapData>  	// Вектор из BtmapData
		
		
		public function RemindCursorsAnim() {
			super();
			data = new Vector.<BitmapData>;
			name = "";
		}
		
		
		/**
		 * Создает экземпляр класса переданного аргуметом, задает параметры курсора и передает для обработки.
		 * @param	cursorClass		Класс курсора
		 * @param	cursorName		Имя курсора. Если null, то будет указано имя класса.
		 */
		public function addCursorFromClass($cursorClass:Class, $cursorName: String = null, $cursorHotSpot:Point = null, $cursorFPS: Number = NaN):void {
			if ($cursorName == null) {
				name = getQualifiedClassName($cursorClass);
			} else {
				name = $cursorName;
			}
			if ($cursorHotSpot != null) {
				this.hotSpot = $cursorHotSpot;
			}
			if ($cursorFPS != NaN) {
				this.fps = $cursorFPS;
			}
			// Запускаем процесс растеризации
			if (getQualifiedSuperclassName($cursorClass) == "flash.display::MovieClip") {
				clipRasterization(new $cursorClass());
			} else { 
				isBitmap(new $cursorClass());
			}
		}
		
		/**
		 * Процесс растеризации.
		 * 
		 * @param	$cursorClip	 MovieClip который будет растеризирован.
		 */
		private function clipRasterization($cursorClip:MovieClip):void {
			var rect:Rectangle;
			
			// Если внутри нашего MovieClip'a есть клип [bound_box].
			if ($cursorClip["bound_box"]) {
				var bound_box:Sprite = $cursorClip["bound_box"] as Sprite;
				rect = new Rectangle(bound_box.x, bound_box.y, bound_box.width, bound_box.height);
				bound_box.visible = false;
			} else {
				// Если [bound_box] нету, ведем расчет по наибольшему кадру
				rect = getFrameSize($cursorClip);
			}
			
			// Курсор может быть максимум 32x32 px.
			if (rect.width > 32 || rect.height > 32) {
				throw new Error("RemindCursorAnim/addCursorFromClip()/ " + name + " /  - Error: Icon only 32x32(px)");
				return;
			}
			
			// При пустой иконке курсора
			if (rect.width == 0 || rect.height == 0){
				throw new Error("RemindCursorAnim/addCursorFromClip()/ " + name + " /  - Error: Icon is empty");
				return;
			}
			
			// Растеризируем MovieClip
			var numFrames: int = $cursorClip.totalFrames;
			for (var i:int = 1; i < numFrames+1; i++) {
				$cursorClip.gotoAndStop(i);
				setFrame($cursorClip, i);
				var bitmapData:BitmapData = new BitmapData(Math.ceil(rect.width), rect.height, true, 0x000000);
				bitmapData.draw($cursorClip, new Matrix(1,0,0,1,-rect.x, -rect.y));
				data[data.length] = bitmapData;
			}
			//Регистрируем курсор
			registerCurrentCursor();
		}
		
		/**
		 * Создает из класса, отличного от MovieClip (embed image) вектор с BitmapData
		 * @param	$cursorClip		Экземпляр класса
		 */
		private function isBitmap($cursorClip:*):void 
		{
			var bitmapData:BitmapData = new BitmapData(32, 32, true, 0x000000);
				bitmapData.draw($cursorClip);
				data[data.length] = bitmapData;
			registerCurrentCursor();
		}
		
		/**
		 * Создает MouseCursorData для текущего курсора и регистрирует его.
		 * @param	cursorAnim	Специализированный класс анимации
		 */
		
		private function registerCurrentCursor():void {
			// Создаем data для курсора
			var mcd: MouseCursorData = new MouseCursorData();
			// В data передаем вектор состоящий из BitmapData
			mcd.data = this.data;
			
			// Точка нажатия курсора. Если параметр не задан - будет по умолчанию в xy(0,0)
			if (hotSpot != null) { 
				mcd.hotSpot = this.hotSpot; 
			}
			// Кол-во кадров в секунду текущего курсора. Если не задано - будет параметр по умолчанию.
			if (fps != NaN) {
				mcd.frameRate = this.fps; 
			}
			// Регистрируем наш курсор
			Mouse.registerCursor(this.name, mcd);
		}
		
		/**
		 * Возвращает Rectangle размеры наибольшего кадра из всех кадров в заданном MovieClip'e
		 * @param	$clip	Заданный MovieClip в котором необходимо найти кадр с максимальными размерами
		 * @return	Rectangle кадра с наибольшими размерами
		 */
		private function getFrameSize($clip:MovieClip):Rectangle {
			var minX:Number = 0;		var maxX: Number = 0;
			var minY: Number = 0;		var maxY: Number = 0;
			var boundBox:Rectangle;
			
			for (var i:int = 1; i < ($clip.totalFrames + 1); i++)
			{
				$clip.gotoAndStop(i);
				setFrame($clip, i);
				boundBox = $clip.getBounds($clip);
				
					minX = Math.min(minX, boundBox.topLeft.x);
					minY = Math.min(minY, boundBox.topLeft.y);
					maxX = Math.max(maxX, boundBox.bottomRight.x);
					maxY = Math.max(maxY, boundBox.bottomRight.y);
			}
			$clip.gotoAndStop(1);
			return new Rectangle(minX, minY, maxX - minX, maxY - minY);
		}
		
		/**
		 * Переключает заданный MovieClip (а также его детей) на указанный кадр
		 * @param	$clip			MovieClip который нужно установить на заданный кадр
		 * @param	$targetFrame	Номер кадра на который необходимо перейти
		 */
		private function setFrame($clip:MovieClip, $targetFrame:int):void {
			var numChild:int = $clip.numChildren;
			for (var i:int = 0; i < numChild; i++)
			{
				if ($clip.getChildAt(i) is MovieClip) {
					setFrame($clip.getChildAt(i) as MovieClip, $targetFrame);
					($clip.getChildAt(i) as MovieClip).gotoAndStop($targetFrame);
				}
			}
		}

	}

}