#import "/templates/base.typ": base, colors
#import "/utils/helpers.typ" as utils

#let tag-listing(tag: none, body) = {
    show: base
    
    html.h1(class: "text-4xl font-bold text-center mb-8")[posts tagged '#tag']
    
    let pages = json("/_data/pages.json")
    let tags = json("/_data/tags.json")
    let postsWithTag = tags.at(tag, default: ())
    html.div(class: "flex flex-col items-center")[
        #for taggedPost in postsWithTag {
            let post = pages.filter(p => p.url == taggedPost.url).at(0)
            utils.post-card(post)
        }
    ]
}
