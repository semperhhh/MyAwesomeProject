
class AboutView: ZPMustacheUtily {
    
    override var templateName: String? {
        return "templates/about.html"
    }
    
    override var mapParam: [String : Any]? {
        
        return ["navigationBar":NavigationBarView.html,
                "WEBSITE_HOST":WEBSITE_HOST,
        ]
    }
}
