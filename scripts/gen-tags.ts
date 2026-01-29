const tagJsonPath = "../public/_data/tags.json"
const templatePath = "../content/tags/tag.typ.tmpl"
const outputRoot = "../content/tags/"

const tags = JSON.parse(Deno.readTextFileSync(tagJsonPath))
const tagNames = Object.keys(tags)
console.log("generating files for", tagNames.length, "tags")

let template = Deno.readTextFileSync(templatePath)

for (const tag of tagNames) {
  const newFile = template.replace("{TAG}", tag)
  const outputPath = outputRoot + tag + ".typ"
  
  Deno.writeTextFileSync(outputPath, newFile);
  console.log("wrote to", outputPath, "for tag", tag)
}
