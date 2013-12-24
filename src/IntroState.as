package
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	
	public class IntroState extends FlxState
	{
		
	
		[Embed(source="assets/introScreen.png")]private var introPNG:Class;
 
		
		override public function create():void
		{
			super.create()
			var bg:FlxSprite= new FlxSprite(0,0,introPNG);
			this.add(bg);
			FlxG.flash(0xffff608c,0.5);
		}
		override public function update():void
		{
			super.update()
			if(FlxG.mouse.justReleased())
			{
				FlxG.fade(0xffff608c,0.5,onSwitch);
				
			}
		}
		private function onSwitch():void
		{
			
			FlxG.switchState(new GameState());
		}
	}
}