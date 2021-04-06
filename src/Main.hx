package;

import js.Browser.document;

class Main {
	static function main() {
		haxe.Log.trace = log;

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
