import Hummingbird
import Mustache

/// Generate an HTML page for a thrown error
struct ErrorPageMiddleware<Context: RequestContext>: RouterMiddleware {
    let errorTemplate: MustacheTemplate
    let mustacheLibrary: MustacheLibrary

    func handle(
        _ request: Request,
        context: Context,
        next: (Request, Context) async throws -> Response
    ) async throws -> Response {
        do {
            return try await next(request, context)
        } catch {
            // if error is thrown from further down the middlware chain then either return
            // page with status code and message or a 501 with a description of the thrown error
            let values: [String: Any]
            let status: HTTPResponse.Status
            if let error = error as? HTTPError {
                status = error.status
                values = [
                    "statusCode": error.status,
                    "message": error.body ?? "",
                ]
            } else {
                status = .internalServerError
                values = [
                    "statusCode": HTTPResponse.Status.internalServerError,
                    "message": "\(error)",
                ]
            }
            // render HTML and return
            let html = self.errorTemplate.render(values, library: self.mustacheLibrary)
            var response = try HTML(html: html).response(from: request, context: context)
            response.status = status
            return response
        }
    }
}
