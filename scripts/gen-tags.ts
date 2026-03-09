const jsonPath = "../data.json"
const templatePath = "../content/tags/tag.typ.tmpl"
const outputRoot = "../content/tags/"

const data = JSON.parse(Deno.readTextFileSync(jsonPath))
const tags = new Set()
for (const page of data) {
  page.tags.forEach(t => tags.add(t))
}

console.log("generating files for", tags.size, "tags")

let template = Deno.readTextFileSync(templatePath)

for (const tag of tags) {
  const newFile = template.replace("{TAG}", tag)
  const outputPath = outputRoot + tag + ".typ"
  
  Deno.writeTextFileSync(outputPath, newFile);
  console.log("wrote to", outputPath, "for tag", tag)
}
