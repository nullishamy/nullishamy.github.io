<script lang="ts">
	import Icon from '@iconify/svelte';
	import { type ExternalPost } from './types';
	export let post: ExternalPost;
</script>

<div class="w-full h-40 bg-mantle rounded-md mx-4 p-3 relative drop-shadow-md outline outline-1 outline-flamingo">
	<h2 class="text-lg font-medium mb-1 font-inclusive mr-6">"{post.title}" by {post.author}</h2>
	<p class="text-ellipsis text-sm font-inclusive">{post.blurb}</p>

	<a
		href={post.externalLink}
		target="_blank"
		aria-label={`An external article, ${post.blurb}`}
		class="absolute right-0 top-0 m-2 text-blue focus:outline-black focus:outline focus:outline-2 focus:rounded-md"
		tabindex={0}><Icon width="24" height="24" icon="ph:arrow-square-out"></Icon></a
	>
</div>
