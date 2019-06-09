module uim.pwa.versions.obj;

import uim.pwa;

class DPWAVersion {
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
	@property auto database() { return versions.app.apps.store.database; };

	mixin(MyProperty!("DPWAVersion", "appVersion"));
	mixin(MyProperty!("DPWAManifest", "manifest"));

	mixin(MyProperty!("int", "id"));
	@property O id(this O)(string newId) { return this.id(to!int(newId)); };

	mixin(MyProperty!("long", "created"));
	@property O created(this O)(string newTime) { _created = to!long(newTime); return cast(O)this; };
	
	mixin(MyProperty!("long", "changed"));
	@property O changed(this O)(string newTime) { _changed = to!long(newTime); return cast(O)this; };

	mixin(MyProperty!("string", "title"));
	mixin(MyProperty!("string", "shortTitle"));
	mixin(MyProperty!("string", "description"));
	mixin(MyProperty!("string", "startUrl"));
	mixin(MyProperty!("string", "appScope"));
	mixin(MyProperty!("string", "display"));
	mixin(MyProperty!("string", "lang"));
	mixin(MyProperty!("string", "backgroundColor"));
	mixin(MyProperty!("string", "themeColor"));
	mixin(MyProperty!("string", "category"));
	mixin(MyProperty!("string[]", "keywords"));
	@property O keywords(this O)(string newKeywords) { 
		auto kws = newKeywords.split(",");
		_keywords = [];
		foreach(kw; kws) _keywords ~= kw.strip();
		return cast(O)this;
	}
	mixin(MyProperty!("bool", "preferRelatedApplications"));
	mixin(MyProperty!("string", "orientation"));
	mixin(MyProperty!("string", "dir")); // ...ltr or rtl
	mixin(MyProperty!("string", "image"));

	mixin(MyProperty!("DPWAIcon[]", "icons"));
	mixin(MyProperty!("DPWARelatedApplication[]", "relatedApplications"));

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
auto PWAVersion(DPWAVersions myVersions) { return new DPWAVersion(myVersions); }

