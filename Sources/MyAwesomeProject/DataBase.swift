//
//  DataBase.swift
//  MyAwesomeProject
//
//  Created by zhangpenghui on 2018/12/29.
//

import PerfectHTTP
import PerfectHTTPServer
import PerfectLib
import PerfectMySQL

class DataBase {
    
    let SQLHost = "39.96.82.100"
    let SQLUser = "root"
    let SQLPassword = "12345678"
    let SQLDB = "blog"
    
    var mysql : MySQL
    
    internal init() {
        
        mysql = MySQL()
        
        guard connectedDataBase() else {
            
            return
        }
    }
    
    //MARK:开启连接
    private func connectedDataBase() -> Bool {
        
        let connected = mysql.connect(host: SQLHost, user: SQLUser, password: SQLPassword, db: SQLDB)
        guard connected else {
            
            print("MySQL连接失败" + mysql.errorMessage())
            return false
        }
        
        print("MySQL连接成功")
        return true
    }
    
    //查 results不是bi必须返回的
    func selectDataBaseWhere(tableName: String, keyWords: [String], keyValue: String?) -> (success: Bool, mysqlResult: MySQL.Results?, errorMsg: String) {
        
        var SQLString = "select "
        
        for key in keyWords {
            SQLString.append("\(key) ,")
        }
        
        SQLString.removeLast()
        
        SQLString.append("from \(tableName)")
        
        SQLString.append(" order by id desc")//倒序
        
        //没有查到库
        guard mysql.selectDatabase(named: SQLDB) else {
            let msg = "no \(SQLDB) Database"
            print(msg)
            return (false,nil,msg)
        }
        
        let successQuery = mysql.query(statement: SQLString)
        guard successQuery else {
            let msg = "SQL_error: \(SQLString)"
            print(msg)
            return (false, nil, msg)
        }
        
        let msg = "SQL_Success: \(SQLString)"
        print(msg)
        return (true,mysql.storeResults(), msg)
    }
}

