#import "/templates/base.typ": base, colors
#import "/utils/helpers.typ" as utils
#import "@tola/pages:0.0.0": pages

#let tag-listing(tag: none, body) = {
    show: base
    
    html.h1(class: "text-4xl font-bold text-center mb-8")[posts tagged '#tag']
    
    let postsWithTag = pages().filter(it => { it.tags.contains(tag)} )
    html.div(class: "flex flex-col items-center")[
        #for taggedPost in postsWithTag {
            utils.post-card(taggedPost)
        }
    ]
}
