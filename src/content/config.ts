import { z, defineCollection } from 'astro:content'

const blogCollection = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    blurb: z.string().max(50),
    tags: z.array(z.string()),
    image: z.string().optional(),
    publishedDate: z.date()
  }),
})

const projectCollection = defineCollection({
  type: 'content',// v2.5.0 and later
  schema: z.object({
    name: z.string(),
    blurb: z.string().max(50),
    repoUrl: z.string(),
    priority: z.number(),
    tags: z.array(z.string())
  }),
})

export const collections = {
  'blog': blogCollection,
  'project': projectCollection
}