

class ListView: ZPMustacheUtily {
    
    override var templateName: String? {
        return "templates/list.html"
    }
    
    func queryDB() -> [[String:Any]]? {
        
        //初始化数据库
        let mysql = DataBase()
        
        //增
//        let imagStr = "学习"
//        let imagStr_utf8 = imagStr.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
//        let resultadd = mysql.addDataBaseWhere(keys: ["TITLE","PID"], values: ["'\(imagStr_utf8 ?? "")'" ,"190116"])
        
        //查
        var resultArray = [[String:Any]]()
        var resultModelArray = [ZPModel]()
        let result = mysql.selectDataBaseWhere(keyWords: ["id", "title", "pid", "create_time", "updata_time", "likeed", "readed"], keyValue: nil)
        
        if result.success {//查找成功
            
            print("result success")
            var dic = [String:Any]()
            
            result.mysqlResult?.forEachRow(callback: { (row) in
                
                let title:String = row[1] ?? ""
                print("title = \(title)")
                
                //标签
                do {
                    let markdown = try String(contentsOfFile: "\(server.documentRoot)/\(TEMPLATES)/\(title).md")
                    
                    print("markdowm success")
                    
                    let i = markdown.range(of: "---")
                    let sub = markdown[markdown.startIndex..<(i?.lowerBound)!]
                    let string1 = String(sub)
                    print("string1 = \(string1)")
                    
                    var tagArray:[[String:String]] = [[String:String]]()//标签数组
                    
                    let j = string1.range(of: "tag: ")
                    if (j?.upperBound != nil) {
                        
                        let subj = string1[(j?.upperBound)!..<string1.endIndex]
                        let string2 = String(subj)
                        print("string2 = \(string2)")
                        
                        let y = string2.range(of: ";")
                        if (y?.lowerBound != nil) {
                            let suby = string2[string2.startIndex..<(y?.lowerBound)!]
                            let string3 = String(suby)
                            print("string3 = \(string3)")
                            
                            //字符串转数组
                            let arr = string3.components(separatedBy: ",")
                            
                            for arrStr in arr {
                                
                                let tagDic:[String:String] = ["POSTS_TAG_NAME":arrStr]
                                tagArray.append(tagDic)
                            }
                            
                        }
                        dic["POSTS_TAG"] = tagArray
                    }
                } catch {
                    
                    print("获取markdown error -- \(error)")
                }
                
                dic["POSTS_TITLE"] = row[1]
                dic["POSTS_PID"] = row[2]//pid
                dic["POSTS_CREATE_TIME"] = row[3]
                dic["POSTS_UPDATA_TIME"] = row[4]
                dic["POSTS_LIKEED"] = row[5]
                dic["POSTS_READED"] = row[6]
                let model = ZPModel(title: row[1], pid: Int(row[2]!), id: Int(row[0]!))
                resultModelArray.append(model)
                resultArray.append(dic)
            })
            
            return resultArray
        }
        
        return nil
    }
    
    override var listObjectSets: [[String : Any]]? {
        
        guard let lists = queryDB() else {
            
            return nil
        }
        
        return lists
    }
    
    override var mapParam: [String : Any]? {
        
        return ["navigationBar":NavigationBarView.html,
                "WEBSITE_HOST":WEBSITE_HOST,
        ]
    }
}
