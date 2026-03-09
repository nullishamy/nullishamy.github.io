// Layout components
// Import: #import "/components/layout.typ" as layout

#import "/utils/tola.typ": cls

/// Horizontal rule with default styling
#let hr = html.hr(class: "border-surface my-8")


/// Flex row container with configurable gap
/// safelist: gap-1 gap-2 gap-3 gap-4 gap-5 gap-6 gap-7 gap-8
#let flex-row(gap: 4, ..items) = html.div(
  class: cls("flex flex-wrap items-center", "gap-" + str(gap)),
)[#for item in items.pos() { item }]


/// Flex column container with configurable gap
/// safelist: gap-1 gap-2 gap-3 gap-4 gap-5 gap-6 gap-7 gap-8
#let flex-col(gap: 4, ..items) = html.div(
  class: cls("flex flex-col", "gap-" + str(gap)),
)[#for item in items.pos() { item }]


/// Grid container
/// safelist: grid-cols-1 grid-cols-2 grid-cols-3 grid-cols-4
#let grid(cols: 2, gap: 4, ..items) = html.div(
  class: cls("grid", "grid-cols-" + str(cols), "gap-" + str(gap)),
)[#for item in items.pos() { item }]
