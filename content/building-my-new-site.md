## choosing a framework

Choosing the right framework to iterate on my website was challenging, given the fruitful choice of tools available in the
web development space today.

Previously, I had used [Astro](https://astro.build/), and whilst it was sufficient for the goals I had, I felt too limited in scope.
I wanted something more flexible, something more mature, but still keeping to some common goals:

1. SSG (Static Site Generation) is a must
2. TypeScript support is a must
3. TailwindCSS support would be nice

With these choices in mind, and given the opinions and shared thoughts from others, I settled on [Svelte](https://svelte.dev/) (with [SvelteKit](https://kit.svelte.dev/)).
I chose it to try something new, as I have never written Svelte before, alongside seeing some quality results from both an aesthetics and code quality perspective.

## first impressions

After getting started with their `npm` creation tool, I had no issue getting the boilerplate template up and running. What greeted me in my editor
was at first rather confusing, with various symbols in the file names and odd suffixes scattered throughout.

I immediately jumped to the docs to make sense of this, to which I found some excellent information. Svelte uses the `+` prefix on a `.svelte` file to denote
that it has semantic meaning. For example, `+page.svelte` represents the page that will be rendered at that path.
The path is determined by the file system structure of your project, as it appears in code.

Alongside `+page.svelte` lay `+page.ts`, which I found out relates to the configuration of the page, instructing Svelte what to do with respect to pre-rendering -
ie static generation (!) -, hydration, etc.

```typescript
// Whether or not pages should be server-rendered
export const ssr = false;

// Whether to load the SvelteKit client
export const csr = true;

// Whether to prerender pages at build time, instead of per-request
export const prerender = true;

// Whether to strip, add, or ignore trailing slashes in URLs
export const trailingSlash = 'ignore';
```

Once I understood this basic layout, I got to work.

## further development

Once the basics were out of the way, the workflow felt quite similar to Astro, with the 'layout' system denoting re-usable wrappers for your content, and the
frontmatter type scripting within pages & components.

```xml
<-- 'Frontmatter' scripts for setting up the component -->
<script>
	import './styles.css';
	import './catppuccin-highlightjs.css';

	import '@fontsource/lily-script-one';
	import '@fontsource-variable/jetbrains-mono';
</script>

<-- Main component -->
<main class="max-w-screen-2xl m-auto">
	<slot />
</main>
```

Familiar but still distinct, Svelte's editor integrations and overall cleanliness really showed here.
Keeping things organised was pretty easy, keeping each part of the site separate in its own folder, and keeping each page's separate configuration separate too.

Once I had my layout sorted, it was time to polish it up ready for content. For icons, I grabbed [@iconify/svelte](https://www.npmjs.com/package/@iconify/svelte),
for fonts I used [FontSource](https://fontsource.org/docs/guides/svelte), and for Markdown rendering I grabbed [svelte-markdown](https://www.npmjs.com/package/svelte-markdown).

The ease of integration and widespread availability of these modules reminds me of the React ecosystem, where just about anything you could need has already been
made, and will generally work well out of the box.
This was very different to my experience with Astro, where the framework would try and vendor these types of features, leading to integration headaches for me.

Once I had the main area sorted out, I looked toward building the content system. I opted for a fairly simple hand-rolled approach, using JS objects to configure
articles alongside Markdown files for the contents.

```typescript
import type { ExternalPost, Post } from './types';

const TODO_POST: Post = {
	title: 'Coming soon:tm:',
	content: 'N/A',
	publishDate: new Date(),
	blurb: "I haven't written this one yet!",
	slug: 'todo',
	tags: []
};

const TODO_READ: ExternalPost = {
	title: 'TBD',
	author: 'Unknown',
	externalLink: 'https://google.com',
	blurb: "I haven't filled this one out yet!"
};

export const externalReads: ExternalPost[] = [
	{
		title: 'optimizing my sveltekit blog',
		externalLink: 'https://www.refact0r.dev/blog/optimizing-sveltekit',
		author: 'refact0r',
		blurb:
			'Improving performance on a static SvelteKit site by optimising images, fonts, and markup.'
	},
	TODO_READ,
	TODO_READ
];

export const posts: Post[] = [
	// This page!
	{
		title: 'building my site with SvelteKit',
		content: 'N/A',
		publishDate: new Date('05/05/2024'),
		blurb: 'Exploring new tools and technologies for fun and profit',
		slug: 'building-my-new-site',
		tags: []
	},
	TODO_POST,
	TODO_POST,
	TODO_POST,
	TODO_POST,
	TODO_POST
];
```

I had used something similar in my Astro project, and aimed to replicate that functionality here, without the
pains of course. I was pleasantly surprised to see Svelte coming out of the box with dynamic routing (with SSG support!), and easy ways to plug in to the build
steps, which I needed to load up the Markdown files.

## closing thoughts

Whilst I initially had trouble getting to grips with Svelte's filesystem-first approach, their extensive documentation and examples really helped accelerate my
knowledge, allowing me to build the first version of this website in just 1 day. It feels like Svelte has the right amount of vendored features, whilst
encouraging easy and convenient community libraries to help fill any gaps. This sort of process reminds me of my experience learning Rust, which is a strong
indicator to me that I will enjoy iterating on this design as time goes on.

I still have plenty of things I want to touch up; adding some animation, accessibility, optimizing performance, but I'm very happy with how the first version
turned out!
