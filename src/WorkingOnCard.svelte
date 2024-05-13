<script lang="ts">
	import Icon from '@iconify/svelte';
	import Tag from './Tag.svelte';
	import { type Post } from './types';
	export let post: Post;
</script>

<a
	class="
		w-full h-40 bg-mantle rounded-md mx-4 p-3 relative drop-shadow-md outline outline-1 outline-peach
	focus:outline-black focus:outline focus:outline-2 focus:rounded-md
	dark:focus:outline-white
	"
	href={`/post/${post.slug}`}
	aria-label={`A blog post, ${post.blurb}`}
>
	<h2 class="text-lg font-medium mb-1 font-inclusive mr-6">{post.title}</h2>
	<p class="text-ellipsis text-sm font-inclusive">{post.blurb}</p>

	<div class="grid grid-flow-col absolute right-0 bottom-0 m-2 gap-2">
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
		target="_blank"
		aria-label={`A blog post, ${post.blurb}`}
		class="absolute right-0 top-0 m-2 text-blue focus:outline-black focus:outline focus:outline-2 focus:rounded-md dark:focus:outline-white"
		tabindex={0}><Icon width="24" height="24" icon="ph:arrow-square-out"></Icon></a
	>
</a>
