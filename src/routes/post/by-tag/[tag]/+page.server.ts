import { posts } from '../../../../content';
import type { Post } from '../../../../lib/types';
import fs from 'fs';

export function load({ params }): { posts: Post[]; query: string } {
	const foundPosts = posts.filter((p) => p.tags.includes(params.tag));

	for (const post of foundPosts) {
		const content = fs.readFileSync(`./src/content/${post.path ?? post.slug}.md`, 'utf-8');
		post.content = content;
	}

	return {
		posts: foundPosts,
		query: params.tag
	};
}
