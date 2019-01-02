
class ListView: ZPMustacheUtily {
    
    override var templateName: String? {
        return "templates/list.html"
    }
    
    override var mapParam: [String : Any]? {
        
        return ["navigationBar":NavigationBarView.html]
    }
}
