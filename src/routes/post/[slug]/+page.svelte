<script lang="ts">
	import type { Post } from "../../../types";
  import SvelteMarkdown from "svelte-markdown";

	export let data: Post;
</script>
<section class="flex flex-col items-center justify-items-center gap-8 mt-4">
  <h1 class="text-6xl font-title">{data.title}</h1>
  <div class="text-lg font-mono rounded-md p-4 max-w-screen-lg prose prose-ctp">
    <SvelteMarkdown source={data.content} />
  </div>
</section>