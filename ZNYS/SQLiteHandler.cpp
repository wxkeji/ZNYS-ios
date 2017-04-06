

//
//  SQLiteHandler.cpp
//  ZNYS
//
//  Created by 张恒铭 on 1/30/17.
//  Copyright © 2017 Woodseen. All rights reserved.
//

#include "SQLiteHandler.hpp"
#include <sqlite3.h>


bool sqliteHandler::initDataBase(const char* DBPath) {
    if (sqlite3_open_v2(DBPath, &db, SQLITE_OPEN_READONLY, NULL) != SQLITE_OK)
    {
        sqlite3_close(db);
        return false;
    }
    return true;
}

bool sqliteHandler::initTables() {
    if (NULL == db) {
        return false;
    }
    sqlite3_stmt *statement;
    string createTableStatment = "IF EXIST (SELECT * FROM SYSOBJECTS WHERE NAME = 'TABLENAME' AND TYPE = 'U')";
    if ( sqlite3_prepare_v2(db, createTableStatment.c_str(), -1, &statement, NULL) == SQLITE_OK ) {
        //todo
    } else {
        
    }
    return true;
}
