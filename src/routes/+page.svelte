<script lang="ts">
	import ExternalRead from '../ExternalRead.svelte';
	import WorkingOnCard from '../WorkingOnCard.svelte';
  import { externalReads, posts } from '../data'

</script>

<div class="flex flex-row mx-6 gap-6">
	<header class="flex flex-col basis-5/6 gap-8">
		<h1
			class="text-7xl mt-4 font-title bg-clip-text text-transparent py-3 bg-gradient-to-r from-maroon to-pink"
		>
			Hello, I’m Amy
		</h1>
		<section class="bg-mantle p-3 my-4 rounded-md mt-auto font-mono drop-shadow-md">
			<p>A hobbyist software developer, based in the UK.</p>
			<br />
			<p>
				Most commonly, I am working on various personal projects, but also spend time contributing
				to open source.
			</p>
			<p>
				I help out over at <a
					href="https://github.com/catppuccin/catppuccin"
					class="text-blue underline">Catppuccin</a
				>, and help develop various internal and external tools for
				<a href="https://github.com/TheCodingDen/" class="text-blue underline">The Coding Den</a>.
			</p>
			<br />
			<p>
				I am most interested in backend technologies, but also dabble with frontend, as you can see
				here!
			</p>
		</section>
	</header>

	<section class="bg-mantle p-2 my-4 rounded-md basis-2/6 font-mono drop-shadow-md">
		<h2 class="text-center text-xl">You can find me in other places:</h2>
	</section>
</div>

<main class="flex flex-row mt-8 gap-16 mx-6">
	<section class="flex flex-col w-1/2 basis-2/3 ">
		<h2 class="text-2xl m-6 underline self-center font-medium font-mono">
			Here's what I've been up to lately
		</h2>

		<div class="grid grid-cols-2 items-center justify-items-center grid-rows-3 gap-6 drop-shadow-md">
			{#each posts as post}
				<WorkingOnCard {post} />
			{/each}
		</div>
	</section>

	<section class="flex flex-col w-1/2 basis-1/3 font-mono">
		<h2 class="text-2xl m-6 underline self-center font-medium">Interesting reads I've found</h2>

		<div class="grid grid-cols-1 items-center justify-items-center grid-rows-3 gap-6 drop-shadow-md">
			{#each externalReads as post}
				<ExternalRead {post} />
			{/each}
		</div>
	</section>
</main>
