import type { ExternalPost, Post } from '../lib/types';

const TODO_POST: Post = {
	title: 'coming soon:tm:',
	content: 'N/A',
	publishDate: new Date(),
	blurb: "i haven't written this one yet!",
	slug: 'todo',
	tags: []
};

/** 
	const TODO_READ: ExternalPost = {
		title: 'TBD',
		author: 'Unknown',
		externalLink: 'https://google.com',
		blurb: "i haven't filled this one out yet!"
	};
*/

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
		externalLink: 'https://giscus.app/',
		author: 'Giscus',
		blurb: 'a library / tool to enable website commenting through a GitHub Discussion backend'
	}
];

function psArticle (): Pick<Post, 'content' | 'blurb' | 'tags'> {
	return {
		content: 'N/A',
		blurb: 'turn your snakes into shells',
		tags: ['python', 'powershell']
	}
}

function article(): Pick<Post, 'content' | 'tags'> {
	return {
		content: 'N/A',
		tags: []
	}
}

export const posts: Post[] = [
	{
		...article(),
		title: 'building my site with SvelteKit',
		publishDate: new Date('05/05/2024'),
		blurb: 'exploring new tools and technologies for fun and profit',
		slug: 'building-my-new-site',
		tags: ['svelte', 'web']
	},
	{
		...article(),
		title: 'into the fediverse',
		publishDate: new Date('05/15/2024'),
		blurb: 'my journey on the fediverse, and my summary after a few months of use',
		slug: 'into-the-fediverse',
		tags: ['fediverse']
	},
	{
		...article(),
		title: 'the display invasion',
		publishDate: new Date('07/19/2024'),
		blurb: 'help, displays are invading my motor vehicle',
		slug: 'screens-in-cars',
		tags: ['automotive']
	},
	{
		...psArticle(),
		title: 'Python to PS',
		slug: 'python-to-ps',
		path: 'python-to-ps/index',
		publishDate: new Date('08/27/2024'),
	},
	TODO_POST,
	TODO_POST,
	{
		...psArticle(),
		title: 'Python to PS (part 1)',
		blurb: 'turn your snakes into shells',
		slug: 'python-to-ps/part-one',
		publishDate: new Date('08/27/2024'),
	},
];
