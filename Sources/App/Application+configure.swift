import Hummingbird
import Logging
import NIOCore
import Mustache

func buildApplication(
    configuration: ApplicationConfiguration
) async throws -> some ApplicationProtocol {
    
    let logger = {
        var logger = Logger(label: "iankoex")
        logger.logLevel = .debug
        return logger
    }()

    let router = Router()

    // add health check route
    router.get("/health") { _, _ in
        return HTTPResponse.Status.ok
    }

    // load mustache template library
    let library = try await MustacheLibrary(directory: "Resources/templates")
    assert(library.getTemplate(named: "head") != nil, "Set your working directory to the root folder of this example to get it to work")

    guard let errorTemplate = library.getTemplate(named: "error")
    else {
        preconditionFailure("Failed to load mustache templates")
    }

    router.add(middleware: ErrorPageMiddleware(errorTemplate: errorTemplate, mustacheLibrary: library))
    // add file middleware to server css and js files
    router.add(middleware: FileMiddleware("Public", logger: logger))
    router.add(middleware: CORSMiddleware(
        allowOrigin: .originBased,
        allowHeaders: [.contentType],
        allowMethods: [.get, .options, .post, .delete, .patch]
    ))

    // Add routes serving HTML files
    WebController(mustacheLibrary: library).addRoutes(to: router)

    let app = Application(
        router: router,
        configuration: configuration,
        logger: logger
    )
    return app
}
