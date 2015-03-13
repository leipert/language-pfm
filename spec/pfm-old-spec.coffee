describe "GitHub Flavored Markdown grammar", ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage("language-pfm")

    runs ->
      grammar = atom.grammars.grammarForScopeName("source.pfm")

  it "parses the grammar", ->
    expect(grammar).toBeDefined()
    expect(grammar.scopeName).toBe "source.pfm"

  it "tokenizes spaces", ->
    {tokens} = grammar.tokenizeLine(" ")
    expect(tokens[0]).toEqual value: " ", scopes: ["source.pfm"]

  it "tokenizes horizontal rules", ->
    {tokens} = grammar.tokenizeLine("***")
    expect(tokens[0]).toEqual value: "***", scopes: ["source.pfm", "comment.hr.pfm"]

    {tokens} = grammar.tokenizeLine("---")
    expect(tokens[0]).toEqual value: "---", scopes: ["source.pfm", "comment.hr.pfm"]

  it "tokenizes escaped characters", ->
    {tokens} = grammar.tokenizeLine("\\*")
    expect(tokens[0]).toEqual value: "\\*", scopes: ["source.pfm", "constant.character.escape.pfm"]

    {tokens} = grammar.tokenizeLine("\\\\")
    expect(tokens[0]).toEqual value: "\\\\", scopes: ["source.pfm", "constant.character.escape.pfm"]

    {tokens} = grammar.tokenizeLine("\\abc")
    expect(tokens[0]).toEqual value: "\\a", scopes: ["source.pfm", "constant.character.escape.pfm"]
    expect(tokens[1]).toEqual value: "bc", scopes: ["source.pfm"]

  it "tokenizes ***bold italic*** text", ->
    {tokens} = grammar.tokenizeLine("this is ***bold italic*** text")
    expect(tokens[0]).toEqual value: "this is ", scopes: ["source.pfm"]
    expect(tokens[1]).toEqual value: "***", scopes: ["source.pfm", "markup.bold.italic.pfm"]
    expect(tokens[2]).toEqual value: "bold italic", scopes: ["source.pfm", "markup.bold.italic.pfm"]
    expect(tokens[3]).toEqual value: "***", scopes: ["source.pfm", "markup.bold.italic.pfm"]
    expect(tokens[4]).toEqual value: " text", scopes: ["source.pfm"]

    [firstLineTokens, secondLineTokens] = grammar.tokenizeLines("this is ***bold\nitalic***!")
    expect(firstLineTokens[0]).toEqual value: "this is ", scopes: ["source.pfm"]
    expect(firstLineTokens[1]).toEqual value: "***", scopes: ["source.pfm", "markup.bold.italic.pfm"]
    expect(firstLineTokens[2]).toEqual value: "bold", scopes: ["source.pfm", "markup.bold.italic.pfm"]
    expect(secondLineTokens[0]).toEqual value: "italic", scopes: ["source.pfm", "markup.bold.italic.pfm"]
    expect(secondLineTokens[1]).toEqual value: "***", scopes: ["source.pfm", "markup.bold.italic.pfm"]
    expect(secondLineTokens[2]).toEqual value: "!", scopes: ["source.pfm"]

  it "tokenizes ___bold italic___ text", ->
    {tokens} = grammar.tokenizeLine("this is ___bold italic___ text")
    expect(tokens[0]).toEqual value: "this is ", scopes: ["source.pfm"]
    expect(tokens[1]).toEqual value: "___", scopes: ["source.pfm", "markup.bold.italic.pfm"]
    expect(tokens[2]).toEqual value: "bold italic", scopes: ["source.pfm", "markup.bold.italic.pfm"]
    expect(tokens[3]).toEqual value: "___", scopes: ["source.pfm", "markup.bold.italic.pfm"]
    expect(tokens[4]).toEqual value: " text", scopes: ["source.pfm"]

    [firstLineTokens, secondLineTokens] = grammar.tokenizeLines("this is ___bold\nitalic___!")
    expect(firstLineTokens[0]).toEqual value: "this is ", scopes: ["source.pfm"]
    expect(firstLineTokens[1]).toEqual value: "___", scopes: ["source.pfm", "markup.bold.italic.pfm"]
    expect(firstLineTokens[2]).toEqual value: "bold", scopes: ["source.pfm", "markup.bold.italic.pfm"]
    expect(secondLineTokens[0]).toEqual value: "italic", scopes: ["source.pfm", "markup.bold.italic.pfm"]
    expect(secondLineTokens[1]).toEqual value: "___", scopes: ["source.pfm", "markup.bold.italic.pfm"]
    expect(secondLineTokens[2]).toEqual value: "!", scopes: ["source.pfm"]

  it "tokenizes **bold** text", ->
    {tokens} = grammar.tokenizeLine("**bold**")
    expect(tokens[0]).toEqual value: "**", scopes: ["source.pfm", "markup.bold.pfm"]
    expect(tokens[1]).toEqual value: "bold", scopes: ["source.pfm", "markup.bold.pfm"]
    expect(tokens[2]).toEqual value: "**", scopes: ["source.pfm", "markup.bold.pfm"]

    [firstLineTokens, secondLineTokens] = grammar.tokenizeLines("this is **bo\nld**!")
    expect(firstLineTokens[0]).toEqual value: "this is ", scopes: ["source.pfm"]
    expect(firstLineTokens[1]).toEqual value: "**", scopes: ["source.pfm", "markup.bold.pfm"]
    expect(firstLineTokens[2]).toEqual value: "bo", scopes: ["source.pfm", "markup.bold.pfm"]
    expect(secondLineTokens[0]).toEqual value: "ld", scopes: ["source.pfm", "markup.bold.pfm"]
    expect(secondLineTokens[1]).toEqual value: "**", scopes: ["source.pfm", "markup.bold.pfm"]
    expect(secondLineTokens[2]).toEqual value: "!", scopes: ["source.pfm"]

    {tokens} = grammar.tokenizeLine("not**bold**")
    expect(tokens[0]).toEqual value: "not**bold**", scopes: ["source.pfm"]

  it "tokenizes __bold__ text", ->
    {tokens} = grammar.tokenizeLine("____")
    expect(tokens[0]).toEqual value: "____", scopes: ["source.pfm"]

    {tokens} = grammar.tokenizeLine("__bold__")
    expect(tokens[0]).toEqual value: "__", scopes: ["source.pfm", "markup.bold.pfm"]
    expect(tokens[1]).toEqual value: "bold", scopes: ["source.pfm", "markup.bold.pfm"]
    expect(tokens[2]).toEqual value: "__", scopes: ["source.pfm", "markup.bold.pfm"]

    [firstLineTokens, secondLineTokens] = grammar.tokenizeLines("this is __bo\nld__!")
    expect(firstLineTokens[0]).toEqual value: "this is ", scopes: ["source.pfm"]
    expect(firstLineTokens[1]).toEqual value: "__", scopes: ["source.pfm", "markup.bold.pfm"]
    expect(firstLineTokens[2]).toEqual value: "bo", scopes: ["source.pfm", "markup.bold.pfm"]
    expect(secondLineTokens[0]).toEqual value: "ld", scopes: ["source.pfm", "markup.bold.pfm"]
    expect(secondLineTokens[1]).toEqual value: "__", scopes: ["source.pfm", "markup.bold.pfm"]
    expect(secondLineTokens[2]).toEqual value: "!", scopes: ["source.pfm"]

    {tokens} = grammar.tokenizeLine("not__bold__")
    expect(tokens[0]).toEqual value: "not__bold__", scopes: ["source.pfm"]

  it "tokenizes *italic* text", ->
    {tokens} = grammar.tokenizeLine("**")
    expect(tokens[0]).toEqual value: "**", scopes: ["source.pfm"]

    {tokens} = grammar.tokenizeLine("this is *italic* text")
    expect(tokens[0]).toEqual value: "this is ", scopes: ["source.pfm"]
    expect(tokens[1]).toEqual value: "*", scopes: ["source.pfm", "markup.italic.pfm"]
    expect(tokens[2]).toEqual value: "italic", scopes: ["source.pfm", "markup.italic.pfm"]
    expect(tokens[3]).toEqual value: "*", scopes: ["source.pfm", "markup.italic.pfm"]
    expect(tokens[4]).toEqual value: " text", scopes: ["source.pfm"]

    {tokens} = grammar.tokenizeLine("not*italic*")
    expect(tokens[0]).toEqual value: "not*italic*", scopes: ["source.pfm"]

    {tokens} = grammar.tokenizeLine("* not italic")
    expect(tokens[0]).toEqual value: "*", scopes: ["source.pfm", "variable.unordered.list.pfm"]
    expect(tokens[1]).toEqual value: " ", scopes: ["source.pfm"]
    expect(tokens[2]).toEqual value: "not italic", scopes: ["source.pfm"]

    [firstLineTokens, secondLineTokens] = grammar.tokenizeLines("this is *ita\nlic*!")
    expect(firstLineTokens[0]).toEqual value: "this is ", scopes: ["source.pfm"]
    expect(firstLineTokens[1]).toEqual value: "*", scopes: ["source.pfm", "markup.italic.pfm"]
    expect(firstLineTokens[2]).toEqual value: "ita", scopes: ["source.pfm", "markup.italic.pfm"]
    expect(secondLineTokens[0]).toEqual value: "lic", scopes: ["source.pfm", "markup.italic.pfm"]
    expect(secondLineTokens[1]).toEqual value: "*", scopes: ["source.pfm", "markup.italic.pfm"]
    expect(secondLineTokens[2]).toEqual value: "!", scopes: ["source.pfm"]

  it "tokenizes _italic_ text", ->
    {tokens} = grammar.tokenizeLine("__")
    expect(tokens[0]).toEqual value: "__", scopes: ["source.pfm"]

    {tokens} = grammar.tokenizeLine("this is _italic_ text")
    expect(tokens[0]).toEqual value: "this is ", scopes: ["source.pfm"]
    expect(tokens[1]).toEqual value: "_", scopes: ["source.pfm", "markup.italic.pfm"]
    expect(tokens[2]).toEqual value: "italic", scopes: ["source.pfm", "markup.italic.pfm"]
    expect(tokens[3]).toEqual value: "_", scopes: ["source.pfm", "markup.italic.pfm"]
    expect(tokens[4]).toEqual value: " text", scopes: ["source.pfm"]

    {tokens} = grammar.tokenizeLine("not_italic_")
    expect(tokens[0]).toEqual value: "not_italic_", scopes: ["source.pfm"]

    {tokens} = grammar.tokenizeLine("not x^{a}_m y^{b}_n italic")
    expect(tokens[0]).toEqual value: "not x^{a}_m y^{b}_n italic", scopes: ["source.pfm"]

    [firstLineTokens, secondLineTokens] = grammar.tokenizeLines("this is _ita\nlic_!")
    expect(firstLineTokens[0]).toEqual value: "this is ", scopes: ["source.pfm"]
    expect(firstLineTokens[1]).toEqual value: "_", scopes: ["source.pfm", "markup.italic.pfm"]
    expect(firstLineTokens[2]).toEqual value: "ita", scopes: ["source.pfm", "markup.italic.pfm"]
    expect(secondLineTokens[0]).toEqual value: "lic", scopes: ["source.pfm", "markup.italic.pfm"]
    expect(secondLineTokens[1]).toEqual value: "_", scopes: ["source.pfm", "markup.italic.pfm"]
    expect(secondLineTokens[2]).toEqual value: "!", scopes: ["source.pfm"]

  it "tokenizes ~~strike~~ text", ->
    {tokens} = grammar.tokenizeLine("~~strike~~")
    expect(tokens[0]).toEqual value: "~~", scopes: ["source.pfm", "markup.strike.pfm"]
    expect(tokens[1]).toEqual value: "strike", scopes: ["source.pfm", "markup.strike.pfm"]
    expect(tokens[2]).toEqual value: "~~", scopes: ["source.pfm", "markup.strike.pfm"]

    [firstLineTokens, secondLineTokens] = grammar.tokenizeLines("this is ~~str\nike~~!")
    expect(firstLineTokens[0]).toEqual value: "this is ", scopes: ["source.pfm"]
    expect(firstLineTokens[1]).toEqual value: "~~", scopes: ["source.pfm", "markup.strike.pfm"]
    expect(firstLineTokens[2]).toEqual value: "str", scopes: ["source.pfm", "markup.strike.pfm"]
    expect(secondLineTokens[0]).toEqual value: "ike", scopes: ["source.pfm", "markup.strike.pfm"]
    expect(secondLineTokens[1]).toEqual value: "~~", scopes: ["source.pfm", "markup.strike.pfm"]
    expect(secondLineTokens[2]).toEqual value: "!", scopes: ["source.pfm"]

    {tokens} = grammar.tokenizeLine("not~~strike~~")
    expect(tokens[0]).toEqual value: "not~~strike~~", scopes: ["source.pfm"]

  it "tokenizes headings", ->
    {tokens} = grammar.tokenizeLine("# Heading 1")
    expect(tokens[0]).toEqual value: "# ", scopes: ["source.pfm", "markup.heading.heading-1.pfm"]
    expect(tokens[1]).toEqual value: "Heading 1", scopes: ["source.pfm", "markup.heading.heading-1.pfm"]

    {tokens} = grammar.tokenizeLine("## Heading 2")
    expect(tokens[0]).toEqual value: "## ", scopes: ["source.pfm", "markup.heading.heading-2.pfm"]
    expect(tokens[1]).toEqual value: "Heading 2", scopes: ["source.pfm", "markup.heading.heading-2.pfm"]

    {tokens} = grammar.tokenizeLine("### Heading 3")
    expect(tokens[0]).toEqual value: "### ", scopes: ["source.pfm", "markup.heading.heading-3.pfm"]
    expect(tokens[1]).toEqual value: "Heading 3", scopes: ["source.pfm", "markup.heading.heading-3.pfm"]

    {tokens} = grammar.tokenizeLine("#### Heading 4")
    expect(tokens[0]).toEqual value: "#### ", scopes: ["source.pfm", "markup.heading.heading-4.pfm"]
    expect(tokens[1]).toEqual value: "Heading 4", scopes: ["source.pfm", "markup.heading.heading-4.pfm"]

    {tokens} = grammar.tokenizeLine("##### Heading 5")
    expect(tokens[0]).toEqual value: "##### ", scopes: ["source.pfm", "markup.heading.heading-5.pfm"]
    expect(tokens[1]).toEqual value: "Heading 5", scopes: ["source.pfm", "markup.heading.heading-5.pfm"]

    {tokens} = grammar.tokenizeLine("###### Heading 6")
    expect(tokens[0]).toEqual value: "###### ", scopes: ["source.pfm", "markup.heading.heading-6.pfm"]
    expect(tokens[1]).toEqual value: "Heading 6", scopes: ["source.pfm", "markup.heading.heading-6.pfm"]

    {tokens} = grammar.tokenizeLine("#Heading 1")
    expect(tokens[0]).toEqual value: "#", scopes: ["source.pfm", "markup.heading.heading-1.pfm"]
    expect(tokens[1]).toEqual value: "Heading 1", scopes: ["source.pfm", "markup.heading.heading-1.pfm"]

  xit "tokenzies matches inside of headers", ->
    {tokens} = grammar.tokenizeLine("# Heading :one:")
    expect(tokens[0]).toEqual value: "# ", scopes: ["source.pfm", "markup.heading.heading-1.pfm"]
    expect(tokens[1]).toEqual value: "Heading ", scopes: ["source.pfm", "markup.heading.heading-1.pfm"]
    expect(tokens[2]).toEqual value: ":", scopes: ["source.pfm", "markup.heading.heading-1.pfm", "string.emoji.pfm", "string.emoji.start.pfm"]
    expect(tokens[3]).toEqual value: "one", scopes: ["source.pfm", "markup.heading.heading-1.pfm", "string.emoji.pfm", "string.emoji.word.pfm"]
    expect(tokens[4]).toEqual value: ":", scopes: ["source.pfm", "markup.heading.heading-1.pfm", "string.emoji.pfm", "string.emoji.end.pfm"]

  xit "tokenizies an :emoji:", ->
    {tokens} = grammar.tokenizeLine("this is :no_good:")
    expect(tokens[0]).toEqual value: "this is ", scopes: ["source.pfm"]
    expect(tokens[1]).toEqual value: ":", scopes: ["source.pfm", "string.emoji.pfm", "string.emoji.start.pfm"]
    expect(tokens[2]).toEqual value: "no_good", scopes: ["source.pfm", "string.emoji.pfm", "string.emoji.word.pfm"]
    expect(tokens[3]).toEqual value: ":", scopes: ["source.pfm", "string.emoji.pfm", "string.emoji.end.pfm"]

    {tokens} = grammar.tokenizeLine("this is :no good:")
    expect(tokens[0]).toEqual value: "this is :no good:", scopes: ["source.pfm"]

    {tokens} = grammar.tokenizeLine("http://localhost:8080")
    expect(tokens[0]).toEqual value: "http://localhost:8080", scopes: ["source.pfm"]

  it "tokenizes a ``` code block```", ->
    {tokens, ruleStack} = grammar.tokenizeLine("```mylanguage")
    expect(tokens[0]).toEqual value: "```mylanguage", scopes: ["source.pfm", "markup.raw.pfm", "support.pfm"]
    {tokens, ruleStack} = grammar.tokenizeLine("-> 'hello'", ruleStack)
    expect(tokens[0]).toEqual value: "-> 'hello'", scopes: ["source.pfm", "markup.raw.pfm"]
    {tokens} = grammar.tokenizeLine("```", ruleStack)
    expect(tokens[0]).toEqual value: "```", scopes: ["source.pfm", "markup.raw.pfm", "support.pfm"]

  it "tokenizes a ~~~ code block", ->
    {tokens, ruleStack} = grammar.tokenizeLine("~~~mylanguage")
    expect(tokens[0]).toEqual value: "~~~mylanguage", scopes: ["source.pfm", "markup.raw.pfm", "support.pfm"]
    {tokens, ruleStack} = grammar.tokenizeLine("-> 'hello'", ruleStack)
    expect(tokens[0]).toEqual value: "-> 'hello'", scopes: ["source.pfm", "markup.raw.pfm"]
    {tokens} = grammar.tokenizeLine("~~~", ruleStack)
    expect(tokens[0]).toEqual value: "~~~", scopes: ["source.pfm", "markup.raw.pfm", "support.pfm"]

  it "tokenizes a ``` code block with a language ```", ->
    {tokens, ruleStack} = grammar.tokenizeLine("```  bash")
    expect(tokens[0]).toEqual value: "```  bash", scopes: ["source.pfm", "markup.code.shell.pfm",  "support.pfm"]

    {tokens, ruleStack} = grammar.tokenizeLine("```js  ")
    expect(tokens[0]).toEqual value: "```js  ", scopes: ["source.pfm", "markup.code.js.pfm",  "support.pfm"]

  it "tokenizes a ~~~ code block with a language", ->
    {tokens, ruleStack} = grammar.tokenizeLine("~~~  bash")
    expect(tokens[0]).toEqual value: "~~~  bash", scopes: ["source.pfm", "markup.code.shell.pfm",  "support.pfm"]

    {tokens, ruleStack} = grammar.tokenizeLine("~~~js  ")
    expect(tokens[0]).toEqual value: "~~~js  ", scopes: ["source.pfm", "markup.code.js.pfm",  "support.pfm"]

  it "tokenizes inline `code` blocks", ->
    {tokens} = grammar.tokenizeLine("`this` is `code`")
    expect(tokens[0]).toEqual value: "`", scopes: ["source.pfm", "markup.raw.pfm"]
    expect(tokens[1]).toEqual value: "this", scopes: ["source.pfm", "markup.raw.pfm"]
    expect(tokens[2]).toEqual value: "`", scopes: ["source.pfm", "markup.raw.pfm"]
    expect(tokens[3]).toEqual value: " is ", scopes: ["source.pfm"]
    expect(tokens[4]).toEqual value: "`", scopes: ["source.pfm", "markup.raw.pfm"]
    expect(tokens[5]).toEqual value: "code", scopes: ["source.pfm", "markup.raw.pfm"]
    expect(tokens[6]).toEqual value: "`", scopes: ["source.pfm", "markup.raw.pfm"]

    {tokens} = grammar.tokenizeLine("``")
    expect(tokens[0]).toEqual value: "`", scopes: ["source.pfm", "markup.raw.pfm"]
    expect(tokens[1]).toEqual value: "`", scopes: ["source.pfm", "markup.raw.pfm"]

    {tokens} = grammar.tokenizeLine("``a\\`b``")
    expect(tokens[0]).toEqual value: "``", scopes: ["source.pfm", "markup.raw.pfm"]
    expect(tokens[1]).toEqual value: "a\\`b", scopes: ["source.pfm", "markup.raw.pfm"]
    expect(tokens[2]).toEqual value: "``", scopes: ["source.pfm", "markup.raw.pfm"]

  it "tokenizes [links](links)", ->
    {tokens} = grammar.tokenizeLine("please click [this link](website)")
    expect(tokens[0]).toEqual value: "please click ", scopes: ["source.pfm"]
    expect(tokens[1]).toEqual value: "[", scopes: ["source.pfm", "link", "punctuation.definition.begin.pfm"]
    expect(tokens[2]).toEqual value: "this link", scopes: ["source.pfm", "link", "entity.pfm"]
    expect(tokens[3]).toEqual value: "]", scopes: ["source.pfm", "link", "punctuation.definition.end.pfm"]
    expect(tokens[4]).toEqual value: "(", scopes: ["source.pfm", "link", "markup.underline.link.pfm", "punctuation.definition.begin.pfm"]
    expect(tokens[5]).toEqual value: "website", scopes: ["source.pfm", "link", "markup.underline.link.pfm"]
    expect(tokens[6]).toEqual value: ")", scopes: ["source.pfm", "link", "markup.underline.link.pfm", "punctuation.definition.end.pfm"]

  it "tokenizes reference [links][links]", ->
    {tokens} = grammar.tokenizeLine("please click [this link][website]")
    expect(tokens[0]).toEqual value: "please click ", scopes: ["source.pfm"]
    expect(tokens[1]).toEqual value: "[", scopes: ["source.pfm", "link", "punctuation.definition.begin.pfm"]
    expect(tokens[2]).toEqual value: "this link", scopes: ["source.pfm", "link", "entity.pfm"]
    expect(tokens[3]).toEqual value: "]", scopes: ["source.pfm", "link", "punctuation.definition.end.pfm"]
    expect(tokens[4]).toEqual value: "[", scopes: ["source.pfm", "link", "markup.underline.link.pfm", "punctuation.definition.begin.pfm"]
    expect(tokens[5]).toEqual value: "website", scopes: ["source.pfm", "link", "markup.underline.link.pfm"]
    expect(tokens[6]).toEqual value: "]", scopes: ["source.pfm", "link", "markup.underline.link.pfm", "punctuation.definition.end.pfm"]

  it "tokenizes id-less reference [links][]", ->
    {tokens} = grammar.tokenizeLine("please click [this link][]")
    expect(tokens[0]).toEqual value: "please click ", scopes: ["source.pfm"]
    expect(tokens[1]).toEqual value: "[", scopes: ["source.pfm", "link", "punctuation.definition.begin.pfm"]
    expect(tokens[2]).toEqual value: "this link", scopes: ["source.pfm", "link", "entity.pfm"]
    expect(tokens[3]).toEqual value: "]", scopes: ["source.pfm", "link", "punctuation.definition.end.pfm"]
    expect(tokens[4]).toEqual value: "[", scopes: ["source.pfm", "link", "markup.underline.link.pfm", "punctuation.definition.begin.pfm"]
    expect(tokens[5]).toEqual value: "]", scopes: ["source.pfm", "link", "markup.underline.link.pfm", "punctuation.definition.end.pfm"]

  it "tokenizes [link]: footers", ->
    {tokens} = grammar.tokenizeLine("[aLink]: http://website")
    expect(tokens[0]).toEqual value: "[", scopes: ["source.pfm", "link", "punctuation.definition.begin.pfm"]
    expect(tokens[1]).toEqual value: "aLink", scopes: ["source.pfm", "link", "entity.pfm"]
    expect(tokens[2]).toEqual value: "]", scopes: ["source.pfm", "link", "punctuation.definition.end.pfm"]
    expect(tokens[3]).toEqual value: ":", scopes: ["source.pfm", "link", "punctuation.separator.key-value.pfm"]
    expect(tokens[4]).toEqual value: " ", scopes: ["source.pfm", "link"]
    expect(tokens[5]).toEqual value: "http://website", scopes: ["source.pfm", "link", "markup.underline.link.pfm"]

  it "tokenizes [link]: <footers>", ->
    {tokens} = grammar.tokenizeLine("[aLink]: <http://website>")
    expect(tokens[0]).toEqual value: "[", scopes: ["source.pfm", "link", "punctuation.definition.begin.pfm"]
    expect(tokens[1]).toEqual value: "aLink", scopes: ["source.pfm", "link", "entity.pfm"]
    expect(tokens[2]).toEqual value: "]", scopes: ["source.pfm", "link", "punctuation.definition.end.pfm"]
    expect(tokens[3]).toEqual value: ": <", scopes: ["source.pfm", "link"]
    expect(tokens[4]).toEqual value: "http://website", scopes: ["source.pfm", "link", "markup.underline.link.pfm"]
    expect(tokens[5]).toEqual value: ">", scopes: ["source.pfm", "link"]

  it "tokenizes [![links](links)](links)", ->
    {tokens} = grammar.tokenizeLine("[![title](image)](link)")
    expect(tokens[0]).toEqual value: "[!", scopes: ["source.pfm", "link", "punctuation.definition.begin.pfm"]
    expect(tokens[1]).toEqual value: "[", scopes: ["source.pfm", "link", "punctuation.definition.begin.pfm"]
    expect(tokens[2]).toEqual value: "title", scopes: ["source.pfm", "link", "entity.pfm"]
    expect(tokens[3]).toEqual value: "]", scopes: ["source.pfm", "link", "punctuation.definition.end.pfm"]
    expect(tokens[4]).toEqual value: "(", scopes: ["source.pfm", "link", "markup.underline.link.pfm", "punctuation.definition.begin.pfm"]
    expect(tokens[5]).toEqual value: "image", scopes: ["source.pfm", "link", "markup.underline.link.pfm"]
    expect(tokens[6]).toEqual value: ")", scopes: ["source.pfm", "link", "markup.underline.link.pfm", "punctuation.definition.end.pfm"]
    expect(tokens[7]).toEqual value: "]", scopes: ["source.pfm", "link", "punctuation.definition.end.pfm"]
    expect(tokens[8]).toEqual value: "(", scopes: ["source.pfm", "link", "markup.underline.link.pfm", "punctuation.definition.begin.pfm"]
    expect(tokens[9]).toEqual value: "link", scopes: ["source.pfm", "link", "markup.underline.link.pfm"]
    expect(tokens[10]).toEqual value: ")", scopes: ["source.pfm", "link", "markup.underline.link.pfm", "punctuation.definition.end.pfm"]

  it "tokenizes [![links](links)][links]", ->
    {tokens} = grammar.tokenizeLine("[![title](image)][link]")
    expect(tokens[0]).toEqual value: "[!", scopes: ["source.pfm", "link", "punctuation.definition.begin.pfm"]
    expect(tokens[1]).toEqual value: "[", scopes: ["source.pfm", "link", "punctuation.definition.begin.pfm"]
    expect(tokens[2]).toEqual value: "title", scopes: ["source.pfm", "link", "entity.pfm"]
    expect(tokens[3]).toEqual value: "]", scopes: ["source.pfm", "link", "punctuation.definition.end.pfm"]
    expect(tokens[4]).toEqual value: "(", scopes: ["source.pfm", "link", "markup.underline.link.pfm", "punctuation.definition.begin.pfm"]
    expect(tokens[5]).toEqual value: "image", scopes: ["source.pfm", "link", "markup.underline.link.pfm"]
    expect(tokens[6]).toEqual value: ")", scopes: ["source.pfm", "link", "markup.underline.link.pfm", "punctuation.definition.end.pfm"]
    expect(tokens[7]).toEqual value: "]", scopes: ["source.pfm", "link", "punctuation.definition.end.pfm"]
    expect(tokens[8]).toEqual value: "[", scopes: ["source.pfm", "link", "markup.underline.link.pfm", "punctuation.definition.begin.pfm"]
    expect(tokens[9]).toEqual value: "link", scopes: ["source.pfm", "link", "markup.underline.link.pfm"]
    expect(tokens[10]).toEqual value: "]", scopes: ["source.pfm", "link", "markup.underline.link.pfm", "punctuation.definition.end.pfm"]

  it "tokenizes [![links][links]](links)", ->
    {tokens} = grammar.tokenizeLine("[![title][image]](link)")
    expect(tokens[0]).toEqual value: "[!", scopes: ["source.pfm", "link", "punctuation.definition.begin.pfm"]
    expect(tokens[1]).toEqual value: "[", scopes: ["source.pfm", "link", "punctuation.definition.begin.pfm"]
    expect(tokens[2]).toEqual value: "title", scopes: ["source.pfm", "link", "entity.pfm"]
    expect(tokens[3]).toEqual value: "]", scopes: ["source.pfm", "link", "punctuation.definition.end.pfm"]
    expect(tokens[4]).toEqual value: "[", scopes: ["source.pfm", "link", "markup.underline.link.pfm", "punctuation.definition.begin.pfm"]
    expect(tokens[5]).toEqual value: "image", scopes: ["source.pfm", "link", "markup.underline.link.pfm"]
    expect(tokens[6]).toEqual value: "]", scopes: ["source.pfm", "link", "markup.underline.link.pfm", "punctuation.definition.end.pfm"]
    expect(tokens[7]).toEqual value: "]", scopes: ["source.pfm", "link", "punctuation.definition.end.pfm"]
    expect(tokens[8]).toEqual value: "(", scopes: ["source.pfm", "link", "markup.underline.link.pfm", "punctuation.definition.begin.pfm"]
    expect(tokens[9]).toEqual value: "link", scopes: ["source.pfm", "link", "markup.underline.link.pfm"]
    expect(tokens[10]).toEqual value: ")", scopes: ["source.pfm", "link", "markup.underline.link.pfm", "punctuation.definition.end.pfm"]

  it "tokenizes [![links][links]][links]", ->
    {tokens} = grammar.tokenizeLine("[![title][image]][link]")
    expect(tokens[0]).toEqual value: "[!", scopes: ["source.pfm", "link", "punctuation.definition.begin.pfm"]
    expect(tokens[1]).toEqual value: "[", scopes: ["source.pfm", "link", "punctuation.definition.begin.pfm"]
    expect(tokens[2]).toEqual value: "title", scopes: ["source.pfm", "link", "entity.pfm"]
    expect(tokens[3]).toEqual value: "]", scopes: ["source.pfm", "link", "punctuation.definition.end.pfm"]
    expect(tokens[4]).toEqual value: "[", scopes: ["source.pfm", "link", "markup.underline.link.pfm", "punctuation.definition.begin.pfm"]
    expect(tokens[5]).toEqual value: "image", scopes: ["source.pfm", "link", "markup.underline.link.pfm"]
    expect(tokens[6]).toEqual value: "]", scopes: ["source.pfm", "link", "markup.underline.link.pfm", "punctuation.definition.end.pfm"]
    expect(tokens[7]).toEqual value: "]", scopes: ["source.pfm", "link", "punctuation.definition.end.pfm"]
    expect(tokens[8]).toEqual value: "[", scopes: ["source.pfm", "link", "markup.underline.link.pfm", "punctuation.definition.begin.pfm"]
    expect(tokens[9]).toEqual value: "link", scopes: ["source.pfm", "link", "markup.underline.link.pfm"]
    expect(tokens[10]).toEqual value: "]", scopes: ["source.pfm", "link", "markup.underline.link.pfm", "punctuation.definition.end.pfm"]

  xit "tokenizes mentions", ->
    {tokens} = grammar.tokenizeLine("sentence with no space before@name ")
    expect(tokens[0]).toEqual value: "sentence with no space before@name ", scopes: ["source.pfm"]

    {tokens} = grammar.tokenizeLine("@name '@name' @name's @name. @name, (@name) [@name]")
    expect(tokens[0]).toEqual value: "@", scopes: ["source.pfm", "variable.mention.pfm"]
    expect(tokens[1]).toEqual value: "name", scopes: ["source.pfm", "string.username.pfm"]
    expect(tokens[2]).toEqual value: " '", scopes: ["source.pfm"]
    expect(tokens[3]).toEqual value: "@", scopes: ["source.pfm", "variable.mention.pfm"]
    expect(tokens[4]).toEqual value: "name", scopes: ["source.pfm", "string.username.pfm"]
    expect(tokens[5]).toEqual value: "' ", scopes: ["source.pfm"]
    expect(tokens[6]).toEqual value: "@", scopes: ["source.pfm", "variable.mention.pfm"]
    expect(tokens[7]).toEqual value: "name", scopes: ["source.pfm", "string.username.pfm"]
    expect(tokens[8]).toEqual value: "'s ", scopes: ["source.pfm"]
    expect(tokens[9]).toEqual value: "@", scopes: ["source.pfm", "variable.mention.pfm"]
    expect(tokens[10]).toEqual value: "name", scopes: ["source.pfm", "string.username.pfm"]
    expect(tokens[11]).toEqual value: ". ", scopes: ["source.pfm"]
    expect(tokens[12]).toEqual value: "@", scopes: ["source.pfm", "variable.mention.pfm"]
    expect(tokens[13]).toEqual value: "name", scopes: ["source.pfm", "string.username.pfm"]
    expect(tokens[14]).toEqual value: ", (", scopes: ["source.pfm"]
    expect(tokens[15]).toEqual value: "@", scopes: ["source.pfm", "variable.mention.pfm"]
    expect(tokens[16]).toEqual value: "name", scopes: ["source.pfm", "string.username.pfm"]
    expect(tokens[17]).toEqual value: ") [", scopes: ["source.pfm"]
    expect(tokens[18]).toEqual value: "@", scopes: ["source.pfm", "variable.mention.pfm"]
    expect(tokens[19]).toEqual value: "name", scopes: ["source.pfm", "string.username.pfm"]
    expect(tokens[20]).toEqual value: "]", scopes: ["source.pfm"]

    {tokens} = grammar.tokenizeLine('"@name"')
    expect(tokens[0]).toEqual value: '"', scopes: ["source.pfm"]
    expect(tokens[1]).toEqual value: "@", scopes: ["source.pfm", "variable.mention.pfm"]
    expect(tokens[2]).toEqual value: "name", scopes: ["source.pfm", "string.username.pfm"]
    expect(tokens[3]).toEqual value: '"', scopes: ["source.pfm"]

    {tokens} = grammar.tokenizeLine("sentence with a space before @name/ and an invalid symbol after")
    expect(tokens[0]).toEqual value: "sentence with a space before @name/ and an invalid symbol after", scopes: ["source.pfm"]

    {tokens} = grammar.tokenizeLine("sentence with a space before @name that continues")
    expect(tokens[0]).toEqual value: "sentence with a space before ", scopes: ["source.pfm"]
    expect(tokens[1]).toEqual value: "@", scopes: ["source.pfm", "variable.mention.pfm"]
    expect(tokens[2]).toEqual value: "name", scopes: ["source.pfm", "string.username.pfm"]
    expect(tokens[3]).toEqual value: " that continues", scopes: ["source.pfm"]

    {tokens} = grammar.tokenizeLine("* @name at the start of an unordered list")
    expect(tokens[0]).toEqual value: "*", scopes: ["source.pfm", "variable.unordered.list.pfm"]
    expect(tokens[1]).toEqual value: " ", scopes: ["source.pfm"]
    expect(tokens[2]).toEqual value: "@", scopes: ["source.pfm", "variable.mention.pfm"]
    expect(tokens[3]).toEqual value: "name", scopes: ["source.pfm", "string.username.pfm"]
    expect(tokens[4]).toEqual value: " at the start of an unordered list", scopes: ["source.pfm"]

    {tokens} = grammar.tokenizeLine("a username @1337_hubot with numbers, letters and underscores")
    expect(tokens[0]).toEqual value: "a username ", scopes: ["source.pfm"]
    expect(tokens[1]).toEqual value: "@", scopes: ["source.pfm", "variable.mention.pfm"]
    expect(tokens[2]).toEqual value: "1337_hubot", scopes: ["source.pfm", "string.username.pfm"]
    expect(tokens[3]).toEqual value: " with numbers, letters and underscores", scopes: ["source.pfm"]

    {tokens} = grammar.tokenizeLine("a username @1337-hubot with numbers, letters and hyphens")
    expect(tokens[0]).toEqual value: "a username ", scopes: ["source.pfm"]
    expect(tokens[1]).toEqual value: "@", scopes: ["source.pfm", "variable.mention.pfm"]
    expect(tokens[2]).toEqual value: "1337-hubot", scopes: ["source.pfm", "string.username.pfm"]
    expect(tokens[3]).toEqual value: " with numbers, letters and hyphens", scopes: ["source.pfm"]

    {tokens} = grammar.tokenizeLine("@name at the start of a line")
    expect(tokens[0]).toEqual value: "@", scopes: ["source.pfm", "variable.mention.pfm"]
    expect(tokens[1]).toEqual value: "name", scopes: ["source.pfm", "string.username.pfm"]
    expect(tokens[2]).toEqual value: " at the start of a line", scopes: ["source.pfm"]

    {tokens} = grammar.tokenizeLine("any email like you@domain.com shouldn't mistakenly be matched as a mention")
    expect(tokens[0]).toEqual value: "any email like you@domain.com shouldn't mistakenly be matched as a mention", scopes: ["source.pfm"]

    {tokens} = grammar.tokenizeLine("@person's")
    expect(tokens[0]).toEqual value: "@", scopes: ["source.pfm", "variable.mention.pfm"]
    expect(tokens[1]).toEqual value: "person", scopes: ["source.pfm", "string.username.pfm"]
    expect(tokens[2]).toEqual value: "'s", scopes: ["source.pfm"]

    {tokens} = grammar.tokenizeLine("@person;")
    expect(tokens[0]).toEqual value: "@", scopes: ["source.pfm", "variable.mention.pfm"]
    expect(tokens[1]).toEqual value: "person", scopes: ["source.pfm", "string.username.pfm"]
    expect(tokens[2]).toEqual value: ";", scopes: ["source.pfm"]

  xit "tokenizes issue numbers", ->
    {tokens} = grammar.tokenizeLine("sentence with no space before#12 ")
    expect(tokens[0]).toEqual value: "sentence with no space before#12 ", scopes: ["source.pfm"]

    {tokens} = grammar.tokenizeLine(" #101 '#101' #101's #101. #101, (#101) [#101]")
    expect(tokens[1]).toEqual value: "#", scopes: ["source.pfm", "variable.issue.tag.pfm"]
    expect(tokens[2]).toEqual value: "101", scopes: ["source.pfm", "string.issue.number.pfm"]
    expect(tokens[3]).toEqual value: " '", scopes: ["source.pfm"]
    expect(tokens[4]).toEqual value: "#", scopes: ["source.pfm", "variable.issue.tag.pfm"]
    expect(tokens[5]).toEqual value: "101", scopes: ["source.pfm", "string.issue.number.pfm"]
    expect(tokens[6]).toEqual value: "' ", scopes: ["source.pfm"]
    expect(tokens[7]).toEqual value: "#", scopes: ["source.pfm", "variable.issue.tag.pfm"]
    expect(tokens[8]).toEqual value: "101", scopes: ["source.pfm", "string.issue.number.pfm"]
    expect(tokens[9]).toEqual value: "'s ", scopes: ["source.pfm"]
    expect(tokens[10]).toEqual value: "#", scopes: ["source.pfm", "variable.issue.tag.pfm"]
    expect(tokens[11]).toEqual value: "101", scopes: ["source.pfm", "string.issue.number.pfm"]
    expect(tokens[12]).toEqual value: ". ", scopes: ["source.pfm"]
    expect(tokens[13]).toEqual value: "#", scopes: ["source.pfm", "variable.issue.tag.pfm"]
    expect(tokens[14]).toEqual value: "101", scopes: ["source.pfm", "string.issue.number.pfm"]
    expect(tokens[15]).toEqual value: ", (", scopes: ["source.pfm"]
    expect(tokens[16]).toEqual value: "#", scopes: ["source.pfm", "variable.issue.tag.pfm"]
    expect(tokens[17]).toEqual value: "101", scopes: ["source.pfm", "string.issue.number.pfm"]
    expect(tokens[18]).toEqual value: ") [", scopes: ["source.pfm"]
    expect(tokens[19]).toEqual value: "#", scopes: ["source.pfm", "variable.issue.tag.pfm"]
    expect(tokens[20]).toEqual value: "101", scopes: ["source.pfm", "string.issue.number.pfm"]
    expect(tokens[21]).toEqual value: "]", scopes: ["source.pfm"]

    {tokens} = grammar.tokenizeLine('"#101"')
    expect(tokens[0]).toEqual value: '"', scopes: ["source.pfm"]
    expect(tokens[1]).toEqual value: "#", scopes: ["source.pfm", "variable.issue.tag.pfm"]
    expect(tokens[2]).toEqual value: "101", scopes: ["source.pfm", "string.issue.number.pfm"]
    expect(tokens[3]).toEqual value: '"', scopes: ["source.pfm"]

    {tokens} = grammar.tokenizeLine("sentence with a space before #123i and a character after")
    expect(tokens[0]).toEqual value: "sentence with a space before #123i and a character after", scopes: ["source.pfm"]

    {tokens} = grammar.tokenizeLine("sentence with a space before #123 that continues")
    expect(tokens[0]).toEqual value: "sentence with a space before ", scopes: ["source.pfm"]
    expect(tokens[1]).toEqual value: "#", scopes: ["source.pfm", "variable.issue.tag.pfm"]
    expect(tokens[2]).toEqual value: "123", scopes: ["source.pfm", "string.issue.number.pfm"]
    expect(tokens[3]).toEqual value: " that continues", scopes: ["source.pfm"]

    {tokens} = grammar.tokenizeLine(" #123's")
    expect(tokens[1]).toEqual value: "#", scopes: ["source.pfm", "variable.issue.tag.pfm"]
    expect(tokens[2]).toEqual value: "123", scopes: ["source.pfm", "string.issue.number.pfm"]
    expect(tokens[3]).toEqual value: "'s", scopes: ["source.pfm"]

  it "tokenizes unordered lists", ->
    {tokens} = grammar.tokenizeLine("*Item 1")
    expect(tokens[0]).not.toEqual value: "*Item 1", scopes: ["source.pfm", "variable.unordered.list.pfm"]

    {tokens} = grammar.tokenizeLine("  * Item 1")
    expect(tokens[0]).toEqual value: "  ", scopes: ["source.pfm"]
    expect(tokens[1]).toEqual value: "*", scopes: ["source.pfm", "variable.unordered.list.pfm"]
    expect(tokens[2]).toEqual value: " ", scopes: ["source.pfm"]
    expect(tokens[3]).toEqual value: "Item 1", scopes: ["source.pfm"]

    {tokens} = grammar.tokenizeLine("  + Item 2")
    expect(tokens[0]).toEqual value: "  ", scopes: ["source.pfm"]
    expect(tokens[1]).toEqual value: "+", scopes: ["source.pfm", "variable.unordered.list.pfm"]
    expect(tokens[2]).toEqual value: " ", scopes: ["source.pfm"]
    expect(tokens[3]).toEqual value: "Item 2", scopes: ["source.pfm"]

    {tokens} = grammar.tokenizeLine("  - Item 3")
    expect(tokens[0]).toEqual value: "  ", scopes: ["source.pfm"]
    expect(tokens[1]).toEqual value: "-", scopes: ["source.pfm", "variable.unordered.list.pfm"]
    expect(tokens[2]).toEqual value: " ", scopes: ["source.pfm"]
    expect(tokens[3]).toEqual value: "Item 3", scopes: ["source.pfm"]

  it "tokenizes ordered lists", ->
    {tokens} = grammar.tokenizeLine("1.First Item")
    expect(tokens[0]).toEqual value: "1.First Item", scopes: ["source.pfm"]

    {tokens} = grammar.tokenizeLine("  1. First Item")
    expect(tokens[0]).toEqual value: "  ", scopes: ["source.pfm"]
    expect(tokens[1]).toEqual value: "1.", scopes: ["source.pfm", "variable.ordered.list.pfm"]
    expect(tokens[2]).toEqual value: " ", scopes: ["source.pfm"]
    expect(tokens[3]).toEqual value: "First Item", scopes: ["source.pfm"]

    {tokens} = grammar.tokenizeLine("  10. Tenth Item")
    expect(tokens[0]).toEqual value: "  ", scopes: ["source.pfm"]
    expect(tokens[1]).toEqual value: "10.", scopes: ["source.pfm", "variable.ordered.list.pfm"]
    expect(tokens[2]).toEqual value: " ", scopes: ["source.pfm"]
    expect(tokens[3]).toEqual value: "Tenth Item", scopes: ["source.pfm"]

    {tokens} = grammar.tokenizeLine("  111. Hundred and eleventh item")
    expect(tokens[0]).toEqual value: "  ", scopes: ["source.pfm"]
    expect(tokens[1]).toEqual value: "111.", scopes: ["source.pfm", "variable.ordered.list.pfm"]
    expect(tokens[2]).toEqual value: " ", scopes: ["source.pfm"]
    expect(tokens[3]).toEqual value: "Hundred and eleventh item", scopes: ["source.pfm"]

  xit "tokenizes > quoted text", ->
    {tokens} = grammar.tokenizeLine("> Quotation :+1:")
    expect(tokens[0]).toEqual value: ">", scopes: ["source.pfm", "comment.quote.pfm", "support.quote.pfm"]
    expect(tokens[1]).toEqual value: " Quotation ", scopes: ["source.pfm", "comment.quote.pfm"]
    expect(tokens[2]).toEqual value: ":", scopes: ["source.pfm", "comment.quote.pfm", "string.emoji.pfm", "string.emoji.start.pfm"]
    expect(tokens[3]).toEqual value: "+1", scopes: ["source.pfm", "comment.quote.pfm", "string.emoji.pfm", "string.emoji.word.pfm"]
    expect(tokens[4]).toEqual value: ":", scopes: ["source.pfm", "comment.quote.pfm", "string.emoji.pfm", "string.emoji.end.pfm"]

  it "tokenizes HTML entities", ->
    {tokens} = grammar.tokenizeLine("&trade; &#8482; &a1; &#xb3;")
    expect(tokens[0]).toEqual value: "&", scopes: ["source.pfm", "constant.character.entity.pfm", "punctuation.definition.entity.pfm"]
    expect(tokens[1]).toEqual value: "trade", scopes: ["source.pfm", "constant.character.entity.pfm"]
    expect(tokens[2]).toEqual value: ";", scopes: ["source.pfm", "constant.character.entity.pfm", "punctuation.definition.entity.pfm"]

    expect(tokens[3]).toEqual value: " ", scopes: ["source.pfm"]

    expect(tokens[4]).toEqual value: "&", scopes: ["source.pfm", "constant.character.entity.pfm", "punctuation.definition.entity.pfm"]
    expect(tokens[5]).toEqual value: "#8482", scopes: ["source.pfm", "constant.character.entity.pfm"]
    expect(tokens[6]).toEqual value: ";", scopes: ["source.pfm", "constant.character.entity.pfm", "punctuation.definition.entity.pfm"]

    expect(tokens[7]).toEqual value: " ", scopes: ["source.pfm"]

    expect(tokens[8]).toEqual value: "&", scopes: ["source.pfm", "constant.character.entity.pfm", "punctuation.definition.entity.pfm"]
    expect(tokens[9]).toEqual value: "a1", scopes: ["source.pfm", "constant.character.entity.pfm"]
    expect(tokens[10]).toEqual value: ";", scopes: ["source.pfm", "constant.character.entity.pfm", "punctuation.definition.entity.pfm"]

    expect(tokens[11]).toEqual value: " ", scopes: ["source.pfm"]

    expect(tokens[12]).toEqual value: "&", scopes: ["source.pfm", "constant.character.entity.pfm", "punctuation.definition.entity.pfm"]
    expect(tokens[13]).toEqual value: "#xb3", scopes: ["source.pfm", "constant.character.entity.pfm"]
    expect(tokens[14]).toEqual value: ";", scopes: ["source.pfm", "constant.character.entity.pfm", "punctuation.definition.entity.pfm"]

  it "tokenizes HTML comments", ->
    {tokens} = grammar.tokenizeLine("<!-- a comment -->")
    expect(tokens[0]).toEqual value: "<!--", scopes: ["source.pfm", "comment.block.pfm", "punctuation.definition.comment.pfm"]
    expect(tokens[1]).toEqual value: " a comment ", scopes: ["source.pfm", "comment.block.pfm"]
    expect(tokens[2]).toEqual value: "-->", scopes: ["source.pfm", "comment.block.pfm", "punctuation.definition.comment.pfm"]

  it "tokenizes YAML front matter", ->
    [firstLineTokens, secondLineTokens, thirdLineTokens] = grammar.tokenizeLines """
      ---
      front: matter
      ---
    """

    expect(firstLineTokens[0]).toEqual value: "---", scopes: ["source.pfm", "front-matter.yaml.pfm", "comment.hr.pfm"]
    expect(secondLineTokens[0]).toEqual value: "front: matter", scopes: ["source.pfm", "front-matter.yaml.pfm"]
    expect(thirdLineTokens[0]).toEqual value: "---", scopes: ["source.pfm", "front-matter.yaml.pfm", "comment.hr.pfm"]

  it "tokenizes linebreaks", ->
    {tokens} = grammar.tokenizeLine("line  ")
    expect(tokens[0]).toEqual value: "line", scopes: ["source.pfm"]
    expect(tokens[1]).toEqual value: "  ", scopes: ["source.pfm", "linebreak.pfm"]
