import type { ExternalPost, Post } from '../lib/types';

const TODO_POST: Post = {
	title: 'coming soon:tm:',
	content: 'N/A',
	publishDate: new Date(),
	blurb: "i haven't written this one yet!",
	slug: 'todo',
	tags: []
};

const TODO_READ: ExternalPost = {
	title: 'TBD',
	author: 'Unknown',
	externalLink: 'https://google.com',
	blurb: "i haven't filled this one out yet!"
};

export const externalReads: ExternalPost[] = [
	{
		title: 'optimizing my sveltekit blog',
		externalLink: 'https://www.refact0r.dev/blog/optimizing-sveltekit',
		author: 'refact0r',
		blurb:
			'improving performance on a static SvelteKit site by optimising images, fonts, and markup.'
	},
	{
		title: 'making fediverse apps for everyone',
		externalLink: 'https://stefanbohacek.com/blog/making-fediverse-apps-for-everyone/',
		author: 'Stefan Bohacek',
		blurb: "a guide to increasing your app's compatibility with non-Mastodon fediverse servers."
	},
	{
		title: 'giscus',
		externalLink:
			'https://giscus.app/',
		author: 'Giscus',
		blurb: 'a library / tool to enable website commenting through a GitHub Discussion backend'
	}
];

export const posts: Post[] = [
	{
		title: 'building my site with SvelteKit',
		content: 'N/A',
		publishDate: new Date('05/05/2024'),
		blurb: 'exploring new tools and technologies for fun and profit',
		slug: 'building-my-new-site',
		tags: ['svelte', 'web']
	},
	{
		title: 'into the fediverse',
		content: 'N/A',
		publishDate: new Date('05/15/2024'),
		blurb: 'my journey on the fediverse, and my summary after a few months of use',
		slug: 'into-the-fediverse',
		tags: []
	},
	TODO_POST,
	TODO_POST,
	TODO_POST,
	TODO_POST
];
