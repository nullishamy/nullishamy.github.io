#import "/templates/page.typ": page
#import "/utils/helpers.typ" as utils
#import "@tola/pages:0.0.0": pages

#show: page.with(title: "posts")

= all posts
#let posts = (
    pages()
        // filter this page out
        .filter(p => p.title != "posts")
        .filter(p => "/posts/" in p.permalink)
        .filter(p => p.at("draft", default: false) == false)
        .sorted(key: p => p.date)
        .rev()
)

#html.div(class: "space-y-6")[
    #for post in posts {
        utils.post-card(post)
    }
]

