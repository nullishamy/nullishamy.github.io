<script lang="ts">
	import Icon from '@iconify/svelte';
	import type { Post } from '$lib/types';

	export let data: { posts: Post[]; query: string };
</script>

<section class="flex flex-col items-center justify-items-center gap-8 mt-4 mb-36">
	<div class="grid grid-cols-4 md:grid-cols-5 items-center justify-items-center">
		<a href="/" aria-label="Go to the home page"><Icon icon="ph:house" width="35" height="35" /></a>
		<h1 class="text-3xl lg:text-5xl font-mono col-span-3 row-span-2 md:row-span-1 text-center">
			Posts with tag '{data.query}'
		</h1>
	</div>

	{#each data.posts as post}
		<a href="/post/{post.slug}" class="rounded-md p-2 m-2 bg-base shadow-md grid grid-cols-[auto_auto] gap-y-1 gap-x-12 font-inclusive">
      <p class="text-subtext1 text-lg row-span-2">{post.publishDate.toLocaleDateString()}</p>
      <h2 class="text-lg">{post.title}</h2>
			<p class="text-sm text-subtext1 ">{post.blurb}</p>
		</a>
	{/each}
</section>
