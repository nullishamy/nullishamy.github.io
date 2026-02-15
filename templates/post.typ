#import "/templates/base.typ": base, colors
#import "/utils/helpers.typ" as utils

#let allendotes = state("endnotes", ())
#let amt-of-endnotes = counter("amt-of-endnotes")

#let endnote(cnt) = {
    amt-of-endnotes.step(level: 2)
    context {
        allendotes.update(x => x + (cnt + parbreak(),))
    
        let currheading = counter(heading).get().first()
        let idx = amt-of-endnotes.get().last()
    
        link("#fn-" + str(idx))[#super[#idx]]
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

#let post(
    title: none,
    date: none,
    update: none,
    author: none,
    summary: none,
    tags: (),
    draft: false,
    body,
) = {
    // Metadata for tola
    [#metadata((
        title: title,
        date: date,
        update: update,
        author: author,
        summary: summary,
        tags: tags,
        draft: draft,
    )) <tola-meta>]

    show heading.where(level: 1): it => {
        let id = lower(repr(it.body).replace("\"", "").replace(" ", "-"))
        html.h2(class: "text-2xl font-bold mt-8 mb-4 " + colors.accent, id: id)[
            #html.a(
                class: "hover:underline underline-offset-4",
                href: "#" + id,
            )[#it.body]
        ]
    }
    show heading.where(level: 2): it => {
        let id = lower(repr(it.body).replace("\"", "").replace(" ", "-"))
        html.h3(class: "text-xl font-semibold mt-6 mb-3", id: id)[
            #html.a(
                class: "hover:underline underline-offset-4",
                href: "#" + id,
            )[#it.body]
        ]
    }

    let title-view = if title != none {
        html.h1(
            class: "text-3xl sm:text-4xl font-bold text-center my-6",
        )[#title]
    }

    let subtitle-view = if date != none or author != none {
        let parts = ()
        if date != none { parts.push(date) }
        if author != none { parts.push("by " + author) }
        html.div(class: "text-center " + colors.muted)[#parts.join(" · ")]
    }

    let summary-view = if summary != none {
        html.div(class: "text-center italic my-4 " + colors.muted)[#summary]
    }

    let tags-view = if tags.len() > 0 {
        html.div(class: "flex flex-wrap justify-center gap-2 my-4")[
            #for tag in tags {
                html.a(
                    href: "/tags/" + tag,
                    class: "px-2 py-1 text-sm bg-surface rounded text-accent",
                )[#tag]
            }
        ]
    }

    show: base

    html.article[
        #title-view #subtitle-view #tags-view #summary-view #utils.hr #body
    ]
    
    showendnote()
}
