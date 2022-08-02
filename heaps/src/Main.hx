
import protobuf.ProtoHL;

import haxe.io.Bytes;

class Main extends hxd.App {

	
	static function main() {
	 	new Main();
	}

	override function init() {
		super.init();
		#if hl
		var helloPb: ProtoHL = new ProtoHL('zhangsan', 26);
		ProtoHL.decode();
		#end
	}
}
