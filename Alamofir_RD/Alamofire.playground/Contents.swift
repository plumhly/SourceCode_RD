import UIKit
import PlaygroundSupport
import Alamofire


let employ = """
{ "employeeId": 7, "name": "John Appleseed", "favoriteToy": {"name":"Teddy Bear"}}
"""


struct Employee: Codable {
    var name: String
    var id: Int
    var favoriteToy: Toy
    
    enum CodingKeys: String, CodingKey {
        case id = "employeeId"
        case name
        case favoriteToy
    }
}

struct Toy: Codable {
    var name: String
}

let decoder = JSONDecoder()
let empl2 = try decoder.decode(Employee.self, from: employ.data(using: .utf8)!)


empl2.favoriteToy.name










let url = "http://api.juheapi.com/japi/toh"
let parameter: [String : Any] = ["v": "1.0", "key": "e5fef8b83ad02196da8b8079cf19dcec", "month": 1, "day": 22]

Alamofire.request(url, method: .get, parameters: parameter, encoding: URLEncoding.default, headers: nil).response { response in
    if let data = response.data {
//        let string = String(data: data, encoding: .utf8)!
        let datas = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! Dictionary<String, Any>
        let results = datas["result"] as! [Dictionary<String, Any>]
        let people = results.map(HistoryPerson.init).first!
        print(people.lunar)
    }
}

PlaygroundPage.current.needsIndefiniteExecution = true

