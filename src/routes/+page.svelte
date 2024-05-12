<script lang="ts">
	import ExternalRead from '../ExternalRead.svelte';
	import WorkingOnCard from '../WorkingOnCard.svelte';
	import ContactDesktop from '$lib/assets/contact-desktop.svelte';
	import ContactMobile from '$lib/assets/contact-mobile.svelte';
	import { externalReads, posts } from '../data';
	import MediaQuery from '../MediaQuery.svelte';
</script>

<svelte:head>
	<title>amy</title>
	<meta property="og:title" content="amy" />
	<meta property="og:site_name" content="amy.is-a.dev" />
	<meta property="og:url" content="https://amy.is-a.dev/" />
	<meta property="og:description" content="my own little corner of the internet" />
	<meta property="og:type" content="article" />

	<meta name="twitter:card" content="summary_large_image" />

	<meta name="theme-color" content="#EA76CB" />
	<meta name="description" content="my own little corner of the internet" />
	<meta name="color-scheme" content="light" />
</svelte:head>

<header class="grid grid-cols-1 md:grid-flow-row xl:grid-cols-6 xl:grid-rows-[auto_auto] gap-4 m-4">
	<h1
		class="
			text-5xl text-center lg:text-left md:text-6xl lg:text-7xl font-header bg-clip-text
			text-transparent py-3 bg-gradient-to-r from-yellow via-peach to-pink md:col-span-2 
			bg-300% animate-gradient
			lg:col-span-3
		"
	>
		hello, i’m amy
	</h1>

	<section
		class="
			bg-mantle text-sm md:text-base md:text-black py-4 lg:text-lg px-4 
			rounded-md md:h-full font-inclusive drop-shadow-md lg:row-start-2 lg:col-span-4 md:pb-16 md:pt-4
			outline outline-maroon outline-1
		"
	>
		<p>A hobbyist software developer, based in the UK.</p>
		<br />
		<p>
			Most commonly, I am working on various personal projects, but also spend time contributing to
			open source.
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

	<section class="bg-mantle p-2 rounded-md font-inclusive drop-shadow-md h-full lg:col-start-5 lg:col-span-2 lg:row-span-2 outline outline-1 outline-pink">
		<h2 class="text-center lg:text-xl flex flex-col items-center">
			You can find me in other places:
			<MediaQuery query="(max-width: 767px)" let:matches>
				{#if matches}
					<ContactMobile />
				{:else}
					<ContactDesktop />
				{/if}
			</MediaQuery>
		</h2>
	</section>
</header>

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
