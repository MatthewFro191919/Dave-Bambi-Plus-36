package false_paradise;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import groovin.StateConstants;
import groovin.menu.main_menu.GroovinMainMenuState;

class FalseParadiseShoutoutsState extends FlxTransitionableState
{
	override function create()
	{
		var credits = new FlxSprite().loadGraphic('mod:mod_assets/FalseParadiseMod/preload/weeks/credits.png');
		credits.antialiasing = true;
		add(credits);
		StateConstants.MAIN_MENU_STATE = GroovinMainMenuState;
		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		if (PlayerSettings.player1.controls.ACCEPT)
			FlxG.switchState(MainMenuState.Create());
	}
}
