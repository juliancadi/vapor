import Routing
import Vapor

/// Register your application's routes here.
///
/// [Learn More →](https://docs.vapor.codes/3.0/getting-started/structure/#routesswift)
public func routes(_ router: Router) throws {
  // Basic "Hello, world!" example
  router.get("hello") { req in
    return "Hello, world!"
  }
  
  router.get("hello", "vapor") { req in
    return "Hello Vapor"
  }
  
  router.get("hello", String.parameter) { req -> String in
    let name = try req.parameter(String.self)
    return "Hello \(name)"
  }
  
  router.post(InfoData.self, at: "info") { req, data -> String in
    return "Hello \(data.name)"
  }
  
  router.post(InfoData.self, at: "info/json") { req, data -> InfoResponse in
    return InfoResponse(request: data)
  }
  
  // Example of configuring a controller
  let todoController = TodoController()
  router.get("todos", use: todoController.index)
  router.post("todos", use: todoController.create)
  router.delete("todos", Todo.parameter, use: todoController.delete)
}

struct InfoData: Content {
  let name: String
}

struct InfoResponse: Content {
  let request: InfoData
}
