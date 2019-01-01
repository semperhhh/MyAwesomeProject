print("Hello, world!")

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import PerfectMustache

let server = HTTPServer()

//根目录

#if os(macOS)
server.documentRoot = "/Users/zhangpenghui/Desktop/MyAwesomeProject/Workspace"
#else //linux
server.documentRoot = "~/Blog/MyAwesomeProject/Workspace"
#endif

var routes = Routes()

routes.add(method: .get, uri: "/login/*/detail") { (resquest, response) in
    response.setHeader(HTTPResponseHeader.Name.contentType, value: "text/html;charset=UTF-8")
    response.appendBody(string: "通配符url为 \(resquest.path)")
    response.completed()
}

routes.add(method: .get, uri: "/") { (request, response) in

    mustacheRequest(request: request, response: response, handler: storyHandler(), templatePath: request.documentRoot + "/index.html")
}

//通配符
routes.add(method: .get, uri: "/*") { (request, response) in

    //用文档根目录初始化静态文件句柄
    let handler = StaticFileHandler(documentRoot: server.documentRoot + "/templates")

    handler.handleRequest(request: request, response: response)
}

//结尾通配符

//检测路径存在
let thisDir = Dir("./webroot")
print("路径 \(thisDir.exists)")

do {
    server.addRoutes(routes)
    server.serverPort = 8181
    try server.start()
    
}catch PerfectError.networkError(let err, let msg) {
    print("Network error thrown: \(err) \(msg)")
}
