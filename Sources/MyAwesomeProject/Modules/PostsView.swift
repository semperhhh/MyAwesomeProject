
import PerfectMarkdown

class PostsView: ZPMustacheUtily {
    
    var pid: Int
    
    init(pid: Int) {
        self.pid = pid
    }
    
    override var templateName: String? {
        return "\(TEMPLATES)/posts.html"
    }
    
    override var mapParam: [String : Any]? {
        return ["navigationBar":NavigationBarView.html,
                "WEBSITE_HOST":WEBSITE_HOST,
                "WEBSITE_PID":self.pid,
                "POSTS_CONTENT":PostsContentView.init(pid: self.pid).getTemplate(),
        ]
    }
}
