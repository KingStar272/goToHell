package
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	
	public class MainState extends FlxState
	{
		[Embed(source="assets/mainScreen.png")]private var mainScreenPNG:Class;
		public function MainState()
		{
			super();
		}
		
		override public function create():void
		{
			FlxG.flash(0xffff608c,0.5);
			super.create()
			
			var bg:FlxSprite= new FlxSprite(0,0,mainScreenPNG);
			this.add(bg);
			
			
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
			FlxG.switchState(new IntroState());
		}
		
	}
}