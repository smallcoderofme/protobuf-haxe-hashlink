package protobuf;

abstract Dyn<T>(Dynamic) from T to T {}


#if hl

@:access(String)
@:forward
abstract HString(String) from String to String {
	@:from static public inline function fromBytes(b:hl.Bytes):HString
		return switch b {
					case null: null;
					default: String.fromUCS2(b);
			}
	
	@:to public inline function toBytes():hl.Bytes
		return switch this {
					case null: null;
					default: this.bytes;
			}
}


typedef HelloResult= {
    var str: HString;
    var id: Int;
}


@:hlNative("protobuf_hl")
private class ProtoBuf {
    public static function helloworldEn(str: String, id: Int): hl.Bytes {
        return null;
    }
    public static function helloworldDe(bytes: hl.Bytes): Dyn<{str:hl.Bytes, id:Int}> {
        return null;
    }
}

class ProtoHL {
	static var encode_char:Dyn<{str:hl.Bytes, id:Int}>;
    public var helloworldEncode: hl.Bytes;
    public function new(name : HString, id : Int) {
        trace("name:", name, "id:", id);
		helloworldEncode = ProtoBuf.helloworldEn(name, id);
        trace("encode:", helloworldEncode);
	}

    public function decode() {
        var r:{str:Null<hl.Bytes>, id:Int} = ProtoBuf.helloworldDe(helloworldEncode);
        trace("decode:", r);
        trace(r.str);
        trace(r.id);
    }
    public function decodeData(data: hl.Bytes) {
        var r:{str:Null<hl.Bytes>, id:Int} = ProtoBuf.helloworldDe(data);
        // var retUCSStr: String = @:privateAccess String.fromUCS2(r.str);
        // trace(retUCSStr);
        trace("decode data:", r);
        trace(r.str);
        trace(r.id);
    }
}
#end