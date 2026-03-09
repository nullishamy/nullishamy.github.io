#import "/templates/page.typ": page
#import "/utils/helpers.typ" as utils
#import "@tola/pages:0.0.0": all-tags

#show: page.with(title: "home")

#html.h1(class: "text-4xl font-bold text-center mb-8")[all tags]

#html.div(class: "flex flex-col gap-2")[
    #for tag in all-tags() {
        html.a(href: "/tags/" + tag)[#text("#" + tag)]
    }
]
