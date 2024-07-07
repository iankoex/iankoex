import Elementary

extension MainLayout: Sendable where Body: Sendable {}

struct MainLayout<Body: HTML>: HTMLDocument {
    var title: String
    @HTMLBuilder var pageContent: Body

    var head: some HTML {
        let siteDescription = "lankoex is a leading provider of comprehensive and tailor made apps, websites and security services for commercial clients."
        meta(.name(.description), .content(siteDescription))
        meta(.name(.author), .content("Iankoex"))
        meta(.name(.keywords), .content("iankoex, ian koex, ian, koex"))

        HTMLComment("Open Graph Meta Tags for Social Media")
        meta(.custom(name: "property", value: "og:title"), .content("Iankoex"))
        meta(.custom(name: "property", value: "og:description"), .content(siteDescription))
        meta(.custom(name: "property", value: "og:image"), .content("/static/images/icon.png"))
        meta(.custom(name: "property", value: "og:url"), .content("https://iankoex.com"))
        meta(.custom(name: "property", value: "og:type"), .content("website"))

        HTMLComment("Twitter Card Meta Tags")
        meta(.custom(name: "name", value: "twitter:title"), .content("Iankoex"))
        meta(.custom(name: "name", value: "twitter:description"), .content(siteDescription))
        meta(.custom(name: "name", value: "twitter:card"), .content("/static/images/icon.png"))
        meta(.custom(name: "name", value: "twitter:image"), .content("/static/images/icon.png"))

        HTMLComment("Link to External CSS Stylesheet")
        link(.rel(.stylesheet), .href("/static/css/style.css?v=1"))

        HTMLComment("Favicon")
        link(.rel("icon"), .href("favicon.ico"), .custom(name: "type", value: "image/x-icon"))
        link(.rel("icon"), .href("/static/images/favicon.ico"), .custom(name: "sizes", value: "any"))
        link(.rel("apple-touch-icon"), .href("/static/images/apple-touch-icon.png"))
        link(.rel("manifest"), .href("/static/images/site.webmanifest"))
        link(.rel("icon"), .href("favicon.ico"), .custom(name: "type", value: "image/x-icon"))

        meta(.custom(name: "name", value: "msapplication-TileColor"), .content("#f0f0f0"))
        meta(.custom(name: "name", value: "theme-color"), .content("#f0f0f0"))
        meta(.custom(name: "name", value: "apple-mobile-web-app-title"), .content("Iankoex"))
        meta(.custom(name: "name", value: "application-name"), .content("Iankoex"))
        meta(.custom(name: "name", value: "HandheldFriendly"), .content("True"))
        meta(.custom(name: "name", value: "referrer"), .content("no-referrer-when-downgrade"))
        meta(.custom(name: "name", value: "generator"), .content("HummingBird2"))

        HTMLComment("Canonical Link")
        link(.rel("canonical"), .href("https://iankoex.com"))

        HTMLComment("Robots Meta Tag")
        meta(.custom(name: "name", value: "robots"), .content("index, follow"))

        HTMLComment("Charset")
        meta(.charset(.utf8))

        HTMLComment("Viewport Meta Tag")
        meta(.name(.viewport), .content("width=device-width, initial-scale=1.0"))

        HTMLComment("Structured Data (JSON-LD)")
        script(.custom(name: "type", value: "application/ld+json"),
               content: {
                    """
                    {
                        "@context": "http://schema.org",
                        "@type": "WebSite",
                        "name": "Iankoex",
                        "url": "https://iankoex.com"
                    }
                    """
        })
    }

    var body: some HTML {
        pageContent
    }
}
