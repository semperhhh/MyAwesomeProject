
import PerfectMustache

public typealias PCViewParam = Dictionary<String, Any>

class ZPMustacheUtily {
    
    internal var mapParam : [String:Any]? {
        return nil
    }
    
    internal var templateName : String? {

        return nil
    }
    
    
    open func getTemplate() -> String {
        
        do {
            let templateText = server.documentRoot + "/\(templateName ?? "")"//路径
            let context = MustacheEvaluationContext(templatePath: templateText, map: (mapParam ?? [String:Any]()))//上下文替换
            let collector = MustacheEvaluationOutputCollector()
            return try context.formulateResponse(withCollector: collector)//结果
        } catch {
            return "Oops !"
        }
    }
}
