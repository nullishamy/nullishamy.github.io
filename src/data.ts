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

export const externalReads: ExternalPost[] = [TODO_READ, TODO_READ, TODO_READ];

export const posts: Post[] = [TODO_POST, TODO_POST, TODO_POST, TODO_POST, TODO_POST, TODO_POST];
