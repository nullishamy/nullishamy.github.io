#import "/templates/page.typ": page
#import "/utils/helpers.typ" as utils

#show: page.with(title: "home")

#html.h1(class: "text-4xl font-bold text-center mb-8")[all tags]

#let tags = json("/_data/tags.json")
#html.div(class: "flex flex-col gap-2")[
    #for tag in tags.keys() {
        html.a(href: "/tags/" + tag)[#text("#" + tag)]
    }
]
