#let callout(body, title: "Callout", bg: "bg-blue-500") = {
  html.div(class: "flex flex-col w-full p-2 my-4 rounded-md gap-2 " + bg)[
      #html.span(class: "text-2xl font-bold")[
          #title
      ]
      #html.span[#body]
  ]
}

#let info = callout.with(
    title: "info",
    bg: "bg-blue-200",
)

#let note = callout.with(
    title: "note",
    bg: "bg-blue-200",
)

#let tip = callout.with(
    title: "tip",
    bg: "bg-cyan-200",
)

#let warning = callout.with(
    title: "warning",
    bg: "bg-yellow-200",
)

#let danger = callout.with(
    title: "danger",
    bg: "bg-red-200",
)


