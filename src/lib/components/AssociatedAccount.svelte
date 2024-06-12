<script lang="ts">
	import Icon from '@iconify/svelte';

	export let service: string | undefined = undefined;
	export let serviceIcon: string | undefined = undefined;
	export let iconSize: number = 24;
	export let url: string;
	export let facade: string;

	if (!service && !serviceIcon) {
		throw new TypeError('must provide service or serviceIcon');
	}
</script>

{#if serviceIcon}
	<span class="flex flex-row items-center gap-2 lg:text-lg underline"
		><Icon icon={serviceIcon} width={iconSize} /> <a class="text-blue" href={url}>{facade}</a></span
	>
{:else}
	<span class="lg:text-lg underline">{service}: <a class="text-blue" href={url}>{facade}</a></span>
{/if}
