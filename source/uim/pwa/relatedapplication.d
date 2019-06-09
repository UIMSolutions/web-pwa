﻿module uim.pwa.relatedapplication;

import uim.pwa;

class DPWARelatedApplication { 
	this() {}
	this(DPWAApp myApp) {
		this();
		_app = myApp;
	}
	
	mixin(MyProperty!("DPWAApp", "app"));

	mixin(MyProperty!("string", "platform"));
	mixin(MyProperty!("string", "url"));
	mixin(MyProperty!("string", "id"));

	@property auto parameters() {
		string[string] result;
		
		result["platform"] = platform;
		result["url"] = url;
		result["id"] = id;
		
		return result;
	}
	@property O parameters(this O)(string[string] newValues) {
		foreach(key, value; newValues) {
			switch(key.toLower) {
				case "platform": platform(value); break;
				case "url": url(value); break;
				case "id": id(value); break;
				default: break;
			}
		}
		return result;
	}

	string toJson() {
		string[] results;
		
		if (platform) results ~= `"platform": "%s"`.format(platform);
		if (url) results ~= `"url": "%s"`.format(url);
		if (id) results ~= `"id": "%s"`.format(id);
		
		return "{ " ~ results.join("; ") ~ " }";
	}
}
auto PWARelatedApplication() { new DPWARelatedApplication; }
auto PWARelatedApplication(DPWAApp myApp) { new DPWARelatedApplication(myApp); }

unittest {

}