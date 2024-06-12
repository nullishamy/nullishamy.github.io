<script lang="ts">
	import Icon from '@iconify/svelte';
	import type { Post } from '$lib/types';

	export let data: { posts: Post[]; query: string };
</script>

<section class="flex flex-col items-center justify-items-center gap-8 m-4 mb-36">
	<div class="grid grid-cols-4 md:grid-cols-5 items-center justify-items-center">
		<a href="/" aria-label="Go to the home page"><Icon icon="ph:house" width="35" height="35" /></a>
		<h1 class="text-3xl lg:text-5xl font-mono col-span-3 row-span-2 md:row-span-1 text-center">
			Posts with tag '{data.query}'
		</h1>
	</div>

	{#each data.posts as post}
		<a
			href="/post/{post.slug}"
			class="rounded-md p-2 m-2 bg-base shadow-md grid grid-cols-4 gap-y-2 font-inclusive w-full md:w-3/5 lg:w-2/5"
		>
			<p class="text-subtext1 text-lg row-span-2">{post.publishDate.toLocaleDateString()}</p>
			<h2 class="text-lg col-start-3 col-span-2 text-right">{post.title}</h2>
			<p class="text-sm text-subtext1 col-start-3 col-span-2 row-start-2 text-right">
				{post.blurb}
			</p>
		</a>
	{/each}
</section>
