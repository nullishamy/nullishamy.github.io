#import "/utils/helpers.typ" as utils

#let colors = (
    accent: "text-accent",
    primary: "text-primary",
    code: "text-text",
    muted: "text-slate-400",
)

#let base(body) = {
    show list: it => html.ul(class: "list-disc ml-6 my-4 space-y-1")[
        #for item in it.children { html.li[#item.body] }
    ]
    show enum: it => html.ol(class: "list-decimal ml-6 my-4 space-y-1")[
        #for item in it.children { html.li[#item.body] }
    ]
    show raw.where(block: false): it => html.code(
        class: "font-semibold " + colors.code,
    )[#it.text]
    show raw.where(block: true): it => html.div(
        class: "mb-4 border border-white/10 rounded-lg",
    )[#it]

    show quote: it => html.blockquote(
        class: "border-l-4 border-accent pl-4 my-4 italic " + colors.muted,
    )[#it.body]
    show link: it => html.a(
        href: repr(it.dest).replace("\"", ""),
    )[#it.body]
    show strike: it => html.del[#it.body]
    show image: html.frame

    // Set math font
    show math.equation: set text(font: "Luciole Math", features: (ss01: 1))

    let inside-figure = state("inside-figure", false)

    show figure: it => {
        inside-figure.update(true)
        html.figure(class: "my-6 mx-auto w-fit")[#it]
        inside-figure.update(false)
    }
    show math.equation.where(block: false): it => context {
        if not inside-figure.get() {
            html.span(
                class: "inline-flex align-middle",
                role: "math",
            )[#html.frame(
                it,
            )]
        } else {
            it
        }
    }
    show math.equation.where(block: true): it => context {
        if not inside-figure.get() {
            html.figure(
                class: "my-6 flex justify-center",
                role: "math",
            )[#html.frame(
                it,
            )]
        } else {
            it
        }
    }

    html.nav(class: "max-w-3xl mx-auto mt-2 mb-2 flex flex-row items-center")[
        #html.a(href: "/")[amy erskine]
        #html.div(class: "flex-grow")
        #html.a(class: "w-full mb-8 text-accent", href: "/posts")[blog]
    ]

    html.main(class: "max-w-3xl mx-auto mb-16")[
        #html.hr(class: "w-full mb-8 text-text/50")
        #body
    ]

    html.footer(class: "flex flex-col max-w-3xl mx-auto mb-24")[
        #html.hr(class: "w-full mb-4 text-text/50")
        the content of #link("https://amy.is-a.dev/")[this blog] © 2025 by amy erskine is licensed under #link("https://creativecommons.org/licenses/by-nc-sa/4.0/")[CC BY-NC-SA 4.0]
        #box[#html.img(
            src: "https://mirrors.creativecommons.org/presskit/icons/cc.svg",
            alt: "CC",
            class: "inline w-4 h-4"
        )]
        #box[#html.img(
            src: "https://mirrors.creativecommons.org/presskit/icons/by.svg",
            alt: "BY",
            class: "inline w-4 h-4"
        )]
        #box[#html.img(
            src: "https://mirrors.creativecommons.org/presskit/icons/nc.svg",
            alt: "NC",
            class: "inline w-4 h-4"
        )]
        #box[#html.img(
            src: "https://mirrors.creativecommons.org/presskit/icons/sa.svg",
            alt: "SA",
            class: "inline w-4 h-4"
        )]
        
        #link("https://github.com/nullishamy/nullishamy.github.io/")[the source code] is licensed under #link("https://opensource.org/license/osl-3-0-php")[OSL 3.0]
    ]
}
