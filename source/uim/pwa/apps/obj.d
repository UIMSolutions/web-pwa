module uim.pwa.apps.obj;

import vibe.vibe;
import uim.pwa;

template PropertyLink(string datatype, string name, string obj) {
	const char[] PropertyLink = `
	@property `~datatype~` `~name~`() { return `~obj~`.`~name~`; };
	@property O `~name~`(this O)(`~datatype~` newValue) { `~obj~`.`~name~` = newValue; return cast(O)this; };`;
}

class DPWAApp {
	this() {}
	this(DPWAApps myApps) {
		_apps = myApps;

		_id = randomUUID;
		_name = _id.toString;
		_versions = PWAVersions(this);
	}

	DPWAApps _apps;
	@property auto apps() { return _apps; };
	@property auto store() { return _apps.store; };
// 	@property auto database() { return _apps.store.database; };

	mixin(OProperty!("DPWAVersions", "versions"));
	DPWAVersion _lastVersion;
	auto lastVersion() { 
//		if (!_lastVersion) _lastVersion = versions.last; 
		return _lastVersion;
	}
	auto manifest() { if (lastVersion) return lastVersion.manifest; return null; }
	auto icons() { if (lastVersion) return lastVersion.icons; return null; }
	auto relatedApplications() { if (lastVersion) return lastVersion.relatedApplications; return null; }

	mixin(OProperty!("UUID", "id"));
	@property O id(this O)(string newId) { _id = UUID(newId); return cast(O)this; };

	mixin(OProperty!("string", "name"));
	mixin(OProperty!("string", "appType"));

	mixin(OProperty!("long", "created"));
	@property O created(this O)(string newTime) { _created = to!long(newTime); return cast(O)this; };

	mixin(OProperty!("long", "changed"));
	@property O changed(this O)(string newTime) { _changed = to!long(newTime); return cast(O)this; };

	mixin(OProperty!("UUID", "ownerId"));
	@property O ownerId(this O)(string newId) { _ownerId = UUID(newId); return cast(O)this; };

	// link to last version (if exists)
	int versionNo() { return lastVersion.id; };
	mixin(PropertyLink!("string", "title", "lastVersion"));
	mixin(PropertyLink!("string", "shortTitle", "lastVersion"));
	mixin(PropertyLink!("string", "description", "lastVersion"));
	mixin(PropertyLink!("string", "startUrl", "lastVersion"));
	mixin(PropertyLink!("string", "appScope", "lastVersion"));
	mixin(PropertyLink!("string", "display", "lastVersion"));
	mixin(PropertyLink!("string", "lang", "lastVersion"));
	mixin(PropertyLink!("string", "backgroundColor", "lastVersion"));
	mixin(PropertyLink!("string", "themeColor", "lastVersion"));
	mixin(PropertyLink!("string", "category", "lastVersion"));
	mixin(PropertyLink!("string[]", "keywords", "lastVersion"));
	mixin(PropertyLink!("bool", "preferRelatedApplications", "lastVersion"));
	mixin(PropertyLink!("string", "orientation", "lastVersion"));
	mixin(PropertyLink!("string", "dir", "lastVersion"));
	mixin(PropertyLink!("string", "image", "lastVersion"));
	mixin(PropertyLink!("DPWAIcon[]", "icons", "lastVersion"));
	mixin(PropertyLink!("DPWARelatedApplication[]", "relatedApplications", "lastVersion"));

	@property long versionCreated() { return lastVersion.created; };
	@property long versionChanged() { return lastVersion.changed; };

	@property auto parameters() {
		STRINGAA result;

		result["id"] = _id.toString;
		result["name"] = _name;
		result["apptype"] = _appType;		
		result["created"] = to!string(_created);
		result["changed"] = to!string(_changed);
		result["ownerid"] = _ownerId.toString;

		return result;
	}
	@property O parameters(this O)(STRINGAA newValues) {
		foreach(key, value; newValues) {
			switch(key.toLower) {
				case "id": id(value); break;
				case "name": name(value); break;
				case "apptype": appType(vaue); break;		
				case "created": created(value); break;
				case "changed": changed(value); break;
				case "ownerid": ownerId(value); break;
				default: break;
			}
		}
		return result;
	}

	O load(this O)() {
		foreach(row; database.query(SELECTFROMAPPS~WHEREID.format(id)~" ORDER BY versionno DESC LIMIT 1")) {
			name(row["name"]).created(row["created"]).changed(["changed"]).ownerID(row["ownerid"]).appType(row["apptype"]);
			_lastVersion = null; lastVersion;
		}
		return cast(O)this;
	}
	O create(this O)() {
		apps.create(this);
		return cast(O)this;
	}
	O save(this O)() {
		lastVersion.save;
		return cast(O)this;
	}
	O saveAsNewVersion(this O)() {
		versions.saveAsNewVersion;
		return cast(O)this;
	}
	O remove(this O)() {
		database.execute("DELETE FROM APPS"~WHEREID.format(id));
		return null;
	}
	void response(string path, STRINGAA parameters, HTTPServerResponse res) { 
		string filepath = "/home/ons/D/UIM18/PUBLIC/sites/uim/apps/"~name;
		writeln("FILEPATH~PATH: ", filepath~path);
		if ((path == "/") || (path == "")) path = "/html/index.html";
			auto appFilePath = filepath~path;
			if (!std.file.exists(filepath~path)) writeln(appFilePath, "\tmissing");
			if (std.file.exists(filepath~path)) writeln(appFilePath, "\texists");

			auto pathItems = path.split("/");
			writeln("PATHITEM[1] - ", pathItems[1]);
			switch(pathItems[1]) {
				case "css": 
					writeln("In css:\t", appFilePath);
					auto content = readText(appFilePath).replace("$appall", "app").replace("$apponly", "app/"~name);
					res.writeBody(content, "text/css");
					break;
				case "json": 
					auto content = readText(appFilePath).replace("$appall", "app").replace("$apponly", "app/"~name);
					res.writeBody(content, "application/json");
					break;
				case "js": 
					auto content = readText(appFilePath).replace("$appall", "app").replace("$apponly", "app/"~name);
					res.writeBody(content, "application/javascript");
					break;
				case "html": 
					auto content = readText(appFilePath).replace("$appall", "app").replace("$apponly", "app/"~name);
					res.writeBody(content, "text/html");
					break;
				default: switch(path.split(".")[$-1]) {
						case "css": 
							res.writeBody(std.file.readText(appFilePath), "text/css");
							break;
						case "js": 
							res.writeBody(std.file.readText(appFilePath), "application/javascript");
							break;
						case "ico": 
							res.writeBody(cast(const(ubyte)[])std.file.read(appFilePath), "image/x-icon");
							break;
						case "jpg": 
							res.writeBody(cast(const(ubyte)[])std.file.read(appFilePath), "image/jpeg");
							break;
						case "png": 
							res.writeBody(cast(const(ubyte)[])std.file.read(appFilePath), "image/png");
							break;
						default: 
							res.writeBody(std.file.readText(appFilePath), "text/html");
							break;
					}
					break;
			}
	}

	string work(string path) { return path; }
}
auto PWAApp() { return new DPWAApp(); }
auto PWAApp(DPWAApps myApps) { return new DPWAApp(myApps); }

unittest {

}