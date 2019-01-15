
//文章列表数据
class ZPModel {
    
    var title: String?
    var pid: Int
    var id: Int
    var date: String?
    var love: Int = 0
    var tag: Int = 0
    var readed: Int = 0
    var update_time: String?
    
    init(title: String?, pid: Int?, id: Int?) {
        self.title = title
        self.pid = pid ?? 0
        self.id = id ?? 0
    }
}
