import { posts } from '../../../../data';
import type { Post } from '../../../../types';
import fs from 'fs';

export function load({ params }): { posts: Post[], query: string } {
	const foundPosts = posts.filter((p) => p.tags.includes(params.tag));

	for (const post of foundPosts) {
		const content = fs.readFileSync(`./content/${post.slug}.md`, 'utf-8');
		post.content = content;
	}

	return {
		posts: foundPosts,
		query: params.tag
	};
}
