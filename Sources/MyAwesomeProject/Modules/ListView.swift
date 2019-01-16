

class ListView: ZPMustacheUtily {
    
    override var templateName: String? {
        return "templates/list.html"
    }
    
    func queryDB() -> [[String:Any]]? {
        
        //初始化数据库
        let mysql = DataBase()
        
        //增
        let imagStr = "学习"
        let imagStr_utf8 = imagStr.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let resultadd = mysql.addDataBaseWhere(keys: ["TITLE","PID"], values: ["'\(imagStr_utf8 ?? "")'" ,"190116"])
        
        //查
        var resultArray = [Dictionary<String,String>]()
        var resultModelArray = [ZPModel]()
        let result = mysql.selectDataBaseWhere(keyWords: ["id","title","pid"], keyValue: nil)
        
        if result.success {//查找成功
            
            print("result success")
            var dic = [String:String]()
            
            result.mysqlResult?.forEachRow(callback: { (row) in
                dic["WEBSITE_PID"] = row[2]//pid
                let rowStr = String(row[1]!)
                dic["title"] = rowStr.removingPercentEncoding
                print("title = \(row[1] ?? "")  \(dic["title"] ?? "")")
//                let model = ZPModel(title: row[1], pid: Int(row[2]!), id: Int(row[0]!))
//                resultModelArray.append(model)
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
