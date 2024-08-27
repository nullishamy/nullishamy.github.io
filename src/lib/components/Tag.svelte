<script lang="ts">
	import { type Tag } from '../types';
	export let tag: Tag;
</script>

<div
	class="rounded-full p-1 min-w-12 h-6 bg-crust flex flex-col items-center justify-center
	outline-blue outline-1 hover:outline outline-dashed"
>
	<a
		class="text-xs"
		href={`/post/by-tag/${tag.name}`}
		aria-label={`Search for posts with tag '${tag.name}'`}
	>
		{tag.name}
	</a>
</div>
