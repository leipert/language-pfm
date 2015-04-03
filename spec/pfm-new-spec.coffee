describe "Pandoc Flavored Markdown grammar", ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage("language-pfm")

    runs ->
      grammar = atom.grammars.grammarForScopeName("source.gfm")

  it "parses the grammar", ->
    expect(grammar).toBeDefined()
    expect(grammar.scopeName).toBe "source.gfm"

  it "tokenizes mentions", ->
    {tokens} = grammar.tokenizeLine("sentence with no space before@name ")
    expect(tokens[0]).toEqual value: "sentence with no space before@name ", scopes: ["source.gfm"]

    {tokens} = grammar.tokenizeLine("@name '@name' @name's @name. @name, (@name) [@name]")
    expect(tokens[0]).toEqual value: "@", scopes: ["source.gfm", "variable.mention.gfm"]
    expect(tokens[1]).toEqual value: "name", scopes: ["source.gfm", "string.username.gfm"]
    expect(tokens[2]).toEqual value: " '", scopes: ["source.gfm"]
    expect(tokens[3]).toEqual value: "@", scopes: ["source.gfm", "variable.mention.gfm"]
    expect(tokens[4]).toEqual value: "name", scopes: ["source.gfm", "string.username.gfm"]
    expect(tokens[5]).toEqual value: "' ", scopes: ["source.gfm"]
    expect(tokens[6]).toEqual value: "@", scopes: ["source.gfm", "variable.mention.gfm"]
    expect(tokens[7]).toEqual value: "name", scopes: ["source.gfm", "string.username.gfm"]
    expect(tokens[8]).toEqual value: "'s ", scopes: ["source.gfm"]
    expect(tokens[9]).toEqual value: "@", scopes: ["source.gfm", "variable.mention.gfm"]
    expect(tokens[10]).toEqual value: "name", scopes: ["source.gfm", "string.username.gfm"]
    expect(tokens[11]).toEqual value: ". ", scopes: ["source.gfm"]
    expect(tokens[12]).toEqual value: "@", scopes: ["source.gfm", "variable.mention.gfm"]
    expect(tokens[13]).toEqual value: "name", scopes: ["source.gfm", "string.username.gfm"]
    expect(tokens[14]).toEqual value: ", (", scopes: ["source.gfm"]
    expect(tokens[15]).toEqual value: "@", scopes: ["source.gfm", "variable.mention.gfm"]
    expect(tokens[16]).toEqual value: "name", scopes: ["source.gfm", "string.username.gfm"]
    expect(tokens[17]).toEqual value: ") ", scopes: ["source.gfm"]

    {tokens} = grammar.tokenizeLine('"@name"')
    expect(tokens[0]).toEqual value: '"', scopes: ["source.gfm"]
    expect(tokens[1]).toEqual value: "@", scopes: ["source.gfm", "variable.mention.gfm"]
    expect(tokens[2]).toEqual value: "name", scopes: ["source.gfm", "string.username.gfm"]
    expect(tokens[3]).toEqual value: '"', scopes: ["source.gfm"]

    {tokens} = grammar.tokenizeLine("sentence with a space before @name/ and an invalid symbol after")
    expect(tokens[0]).toEqual value: "sentence with a space before @name/ and an invalid symbol after", scopes: ["source.gfm"]

    {tokens} = grammar.tokenizeLine("sentence with a space before @name that continues")
    expect(tokens[0]).toEqual value: "sentence with a space before ", scopes: ["source.gfm"]
    expect(tokens[1]).toEqual value: "@", scopes: ["source.gfm", "variable.mention.gfm"]
    expect(tokens[2]).toEqual value: "name", scopes: ["source.gfm", "string.username.gfm"]
    expect(tokens[3]).toEqual value: " that continues", scopes: ["source.gfm"]

    {tokens} = grammar.tokenizeLine("* @name at the start of an unordered list")
    expect(tokens[0]).toEqual value: "*", scopes: ["source.gfm", "variable.unordered.list.gfm"]
    expect(tokens[1]).toEqual value: " ", scopes: ["source.gfm"]
    expect(tokens[2]).toEqual value: "@", scopes: ["source.gfm", "variable.mention.gfm"]
    expect(tokens[3]).toEqual value: "name", scopes: ["source.gfm", "string.username.gfm"]
    expect(tokens[4]).toEqual value: " at the start of an unordered list", scopes: ["source.gfm"]

    {tokens} = grammar.tokenizeLine("a username @1337_hubot with numbers, letters and underscores")
    expect(tokens[0]).toEqual value: "a username ", scopes: ["source.gfm"]
    expect(tokens[1]).toEqual value: "@", scopes: ["source.gfm", "variable.mention.gfm"]
    expect(tokens[2]).toEqual value: "1337_hubot", scopes: ["source.gfm", "string.username.gfm"]
    expect(tokens[3]).toEqual value: " with numbers, letters and underscores", scopes: ["source.gfm"]

    {tokens} = grammar.tokenizeLine("a username @1337-hubot with numbers, letters and hyphens")
    expect(tokens[0]).toEqual value: "a username ", scopes: ["source.gfm"]
    expect(tokens[1]).toEqual value: "@", scopes: ["source.gfm", "variable.mention.gfm"]
    expect(tokens[2]).toEqual value: "1337-hubot", scopes: ["source.gfm", "string.username.gfm"]
    expect(tokens[3]).toEqual value: " with numbers, letters and hyphens", scopes: ["source.gfm"]

    {tokens} = grammar.tokenizeLine("@name at the start of a line")
    expect(tokens[0]).toEqual value: "@", scopes: ["source.gfm", "variable.mention.gfm"]
    expect(tokens[1]).toEqual value: "name", scopes: ["source.gfm", "string.username.gfm"]
    expect(tokens[2]).toEqual value: " at the start of a line", scopes: ["source.gfm"]

    {tokens} = grammar.tokenizeLine("any email like you@domain.com shouldn't mistakenly be matched as a mention")
    expect(tokens[0]).toEqual value: "any email like you@domain.com shouldn't mistakenly be matched as a mention", scopes: ["source.gfm"]

    {tokens} = grammar.tokenizeLine("@person's")
    expect(tokens[0]).toEqual value: "@", scopes: ["source.gfm", "variable.mention.gfm"]
    expect(tokens[1]).toEqual value: "person", scopes: ["source.gfm", "string.username.gfm"]
    expect(tokens[2]).toEqual value: "'s", scopes: ["source.gfm"]

    {tokens} = grammar.tokenizeLine("@person;")
    expect(tokens[0]).toEqual value: "@", scopes: ["source.gfm", "variable.mention.gfm"]
    expect(tokens[1]).toEqual value: "person", scopes: ["source.gfm", "string.username.gfm"]
    expect(tokens[2]).toEqual value: ";", scopes: ["source.gfm"]
