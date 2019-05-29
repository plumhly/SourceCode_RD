import UIKit
import PlaygroundSupport
import Alamofire

/**
let employ = """
{ "employeeId": 7, "name": "John Appleseed", "favoriteToy": {"name":"Teddy Bear"}}
"""


struct Employee  {
    var name: String
    var id: Int
    var favoriteToy: Toy
    
    enum CodingKeys: String, CodingKey {
        case id = "employeeId"
        case name
        case gift
    }
}

struct Toy: Codable {
    var name: String
}

extension Employee : Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(id, forKey: .id)
        try container.encode(favoriteToy.name, forKey: .gift)
        
    }
}

extension Employee : Decodable {
    init(from decoder: Decoder) throws {
       let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        id = try container.decode(Int.self, forKey: .id)
        let toyName = try container.decode(String.self, forKey: .gift)
        favoriteToy = Toy(name: toyName)
    }
}

let decoder = JSONDecoder()
//let empl2 = try decoder.decode(Employee.self, from: employ.data(using: .utf8)!)
let empl2 = Employee(name: "plum", id: 3, favoriteToy: Toy(name: "bobo"))
let encoder = JSONEncoder()
let data = try! encoder.encode(empl2)
let jsString = String(data: data, encoding: .utf8)
//empl2.favoriteToy.name

let imp3 = try decoder.decode(Employee.self, from: data)
imp3.favoriteToy.name
*/


enum MyError : Error {
    case invalid
}


let url = "http://api.juheapi.com/japi/toh"
let parameter: [String : Any] = ["v": "1.0", "key": "e5fef8b83ad02196da8b8079cf19dcec", "month": 1, "day": 22]

Alamofire.request(url, method: .get, parameters: parameter, encoding: URLEncoding.default, headers: nil)
    .validate { (request, response, data)  in
        return Request.ValidationResult.failure(MyError.invalid)
    }
    .response { response in
//    if let data = response.data {
//        //        let string = String(data: data, encoding: .utf8)!
//        let datas = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! Dictionary<String, Any>
//        let results = datas["result"] as! [Dictionary<String, Any>]
//        let people = results.map(HistoryPerson.init).first!
//        print(people.lunar)
//    }
    print(response.error)
}
 

//let a = 1 << 0
//let b = 1 << 2

DownloadRequest.suggestedDownloadDestination()

PlaygroundPage.current.needsIndefiniteExecution = true

