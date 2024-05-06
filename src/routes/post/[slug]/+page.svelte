<script lang="ts">
	import Icon from '@iconify/svelte';
import type { Post } from '../../../types';
	import SvelteMarkdown from 'svelte-markdown';

	export let data: Post;
</script>

<svelte:head>
	<title>Amy | {data.title}</title>
	<meta property="og:title" content="Amy | {data.title}" />
	<meta property="og:site_name" content="amy.is-a.dev" />
	<meta property="og:url" content="https://amy.is-a.dev/post/{data.slug}" />
	<meta property="og:description" content={data.blurb} />
	<meta property="og:type" content="article" />
	<meta property="og:image" content="https://amy.is-a.dev/favicon.png" />
	<meta name="twitter:card" content="summary_large_image" />
	<meta name="theme-color" content="#EA76CB" />
	<meta name="color-scheme" content="light" />
</svelte:head>

<section class="flex flex-col items-center justify-items-center gap-8 mt-4 mx-4">
	<div class="grid grid-cols-4 lg:grid-cols-5 items-center justify-items-center">
		<a href="/"><Icon icon='ph:house' width=35 height=35/></a>
		<h1 class="text-4xl lg:text-6xl font-title col-span-3 lg:col-span-3 text-center">
			{data.title}
		</h1>
	</div>

	<div
		class="text-md lg:text-lg font-mono rounded-md p-4 max-w-screen-lg prose z lg:prose-lg prose-ctp"
	>
		<SvelteMarkdown source={data.content} />
	</div>
</section>
