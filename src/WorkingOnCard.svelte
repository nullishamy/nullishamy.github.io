<script lang="ts">
	import Icon from '@iconify/svelte';
	import Tag from './Tag.svelte';
	import { type Post } from './types';
	export let post: Post;
</script>

<div class="w-full h-40 bg-mantle rounded-md mx-4 p-3 relative drop-shadow-md">
	<h2 class="text-lg font-medium mb-1">{post.title}</h2>

  <p class="text-ellipsis text-sm w-2/3">{post.blurb}</p>

	<div class="grid grid-cols-2 grid-rows-2 absolute right-0 bottom-0 m-2 gap-2">
    {#each post.tags as tag}
		<Tag
			tag={{
				name: tag
			}}
		/>
    {/each}
	</div>

	<a href={`/post/${post.slug}`}
		><Icon
			width="24"
			height="24"
			icon="ph:arrow-square-out"
			class="absolute right-0 top-0 m-2 text-blue"
		></Icon></a
	>
</div>
