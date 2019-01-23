
import PerfectMarkdown
import PerfectLib

class PostsView: ZPMustacheUtily {
    
    var pid: Int
    
    init(pid: Int) {
        self.pid = pid
    }
    
    let markString = "# 123333  \n #### 1231231231312331"
    
    override var templateName: String? {
        return "\(TEMPLATES)/posts.html"
    }
    
    override var mapParam: [String : Any]? {
        return ["navigationBar":NavigationBarView.html,
                "WEBSITE_HOST":WEBSITE_HOST,
                "WEBSITE_PID":self.pid,
                "POSTS_CONTENT":PostsContentView.init(pid: self.pid).getTemplate()
        ]
    }
}
