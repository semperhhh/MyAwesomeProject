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

routes.add(method: .get, uri: "/123") { (_, response) in
    response.setHeader(HTTPResponseHeader.Name.contentType, value: "text/html;charset=UTF-8")
    response.setBody(string: "test测试")
    response.completed()
}

routes.add(method: .get, uri: "/") { (request, response) in
    StaticFileHandler(documentRoot: request.documentRoot, allowResponseFilters: true).handleRequest(request: request, response: response)
}

//初始化数据库
var mysql = SQLManage.init()

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
