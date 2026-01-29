#import "/templates/page.typ": page
#import "/utils/helpers.typ" as utils

#show: page.with(title: "posts")

= all posts
#let pages = json("/_data/pages.json")
#let posts = (
    pages
        // filter this page out
        .filter(p => p.title != "posts")
        .filter(p => "/posts/" in p.url)
        .filter(p => p.at("draft", default: false) == false)
        .sorted(key: p => p.date)
        .rev()
)

#html.div(class: "space-y-6")[
    #for post in posts {
        utils.post-card(post)
    }
]

