package;

import js.Browser.document;
import js.mix.External;

class Main {
	static function main() {
		haxe.Log.trace = log;

		if (External.available) {
			External.misc.setTitle("demo");
		}

		trace("try haxe");
	}

	static function log(v:Dynamic, ?infos:haxe.PosInfos) {
		var id = "haxe_log";
		var node = document.querySelector("#" + id);
		if (node == null) {
			node = document.createElement("div");
			node.setAttribute("id", id);
			document.body.appendChild(node);
		}
		node.appendChild( document.createTextNode( haxe.Log.formatOutput(v, infos) + "\n") );
	}
}