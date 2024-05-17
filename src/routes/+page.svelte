<script lang="ts">
	import ExternalRead from '$lib/components/ExternalRead.svelte';
	import WorkingOnCard from '$lib/components/WorkingOnCard.svelte';
	import { externalReads, posts } from '../content';
	import Icon from '@iconify/svelte';
	import { onMount } from 'svelte';
	import ContactCardBack from '$lib/components/ContactCardBack.svelte';
	import ContactCardFront from '$lib/components/ContactCardFront.svelte';
	import MediaQuery from '$lib/components/MediaQuery.svelte';

	const refreshTheme = () => {
		if (
			localStorage.getItem('theme') === 'dark' ||
			(!('theme' in localStorage) && window.matchMedia('(prefers-color-scheme: dark)').matches)
		) {
			document.documentElement.classList.add('dark');
		} else {
			document.documentElement.classList.remove('dark');
		}
	};

	const handleThemeChange = () => {
		const currentTheme = localStorage.getItem('theme') ?? 'light';
		if (currentTheme === 'light') {
			localStorage.setItem('theme', 'dark');
			refreshTheme();
		} else {
			localStorage.setItem('theme', 'light');
			refreshTheme();
		}
	};

	onMount(() => {
		refreshTheme();
	});

	let contactFlipped = false;
	const handleContactFlip = () => {
		contactFlipped = !contactFlipped;
	};

	let hamburgerOpen = false;
	const handleHamburger = () => {
		hamburgerOpen = !hamburgerOpen;
	};
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

<header
	class="grid grid-cols-1 md:grid-cols-4 md:grid-flow-row xl:grid-cols-6 xl:grid-rows-[auto_auto] gap-4 m-4 mx-2 lg:mx-4 2xl:mx-0"
>
	<h1
		class="
      text-5xl md:text-left md:text-6xl lg:text-7xl font-header bg-clip-text
      text-transparent py-3 bg-gradient-to-r from-yellow via-peach to-pink lg:col-span-3
      md:col-span-3
      bg-300% animate-gradient
    "
	>
		hello, i’m amy
	</h1>

	<MediaQuery query="(max-width: 767px)" let:matches>
		{#if matches}
			<button class="absolute top-9 right-5" on:click={handleHamburger}>
				<Icon width="30" icon="ph:list" />
			</button>
			{#if hamburgerOpen}
				<div
					class="
            absolute top-9 right-14 bg-mantle p-4 rounded-md drop-shadow-md
            grid grid-cols-4 grid-rows-2 gap-6 z-10
          "
				>
					<a title="Webring previous" href="https://ctp-webr.ing/amy/previous"
						><Icon width="25" icon="ph:caret-double-left" /></a
					>
					<a title="Webring info" target="_blank" href="https://ctp-webr.ing/"
						><Icon width="25" icon="ph:fediverse-logo" /></a
					>
					<a title="Webring next" href="https://ctp-webr.ing/amy/next"
						><Icon width="25" icon="ph:caret-double-right" /></a
					>
					<button title="Theme toggle" on:click={handleThemeChange}
						><Icon width="25" icon="ph:lightbulb" /></button
					>

					<button title="Undecided content"><Icon width="25" icon="ph:seal-question" /></button>
					<button title="Undecided content"><Icon width="25" icon="ph:seal-question" /></button>
					<button title="Undecided content"><Icon width="25" icon="ph:seal-question" /></button>
					<a title="All blog posts" href="/post/list"><Icon width="25" icon="ph:notepad" /></a>
				</div>
			{/if}
		{:else}
			<div
				class="
          col-start-4 row-start-1 font-inclusive place-self-center
          grid grid-cols-4 grid-rows-2 gap-6
        "
			>
				<a title="Webring previous" href="https://ctp-webr.ing/amy/previous"
					><Icon width="30" icon="ph:caret-double-left" /></a
				>
				<a title="Webring info" target="_blank" href="https://ctp-webr.ing/"
					><Icon width="30" icon="ph:fediverse-logo" /></a
				>
				<a title="Webring next" href="https://ctp-webr.ing/amy/next"
					><Icon width="30" icon="ph:caret-double-right" /></a
				>
				<button title="Theme toggle" on:click={handleThemeChange}
					><Icon width="30" icon="ph:lightbulb" /></button
				>

				<button title="Undecided content"><Icon width="30" icon="ph:seal-question" /></button>
				<button title="Undecided content"><Icon width="30" icon="ph:seal-question" /></button>
				<button title="Undecided content"><Icon width="30" icon="ph:seal-question" /></button>
				<a title="All blog posts" href="/post/list"><Icon width="30" icon="ph:notepad" /></a>
			</div>
		{/if}
	</MediaQuery>

	<section
		class="
      bg-mantle text-sm py-4 lg:text-lg px-4
      rounded-md md:h-full font-inclusive drop-shadow-md md:col-start-1 lg:row-start-2 lg:col-span-4 md:pb-16 md:pt-4
      md:col-span-2
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

	<div
		class="
      md:col-start-3 md:col-span-2 lg:col-start-5 lg:col-span-2 lg:row-span-2
      bg-mantle p-2 rounded-md font-inclusive drop-shadow-md outline outline-1 outline-pink
      min-h-[21rem] md:min-h-[26rem] h-full relative
    "
	>
		{#if contactFlipped}
			<ContactCardBack />
		{:else}
			<ContactCardFront />
		{/if}
		<button
			on:click={handleContactFlip}
			class="bg-crust w-full h-10 grid grid-cols-3 items-center justify-items-center rounded-md absolute bottom-0 left-0"
		>
			<Icon icon="ph:arrow-up-right" />
			<Icon icon="ph:arrow-up-right" />
			<Icon icon="ph:arrow-up-right" />
		</button>
	</div>
</header>

<main class="flex flex-col lg:flex-row mt-8 gap-6 mx-2 lg:mx-4 2xl:mx-0 mb-2">
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
