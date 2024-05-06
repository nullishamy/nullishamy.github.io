export interface Post {
	title: string;
	content: string;
	blurb: string;
	slug: string;
	tags: string[];
}

export interface ExternalPost {
	title: string;
	author: string;
	blurb: string;
	externalLink: string;
}

export interface Tag {
	name: string;
}
