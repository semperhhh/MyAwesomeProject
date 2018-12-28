print("Hello, world!")

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import PerfectMustache

let server = HTTPServer()

server.documentRoot = "./webroot"

var routes = Routes()

//routes.add(method: .get, uri: "/") { (_, response) in
//    response.setHeader(HTTPResponseHeader.Name.contentType, value: "text/html")
//    response.setBody(string: "91 test 91.com")
//    response.completed()
//}

routes.add(method: .get, uri: "/") { (request, response) in
    StaticFileHandler(documentRoot: request.documentRoot, allowResponseFilters: true).handleRequest(request: request, response: response)
//    response.completed()
}

//初始化数据库
var mysql = SQLManage.init()

do {
    server.addRoutes(routes)
    server.serverPort = 8181
    try server.start()
    
}catch PerfectError.networkError(let err, let msg) {
    print("Network error thrown: \(err) \(msg)")
}
