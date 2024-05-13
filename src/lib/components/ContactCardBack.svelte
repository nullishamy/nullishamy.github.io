<script lang="ts">
	import Account from '$lib/components/AssociatedAccount.svelte';
	import { backOut } from 'svelte/easing';
	import { fly } from 'svelte/transition';
</script>

<section
	class="grid grid-cols-2 auto-rows-max gap-4 justify-items-center h-full w-full pb-10"
	in:fly={{ opacity: 0, y: 300, easing: backOut }}
>
	<Account
		serviceIcon="simple-icons:github"
		url="https://github.com/nullishamy"
		facade="@nullishamy"
	/>
	<Account
		serviceIcon="simple-icons:npm"
		url="https://www.npmjs.com/~nullishamy"
		facade="@nullishamy"
	/>
	<Account
		serviceIcon="simple-icons:gravatar"
		url="https://gravatar.com/profile/"
		facade="@nullishamy"
	/>
	<Account
		serviceIcon="logos:lastfm"
		iconSize={55}
		url="https://www.last.fm/user/amycodes"
		facade="@amycodes"
	/>
</section>
