<script lang="ts">
  import { type Tag } from "./types";
  export let tag: Tag
</script>
<div class="rounded-full min-w-12 h-6 bg-crust text-black flex flex-col items-center justify-center outline-blue outline-1 outline">
  <p class="text-xs">{tag.name}</p>
</div>