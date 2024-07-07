import Hummingbird
import HummingbirdElementary

/// Serves HTML pages
struct WebController {

    init() {}

    func addRoutes(to router: Router<some RequestContext>) {
        router.group()
            .get("/", use: self.home)
    }

    @Sendable
    func home(request: Request, context: some RequestContext) async throws -> some ResponseGenerator {
        HTMLResponse {
            MainLayout(title: "Iankoex") {
                HomePage()
            }
        }
    }
}
