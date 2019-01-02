
class NavigationBarView: ZPMustacheUtily {
    
    override var templateName: String? {
        return "templates/navigationBar.html"
    }
    
    static var html = NavigationBarView().getTemplate()
}
