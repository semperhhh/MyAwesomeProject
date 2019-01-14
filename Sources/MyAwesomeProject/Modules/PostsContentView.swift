
class PostsContentView: ZPMustacheUtily {
    
    var pid: Int
    
    override var templateName: String? {
        
        return "\(TEMPLATES)/\(POSTS)/\(pid).html"
    }
    
    init(pid: Int) {
        self.pid = pid
    }
}
