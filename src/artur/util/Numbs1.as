package artur.util
{
	
	public class Numbs1 
	{
		
		dynamic public function Numbs1() 
		{
			
		}
		//Находится ли Num в диапазоне lRange..uRange
        static public function inRange(Num:Number,lRange:Number,uRange:Number):Boolean
	    {
	     return ((Num > lRange) && (Num < uRange));
	    }
		static public function inRange2(Num:Number,lRange:Number,uRange:Number):Boolean
	    {
	     return ((Num >= lRange) && (Num <= uRange));
	    }
 
	      //получить ближайшие число к arg - Val1 или Val2
         static public function getClosest(arg:Number,Val1:Number,Val2:Number):Number
	    {
		if(Math.abs(arg - Val1)< Math.abs(arg - Val2)) return Val1;
		return Val2;
	    }
 
         //Получить случайное число из диапазона clow..chigh
	     static public function Random(clow:Number, chigh:Number):Number
	    {
	       return Math.round(Math.random() * (chigh - clow)) + clow;
	    }
 
	    //Получить целое случайное число из диапазона clow..chigh
		static public function RandomInt(minNum:int, maxNum:int):int
	    {
	       return (int(Math.random() * (maxNum - minNum + 1)) + minNum);
	    }
		
	}
	
}