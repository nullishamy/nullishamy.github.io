#import "/templates/page.typ": page
#import "/utils/helpers.typ" as utils

#show: page.with(title: "home")

#html.h1(class: "text-4xl font-bold mb-4")[hello, i'm amy]

I'm a sysadmin by trade and a developer by hobby with a passion for digging into the internals of software and ecosystems.

I've built #link("https://github.com/nullishamy/kate")[a JVM], run my own homelab, and mess around with electronics on occasion.

In the near future I intend on exploring embedded hardware & RF with some home-assistant integrated sensors and an RF SDR. Stay tuned here for posts about that!

#utils.hr

#let icon-with-dest(link, dest, alt) = html.div[#html.a(href: dest, target: "_blank", style: "height: 31px; width: 88px; display: block")[#html.img(
    src: link,
    alt: alt,
)]]

#let icon(link, alt) = html.img(
    src: link,
    alt: alt,
    style: "height: 31px; width: 88px"
)

#html.div(class: "flex flex-col gap-4")[
    #html.div(class: "flex flex-row items-center gap-2")[
        #link("https://github.com/nullishamy")[github]
        #link("https://jvm.social/@amy")[fediverse]
        #link("mailto:contact@amyerskine.me")[email]
    ]
    #html.div(class: "flex flex-row items-center gap-2")[
        #icon-with-dest(
            "https://linus.dev/images/88x31.png",
            "https://linus.dev/",
            "An 88x31 button. A cartoonish penguin is on the left. Next to it is the text 'linus' in white letters.",
        )
        #icon-with-dest(
            "https://www.theresnotime.co.uk/button.png",
            "https://www.theresnotime.co.uk/",
            "An 88x31 button. It features a cartoon fox face with the words 'TheresNoTime' on the bottom.",
        )
        #icon("/88x31/trans.png", "An 88x31 button. It is the trans flag")
        #icon("/88x31/ace.png", "An 88x31 button. It is the ace flag")
    ]
]

#utils.hr

= recent posts
#let pages = json("/_data/pages.json")
#let posts = (
    pages
        // filter 'all posts' out
        .filter(p => p.title != "posts")
        .filter(p => "/posts/" in p.url)
        .filter(p => p.at("draft", default: false) == false)
        .sorted(key: p => p.date)
        .rev()
)

#html.div(class: "space-y-6")[
    #for post in posts.slice(0, calc.min(posts.len(), 5)) {
        utils.post-card(post)
    }
]

