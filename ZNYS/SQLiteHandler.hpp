//
//  SQLiteHandler.hpp
//  ZNYS
//
//  Created by 张恒铭 on 1/30/17.
//  Copyright © 2017 Woodseen. All rights reserved.
//

#ifndef SQLiteHandler_hpp
#define SQLiteHandler_hpp


#include <stdio.h>
#include <string>
#include <vector>
#include <sqlite3.h>
using namespace std;

namespace sqliteHandler {
    sqlite3 *db;
    bool initDataBase(const char* databasePath);
    bool initTables();
}


#endif /* SQLiteHandler_hpp */
