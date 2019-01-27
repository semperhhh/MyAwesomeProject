
import PerfectMarkdown
import PerfectLib

class PostsView: ZPMustacheUtily {
    
    var pid: Int
    var titleName:String
    var mdstring:String?
    
    init(titleName:String) {
        self.pid = 0
        self.titleName = titleName
        super.init()
        
        markContent()
    }
    
    //MARK:获取内容
    func markContent() {
        
        do {
            let markdown = try String(contentsOfFile: "\(server.documentRoot)/\(TEMPLATES)/\(STATIC)/\(titleName).md")
            let md = markdown[(markdown.range(of: "---")?.lowerBound)!..<markdown.endIndex]
            mdstring = String(md)
        } catch {
            print("mark content error")
        }
    }
    
    let markString = "# 123333  \n #### 1231231231312331"
    
    override var templateName: String? {
        return "\(TEMPLATES)/posts.html"
    }
    
    override var mapParam: [String : Any]? {
        return ["navigationBar":NavigationBarView.html,
                "WEBSITE_HOST":WEBSITE_HOST,
                "WEBSITE_PID":self.pid,
//                "POSTS_CONTENT":PostsContentView.init(pid: self.pid).getTemplate()
            "POSTS_CONTENT":mdstring?.markdownToHTML ?? "Oops!",
        ]
    }
}
