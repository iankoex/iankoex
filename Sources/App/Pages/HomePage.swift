import Elementary

struct HomePage: HTML {
    var content: some HTML {
        div(.class("container")) {
            img(.src("/static/images/icon.png"))
            span(.class("responsive-text"), content: { "iankoex" })
        }
    }
}
