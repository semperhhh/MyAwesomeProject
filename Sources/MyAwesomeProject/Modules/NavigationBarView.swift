
class NavigationBarView: ZPMustacheUtily {
    
    override var templateName: String? {
        return "templates/navigationBar.html"
    }
    
    override var mapParam: [String : Any]? {
        return ["WEBSITE_HOST":WEBSITE_HOST]
    }
    
    static var html = NavigationBarView().getTemplate()
}
