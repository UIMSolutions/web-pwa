module uim.pwa.stores.obj;

import uim.pwa;

class DPWAStore {
	this() {}
/*	this(Database database) { 
		_database = database;
		_apps = PWAApps(this);
	}
	mixin(OProperty!("Database", "database"));*/
	mixin(OProperty!("DPWAApps", "apps"));
}
auto PWAStore() { return new DPWAStore(); } 
//auto PWAStore(Database myDatabase) { return new DPWAStore(myDatabase); } 

unittest {
/*	auto store = PWAStore(new Database("sqlite:///home/ons/D/UIM18/DATABASES/apps.db"));

	auto name = "uim.travel";
	if (store.apps.has(name)) writeln("app "~name~" exists"); else writeln("app "~name~" missing");

	if (!store.apps.has(name)) {
		auto app = PWAApp(store.apps).name(name).create;
		app.title("UIM Fahrtenbuch").shortTitle("Fahrten").save;
	}
	auto app = store.apps[name];
	writeln(app.id, "\t", app.name, "\t", app.lastVersion.id);

	app.saveAsNewVersion;
	app = store.apps[name];
	writeln(app.id, "\t", app.name, "\t", app.lastVersion.id	);

//	app.versions[2].remove;
//	app.remove;
//	if (!store.apps.has(name)) writeln("app uim.tax2018 deleted");
*/
}
