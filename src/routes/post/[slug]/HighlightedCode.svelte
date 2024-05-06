<script lang="ts">
	export let lang: string;
	export let text: string;

	import * as languages from 'svelte-highlight/languages';
	import Highlight from 'svelte-highlight';

	const langKey = lang as keyof typeof languages;
  if (!Object.keys(languages).includes(langKey)) {
    throw new TypeError(`key '${langKey}' is not supported!`) 
  }

</script>

<div class="rounded-lg drop-shadow-lg">
  <Highlight language={languages[langKey]} code={text} />
</div>
