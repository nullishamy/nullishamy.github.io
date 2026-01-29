#import "/templates/post.typ": post
#import "/utils/helpers.typ" as utils

#let args = (
    title: "hello world",
    date: "2026-01-29",
    author: "amy erskine",
    summary: [the first post!],
    tags: ("tutorial", "typst", "tailwind"),
)

#show: post.with(..args)

Welcome to your first blog post! This template uses Tailwind CSS for styling.

= Text Formatting

You can use *bold*, _italic_, and `inline code`.

#quote[
    Typst is a new markup-based typesetting system that is designed to be as
    powerful as LaTeX while being much easier to learn and use.
]

= Code Blocks

```rust
fn main() {
    println!("Hello from Typst!");
}
```

```python
def greet(name):
    return f"Hello, {name}!"
```

= Lists

Unordered list:
- First item
- Second item
- Third item with `code`

Ordered list:
+ Step one
+ Step two
+ Step three

= Links

Check out these resources:
- #link("https://typst.app/docs")[Typst Documentation]
- #link("https://github.com/tola-ssg/tola-ssg")[Tola on GitHub]
- #link("https://tailwindcss.com/docs")[Tailwind CSS Docs]

= Math

The quadratic formula: $x = (-b plus.minus sqrt(b^2 - 4 a c)) / (2 a)$

A more complex example:

$ sum_(n=0)^infinity x^n / n! = e^x $

= Table

#table(
    columns: 3,
    [Feature], [Status], [Notes],
    [Math], [✓], [Full support],
    [Code], [✓], [Syntax highlighting],
    [Images], [✓], [SVG, PNG, JPEG],
)

= How This Post Works

You might notice we define metadata in an `args` dictionary at the top of this file:

```typst
#let args = (
  title: "Hello World",
  date: "2025-12-27",
  // ...
)
#show: post.with(..args)
```

**Why do we do this?**

Defining metadata in a variable allows us to **reuse** it inside the content. for example, the date below is dynamically inserted using `args.date`:

_Last updated: #(args.date)_
