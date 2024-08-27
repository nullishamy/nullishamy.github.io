import { posts } from '../../../content';
import type { Post } from '../../../lib/types';
import fs from 'fs';

export function load({ params }): Post {
	const post = posts.find((p) => p.slug == params.slug);
	if (!post) {
		throw new TypeError(`no post '${params.slug}' found`);
	}

	const content = fs.readFileSync(`./src/content/${post.path ?? post.slug}.md`, 'utf-8');
	post.content = content;

	return post;
}
