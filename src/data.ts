import type { ExternalPost, Post } from './types';

const TODO_POST: Post = {
	title: 'Coming soon:tm:',
	content: 'N/A',
	blurb: "I haven't written this one yet!",
	slug: 'todo',
	tags: []
};

const TODO_READ: ExternalPost = {
	title: 'TBD',
	author: 'Unknown',
	externalLink: 'https://google.com',
	blurb: "I haven't filled this one out yet!"
};

export const externalReads: ExternalPost[] = [
	{
		title: 'optimizing my sveltekit blog',
		externalLink: 'https://www.refact0r.dev/blog/optimizing-sveltekit',
		author: 'refact0r',
		blurb: 'Improving performance on a static SvelteKit site by optimising images, fonts, and markup.'
	},
	TODO_READ,
	TODO_READ
];

export const posts: Post[] = [
	{
		title: 'building my site with SvelteKit',
		content: 'N/A',
		blurb: 'Exploring new tools and technologies for fun and profit',
		slug: 'building-my-new-site',
		tags: []
	},
	TODO_POST,
	TODO_POST,
	TODO_POST,
	TODO_POST,
	TODO_POST
];
