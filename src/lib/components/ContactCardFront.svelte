<script lang="ts">
	import MediaQuery from './MediaQuery.svelte';
	import ContactMobile from '$lib/assets/contact-mobile.svelte';
	import ContactDesktop from '$lib/assets/contact-desktop.svelte';
	import { fly } from 'svelte/transition';
	import { backOut } from 'svelte/easing';

</script>

<section
	class="flex flex-col items-center h-full w-full pb-10"
	in:fly={{ opacity: 0, y: 200, easing: backOut }}
>
	<h2 class="text-center lg:text-xl">You can find me in other places:</h2>

	<MediaQuery query="(max-width: 767px)" let:matches>
		{#if matches}
			<ContactMobile classList="fill-black dark:fill-text" />
		{:else}
			<ContactDesktop classList="fill-black dark:fill-text" />
		{/if}
	</MediaQuery>

</section>
