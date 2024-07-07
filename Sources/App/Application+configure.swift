import Hummingbird
import Logging
import Elementary

func buildApplication(
    configuration: ApplicationConfiguration
) async throws -> some ApplicationProtocol {
    
    let logger = {
        var logger = Logger(label: "iankoex")
        logger.logLevel = .info
        return logger
    }()

    let router = Router()

    // add health check route
    router.get("/health") { _, _ in
        return HTTPResponse.Status.ok
    }

    router.add(middleware: ErrorPageMiddleware())
    // add file middleware to server css and js files
    router.add(middleware: FileMiddleware("Public", logger: logger))
    router.add(middleware: CORSMiddleware(
        allowOrigin: .originBased,
        allowHeaders: [.contentType],
        allowMethods: [.get, .options, .post, .delete, .patch]
    ))

    // Add routes serving HTML files
    WebController().addRoutes(to: router)

    let app = Application(
        router: router,
        configuration: configuration,
        onServerRunning: { _ in
#if DEBUG
            browserSyncReload()
#endif
        },
        logger: logger
    )
    return app
}
