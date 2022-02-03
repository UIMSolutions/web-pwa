module uim.pwa.versions.obj;

import uim.pwa;

class DPWAVersion {
	this() {} 
	this(DPWAVersions myVersions) { 
		_id = 1;
		_versions = myVersions; 
		_manifest = PWAManifest;
		_icons = [];
		_relatedApplications = [];
	}

	protected DPWAVersions _versions;
	@property auto versions() { return _versions; };
	@property auto app() { return versions.app; };
	@property auto apps() { return versions.app.apps; };
	@property auto store() { return versions.app.apps.store; };

	mixin(OProperty!("DPWAVersion", "appVersion"));
	mixin(OProperty!("DPWAManifest", "manifest"));

	mixin(OProperty!("int", "id"));
	@property O id(this O)(string newId) { return this.id(to!int(newId)); };

	mixin(OProperty!("long", "created"));
	@property O created(this O)(string newTime) { _created = to!long(newTime); return cast(O)this; };
	
	mixin(OProperty!("long", "changed"));
	@property O changed(this O)(string newTime) { _changed = to!long(newTime); return cast(O)this; };

	mixin(OProperty!("string", "title"));
	mixin(OProperty!("string", "shortTitle"));
	mixin(OProperty!("string", "description"));
	mixin(OProperty!("string", "startUrl"));
	mixin(OProperty!("string", "appScope"));
	mixin(OProperty!("string", "display"));
	mixin(OProperty!("string", "lang"));
	mixin(OProperty!("string", "backgroundColor"));
	mixin(OProperty!("string", "themeColor"));
	mixin(OProperty!("string", "category"));
	mixin(OProperty!("string[]", "keywords"));
	@property O keywords(this O)(string newKeywords) { 
		auto kws = newKeywords.split(",");
		_keywords = [];
		foreach(kw; kws) _keywords ~= kw.strip();
		return cast(O)this;
	}
	mixin(OProperty!("bool", "preferRelatedApplications"));
	mixin(OProperty!("string", "orientation"));
	mixin(OProperty!("string", "dir")); // ...ltr or rtl
	mixin(OProperty!("string", "image"));

	mixin(OProperty!("DPWAIcon[]", "icons"));
	mixin(OProperty!("DPWARelatedApplication[]", "relatedApplications"));

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
	
	O save(this O)() {
		auto ts = now.stdTime;
		string[] sets;
		// from App	
		sets ~= "changed=%s".format(ts);
		// from Version
		sets ~= "versionno=%s".format(id);
		sets ~= "versionchanged=%s".format(ts);
		if (title) sets ~= "title='%s'".format(title);
		if (shortTitle) sets ~= "shorttitle='%s'".format(shortTitle);
		if (startUrl) sets ~= "starturl='%s'".format(startUrl);
		if (appScope) sets ~= "scope='%s'".format(appScope);
		if (display) sets ~= "display='%s'".format(display);
		if (backgroundColor) sets ~= "backgroundcolor='%s'".format(backgroundColor);
		if (description) sets ~= "description='%s'".format(description);
		if (lang) sets ~= "lang='%s'".format(lang);
		if (themeColor) sets ~= "themecolor='%s'".format(themeColor);
		if (preferRelatedApplications) sets ~= "preferrelatedapplications='%s'".format((preferRelatedApplications) ? "true" : "false");
		if (orientation) sets ~= "orientation='%s'".format(orientation);
		if (dir) sets ~= "dir='%s'".format(dir);

		database.execute("UPDATE apps SET %s %s".format(sets.join(","), WHEREID.format(app.id)~ANDVERSION.format(id)));		
		return cast(O)this;
	}
	O remove(this O)() {
		database.execute("DELETE FROM APPS"~WHEREID.format(app.id)~ANDVERSION.format(id));
		return null;
	}
}
auto PWAVersion() { return new DPWAVersion(); }
auto PWAVersion(DPWAVersions myVersions) { return new DPWAVersion(myVersions); }

