describe "Pandoc Flavored Markdown grammar", ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage("language-gfm")

    runs ->
      grammar = atom.grammars.grammarForScopeName("source.gfm")

  it "parses the grammar", ->
    expect(grammar).toBeDefined()
    expect(grammar.scopeName).toBe "source.gfm"

  xit "tokenzies matches inside of headers", ->
    {tokens} = grammar.tokenizeLine("# Heading ***one***")
    expect(tokens[0]).toEqual value: "# ", scopes: ["source.pfm", "markup.heading.heading-1.pfm"]
    expect(tokens[1]).toEqual value: "Heading ", scopes: ["source.pfm", "markup.heading.heading-1.pfm"]
    expect(tokens[2]).toEqual value: "***", scopes: ["source.pfm", "markup.heading.heading-1.pfm", "markup.bold.italic.pfm"]
    expect(tokens[3]).toEqual value: "one", scopes: ["source.pfm", "markup.heading.heading-1.pfm", "markup.bold.italic.pfm"]
    expect(tokens[4]).toEqual value: "***", scopes: ["source.pfm", "markup.heading.heading-1.pfm", "markup.bold.italic.pfm"]

  xit "tokenizes > quoted text", ->
    {tokens} = grammar.tokenizeLine("> Quotation ***one***")
    console.warn(tokens)
    expect(tokens[0]).toEqual value: ">", scopes: ["source.pfm", "comment.quote.pfm", "support.quote.pfm"]
    expect(tokens[1]).toEqual value: " Quotation ", scopes: ["source.pfm", "comment.quote.pfm"]
    expect(tokens[2]).toEqual value: "***", scopes: ["source.pfm", "comment.quote.pfm", "markup.bold.italic.pfm"]
    expect(tokens[3]).toEqual value: "one", scopes: ["source.pfm", "comment.quote.pfm", "markup.bold.italic.pfm"]
    expect(tokens[4]).toEqual value: "***", scopes: ["source.pfm", "comment.quote.pfm", "markup.bold.italic.pfm"]

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
