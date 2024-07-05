import Hummingbird
import Mustache

/// Serves HTML pages
struct WebController {
    let mustacheLibrary: MustacheLibrary
    let homeTemplate: MustacheTemplate

    init(mustacheLibrary: MustacheLibrary) {
        // get the mustache templates from the library
        self.mustacheLibrary = mustacheLibrary

        guard let homeTemplate = mustacheLibrary.getTemplate(named: "home") else {
            preconditionFailure("Failed to load mustache templates")
        }

        self.homeTemplate = homeTemplate
    }

    func addRoutes(to router: Router<some RequestContext>) {
        router.group()
            .get("/", use: self.home)
    }

    @Sendable
    func home(request: Request, context: some RequestContext) async throws -> HTML {
        let html = self.homeTemplate.render((), library: mustacheLibrary)
        return HTML(html: html)
    }
}
