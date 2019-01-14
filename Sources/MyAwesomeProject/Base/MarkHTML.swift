
import PerfectLib

class MarkHTML {
    
    //markdown 转html
    //let markdown = "# 这是一个markdown文档\n\n## with mojo"
    
    internal func markWithHTML(markFile: String, htmlFile: String) {
        
        do {
            let markdown = try String(contentsOfFile: "\(server.documentRoot)/\(TEMPLATES)/\(STATIC)/\(markFile).md")
            
            if let html = markdown.markdownToHTML {
                //转换失败
                print("markdownWithHTML html = \(html)")
                
                let thisFile = File("\(server.documentRoot)/\(TEMPLATES)/\(POSTS)/\(htmlFile).html")
                print("markdownWithHTML thisFile before = \(thisFile.exists)")
                guard !thisFile.exists else {//已经存在路径,就返回
                    return
                }
                try thisFile.open(.readWrite)
                try thisFile.write(string: html)
                thisFile.close()
                print("markdownWithHTML thisFile after = \(thisFile.exists)")
            }
        } catch {
            
            print("markdownWithHTML error")
        }
    }
}
