import Elementary

struct ErrorPage: HTML {
    var statusCode: String
    var message: String

    var content: some HTML {
        div(.class("container")) {
            img(.src("/static/images/icon.png"))
            h1 { "Error" }
            h2 { statusCode }
            p { message }
        }
    }
}
