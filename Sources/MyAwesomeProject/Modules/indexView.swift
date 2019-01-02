
class indexView: ZPMustacheUtily {
    
    override var templateName: String? {
        return "index.html"
    }
    
    override var mapParam: [String : Any]? {
        return ["name":"The name",
                "title":"1231231313131",
                "navigationBar":NavigationBarView.html
        ]
    }
}
