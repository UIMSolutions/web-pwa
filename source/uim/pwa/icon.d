module uim.pwa.icon;

import uim.pwa;

class DPWAIcon {
	this() {}
	this(DPWAApp myApp) {
		this();
		_app = myApp;
	}

	mixin(OProperty!("DPWAApp", "app"));

	mixin(OProperty!("string", "src"));
	mixin(OProperty!("string", "type"));
	mixin(OProperty!("string", "sizes"));

	@property auto parameters() {
		string[string] result;
		
		result["src"] = src;
		result["type"] = type;
		result["sizes"] = sizes;

		return result;
	}
	@property O parameters(this O)(string[string] newValues) {
		foreach(key, value; newValues) {
			switch(key.toLower) {
				case "src": src(value); break;
				case "type": type(value); break;
				case "sizes": sizes(value); break;
				default: break;
			}
		}
		return result;
	}

	string toJson() {
		string[] results;
		
		if (src) results ~= `"src": "%s"`.format(src);
		if (type) results ~= `"type": "%s"`.format(type);
		if (sizes) results ~= `"sizes": "%s"`.format(sizes);

		return "{ " ~ results.join("; ") ~ " }";
	}
}
auto PWAIcon() { return new DPWAIcon; }
auto PWAIcon(DPWAApp myApp) { return new DPWAIcon(myApp); }

unittest {

}