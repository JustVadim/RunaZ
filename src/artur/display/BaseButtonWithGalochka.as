package artur.display {
	public class BaseButtonWithGalochka extends BaseButton {
		private var gal:ButtonGalochka;
		private var galochkaX:Number;
		private var activeAfter:Boolean;
		
		public function BaseButtonWithGalochka(index:int,activeAfter:Boolean, galochkaX:Number = -60) {
			super(index);
			this.activeAfter = activeAfter;
			this.galochkaX = galochkaX;
		}
		
		public function addGalochka():void {
			if (gal == null) {
				this.setActive(this.activeAfter);
				gal = ButtonGalochka.getGalochka(this, this.galochkaX);
			}
		}
		
		public function removeGalochka():void {
			if (gal != null) {
				this.setActive(true);
				gal.frees();
				gal = null;
			}
		}
	}

}