package
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import net.hires.debug.Stats;
	
	import org.flixel.FlxG;
	import org.flixel.FlxGame;
	
    [SWF(width="320", height="480" , backgroundColor="#930303")]
	 
	public class QQ_game extends FlxGame
	{
		
		public function QQ_game()
		{
	/*	var s:Shape = new Shape()
			s.graphics.beginFill(0x000000)
			s.graphics.drawRect( -340,-260,1000,1000)
			s.graphics.endFill()
			this.addChild(s);*/
			super(320,480,MainState);
			FlxG.mobile = true
			FlxG.debug = false
			FlxG.mouse.hide()
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
		}
		
		override protected function create(flashEvent:Event):void
		{

			super.create(flashEvent)
			stage.scaleMode = StageScaleMode.EXACT_FIT;
		}
		
	}
}


