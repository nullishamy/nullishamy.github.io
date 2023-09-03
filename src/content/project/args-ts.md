---
name: args.ts
tags: [typescript]
brief: Argument parsing, built for TypeScript
repoUrl: https://github.com/nullishamy/args-ts
priority: 1
---
This project came to be when I was using other parsers, such as `Yargs`, and I noticed a disctinct lack of TypeScript support.
<br/><br/>
The best these libraries could offer was simply to declare an `interface` for the types you expect, without any real cohesiveness
between this definition, and the schema definition.
<br/><br/>
I was originally inspired by the likes of `zod`, as I really liked their schema declaration syntax.
Thus, I created my library. It uses a syntax much like `zod`, with type utilities to complement (similar to `z.infer`).
```ts
// Example Usage
const parser = new Args({
  programName: 'test',
  programDescription: 'hello',
  programVersion: 'v1.0'
})

parser.arg(['--test'], a.boolean())

const result = await parser.parse('--test')
```