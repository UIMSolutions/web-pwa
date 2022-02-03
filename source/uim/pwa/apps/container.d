module uim.pwa.apps.container;

import uim.pwa;

class DPWAApps {
	this() {}
	this(DPWAStore myStore) { 
		_store = myStore; 
	}
	
	protected DPWAStore _store;
	@property auto store() { return _store; };
/*	@property auto database() { return _store.database; };

	auto readRow(DPWAApp app, Row row) {
		return app.id(row["id"]).name(row["name"]).created(row["created"]).changed(row["changed"]).ownerId(row["ownerid"]);
	}

	bool has(UUID id) {
		string where = WHEREID.format(id);
		foreach(approw; database.query(SELECTFROMAPPS~where~" LIMIT 1")) return true;
		return false;
	}
	bool has(string name) {
		string where = WHERENAME.format(name);
		foreach(approw; database.query(SELECTFROMAPPS~where~" LIMIT 1")) return true;
		return false;
	}

	auto opIndex(UUID id) {
		string where = WHEREID.format(id);
		
		foreach(row; database.query(SELECTFROMAPPS~where~" LIMIT 1")) return readRow(PWAApp(this), row);
		return null;
	} 
	auto opIndex(string name) {
		string where = WHERENAME.format(name);
		
		foreach(row; database.query(SELECTFROMAPPS~where~" LIMIT 1")) return readRow(PWAApp(this), row);
		return null;
	}		
	DPWAApp[] all() {
		DPWAApp[] results;
		foreach(row; database.query("SELECT DISTINCT(id) FROM apps")) results ~= this[UUID(row[0])];
		return results;
	}
	DPWAApp[] byCategory(string category) {
		DPWAApp[] results;
		foreach(row; database.query(SELECTFROMAPPS~" WHERE (category = '%s')".format(category))) {
			results ~= readRow(PWAApp(this), row);
		}
		return results;
	}
	DPWAApp[] byKeywords(string[] keywords) {
		string[] kws;
		foreach(kw; keywords) kws ~= "(keywords like '%s')".format(kw);
		DPWAApp[] results;
		foreach(row; database.query(SELECTFROMAPPS~" WHERE "~kws.join(" OR "))) {
			results ~= readRow(PWAApp(this), row);
		}
		return results;
	}
	DPWAApp[] byOwner(string ownerId) {
		DPWAApp[] results;
		foreach(row; database.query(SELECTFROMAPPS~" WHERE (ownerid = '%s')".format(ownerId))) {
			results ~= readRow(PWAApp(this), row);
		}
		return results;
	}
	O create(this O)(DPWAApp anApp) {
		if (anApp) {
			auto ts = now.stdTime;
			string[] keys;
			string[] values;
			// from App
			keys ~= "id"; values ~= "'%s'".format(anApp.id);
			keys ~= "name"; values ~= "'%s'".format(anApp.name);
			keys ~= "apptype"; values ~= "'%s'".format(anApp.appType);
			keys ~= "ownerid"; values ~= "'%s'".format(anApp.ownerId);
			keys ~= "created"; values ~= "%s".format(ts);
			keys ~= "changed"; values ~= "%s".format(ts);
			keys ~= "versioncreated"; values ~= "%s".format(ts);
			keys ~= "versionchanged"; values ~= "%s".format(ts);

			database.execute("INSERT INTO apps (%s) VALUES(%s)".format(keys.join(","), values.join(",")));		
		}
		return cast(O)this;
	}
	O remove(this O)(UUID id) {
		string where = WHEREID.format(id);

		_database.execute("DELETE FROM apps"~where);
		return cast(O)this;
	}
	O remove(this O)(string appName) {
		string where = WHERENAME.format(appName);

		_database.execute("DELETE FROM apps"~where);
		return cast(O)this;
	}
*/
}
auto PWAApps() { return new DPWAApps(); }
// auto PWAApps(DPWAStore myStore) { return new DPWAApps(myStore); }

unittest {
	
}