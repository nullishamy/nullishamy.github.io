<script lang="ts">
	import Account from '$lib/components/AssociatedAccount.svelte';
	import { Github, Gravatar, Npm, Lastdotfm } from '@steeze-ui/simple-icons'
	import { backOut } from 'svelte/easing';
	import { fly } from 'svelte/transition';
</script>

<section
	class="grid md:grid-cols-2 auto-rows-max gap-4 justify-items-center h-full w-full pb-10"
	in:fly={{ opacity: 0, y: 300, easing: backOut }}
>
	<Account
		serviceIcon={Github}
		url="https://github.com/nullishamy"
		facade="@nullishamy"
	/>
	<Account
		serviceIcon={Npm}
		url="https://www.npmjs.com/~nullishamy"
		facade="@nullishamy"
	/>
	<Account
		serviceIcon={Gravatar}
		url="https://gravatar.com/profile/"
		facade="@nullishamy"
	/>
	<Account
		serviceIcon={Lastdotfm}
		iconSize={35}
		url="https://www.last.fm/user/amycodes"
		facade="@amycodes"
	/>
</section>
