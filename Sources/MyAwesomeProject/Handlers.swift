
import PerfectMustache

struct MusHandler: MustachePageHandler {
    
    //context 上下文环境：类型为MustacheWebEvaluationContext，为程序内读取HTTPRequest请求内容而保存的所有信息
    //collector 结果搜集器：类型为MustacheEvaluationOutputCollector，用于调整模板输出。比如一个`defaultEncodingFunc`默认编码函数将被安装用于改变输出结果的编码方式
    
    /// 当句柄需要将参数值传入模板时会被系统调用。
    func extendValuesForResponse(context contxt: MustacheWebEvaluationContext, collector: MustacheEvaluationOutputCollector) {
        
        var values = MustacheEvaluationContext.MapType()
        values["title"] = "swift 用户"
        contxt.extendValues(with: values)
        
        do {
            try contxt.requestCompleted(withCollector: collector)
        } catch {
            let response = contxt.webResponse
            response.status = .internalServerError
            response.appendBody(string: "\(error)")
            response.completed()
        }
    }
}

//故事
struct ListHandler: MustachePageHandler {
    
    func extendValuesForResponse(context contxt: MustacheWebEvaluationContext, collector: MustacheEvaluationOutputCollector) {
        
        //初始化数据库
        let mysql = DataBase()
        
        //查
        var resultArray = [Dictionary<String,String>]()
        let result = mysql.selectDataBaseWhere(tableName: "blog_home", keyWords: ["title","content"], keyValue: nil)
        
        if result.success {
            
            print("result success")
            var dic = [String:String]()
            
            result.mysqlResult?.forEachRow(callback: { (row) in
                dic["title"] = row[0]
                dic["content"] = row[1]
                resultArray.append(dic)
            })
        }
        
        var values = MustacheEvaluationContext.MapType()
        values["title"] = resultArray
        
        contxt.extendValues(with: values)
        
        do {
            try contxt.requestCompleted(withCollector: collector)
        } catch {
            let response = contxt.webResponse
            response.status = .internalServerError
            response.appendBody(string: "\(error)")
            response.completed()
        }
    }
}

//列表
struct StoryHandler: MustachePageHandler {
    func extendValuesForResponse(context contxt: MustacheWebEvaluationContext, collector: MustacheEvaluationOutputCollector) {
        
        //初始化数据库
        let mysql = DataBase()
        
        //查
        var resultArray = [Dictionary<String,String>]()
        let result = mysql.selectDataBaseWhere(tableName: "blog_home", keyWords: ["title","content"], keyValue: nil)
        
        if result.success {
            
            print("result success")
            var dic = [String:String]()
            
            result.mysqlResult?.forEachRow(callback: { (row) in
                dic["title"] = row[0]
                dic["content"] = row[1]
                resultArray.append(dic)
            })
        }
        
        var values = MustacheEvaluationContext.MapType()
        values["title"] = resultArray
        
        contxt.extendValues(with: values)
        
        do {
            try contxt.requestCompleted(withCollector: collector)
        } catch {
            let response = contxt.webResponse
            response.status = .internalServerError
            response.appendBody(string: "\(error)")
            response.completed()
        }
    }
}
