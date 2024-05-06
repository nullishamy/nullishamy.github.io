<script lang="ts">
	import Icon from '@iconify/svelte';
	import type { Post } from '../../../types';
	import SvelteMarkdown from 'svelte-markdown';
	import HighlightedCode from './HighlightedCode.svelte';
	import AnchoredHeading from '../../AnchoredHeading.svelte';

	export let data: Post;
</script>

<svelte:head>
	<title>Amy | {data.title}</title>
	<meta property="og:title" content="amy | {data.title}" />
	<meta property="og:site_name" content="amy.is-a.dev" />
	<meta property="og:url" content="https://amy.is-a.dev/post/{data.slug}" />
	<meta property="og:description" content={data.blurb} />
	<meta property="og:type" content="article" />

	<meta name="twitter:card" content="summary_large_image" />

	<meta name="theme-color" content="#EA76CB" />
	<meta name="description" content="{data.blurb}">
	<meta name="color-scheme" content="light" />
</svelte:head>

<section class="flex flex-col items-center justify-items-center gap-8 mt-4 mb-36">
	<div class="grid grid-cols-4 md:grid-cols-5 items-center justify-items-center">
		<a href="/" aria-label="Go to the home page"><Icon icon="ph:house" width="35" height="35" /></a>
		<h1 class="text-4xl lg:text-6xl font-title col-span-3 row-span-2 text-center">
			{data.title}
		</h1>
		<p class="text-md md:text-xl border-t-black border-t-2">
			{data.publishDate.toLocaleDateString()}
		</p>
	</div>

	<div
		class="text-md lg:text-lg font-mono rounded-md p-4 max-w-screen-lg prose z lg:prose-lg prose-ctp w-full md-content"
	>
		<SvelteMarkdown
			source={data.content}
			renderers={{
				code: HighlightedCode,
				heading: AnchoredHeading
			}}
		/>
	</div>
</section>
