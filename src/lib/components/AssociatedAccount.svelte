<script lang="ts">
	import { Icon, type IconSource } from '@steeze-ui/svelte-icon';

	export let service: string | undefined = undefined;
	export let serviceIcon: IconSource | undefined = undefined;
	export let iconSize: number = 24;
	export let url: string;
	export let facade: string;

	if (!service && !serviceIcon) {
		throw new TypeError('must provide service or serviceIcon');
	}
</script>

{#if serviceIcon}
	<span class="flex flex-row items-center gap-2 lg:text-lg underline">
		<Icon
			src={serviceIcon}
			width={iconSize}
		/>
		<a
			class="text-blue"
			href={url}
		>
			{facade}
		</a>
	</span>
{:else}
	<span class="lg:text-lg underline">
		{service}:
		<a
			class="text-blue"
			href={url}
		>
			{facade}
		</a>
	</span>
{/if}
