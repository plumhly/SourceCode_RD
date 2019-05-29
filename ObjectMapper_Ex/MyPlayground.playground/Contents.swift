import UIKit
import ObjectMapper


/*
 {
     "name": "libo",
     "age": 20,
     "companies": [
         {
         "name": "钛马",
         "employee": 200,
         "ceo": "plum"
         },
         {
         "name": "我去",
         "employee": 300,
         "ceo": "mit"
         }
    ],
     "phone": {
         "brand": "apple",
         "system": "ios",
         "price": 6000.0
     }
 }
 */

struct PLTransform: TransformType {
    
    func transformFromJSON(_ value: Any?) -> CompanyLevel? {
        if let v = value as? Int {
            return .info(v)
        }
        return nil
    }
    
    func transformToJSON(_ value: CompanyLevel?) -> Int? {
        if case .info(let s)? = value {
            return s
        }
        return nil
    }
}

//enum CompanyLevel: Int {
//    case one = 1
//    case two
//}

enum CompanyLevel {
    case info(Int)
}


struct Company : Mappable {
    var name : String?
    var employee : Int?
    var ceo : String?
    var level: CompanyLevel?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        name <- map["name"]
        employee <- map["employee"]
        ceo <- map["ceo"]
        level <- (map["level"], PLTransform())
    }
    
}

struct User : Mappable {
    var name : String?
    var age : Int?
    var companies : [Company]?
    var phone : Phone?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        print("呵呵呵")
        name <- map["companies.0.name"]
        age <- map["age"]
        companies <- map["companies"]
        phone <- map["phone"]
    }
    
}

struct Phone : Mappable {
    var brand : String?
    var system : String?
    var price : Double?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        brand <- map["brand"]
        system <- map["system"]
        price <- map["price"]
    }
    
}


//let path = Bundle.main.url(forResource: "test", withExtension: "json")
//let data = try! Data(contentsOf: path)

let user = Mapper<User>().map(JSONfile: "test.json")


let s = (user?.companies?[1].level)!

user?.name
print(user?.toJSON())
