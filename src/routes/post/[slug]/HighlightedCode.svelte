<script lang="ts">
	export let lang: string;
	export let text: string;

	const langKey = lang as keyof typeof languages;

	import * as languages from 'svelte-highlight/languages';
	import Highlight from 'svelte-highlight';
</script>

<Highlight language={languages[langKey]} code={text} />
