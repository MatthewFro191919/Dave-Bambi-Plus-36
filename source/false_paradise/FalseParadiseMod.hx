/**
 * @ Author: 4mbr0s3 2
 * @ Create Time: 2021-07-14 22:57:09
 * @ Modified by: 4mbr0s3 2
 * @ Modified time: 2021-12-26 20:57:43
 */

package false_paradise;

import states.FreeplayState.SongMetadata;
import flixel.FlxG;
import flixel.FlxSprite;
import schmovin.SchmovinInstance;

class FalseParadiseInstance
{
	public var optionDisableBGShader:Bool = false;
	public var bg:FlxSprite;
	public var stageFront:FlxSprite;
	public var stageCurtains:FlxSprite;

	private function new() {}

	public static function Create()
	{
		return new FalseParadiseInstance();
	}
}

class FalseParadiseMod
{
	var _inst:FalseParadiseInstance;
	var optionDisableBGShader:Bool = false;

	public static function GetAssetPath(s:String)
	{
		return 'mod:mod_assets/FalseParadiseMod/weeks/${s}';
	}

	override function addMissDamage(state:PlayState, causedByLateness:Bool):Float
	{
		return 0.04;
	}

	override function preCameras(state:PlayState)
	{
		_inst = FalseParadiseInstance.Create();
		_inst.optionDisableBGShader = optionDisableBGShader;
	}

	override function shouldRun():Bool
	{
		if (Type.getClass(FlxG.state) == PlayState)
		{
			return PlayState.curMod == this && PlayState.isModdedStage;
		}
		return false;
	}

	override function receiveCrossModCall(command:String, args:Array<Dynamic>)
	{
		if (PlayState.SONG.song == 'false-paradise' && shouldRun())
		{
			switch (command)
			{
				case 'SchmovinSetClient':
					var instance:SchmovinInstance = cast args[0];
					var cli = new FalseParadiseSchmovinClient(instance, args[1], args[2], _inst);
					instance.setClient(cli);
					sendCrossModCall('SchmovinPrepareDebug', [cli]);
			}
		}
	}

	override function setupStage(state:PlayState, stageName:String)
	{
		state.defaultCamZoom = 0.9;
		_inst.bg = new FlxSprite(-600, -200).loadGraphic(Paths.image('stageback'));
		_inst.bg.antialiasing = true;
		_inst.bg.scrollFactor.set(0.9, 0.9);
		_inst.bg.active = false;
		state.add(_inst.bg);

		_inst.stageFront = new FlxSprite(-650, 600).loadGraphic(Paths.image('stagefront'));
		_inst.stageFront.setGraphicSize(Std.int(_inst.stageFront.width * 1.1));
		_inst.stageFront.updateHitbox();
		_inst.stageFront.antialiasing = true;
		_inst.stageFront.scrollFactor.set(0.9, 0.9);
		_inst.stageFront.active = false;
		state.add(_inst.stageFront);

		_inst.stageCurtains = new FlxSprite(-500, -300).loadGraphic(Paths.image('stagecurtains'));
		_inst.stageCurtains.setGraphicSize(Std.int(_inst.stageCurtains.width * 0.9));
		_inst.stageCurtains.updateHitbox();
		_inst.stageCurtains.antialiasing = true;
		_inst.stageCurtains.scrollFactor.set(1.3, 1.3);
		_inst.stageCurtains.active = false;

		state.add(_inst.stageCurtains);
	}

	override function addToFreeplay(addWeek:(Array<String>, String, Array<String>) -> Void, weekNum:Int)
	{
		var menu = cast(FlxG.state, FreeplayState);
		// menu.songs = [new SongMetadata('tutorial', 1, 'gf')];
		addWeek(['false-paradise'], 'false-paradise', ['dad']);
	}
}
