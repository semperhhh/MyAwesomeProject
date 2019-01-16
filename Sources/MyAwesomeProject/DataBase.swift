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
    var tableName: String
    
    var mysql : MySQL
    
    internal init() {
        
        tableName = "postslist"
        
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
    
    //查 results不是必须返回的
    func selectDataBaseWhere(keyWords: [String], keyValue: String?) -> (success: Bool, mysqlResult: MySQL.Results?, errorMsg: String) {
        
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
    
    //增
    func addDataBaseWhere(keys:[String],values:[String]) -> (Bool) {
        
        var Msg :String?
        
        var SQLString = "insert into \(tableName) ("
        
        for key in keys {
            SQLString.append(" \(key),")
            
        }
        SQLString.removeLast()
        SQLString.append(") values (")
        
        for value in values {
            SQLString.append(" \(value),")
        }
        SQLString.removeLast()
        SQLString.append(")")
        
//        let sql = "insert into BLOG_POSTSLIST (TITLE, PID) values ('ios', 190116)"
        
        let successaAdd = mysql.query(statement: SQLString)
        
        guard successaAdd else {
            
            Msg = "add - error: \(SQLString)"
            print(Msg!)
            return false
        }
        
        Msg = "add - success: \(SQLString)"
        print(Msg!)
        return true
    }
}

