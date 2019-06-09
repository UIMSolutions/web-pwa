module uim.pwa;

public import std.uuid;
public import d2sqlite3;


public import uim.core;
public import uim.sql;
public import uim.sqlite;

public import uim.pwa.icon;
public import uim.pwa.manifest;
public import uim.pwa.relatedapplication;
public import uim.pwa.serviceworker;
public import uim.pwa.stores;
public import uim.pwa.apps;
public import uim.pwa.versions;

enum APPATTRIBUTES = "id, name, versionno, title, shorttitle, created, changed, ownerid, category, keywords, image, description, versioncreated, versionchanged, apptype, starturl, backgroundcolor, themecolor, display, orientation, dir, lang, scope, preferrelatedapplications";
enum SELECTFROMAPPS = "SELECT "~APPATTRIBUTES~" FROM apps";
enum WHEREID = " WHERE (id = '%s')";
enum WHERENAME = " WHERE (name = '%s')";
enum ANDVERSION = " AND (versionno = %s)";
