[private]
default:
  @just --list

# Rebuild the css with tailwind
css:
	tailwindcss -i src/styles.css.tw -o src/styles.css

# Rebuild the css with tailwind and watch for changes
css-watch:
	tailwindcss -i src/styles.css.tw -o src/styles.css -w

# Start the dev server
dev:
	raco pollen start src

# Render the website
build:
	raco pollen render src && raco pollen render src/posts