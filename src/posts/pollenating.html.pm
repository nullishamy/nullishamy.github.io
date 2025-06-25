#lang pollen
◊(define-meta template "template-post.html")

◊title{
  pollenating your blog
}

◊subtitle{
  embrace your inner PL nerd with Pollen
}

◊content{
  ◊post-heading[
    #:heading "outline"
	#:id "outline"
  ]
  
  ◊p{
	I had actually conceived of this idea whilst talking with fellow nerd ◊a[#:href "https://types.pl/◊ari"]{ari}, where we imagined a static side generator written in Racket.
	It would involve a DSL for the markup, a small cli render tool, with some web support bundled in. It was on the backburner until one day she suggested I look at Pollen.
  }

  ◊p{
	Pollen is essentially what I had been thinking of building! You write your pages in Polen Markup, markdown or HTML but PM is encouraged due to its expansive feature-set when compared
	to MD.
  }
  
  ◊p{
    Templates are written in a templated HTML format where you lay out the skeleton of the page, and inject specific elements from your PM. For example, you might select the title to put into
	the <tite> element, and the subtitle to put at the top of the page.
  }

  ◊p{
	These pages are all rendered into a static side, ready to deploy wherever you want! I use GitHub Pages myself, using ◊a[#:href "https://github.com/nullishamy/nullishamy.github.io/blob/main/.github/workflows/build.yml"]{this action I wrote} to automatically publish the site on pushes to main.
  }

  ◊post-heading[
    #:heading "the markup experience"
	#:id "markup"
  ]

  ◊p{
	One of the the things that might scare people the most is the markup, but with a few examples I hope to show that it isn't so bad!
	Tag elements are prefixed by the lozenge (◊"◊"), which is the only character treated specially by Pollen. You can customise it, though it doesn't change it
	absolutely everywhere, so be warned.
  }

  ◊p{
	There's editor integrations for all the common ones to provide a convenient way to type it. In ◊a[#:href "https://github.com/lijunsong/pollen-mode"]{lijunsong/pollen-mode}, typing `@` gets you
	a lozenge, typing it twice gets you the actual @ symbol.

	Here's a basic example:
	◊codeblock{
	◊"◊"p{
	paragraph content goes here
    }}
  }

  ◊p{
    You will notice that the tag names closely map to HTML tags, but Pollen does not limit you at all with how you define tags.
	To Pollen, tags are just lisp functions. This means you can redefine them, define new ones, and compose them however you'd like.
	For example, the codeblock above:
	◊codeblock{
	(define (trim-first L)
      (if (regexp-match-exact? #px"\\s*" (list-ref L 0)) (rest L) L))

    (define (codeblock . lines)
      (define container-classes "font-monospace whitespace-pre text-black bg-gray-100 rounded-md p-2 block text-wrap my-2")
      `(span ((class ,container-classes))
             (span ,@(trim-first lines))))
    }
	Is then called like so:
	◊codeblock{
	◊"◊"codeblock {
	// Code
    }
    }
  }

  ◊post-heading[
    #:heading "publishing"
	#:id "publishing"
  ]

  ◊p{
    Publishing your Pollen site is exceedingly simple.
	◊br[]
	My build script is ◊code{raco pollen render src && raco pollen render src/posts}
	It will then output the rendered HTML next to each template, so you can simply deploy ◊code{src} to any static host.
  }

  ◊post-heading[
    #:heading "a small gripe"
	#:id "gripes"
  ]

  ◊p{
    As much as I praise and enjoy the flexibily of Pollen's markup system, it can be rather challenging to get used to with limited documentation / tooling
	feedback to support you. The tight integration with Racket is a great blessing and a horrific curse, as Racket's runtime errors are less than helpful a lot of the time.
  }
  
  ◊p{
	I hope, with this little article/site, to give a practical example for bloggers on how they can get up and going with Pollen's core elements.
  }

  ◊post-heading[
    #:heading "future ideas"
	#:id "ideas"
  ]

  ◊p{
    In the future, I'd like to improve the way I store and display posts, such that I can utilise them from the lisp side.
	This will allow me to dynamically show the latest posts, offer limited search through tags, have a 'time to read' metric, etc.
  }

  ◊p{
	Hopefully this adventure can turn into its own little meta-SSG for bloggers to utilise.
  }
}