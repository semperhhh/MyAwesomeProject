

class ListView: ZPMustacheUtily {
    
    override var templateName: String? {
        return "templates/list.html"
    }
    
    func queryDB() -> [[String:Any]]? {
        
        //初始化数据库
        let mysql = DataBase()
        
        //查
        var resultArray = [Dictionary<String,String>]()
        let result = mysql.selectDataBaseWhere(tableName: "BLOG_POSTSLIST", keyWords: ["id","PID","TITLE","DATE","LOVE","TAG","READED"], keyValue: nil)
        
        if result.success {//查找成功
            
            print("result success")
            var dic = [String:String]()
            
            result.mysqlResult?.forEachRow(callback: { (row) in
                dic["id"] = row[1]
                dic["title"] = row[2]
                resultArray.append(dic)
            })
            
            return resultArray
        }
        
        return nil
    }
    
    override var listObjectSets: [String : Any]? {
        
        guard let lists = queryDB() else {
            
            return nil
        }
        
        return ["lists":lists]
    }
    
    override var mapParam: [String : Any]? {
        
        return ["navigationBar":NavigationBarView.html,
                "WEBSITE_HOST":WEBSITE_HOST,
        ]
    }
}
