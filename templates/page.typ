#import "/templates/base.typ": base, colors
#import "/utils/helpers.typ" as utils

#let page(title: none, body) = {
    if title != none { [#metadata((title: title)) <tola-meta>] }

    show heading.where(level: 1): it => html.h2(
        class: "text-2xl font-bold mt-8 mb-4",
    )[#it.body]
    show heading.where(level: 2): it => html.h3(
        class: "text-xl font-semibold mt-6 mb-3",
    )[#it.body]

    show: base

    body
}
