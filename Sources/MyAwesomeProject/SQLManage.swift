import PerfectHTTP
import PerfectHTTPServer
import PerfectLib
import PerfectMySQL

class SQLManage {
    
    let SQLHost = "127.0.0.1"
    let SQLUser = "root"
    let SQLPassword = "12345678"
    let SQLDB = "BlogProject"
    
    var mysql : MySQL
    
    internal init() {
        
        mysql = MySQL.init()
        
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
    
}
