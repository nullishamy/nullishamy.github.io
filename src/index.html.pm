#lang pollen

◊(define-meta template "template-index.html")

◊main[#:class "grid grid-cols-1 lg:grid-rows-2 lg:grid-cols-2 gap-8 h-full w-full lg:m-2 lg:px-36 lg:py-38"]{
  ◊section[#:class "row-span-2 border border-rose-400 p-2 flex flex-col bg-neutral-50"]{
    ◊h1[#:class "text-4xl mb-4"]{
      hello, i'm amy
    }

    ◊div[#:class "text-lg flex-1"]{
      ◊p{
	    I'm a sysadmin by trade and a developer by hobby with a passion for digging into the internals of software and ecosystems.
      }
	  ◊p{
	    I've built ◊a[#:class "text-blue-500 underline" #:href "https://github.com/nullishamy/kate"]{a JVM}, run my own homelab, and mess around with electronics on occasion.
      }
	  
	  ◊br[]

	  ◊p{
	    In the near future I intend on exploring embedded hardware & RF with some home-assistant integrated sensors and an RF SDR. Stay tuned here for posts about that!
      }
	  
	  ◊hr[#:class "mt-6 border border-rose-500 border-dashed"]{}
    }

	◊div[#:class "flex flex-row items-center justify-center gap-4"]{
	  ◊a[#:href "https://ctp-webr.ing/amy/previous"]{<-}
	  ◊span{webring}
	  ◊a[#:href "https://ctp-webr.ing/amy/next"]{->}
    }

    ◊hr[#:class "mt-6 border border-rose-500 border-dashed"]{}

    ◊div[#:class "flex flex-row gap-4 my-6 w-full justify-center"]{
	  ◊a[#:href "https://linus.dev" #:target "_blank"]{
        ◊img[#:src "https://linus.dev/images/88x31.png" #:alt "An 88x31 button. A cartoonish penguin is on the left. Next to it is the text 'linus' in white letters."]
      }

	  ◊a[#:href "https://theresnotime.co.uk" #:target "_blank"]{
        ◊img[#:src "https://www.theresnotime.co.uk/button.png" #:alt "An 88x31 button. It features a cartoon fox face with the words 'TheresNoTime' on the bottom."]
      }

	  ◊img[#:src "https://aprl.cat/88x31/queercoded.png" #:alt "An 88x31 button. It has a rainbow background with the text 'you're telling me a queer coded this'? prominently."]
	  
	  ◊img[#:src "/assets/88x31/trans.png" #:alt "An 88x31 button. It is the trans flag"]
	  
	  ◊img[#:src "/assets/88x31/ace.png" #:alt "An 88x31 button. It is the asexual flag"]

	  ◊img[#:src "/assets/88x31/racket.png" #:alt "An 88x31 button. It has the racket language logo, with the text 'powered by racket' next to it."]

	  ◊a[#:href "https://volpeon.ink" #:target "_blank"]{
	    ◊img[#:src "https://slatecave.net/resources/badges/volpeon-ink.svg/" #:alt "An 88x31 button. It has a dragon on the right, silhouetted, with the text 'volpeon' to the left of it."]
	  }

	  ◊a[#:href "https://codeberg.org/" #:target "_blank"]{
	   ◊img[#:src "https://slatecave.net/resources/badges/88x31_codeberg-org.png" #:alt "An 88x31 button. It contains the codeberg logo."]
	  }
    }
  }

  ◊section[#:class "border border-rose-400 p-2 flex flex-col gap-2 bg-neutral-50"]{
    ◊h2[#:class "text-3xl"]{ recent posts }
	◊hr[#:class "mb-2 border border-rose-500 border-dashed"]{}

    ◊div[#:class "grid grid-cols-2 grid-rows-2 gap-2 flex-1"]{
	  ◊post-card[
	    #:to "/posts/pollenating.html"
		#:title "pollenating your blog"
		#:description "embrace your inner PL nerd with Pollen"
      ]
	  
	  ◊post-card[
	    #:to "/posts/test-post.html"
		#:description "just a test post to make sure everything is working"
		#:title "test post"
      ]
	  
	  ◊post-card[
	    #:to "/post.1.html"
		#:title "???"
      ]
	  
	  ◊post-card[
	    #:to "/post-1.html"
		#:title "???"
      ]
    }
  }

  ◊section[#:class "border border-rose-400 p-2 flex flex-col gap-2 bg-neutral-50"]{
    ◊h2[#:class "text-3xl"]{ find me elsewhere }
	◊hr[#:class "mb-2 border border-rose-500 border-dashed"]

    ◊div[#:class "flex-1 p-4 grid grid-cols-6 grid-rows-3 items-center justify-items-center"]{
	  ◊personal-link[
	    #:class "h-20 w-20"
		#:label "GitHub"
		#:url "https://github.com/nullishamy"
      ]

      ◊personal-link[
	    #:class "h-24 w-24 col-start-2 row-start-2"
		#:label "Fediverse"
		#:url "https://jvm.social/@amy"
      ]
	  
	  ◊personal-link[
	    #:class "h-24 w-24 col-start-4 row-start-3"
        #:label "Discord"
		#:subtext "@amycodes"
		#:url "discord://-/users/637032376731566082"
      ]
	  
	  ◊personal-link[
	    #:class "h-14 w-14 col-start-5 row-start-2"
		#:label "Email"
		#:url "mailto:contact@amyerskine.me"
      ]
	  
	  ◊personal-link[
	    #:class "h-20 w-20 col-start-6 row-start-3"
		#:label "???"
		#:url "???"
      ]
	  
	  ◊personal-link[
	    #:class "h-20 w-20 col-start-3 row-start-1"
		#:label "???"
		#:url "???"
      ]
    }
  }
}	  	  


