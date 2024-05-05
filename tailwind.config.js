import ctp from "@catppuccin/tailwindcss"
import typography from '@tailwindcss/typography'

const accent = "mauve";
const linkColor = "blue";

/** @type {import('tailwindcss').Config} */
export default {
  content: ['./src/**/*.{html,js,svelte,ts}'],
  theme: {
    extend: {
      typography: ({ theme }) => ({
        ctp: {
          css: {
            "--tw-prose-body": "#000000",
            "--tw-prose-headings": theme(`colors.${accent}.DEFAULT`),
            "--tw-prose-lead": "#000000",
            "--tw-prose-links": theme(`colors.${linkColor}.DEFAULT`),
            "--tw-prose-bold": theme(`colors.${accent}.DEFAULT`),
            "--tw-prose-counters": theme(`colors.${accent}.DEFAULT`),
            "--tw-prose-bullets": theme(`colors.${accent}.DEFAULT`),
            "--tw-prose-hr": theme(`colors.${accent}.DEFAULT`),
            "--tw-prose-quotes": theme(`colors.${accent}.DEFAULT`),
            "--tw-prose-quote-borders": theme(`colors.${accent}.DEFAULT`),
            "--tw-prose-captions": theme(`colors.${accent}.DEFAULT`),
            "--tw-prose-code": theme(`colors.${accent}.DEFAULT`),
            "--tw-prose-pre-code": theme(`colors.${accent}.DEFAULT`),
            "--tw-prose-pre-bg": theme(`colors.base.DEFAULT`),
            "--tw-prose-th-borders": theme(`colors.${accent}.DEFAULT`),
            "--tw-prose-td-borders": theme(`colors.${accent}.DEFAULT`),
    
            "--tw-prose-invert-body": theme(`colors.${accent}.DEFAULT`),
            "--tw-prose-invert-headings": theme(`colors.${accent}.DEFAULT`),
            "--tw-prose-invert-lead": theme(`colors.${accent}.DEFAULT`),
            "--tw-prose-invert-links": theme(`colors.${linkColor}.DEFAULT`),
            "--tw-prose-invert-bold": theme(`colors.${accent}.DEFAULT`),
            "--tw-prose-invert-counters": theme(`colors.${accent}.DEFAULT`),
            "--tw-prose-invert-bullets": theme(`colors.${accent}.DEFAULT`),
            "--tw-prose-invert-hr": theme(`colors.${accent}.DEFAULT`),
            "--tw-prose-invert-quotes": theme(`colors.${accent}.DEFAULT`),
            "--tw-prose-invert-quote-borders": theme(
              `colors.${accent}.DEFAULT`,
            ),
            "--tw-prose-invert-captions": theme(`colors.${accent}.DEFAULT`),
            "--tw-prose-invert-code": theme(`colors.${accent}.DEFAULT`),
            "--tw-prose-invert-pre-code": theme(`colors.${accent}.DEFAULT`),
            "--tw-prose-invert-pre-bg": theme(`colors.base.DEFAULT`),
            "--tw-prose-invert-th-borders": theme(`colors.${accent}.DEFAULT`),
            "--tw-prose-invert-td-borders": theme(`colors.${accent}.DEFAULT`),
          },
        },
      }),
    },
    fontFamily: {
      'title': 'Lily Script One',
      'mono': 'JetBrains Mono Variable',
    }
  },
  plugins: [
    ctp({
      defaultFlavour: "latte",
    }),
    typography
  ],
}
