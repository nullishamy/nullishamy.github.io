<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>◊select['h1 doc]</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Rubik:ital,wght@0,300..900;1,300..900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/styles.css" type="text/css" media="screen"/>
	
	<meta name="description" content="◊select['subtitle doc]">

	<!-- Facebook Meta Tags -->
	<meta property="og:url" content="https://amy.is-a.dev">
	<meta property="og:type" content="website">
	<meta property="og:title" content="amy erskine | ◊select['title doc">
	<meta property="og:description" content="◊select['subtitle doc]">
	<meta property="og:image" content="https://amy.is-a.dev/assets/og.png">

	<!-- Twitter Meta Tags -->
	 <meta name="twitter:card" content="summary_large_image">
	 <meta property="twitter:domain" content="amy.is-a.dev">
	 <meta property="twitter:url" content="https://amy.is-a.dev">
	 <meta name="twitter:title" content="amy erskine | ◊select['title doc">
	 <meta name="twitter:description" content="◊select['subtitle doc]">
	 <meta name="twitter:image" content="https://amy.is-a.dev/assets/og.png">
  </head>

  <body class="flex flex-col h-screen p-4 max-w-4xl m-auto prose">
    <nav class="mb-12">
      <a href="/" class="text-lg"><- Home</a>
    </nav>
    
    <h1 class="text-6xl">◊select['title doc]</h1>

    <span class="text-3xl mb-2">
      ◊select['subtitle doc]
      <hr class="mt-2 border border-rose-500 border-dashed w-full not-prose"></hr>
    </span>
    
    <main>
      ◊(->html (select* 'content doc))
    </main>
  </body>
</html>
