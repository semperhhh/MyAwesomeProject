
import PerfectMustache

public typealias PCViewParam = Dictionary<String, Any>

class ZPMustacheUtily {
    
    //不包含列表的字典
    internal var mapParam : [String:Any]? {
        return nil
    }
    
    //地址
    internal var templateName : String? {
        return nil
    }
    
    //列表数组
    internal var listObjectSets : [[String:Any]]? {
        return nil
    }
    
    //最后 要替换的字典
    internal var param:[String:Any] {
        
        guard let lists = listObjectSets else {//如果列表字典为空
            return mapParam ?? [String:Any]()
        }
        
        var dic:[String:Any] = mapParam ?? [String:Any]()
        
        dic["lists"] = lists
        
        return dic
    }
    
    open func getTemplate() -> String {
        
        do {
            let templateText = server.documentRoot + "/\(templateName ?? "")"//路径
            let context = MustacheEvaluationContext(templatePath: templateText, map: param)//上下文替换
            let collector = MustacheEvaluationOutputCollector()
            return try context.formulateResponse(withCollector: collector)//结果
        } catch {
            return "Oops !"
        }
    }
}
