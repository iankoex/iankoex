import Hummingbird
import HummingbirdElementary

/// Generate an HTML page for a thrown error
struct ErrorPageMiddleware<Context: RequestContext>: RouterMiddleware {

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
            let status: HTTPResponse.Status
            let statusCode: String
            let message: String
            if let error = error as? HTTPError {
                status = error.status
                statusCode = "\(error.status.code)"
                message = error.body ?? error.status.reasonPhrase
            } else {
                status = .internalServerError
                statusCode = "\(HTTPResponse.Status.internalServerError)"
                message = "\(error)"
            }
            // render HTML and return
            let page = HTMLResponse {
                MainLayout(title: "Iankoex Error: \(statusCode)") {
                    ErrorPage(statusCode: statusCode, message: message)
                }
            }
            var response = try page.response(from: request, context: context)
            response.status = status
            return response
        }
    }
}
