module uim.pwa.manifest;

import uim.pwa;

class DPWAManifest {
	this() {}
	this(DPWAVersion myVersion) { 
		this();
		_version = myVersion;
	}
	protected DPWAVersion _version;
	@property auto appVersion() { return _version; };
	@property auto versions() { return appVersion.versions; };
	@property auto app() { return versions.app; };
	@property auto apps() { return app.apps; };
	@property auto store() { return apps.store; };

	@property auto name() { return _version.title; };
	@property auto shortName() { return _version.shortTitle; };
	@property auto description() { return _version.description; };
	@property auto startUrl() { return _version.startUrl; };
	@property auto appScope() { return _version.appScope; }; // scope
	@property auto display() { return _version.display; };  // fullscreen, standalone, minimal-ui, browser
	@property auto backgroundColor() { return _version.backgroundColor; }; // background_color
	@property auto lang() { return _version.lang; };
	@property auto themeColor() { return _version.themeColor; };  // theme_color
	@property auto preferRelatedApplications() { return _version.preferRelatedApplications; };
	@property auto orientation() { return _version.orientation; };  // any, natural, landscape, landscape-primary, landscape-secondary, portrait, portrait-primary, portrait-secondary
	@property auto dir() { return _version.dir; }; // ...ltr or rtl

	@property auto icons() { return _version.icons; };
	@property auto relatedApplications() { return _version.relatedApplications; };

	O add(this O)(DPWAIcon addIcon) {
		icons ~= addIcon;
		if (_app) _app.icons = icons;
		return cast(O)this;
	}
	O add(this O)(DPWARelatedApplication addApplication) {
		relatedApplications ~= addApplication;
		if (_app) _app.relatedApplications = relatedApplications;
		return cast(O)this;
	}

	@property auto parameters() {
		STRINGAA result;
		
		if (name) result["name"] = name;
		if (shortName) result["shortname"] = shortName;
		if (startUrl) result["starturl"] = startUrl;
		if (appScope) result["scope"] = appScope;
		if (display) result["display"] = display;
		if (backgroundColor) result["backgroundcolor"] = backgroundColor;
		if (description) result["description"] = description;
		if (lang) result["lang"] = lang;
		if (themeColor) result["themecolor"] = themeColor;
		if (preferRelatedApplications) result["preferrelatedapplications"] = (preferRelatedApplications) ? "true" : "false";
		if (orientation) result["orientation"] = orientation;
		if (dir) result["dir"] = dir;

		return result;
	}
	@property O parameters(this O)(STRINGAA newValues) {
		foreach(key, value; newValues) {
			switch(key.toLower) {
				case "name": name(value); break;
				case "short-name": 
				case "shortname": shortName(value); break;
				case "start-url": 
				case "starturl": startUrl(value); break;
				case "appscope": 
				case "scope": appScope(value); break;
				case "display": display(value); break;
				case "background-color": 
				case "backgroundcolor": backgroundColor(value); break;
				case "description": description(value); break;
				case "lang": lang(value); break;
				case "theme-color":
				case "themecolor": themeColor(value); break;
				case "prefer-related-applications": 
				case "preferrelatedapplications": preferRelatedApplications(value); break;
				case "orientation": orientation(value); break;
				case "dir": dir(value); break;
				default: break;
			}
		}
		return result;
	}

	string toJson() {
		string[] results;

		if (name) results ~= `"name": "%s"`.format(name);
		if (shortName) results ~= `"short_name": "%s"`.format(shortName);
		if (startUrl) results ~= `"start_url": "%s"`.format(startUrl);
		if (appScope) results ~= `"scope": "%s"`.format(appScope);
		if (display) results ~= `"display": "%s"`.format(display);
		if (backgroundColor) results ~= `"background_color": "%s"`.format(backgroundColor);
		if (description) results ~= `"description": "%s"`.format(description);
		if (lang) results ~= `"lang": "%s"`.format(lang);
		if (themeColor) results ~= `"theme_color": "%s"`.format(themeColor);
		if (preferRelatedApplications) results ~= `"prefer_related_applications": true`;
		else results ~= `"prefer_related_applications": false`;
		if (orientation) results ~= `"orientation": "%s"`.format(orientation);
		if (dir) results ~= `"dir": "%s"`.format(dir);

		if (icons) {
			string[] iconsToJson;
			foreach(icon; icons) iconsToJson ~= icon.toJson;
			if (iconsToJson) results ~= `"icons": [%s]`.format(iconsToJson.join(","));  
		}
		if (relatedApplications) {
			string[] relAppsToJson;
			foreach(relApp; relatedApplications) relAppsToJson ~= relApp.toJson;
			if (relAppsToJson) results ~= `"related_applications": [%s]`.format(relAppsToJson.join(","));  
		}

		return "{ " ~ results.join("; ") ~ " }";
	}
}
auto PWAManifest() { return new DPWAManifest; }

unittest {
	
}