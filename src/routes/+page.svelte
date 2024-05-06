<script lang="ts">
	import ExternalRead from '../ExternalRead.svelte';
	import WorkingOnCard from '../WorkingOnCard.svelte';
	import ContactDesktop from '$lib/assets/contact-desktop.svelte'
	import ContactMobile from '$lib/assets/contact-mobile.svelte'
	import { externalReads, posts } from '../data';
	import MediaQuery from '../MediaQuery.svelte';
</script>

<svelte:head>
	<title>Amy Erskine</title>
	<meta property="og:title" content="Amy Erskine" />
	<meta property="og:site_name" content="Amy's Site" />
	<meta property="og:url" content="https://amy.is-a.dev/" />
	<meta property="og:description" content="My own little corner of the internet" />
	<meta property="og:type" content="article" />
	<meta name="twitter:card" content="summary_large_image" />
</svelte:head>

<div class="flex flex-col lg:flex-row mx-6 gap-1 lg:gap-6">
	<header class="flex flex-col basis-5/6 gap-8">
		<h1
			class="
        text-5xl text-center lg:text-left lg:text-7xl mt-4 font-title bg-clip-text
        text-transparent py-3 bg-gradient-to-r from-maroon to-pink
      "
		>
			Hello, I’m Amy
		</h1>
		<section
			class="bg-mantle text-sm lg:text-lg p-3 my-4 rounded-md mt-auto font-mono drop-shadow-md"
		>
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
		<h2 class="text-center text-md lg:text-xl flex flex-col items-center">
			You can find me in other places:
			<MediaQuery query="(max-width: 480px)" let:matches>
				{#if matches}
				<ContactMobile />
				{:else}
					<ContactDesktop />
				{/if}
			</MediaQuery>
		</h2>
	</section>
</div>

<main class="flex flex-col lg:flex-row mt-8 gap-6 mx-3 lg:mx-6 mb-2">
	<section class="flex flex-col w-full lg:w-1/2 basis-2/3">
		<h2
			class="text-lg lg:text-2xl my-2 lg:my-6 underline self-center lg:self-baseline font-medium font-mono"
		>
			What I've been up to lately
		</h2>

		<div
			class="grid grid-cols-1 gap-6 lg:grid-cols-2 lg:grid-rows-3 lg:gap-6 items-center justify-items-center drop-shadow-md"
		>
			{#each posts as post}
				<WorkingOnCard {post} />
			{/each}
		</div>
	</section>

	<section class="flex flex-col w-full lg:w-1/2 basis-2/3">
		<h2
			class="text-lg lg:text-2xl my-2 lg:my-6 underline self-center lg:self-end font-medium font-mono"
		>
			Interesting reads I've found
		</h2>

		<div
			class="grid grid-cols-1 items-center justify-items-center grid-rows-3 gap-6 drop-shadow-md"
		>
			{#each externalReads as post}
				<ExternalRead {post} />
			{/each}
		</div>
	</section>
</main>
