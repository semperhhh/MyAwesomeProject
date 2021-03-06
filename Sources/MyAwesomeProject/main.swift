print("Hello, world!")

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import PerfectMustache
import PerfectMarkdown

let server = HTTPServer()

//根目录
#if os(macOS)
server.documentRoot = "/Users/zhangpenghui/Desktop/MyAwesomeProject/Workspace"
#else //linux
server.documentRoot = "/root/Blog/MyAwesomeProject/Workspace"
#endif

//遍历文件
//let thisStatic = Dir("/Users/zhangpenghui/Desktop/MyAwesomeProject/Workspace/templates/static/")
//
//try thisStatic.forEachEntry { (n) in
//    print(n)
//
////    markdown转html
//    var md: String = n
//    md.removeLast(3)
//
//    MarkHTML().markWithHTML(markFile: md, htmlFile: md)
//}


var routes = Routes()

routes.add(method: .get, uri: "/login/*/detail") { (resquest, response) in
    response.setHeader(HTTPResponseHeader.Name.contentType, value: "text/html;charset=UTF-8")
    response.appendBody(string: "通配符url为 \(resquest.path)")
    response.completed()
}

//mustache基本用法
//导航栏
//let navResult = NavigationBarView().getTemplate()

//首页
let home = indexView().getTemplate()
routes.add(method: .get, uri: "/") { (_, response) in
    print("/home")
    response.setHeader(HTTPResponseHeader.Name.contentType, value: "text/html;charset=UTF-8")
    response.setBody(string: home)
    response.completed()
}

//列表
routes.add(method: .get, uri: "/list") { (_, response) in
    print("/list")
    let list = ListView().getTemplate()
    response.setHeader(HTTPResponseHeader.Name.contentType, value: "text/html;charset=UTF-8")
    response.setBody(string: list)
    response.completed()
}

//帖子页
let pid = "key"
routes.add(method: .get, uri: "/posts/{\(pid)}") { (request, response) in
    print("/pid")
    let fileName = request.urlVariables[pid]!
    print("fileName pid = \(fileName)")
    let postsString = PostsView(titleName: fileName).getTemplate()
    response.appendBody(string: postsString)
    response.completed()
}

//帖子点击喜欢
routes.add(method: .get, uri: "/posts/likeClick/**") { (request, response) in
    
    print("likeClick")
    //查找数据库对应喜欢数+1
    response.completed()
}

//帖子点击打赏
routes.add(method: .get, uri: "/posts/rewardClick/**") { (request, response) in
    
    print("rewardClick")
    //查找数据库对应点赞数+1
    response.completed()
}

//关于
let about = AboutView().getTemplate()
routes.add(method: .get, uri: "/about") { (request, response) in
    print("/about")
    response.setHeader(.contentType, value: "text/html;charset=UTF-8")
    response.setBody(string: about)
    response.completed()
}

////首页
//routes.add(method: .get, uri: "/") { (request, response) in
//
//    mustacheRequest(request: request, response: response, handler: StoryHandler(), templatePath: server.documentRoot + "/index.html")
//}

//列表
//routes.add(method: .get, uri: "/list.html") { (request, response) in
//
//    mustacheRequest(request: request, response: response, handler: ListHandler(), templatePath: server.documentRoot + "/templates/list.html")
//}

//通配符
//routes.add(method: .get, uri: "/*") { (request, response) in
//
//    //用文档根目录初始化静态文件句柄
//    let handler = StaticFileHandler(documentRoot: server.documentRoot + "/templates")
//
//    handler.handleRequest(request: request, response: response)
//}

//结尾通配符

////检测路径存在
let thisDir = Dir("/root/Blog/MyAwesomeProject/Workspace/templates/static/")
print("路径 \(thisDir.exists)")

do {
    server.addRoutes(routes)
    server.serverPort = 8181
    try server.start()
    
}catch PerfectError.networkError(let err, let msg) {
    print("Network error thrown: \(err) \(msg)")
}
