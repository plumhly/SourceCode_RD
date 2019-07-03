import UIKit
import Moya
//import Alamofire
import Result

struct PL : CustomDebugStringConvertible {
    let name: String
    var description: String {
        return "pl---:----\(name)"
    }

    var debugDescription: String {
        print("调用")
        return "debug: \(name)"
    }

    var s: String {
        return "哈哈"
    }
}

var s: CustomDebugStringConvertible = PL(name: "")
//
//let l = PL(name: "libo")
//print(String(describing: l))
//print(String(reflecting: l))
//print(l)


let url = URL(string: "http://api.juheapi.com/japi/toh")!

enum API {
    case history(String, Int, Int, String)
}

extension TargetType {
    var baseURL: URL {
        return URL(string: "http://api.juheapi.com")!
    }
}

extension API: TargetType {
    
    var path: String {
        switch self {
            case .history:
            return "/japi/toh"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return "{\"name\": \"呵呵呵\"}".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .history(let version, let month, let day, let key):
            let dic: [String: Any] = ["v": version, "month": month, "day": day, "key": key];
            return .requestParameters(parameters: dic, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil;
    }
    
}

final class PLplugin: PluginType {
    
    func willSend(_ request: RequestType, target: TargetType) {
        print(request)
    }
    
    func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        print("failed")
    }
}

let sampleClosure = {
    (taget: API) -> Endpoint in
    return Endpoint(url: URL(target: taget).absoluteString, sampleResponseClosure: {() -> EndpointSampleResponse in
        print("哈哈哈哈")
        return .networkResponse(200, taget.sampleData)
    }, method: taget.method, task: taget.task, httpHeaderFields: nil)
}


//let provider = MoyaProvider<API>(endpointClosure: sampleClosure, stubClosure: MoyaProvider.immediatelyStub)
let provider = MoyaProvider<API>(plugins: [PLplugin()])


provider.request(.history("1.0", 1, 1, "e5fef8b83ad02196da8b8079cf19dcec")) { result in
    switch result {
    case let .success(resonse):
//        let dic = try! JSONSerialization.jsonObject(with: val.data, options: .allowFragments)
//        print(dic)
        do {
            try resonse.filterSuccessfulStatusCodes()
            let s = try resonse.mapString()
            print(s)
        } catch {
            print("filter success failed")
        }
    case let .failure(error):
        print(error)
    }
}

//SessionManager().adapter
//SessionManager().retrier


//enum PlumEnum {
//    case success(String)
//}
//
//let a: String? = "哈哈"
//let other = a.map(PlumEnum.success)
//print(other)


//let urlt = URL(string: "https://stackoverflow.com/questions/26273672/how-to-hide-status-bar-and-navigation-bar-when-tap-device")!
//
//let urlC = URLComponents(url: urlt, resolvingAgainstBaseURL: false)
