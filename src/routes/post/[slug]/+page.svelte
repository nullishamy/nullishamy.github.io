<script lang="ts">
	import type { Post } from '../../../types';
	import SvelteMarkdown from 'svelte-markdown';

	export let data: Post;
</script>

<svelte:head>
	<title>Amy | {data.title}</title>
	<meta property="og:title" content="Amy | {data.title}" />
	<meta property="og:site_name" content="Amy's Site" />
	<meta property="og:url" content="https://amy.is-a.dev/post/{data.slug}" />
	<meta property="og:description" content="{data.blurb}" />
	<meta property="og:type" content="article" />
	<meta name="twitter:card" content="summary_large_image" />
</svelte:head>

<section class="flex flex-col items-center justify-items-center gap-8 mt-4 mx-4">
	<h1 class="text-4xl lg:text-6xl font-title">{data.title}</h1>
	<div class="text-md lg:text-lg font-mono rounded-md p-4 max-w-screen-lg prose  lg:prose-lg prose-ctp">
		<SvelteMarkdown source={data.content} />
	</div>
</section>
