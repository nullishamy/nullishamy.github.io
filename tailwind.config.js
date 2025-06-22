module.exports = {
    content: [
        './src/**/*.html.*',
    ],
    theme: {
        extend: {
            typography: () => ({
                DEFAULT: {
                    css: {
                      '--tw-prose-body': '#000000',
                    }
                }
            })
        },
        fontFamily: {
            display: ["Rubik", "ui-sans-serif", "system-ui", "sans-serif", "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji"],
            sans: ["Rubik", "ui-sans-serif", "system-ui", "sans-serif", "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji"],
            serif: ["Rubik", "ui-sans-serif", "system-ui", "sans-serif", "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji"]
        }
    },
    plugins: [
        require('@tailwindcss/typography'),
    ],
}
