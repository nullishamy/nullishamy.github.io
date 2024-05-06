<script lang="ts">
	import Icon from '@iconify/svelte';
	import Tag from './Tag.svelte';
	import { type Post } from './types';
	export let post: Post;
</script>

<div class="w-full h-40 bg-mantle rounded-md mx-4 p-3 relative drop-shadow-md">
	<h2 class="text-lg font-medium mb-1 font-mono">{post.title}</h2>
	<p class="text-ellipsis text-sm w-2/3 font-mono">{post.blurb}</p>

	<div class="grid grid-cols-2 grid-rows-2 absolute right-0 bottom-0 m-2 gap-2">
		{#each post.tags as tag}
			<Tag
				tag={{
					name: tag
				}}
			/>
		{/each}
	</div>

	<a
		href={`/post/${post.slug}`}
		aria-label={`A blog post, ${post.blurb}`}
		class="absolute right-0 top-0 m-2 text-blue focus:outline-black focus:outline focus:outline-2 focus:rounded-md"
		tabindex={0}><Icon width="24" height="24" icon="ph:arrow-square-out"></Icon></a
	>
</div>
