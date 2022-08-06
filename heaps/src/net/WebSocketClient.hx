package net;

import haxe.net.WebSocket;
import protobuf.ProtoHL;

class WebSocketClient {
    
    private static var _instance: WebSocketClient = null;
    public static function getInstance(): WebSocketClient {
        if(_instance == null) {
            _instance = new WebSocketClient();
        }
        return _instance;
    }
    public function new() {

        var ws = WebSocket.create("ws://127.0.0.1/", null, false);
        trace("create ws");
        var helloPb: ProtoHL;
        ws.onopen = function() {
            trace('open!');
            helloPb = new ProtoHL('zhangsan', 26);
  
            var str: String = @:privateAccess String.fromUTF8(helloPb.helloworldEncode);
        
            ws.sendString(str);

        };
        ws.onmessageString = function(message: String) {
            trace('From server!' + message);
        };

        ws.onmessageBytes = function(msg: haxe.io.Bytes) {
            var bytes: hl.Bytes = hl.Bytes.fromBytes(msg);
            helloPb.decodeData(bytes);
        }

        #if sys
        while (true) {
            ws.process();
            Sys.sleep(0.1);
        }
        #end
    }
    
    function onOpen() {
        trace("ws open");
    }

    function onClose() {
        trace("ws close");
    }

    function onMessage(): Void{
  
    }

    function onError(error): Void{
        trace("error: ", error);
    }
    
}
