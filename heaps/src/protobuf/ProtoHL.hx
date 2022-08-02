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



private typedef HLEncodeChar = hl.Abstract<"encode_char">;


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
    static var helloworldEncode: hl.Bytes;
    public function new(name : HString, id : Int) {
        trace("name:", name, "id:", id);
		helloworldEncode = ProtoBuf.helloworldEn(name, id);
        trace("encode:", helloworldEncode);
	}

    public static function decode() {
        var r:{str:Null<hl.Bytes>, id:Int} = ProtoBuf.helloworldDe(helloworldEncode);
		//var ret: HelloResult = {str : r.str, id : r.id};
        trace("decode:", r);
        trace("id:", r.id);
        trace("str: utf",@:privateAccess String.fromUTF8(r.str));
       
        trace("str:",r.str);
        trace("str: UC",@:privateAccess String.fromUCS2(r.str));
    }
}
#end