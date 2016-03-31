package artur.display {
	public class BaseButtonWithGalochka extends BaseButton {
		private var gal:ButtonGalochka;
		private var galochkaX:Number;
		
		public function BaseButtonWithGalochka(index:int, galochkaX:Number = -60) {
			super(index);
			this.galochkaX = galochkaX;
		}
		
		public function addGalochka():void {
			if(gal == null) {
				this.setActive(false);
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