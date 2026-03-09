#import "/templates/tola.typ": wrap-page
#import "/templates/base.typ": base, colors
#import "/utils/tola.typ": cls
#import "@tola/site:0.0.0": info

#let page = wrap-page(
  base: base,
  head: m => [
    #if m.title != none {
      html.title(m.title + " | " + info.title)
    } else {
      html.title(info.title)
    }
  ],
  view: (body, m) => {
    show heading.where(level: 1): it => html.h2(class: cls("text-2xl font-bold mt-8 mb-4", colors.accent))[#it.body]
    show heading.where(level: 2): it => html.h3(class: "text-xl font-semibold mt-6 mb-3")[#it.body]
    body
  },
)
