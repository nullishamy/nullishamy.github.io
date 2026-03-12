#import "/templates/tola.typ": wrap-page
#import "/templates/base.typ": base, colors
#import "/components/layout.typ" as layout
#import "/utils/tola.typ": cls, og-tags, set-tab-title, to-string
#import "@tola/site:0.0.0": info
#import "@tola/current:0.0.0": headings
#import "/utils/helpers.typ" as utils

#let allendotes = state("endnotes", ())
#let amt-of-endnotes = counter("amt-of-endnotes")

#let endnote(cnt) = {
    amt-of-endnotes.step(level: 2)
    context {
        allendotes.update(x => x + (cnt + parbreak(),))
    
        let currheading = counter(heading).get().first()
        let idx = amt-of-endnotes.get().last()
    
        html.a(href: "#fn-" + str(idx))[#super[#idx]]
    }
}

#let showendnote(name: "references") = context {
    if amt-of-endnotes.get().len() == 1 {
        return
    }

    utils.hr

    let currheading = counter(heading).get().first()
    let (level, amt) = amt-of-endnotes.get()

    html.ul[
        #for idx in range(amt) {
            let num = str(level) + "." + str(idx + 1)
    
            html.li(id: "fn-" + str(idx + 1))[
                #super[#(idx + 1)]
                #allendotes.get().at(idx) #label(num)
            ]
        }    
    ]
    
    amt-of-endnotes.step()
    allendotes.update(x => ())
}

#let post = wrap-page(
  base: base,

  // custom html head
  // `m`: page metadata
  head: m => [
    #og-tags(
      title: m.title,
      description: m.summary,
      type: "article",
      site-name: info.title,
      author: m.author,
      published: m.date,
      tags: m.tags,
      image: "/images/avatar.png"  
    )
    #if m.title != none {
      html.title(m.title + " | " + info.title)
    }
  ],

  // custom html body
  // `body`: page body
  // `m`: page metadata
  view: (body, m) => {
    let heading-id(text) = lower(to-string(text).replace("/", "-"))

    // Show rules
    show heading.where(level: 1): it => {
      let id = heading-id(it.body)
      html.h2(class: cls("text-2xl font-bold mt-8 mb-4", colors.accent), id: id)[
        #html.a(class: "hover:underline underline-offset-4", href: "#" + id)[#it.body]
      ]
    }
    show heading.where(level: 2): it => {
      let id = heading-id(it.body)
      html.h3(class: "text-xl font-semibold mt-6 mb-3", id: id)[
        #html.a(class: "hover:underline underline-offset-4", href: "#" + id)[#it.body]
      ]
    }

    // Views
    let title-view = if m.title != none {
      html.h1(class: "text-3xl sm:text-4xl font-bold text-center my-6")[#m.title]
    }

    let subtitle-view = if m.date != none or m.author != none {
      let parts = ()
      if m.date != none { parts.push(m.date.display("[year]-[month]-[day]")) }
      if m.author != none { parts.push("by " + m.author) }
      html.div(class: cls("text-center", colors.muted))[#parts.join(" · ")]
    }

    let summary-view = if m.summary != none {
      html.div(class: cls("text-center italic my-4", colors.muted))[#m.summary]
    }

    let tags-view = if m.tags.len() > 0 {
      html.div(class: "flex flex-wrap justify-center gap-2 my-4")[
          #for tag in m.tags {
              html.a(
                  href: "/tags/" + tag,
                  class: "px-2 py-1 text-sm bg-surface rounded text-accent"
              )[#tag]
          }
      ]
    }

    // TOC using headings from @tola/current
    let toc-view = if headings.len() > 0 {
      html.nav(class: "my-6 p-4 border border-slate-400")[
        #html.div(class: "font-bold mb-3")[Contents]
        #html.div(class: "text-sm space-y-1")[
          #for h in headings {
            let id = heading-id(h.text)
            let indent = if h.level == 1 { "" } else { "pr-2" }
            let prefix = if h.level == 1 { "" } else { "→" }
            let prefix = html.span(class: cls("text-black/75", indent))[#prefix]
            let text = html.a(class: "hover:text-sky-400 hover:underline underline-offset-4", href: "#" + id)[#h.text]
            let item-class = if h.level == 1 { "mt-5 first:mt-0" } else { "" }
            html.div(class: item-class)[
              #prefix#text
            ]
          }
        ]
      ]
    }

    html.article(class: "space-y-6")[
      #title-view #subtitle-view #tags-view #summary-view #toc-view #layout.hr #body
    ]

    showendnote()
  },
)
