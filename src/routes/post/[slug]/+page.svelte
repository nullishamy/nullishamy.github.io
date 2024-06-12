<script lang="ts">
	import Icon from '@iconify/svelte';
	import type { Post } from '$lib/types';
	import SvelteMarkdown from 'svelte-markdown';
	import HighlightedCode from './HighlightedCode.svelte';
	import AnchoredHeading from './AnchoredHeading.svelte';
	import Giscus from '@giscus/svelte';
	import { onMount } from 'svelte';

	export let data: Post;

	function makeGiscusAssetRoot() {
		const url = new URL(document.URL);
		return `${url.origin}/giscus/`;
	}

	let url = '';
	onMount(() => {
		const suffix = document.documentElement.classList.contains('dark') ? 'dark' : 'light';
		url = makeGiscusAssetRoot() + `${suffix}.css`;
	});
</script>

<svelte:head>
	<title>amy | {data.title}</title>
	<meta property="og:title" content="amy | {data.title}" />
	<meta property="og:site_name" content="amy.is-a.dev" />
	<meta property="og:url" content="https://amy.is-a.dev/post/{data.slug}" />
	<meta property="og:description" content={data.blurb} />
	<meta property="og:type" content="article" />

	<meta name="twitter:card" content="summary_large_image" />

	<meta name="theme-color" content="#EA76CB" />
	<meta name="description" content={data.blurb} />
	<meta name="color-scheme" content="light" />
</svelte:head>

<section class="flex flex-col items-center justify-items-center gap-8 mt-4 mb-36">
	<div class="grid grid-cols-4 md:grid-cols-5 items-center justify-items-center min-w-full">
		<a href="/" aria-label="Go to the home page"><Icon icon="ph:house" width="35" height="35" /></a>
		<h1 class="text-3xl lg:text-5xl font-mono col-span-3 row-span-2 md:row-span-1 text-center">
			{data.title}
		</h1>
		<p class="text-md md:text-xl border-t-black border-t-2 lg:border-0">
			{data.publishDate.toLocaleDateString()}
		</p>
	</div>

	<div
		class="text-md lg:text-lg font-inclusive rounded-md p-4 max-w-screen-lg prose lg:prose-lg prose-ctp-light dark:prose-ctp-dark w-full md-content break-words"
	>
		<SvelteMarkdown
			source={data.content}
			renderers={{
				code: HighlightedCode,
				heading: AnchoredHeading
			}}
		/>
	</div>
	<div class="w-full h-full m-2 px-4">
		<Giscus
			id="comments"
			term="Leave a comment!"
			repo="nullishamy/nullishamy.github.io"
			repoId="R_kgDOHbb9xA"
			category="Comments"
			categoryId="DIC_kwDOHbb9xM4CgCvv"
			mapping="pathname"
			strict="1"
			reactionsEnabled="1"
			emitMetadata="1"
			inputPosition="top"
			theme={url}
			lang="en"
			loading="lazy"
		/>
	</div>
</section>
