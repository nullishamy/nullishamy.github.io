import type { ExternalPost, Post } from './types';

const TODO_POST: Post = {
	title: 'Coming soon:tm:',
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
	TODO_READ,
	TODO_READ
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
	TODO_POST,
	TODO_POST,
	TODO_POST,
	TODO_POST,
	TODO_POST
];
