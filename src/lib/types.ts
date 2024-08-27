export interface Post {
	title: string;
	publishDate: Date;
	content: string;
	blurb: string;
	slug: string;
	path?: string;
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
