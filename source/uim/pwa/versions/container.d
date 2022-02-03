module uim.pwa.versions.container;

import uim.pwa;

class DPWAVersions {
	this() {}
	this(DPWAApp myApp) {
		_app = myApp;
	}
	protected DPWAApp _app;
	@property auto app() { return _app; };
	@property auto apps() { return app.apps; };
	@property auto store() { return app.apps.store; };

/*	bool has(int id) {
		string where = WHEREID.format(app.id)~ANDVERSION.format(id);
		foreach(row; database.query(SELECTFROMAPPS~where~" LIMIT 1")) return true;
		return false;
	}
	DPWAVersion opIndex(int versionNo) {
		if (versionNo == 0) return null;

		string where = WHEREID.format(app.id)~ANDVERSION.format(versionNo);
		foreach(row; database.query(SELECTFROMAPPS~where~" LIMIT 1")) 
			return PWAVersion(this)
				.id(row["versionno"]).created(row["versioncreated"])
				.changed(row["versionchanged"])
				.title(row["title"]).shortTitle(row["shorttitle"])
				.image(row["image"]).category(row["category"]).keywords(row["keywords"]).description(row["description"]);
		return null;
	}
	DPWAVersion last() { return this[maxVersionNo]; }

	int maxVersionNo() {
		foreach(row; database.query("SELECT MAX(versionno) FROM apps"~WHEREID.format(app.id))) return to!int(row[0]);
		return 0;
	}
	O create(this O)(DPWAVersion newVersion) {
		if (!newVersion) return cast(O)this;

		auto ts = now.stdTime;
		string[] keys;
		string[] values;
		// from App
		keys ~= "id"; values ~= "'%s'".format(app.id);
		keys ~= "name"; values ~= "'%s'".format(app.name);
		keys ~= "apptype"; values ~= "'%s'".format(app.appType);
		keys ~= "ownerid"; values ~= "'%s'".format(app.ownerId);
		keys ~= "created"; values ~= "%s".format(app.created);
		keys ~= "changed"; values ~= "%s".format(ts);

		// from Version
		keys ~= "versionno"; values ~= "%s".format(newVersion.id);
		keys ~= "versioncreated"; values ~= "%s".format(ts);
		keys ~= "versionchanged"; values ~= "%s".format(ts);
		keys ~= "title"; values ~= "'%s'".format(newVersion.title);
		keys ~= "shorttitle"; values ~= "'%s'".format(newVersion.shortTitle);
		keys ~= "starturl"; values ~= "'%s'".format(newVersion.startUrl);
		keys ~= "scope"; values ~= "'%s'".format(newVersion.appScope);
		keys ~= "display"; values ~= "'%s'".format(newVersion.display);
		keys ~= "backgroundcolor"; values ~= "'%s'".format(newVersion.backgroundColor);
		keys ~= "description"; values ~= "'%s'".format(newVersion.description);
		keys ~= "lang"; values ~= "'%s'".format(newVersion.lang);
		keys ~= "themecolor"; values ~= "'%s'".format(newVersion.themeColor);
		keys ~= "preferrelatedapplications"; values ~= "'%s'".format((newVersion.preferRelatedApplications) ? "true" : "false");
		keys ~= "orientation"; values ~= "'%s'".format(newVersion.orientation);
		keys ~= "dir"; values ~= "'%s'".format(newVersion.dir);
		
		database.execute("INSERT INTO apps (%s) VALUES(%s)".format(keys.join(","), values.join(",")));		

		return cast(O)this;
	}
	O saveAsNewVersion(this O)() {
		auto ver = last;
		ver.id = ver.id+1;

		create(ver);
		return cast(O)this;
	}
	O remove(this O)(int appVersion) {
		string where = WHEREID.format(app.id)~ANDVERSION.format(appVersion);		
		
		_database.execute("DELETE FROM apps"~where);
		return cast(O)this;
	}
	O remove(this O)(int appVersion) {
		string where = WHERENAME.format(app.name)~ANDVERSION.format(appVersion);
		
		_database.execute("DELETE FROM apps"~where);
		return cast(O)this;
	}
	*/
}
auto PWAVersions() { return new DPWAVersions(); }
auto PWAVersions(DPWAApp myApp) { return new DPWAVersions(myApp); }
