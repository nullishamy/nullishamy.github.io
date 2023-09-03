import { defineConfig } from 'astro/config';
import tailwind from "@astrojs/tailwind";
import theme from './src/theme/shiki.json'

// https://astro.build/config
export default defineConfig({
  integrations: [tailwind()],
  markdown: {
    shikiConfig: {
      langs: [],
      // @ts-expect-error
      theme,
      wrap: true,
    },
  },
  site: 'https://amy.is-a.dev'
});