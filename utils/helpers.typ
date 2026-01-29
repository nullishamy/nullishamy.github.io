// Shared utilities
// Import: #import "/utils/helpers.typ": *


#let hr = html.hr(class: "border-text/50 my-4")

#let nav-link(href, label) = html.a(
    class: "text-muted hover:text-accent transition-colors",
    href: href,
)[#label]
#let tag(name) = html.span(
    class: "px-2 py-1 text-xs bg-surface rounded text-accent",
)[#name]
#let card(title: none, body) = html.div(class: "p-4 bg-surface rounded-lg")[
    #if title != none {
        html.h3(class: "font-semibold text-accent mb-2")[#title]
    }
    #body
]
// Helper for flex rows.
// We use a safelist comment to ensure Tailwind generates these classes.
// safelist: gap-1 gap-2 gap-3 gap-4 gap-5 gap-6 gap-8
#let flex-row(gap: "4", ..items) = html.div(
    class: "flex flex-wrap gap-" + gap + " items-center",
)[#for item in items.pos() { item }]

#let to-string(value) = repr(value)

// ----------------------------------------------------------------------------
// Post Helpers
// ----------------------------------------------------------------------------

// Helper to fetching posts from the virtual JSON file
// - Filters for pages with "/posts/" anywhere in URL (supports path_prefix)
// - Excludes drafts
// - Sorts by date (newest first)

// Helper to render a consistent post card
// - post: The post object from get-posts()
#let post-card(post) = {
    let date = post.at("date", default: "")
    // Cleaner approach: Wrap the whole card in a block-level anchor tag.
    // HTML5 allows block elements (div, h3, p) inside anchor tags.
    html.a(
        class: "block mb-6 p-4 border border-white/10 rounded-lg bg-surface/50 hover:bg-surface transition-colors no-underline group",
        href: post.url,
    )[
        #html.h3(
            class: "text-xl font-semibold mb-2 group-hover:text-accent transition-colors",
        )[
            #post.title
        ]

        #flex-row(
            gap: "4",
            html.span(class: "text-sm text-muted")[#date],
            ..post.at("tags", default: ()).map(t => tag(t)),
        )

        #if post.at("summary", default: none) != none {
            html.p(class: "mt-2 text-muted")[#post.at("summary")]
        }
    ]
}
