
import protobuf.ProtoHL;
import h2d.Tile;
import tinyvg.events.EventUtils;
class Main extends hxd.App {

	
	static function main() {
		// #if hl
		// hxd.res.Resource.LIVE_UPDATE = true;
		// hxd.Res.initLocal();
		// #else
		// hxd.Res.initEmbed();
		// #end
	 	new Main();
	}

	override function init() {
		super.init();

		var ws: WebSocketClient = new WebSocketClient();
		
	}
}