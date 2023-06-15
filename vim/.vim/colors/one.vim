vim9script
# Name:    one vim colorscheme
# Author:  Ramzi Akremi
# License: MIT
# Version: 1.1.1-pre

# Global setup ==============================================================

hi clear
syntax reset
if exists('g:colors_name')
  unlet g:colors_name
endif
g:colors_name = 'one9'

if !exists('g:one_allow_italics')
  g:one_allow_italics = 0
endif

var italic = ''
if g:one_allow_italics == 1
  italic = 'italic'
endif

if has('gui_running') || has('termguicolors') || &t_Co == 88 || &t_Co == 256
  # functions
  # returns an approximate grey index for the given grey level

  # Utility functions -------------------------------------------------------
  def GreyNumber(x: number)
    if &t_Co == 88
      if x < 23
        return 0
      elseif x < 69
        return 1
      elseif x < 103
        return 2
      elseif x < 127
        return 3
      elseif x < 150
        return 4
      elseif x < 173
        return 5
      elseif x < 196
        return 6
      elseif x < 219
        return 7
      elseif x < 243
        return 8
      else
        return 9
      endif
    else
      if x < 14
        return 0
      else
        var n = (x - 8) / 10
        var m = (x - 8) % 10
        if m < 5
          return n
        else
          return n + 1
        endif
      endif
    endif
  enddef

  # returns the actual grey level represented by the grey index
  def GreyLevel(n: number)
    if &t_Co == 88
      if n == 0
        return 0
      elseif n == 1
        return 46
      elseif n == 2
        return 92
      elseif n == 3
        return 115
      elseif n == 4
        return 139
      elseif n == 5
        return 162
      elseif n == 6
        return 185
      elseif n == 7
        return 208
      elseif n == 8
        return 231
      else
        return 255
      endif
    else
      if n == 0
        return 0
      else
        return 8 + (n * 10)
      endif
    endif
  enddef

  # returns the palette index for the given grey index
  def GreyColor(n: number)
    if &t_Co == 88
      if n == 0
        return 16
      elseif n == 9
        return 79
      else
        return 79 + n
      endif
    else
      if n == 0
        return 16
      elseif n == 25
        return 231
      else
        return 231 + n
      endif
    endif
  enddef

  # Highlight function
  # the original one is borrowed from mhartington/oceanic-next
  def X(group: string, fg: any, bg: any, attr: string, ...args: list<any>)
    # fg, bg, attr, attrsp
    if !empty(fg)
      exec "hi " .. group .. " guifg=" ..  fg[0]
      exec "hi " .. group .. " ctermfg=" .. fg[1]
    endif
    if !empty(bg)
      exec "hi " .. group .. " guibg=" ..  bg[0]
      exec "hi " .. group .. " ctermbg=" .. bg[1]
    endif
    if attr != ""
      exec "hi " .. group .. " gui=" ..   attr
      exec "hi " .. group .. " cterm=" .. attr
    endif
    if !empty(args)
      exec "hi " .. group .. " guisp=" .. args[0]
    endif
  enddef

  #


  # Color definition --------------------------------------------------------
  var dark = 0
  var mono_1 = ['#494b53', '23']
  var mono_2 = ['#696c77', '60']
  var mono_3 = ['#a0a1a7', '145']
  var mono_4 = ['#c2c2c3', '250']

  var hue_1  = ['#0184bc', '31'] # cyan
  var hue_2  = ['#4078f2', '33'] # blue
  var hue_3  = ['#a626a4', '127'] # purple
  var hue_4  = ['#50a14f', '71'] # green

  var hue_5   = ['#e45649', '166'] # red 1
  var hue_5_2 = ['#ca1243', '160'] # red 2

  var hue_6   = ['#986801', '94'] # orange 1
  var hue_6_2 = ['#c18401', '136'] # orange 2

  var syntax_bg     = ['#fafafa', '255']
  var syntax_gutter = ['#9e9e9e', '247']
  var syntax_cursor = ['#f0f0f0', '254']

  var syntax_accent = ['#526fff', '63']
  var syntax_accent_2 = ['#0083be', '31']

  var vertsplit    = ['#e7e9e1', '188']
  var special_grey = ['#d3d3d3', '251']
  var visual_grey  = ['#d0d0d0', '251']
  var pmenu        = ['#dfdfdf', '253']
  if &background ==# 'dark'
    dark = 1
    mono_1 = ['#abb2bf', '145']
    mono_2 = ['#828997', '102']
    mono_3 = ['#5c6370', '59']
    mono_4 = ['#4b5263', '59']

    hue_1  = ['#56b6c2', '73'] # cyan
    hue_2  = ['#61afef', '75'] # blue
    hue_3  = ['#c678dd', '176'] # purple
    hue_4  = ['#98c379', '114'] # green

    hue_5   = ['#e06c75', '168'] # red 1
    hue_5_2 = ['#be5046', '130'] # red 2

    hue_6   = ['#d19a66', '173'] # orange 1
    hue_6_2 = ['#e5c07b', '180'] # orange 2

    syntax_bg     = ['#282c34', '16']
    syntax_gutter = ['#636d83', '60']
    syntax_cursor = ['#2c323c', '16']

    syntax_accent = ['#528bff', '69']

    vertsplit    = ['#181a1f', '233']
    special_grey = ['#3b4048', '16']
    visual_grey  = ['#3e4452', '17']
    pmenu        = ['#333841', '16']
  endif

  const syntax_fg = mono_1
  const syntax_fold_bg = mono_3

  #

  # Vim editor color --------------------------------------------------------
  X('Normal',        syntax_fg,      syntax_bg,      '')
  X('bold',          '',             '',             'bold')
  X('ColorColumn',   '',             syntax_cursor,  '')
  X('Conceal',       mono_4,         syntax_bg,      '')
  X('Cursor',        '',             syntax_accent,  '')
  X('CursorIM',      '',             '',             '')
  X('CursorColumn',  '',             syntax_cursor,  '')
  X('CursorLine',    '',             syntax_cursor,  'none')
  X('Directory',     hue_2,          '',             '')
  X('ErrorMsg',      hue_5,          syntax_bg,      'none')
  X('VertSplit',     syntax_cursor,  syntax_cursor,  'none')
  X('Folded',        syntax_fg,      syntax_bg,      'none')
  X('FoldColumn',    mono_3,         syntax_cursor,  '')
  X('IncSearch',     hue_6,          '',             '')
  X('LineNr',        mono_4,         '',             '')
  X('CursorLineNr',  syntax_fg,      syntax_cursor,  'none')
  X('MatchParen',    hue_5,          syntax_cursor,  'underline,bold')
  X('Italic',        '',             '',             italic)
  X('ModeMsg',       syntax_fg,      '',             '')
  X('MoreMsg',       syntax_fg,      '',             '')
  X('NonText',       mono_3,         '',             'none')
  X('PMenu',         '',             pmenu,          '')
  X('PMenuSel',      '',             mono_4,         '')
  X('PMenuSbar',     '',             syntax_bg,      '')
  X('PMenuThumb',    '',             mono_1,         '')
  X('Question',      hue_2,          '',             '')
  X('Search',        syntax_bg,      hue_6_2,        '')
  X('SpecialKey',    special_grey,   '',             'none')
  X('Whitespace',    special_grey,   '',             'none')
  X('StatusLine',    syntax_fg,      syntax_cursor,  'none')
  X('StatusLineNC',  mono_3,         '',             '')
  X('TabLine',       mono_2,         visual_grey,    'none')
  X('TabLineFill',   mono_3,         visual_grey,    'none')
  X('TabLineSel',    syntax_bg,      hue_2,          '')
  X('Title',         syntax_fg,      '',             'bold')
  X('Visual',        '',             visual_grey,    '')
  X('VisualNOS',     '',             visual_grey,    '')
  X('WarningMsg',    hue_5,          '',             '')
  X('TooLong',       hue_5,          '',             '')
  X('WildMenu',      syntax_fg,      mono_3,         '')
  X('SignColumn',    '',             syntax_bg,      '')
  X('Special',       hue_2,          '',             '')
  #

  # Vim Help highlighting ---------------------------------------------------
  X('helpCommand',      hue_6_2, '', '')
  X('helpExample',      hue_6_2, '', '')
  X('helpHeader',       mono_1,  '', 'bold')
  X('helpSectionDelim', mono_3,  '', '')
  #

  # Standard syntax highlighting --------------------------------------------
  X('Comment',         mono_3,         '',         italic)
  X('Constant',        hue_4,          '',         '')
  X('String',          hue_4,          '',         '')
  X('Character',       hue_4,          '',         '')
  X('Number',          hue_6,          '',         '')
  X('Boolean',         hue_6,          '',         '')
  X('Float',           hue_6,          '',         '')
  X('Identifier',      hue_5,          '',         'none')
  X('Function',        hue_2,          '',         '')
  X('Statement',       hue_3,          '',         'none')
  X('Conditional',     hue_3,          '',         '')
  X('Repeat',          hue_3,          '',         '')
  X('Label',           hue_3,          '',         '')
  X('Operator',        syntax_accent,  '',         'none')
  X('Keyword',         hue_5,          '',         '')
  X('Exception',       hue_3,          '',         '')
  X('PreProc',         hue_6_2,        '',         '')
  X('Include',         hue_2,          '',         '')
  X('Define',          hue_3,          '',         'none')
  X('Macro',           hue_3,          '',         '')
  X('PreCondit',       hue_6_2,        '',         '')
  X('Type',            hue_6_2,        '',         'none')
  X('StorageClass',    hue_6_2,        '',         '')
  X('Structure',       hue_6_2,        '',         '')
  X('Typedef',         hue_6_2,        '',         '')
  X('Special',         hue_2,          '',         '')
  X('SpecialChar',     '',             '',         '')
  X('Tag',             '',             '',         '')
  X('Delimiter',       '',             '',         '')
  X('SpecialComment',  '',             '',         '')
  X('Debug',           '',             '',         '')
  X('Underlined',      '',             '',         'underline')
  X('Ignore',          '',             '',         '')
  X('Error',           hue_5,          syntax_bg,  'bold')
  X('Todo',            hue_3,          syntax_bg,  '')
  #

  # Diff highlighting -------------------------------------------------------
  X('DiffAdd',     hue_4, visual_grey, '')
  X('DiffChange',  hue_6, visual_grey, '')
  X('DiffDelete',  hue_5, visual_grey, '')
  X('DiffText',    hue_2, visual_grey, '')
  X('DiffAdded',   hue_4, visual_grey, '')
  X('DiffFile',    hue_5, visual_grey, '')
  X('DiffNewFile', hue_4, visual_grey, '')
  X('DiffLine',    hue_2, visual_grey, '')
  X('DiffRemoved', hue_5, visual_grey, '')
  #

  # Asciidoc highlighting ---------------------------------------------------
  X('asciidocListingBlock',   mono_2,  '', '')
  #

  # C/C++ highlighting ------------------------------------------------------
  X('cInclude',           hue_3,  '', '')
  X('cPreCondit',         hue_3,  '', '')
  X('cPreConditMatch',    hue_3,  '', '')

  X('cType',              hue_3,  '', '')
  X('cStorageClass',      hue_3,  '', '')
  X('cStructure',         hue_3,  '', '')
  X('cOperator',          hue_3,  '', '')
  X('cStatement',         hue_3,  '', '')
  X('cTODO',              hue_3,  '', '')
  X('cConstant',          hue_6,  '', '')
  X('cSpecial',           hue_1,  '', '')
  X('cSpecialCharacter',  hue_1,  '', '')
  X('cString',            hue_4,  '', '')

  X('cppType',            hue_3,  '', '')
  X('cppStorageClass',    hue_3,  '', '')
  X('cppStructure',       hue_3,  '', '')
  X('cppModifier',        hue_3,  '', '')
  X('cppOperator',        hue_3,  '', '')
  X('cppAccess',          hue_3,  '', '')
  X('cppStatement',       hue_3,  '', '')
  X('cppConstant',        hue_5,  '', '')
  X('cCppString',         hue_4,  '', '')
  #

  # Cucumber highlighting ---------------------------------------------------
  X('cucumberGiven',           hue_2,  '', '')
  X('cucumberWhen',            hue_2,  '', '')
  X('cucumberWhenAnd',         hue_2,  '', '')
  X('cucumberThen',            hue_2,  '', '')
  X('cucumberThenAnd',         hue_2,  '', '')
  X('cucumberUnparsed',        hue_6,  '', '')
  X('cucumberFeature',         hue_5,  '', 'bold')
  X('cucumberBackground',      hue_3,  '', 'bold')
  X('cucumberScenario',        hue_3,  '', 'bold')
  X('cucumberScenarioOutline', hue_3,  '', 'bold')
  X('cucumberTags',            mono_3, '', 'bold')
  X('cucumberDelimiter',       mono_3, '', 'bold')
  #

  # CSS/Sass highlighting ---------------------------------------------------
  X('cssAttrComma',         hue_3,  '', '')
  X('cssAttributeSelector', hue_4,  '', '')
  X('cssBraces',            mono_2, '', '')
  X('cssClassName',         hue_6,  '', '')
  X('cssClassNameDot',      hue_6,  '', '')
  X('cssDefinition',        hue_3,  '', '')
  X('cssFontAttr',          hue_6,  '', '')
  X('cssFontDescriptor',    hue_3,  '', '')
  X('cssFunctionName',      hue_2,  '', '')
  X('cssIdentifier',        hue_2,  '', '')
  X('cssImportant',         hue_3,  '', '')
  X('cssInclude',           mono_1, '', '')
  X('cssIncludeKeyword',    hue_3,  '', '')
  X('cssMediaType',         hue_6,  '', '')
  X('cssProp',              hue_1,  '', '')
  X('cssPseudoClassId',     hue_6,  '', '')
  X('cssSelectorOp',        hue_3,  '', '')
  X('cssSelectorOp2',       hue_3,  '', '')
  X('cssStringQ',           hue_4,  '', '')
  X('cssStringQQ',          hue_4,  '', '')
  X('cssTagName',           hue_5,  '', '')
  X('cssAttr',              hue_6,  '', '')

  X('sassAmpersand',      hue_5,   '', '')
  X('sassClass',          hue_6_2, '', '')
  X('sassControl',        hue_3,   '', '')
  X('sassExtend',         hue_3,   '', '')
  X('sassFor',            mono_1,  '', '')
  X('sassProperty',       hue_1,   '', '')
  X('sassFunction',       hue_1,   '', '')
  X('sassId',             hue_2,   '', '')
  X('sassInclude',        hue_3,   '', '')
  X('sassMedia',          hue_3,   '', '')
  X('sassMediaOperators', mono_1,  '', '')
  X('sassMixin',          hue_3,   '', '')
  X('sassMixinName',      hue_2,   '', '')
  X('sassMixing',         hue_3,   '', '')

  X('scssSelectorName',   hue_6_2, '', '')
  #

  # Elixir highlighting------------------------------------------------------
  hi link elixirModuleDefine Define
  X('elixirAlias',             hue_6_2, '', '')
  X('elixirAtom',              hue_1,   '', '')
  X('elixirBlockDefinition',   hue_3,   '', '')
  X('elixirModuleDeclaration', hue_6,   '', '')
  X('elixirInclude',           hue_5,   '', '')
  X('elixirOperator',          hue_6,   '', '')
  #

  # Git and git related plugins highlighting --------------------------------
  X('gitcommitComment',       mono_3,  '', '')
  X('gitcommitUnmerged',      hue_4,   '', '')
  X('gitcommitOnBranch',      '',        '', '')
  X('gitcommitBranch',        hue_3,   '', '')
  X('gitcommitDiscardedType', hue_5,   '', '')
  X('gitcommitSelectedType',  hue_4,   '', '')
  X('gitcommitHeader',        '',        '', '')
  X('gitcommitUntrackedFile', hue_1,   '', '')
  X('gitcommitDiscardedFile', hue_5,   '', '')
  X('gitcommitSelectedFile',  hue_4,   '', '')
  X('gitcommitUnmergedFile',  hue_6_2, '', '')
  X('gitcommitFile',          '',        '', '')
  hi link gitcommitNoBranch       gitcommitBranch
  hi link gitcommitUntracked      gitcommitComment
  hi link gitcommitDiscarded      gitcommitComment
  hi link gitcommitSelected       gitcommitComment
  hi link gitcommitDiscardedArrow gitcommitDiscardedFile
  hi link gitcommitSelectedArrow  gitcommitSelectedFile
  hi link gitcommitUnmergedArrow  gitcommitUnmergedFile

  X('SignifySignAdd',    hue_4,   '', '')
  X('SignifySignChange', hue_6_2, '', '')
  X('SignifySignDelete', hue_5,   '', '')
  hi link GitGutterAdd    SignifySignAdd
  hi link GitGutterChange SignifySignChange
  hi link GitGutterDelete SignifySignDelete
  X('diffAdded',         hue_4,   '', '')
  X('diffRemoved',       hue_5,   '', '')
  #

  # Go highlighting ---------------------------------------------------------
  X('goDeclaration',         hue_3, '', '')
  X('goField',               hue_5, '', '')
  X('goMethod',              hue_1, '', '')
  X('goType',                hue_3, '', '')
  X('goUnsignedInts',        hue_1, '', '')
  #

  # Haskell highlighting ----------------------------------------------------
  X('haskellDeclKeyword',    hue_2, '', '')
  X('haskellType',           hue_4, '', '')
  X('haskellWhere',          hue_5, '', '')
  X('haskellImportKeywords', hue_2, '', '')
  X('haskellOperators',      hue_5, '', '')
  X('haskellDelimiter',      hue_2, '', '')
  X('haskellIdentifier',     hue_6, '', '')
  X('haskellKeyword',        hue_5, '', '')
  X('haskellNumber',         hue_1, '', '')
  X('haskellString',         hue_1, '', '')


  # HTML highlighting -------------------------------------------------------
  X('htmlArg',            hue_6,  '', '')
  X('htmlTagName',        hue_5,  '', '')
  X('htmlTagN',           hue_5,  '', '')
  X('htmlSpecialTagName', hue_5,  '', '')
  X('htmlTag',            mono_2, '', '')
  X('htmlEndTag',         mono_2, '', '')

  X('MatchTag', hue_5, syntax_cursor, 'underline,bold')
  #

  # JavaScript highlighting -------------------------------------------------
  X('coffeeString',           hue_4,   '', '')

  X('javaScriptBraces',       mono_2,  '', '')
  X('javaScriptFunction',     hue_3,   '', '')
  X('javaScriptIdentifier',   hue_3,   '', '')
  X('javaScriptNull',         hue_6,   '', '')
  X('javaScriptNumber',       hue_6,   '', '')
  X('javaScriptRequire',      hue_1,   '', '')
  X('javaScriptReserved',     hue_3,   '', '')
  # http//github.com/pangloss/vim-javascript
  X('jsArrowFunction',        hue_3,   '', '')
  X('jsBraces',               mono_2,  '', '')
  X('jsClassBraces',          mono_2,  '', '')
  X('jsClassKeywords',        hue_3,   '', '')
  X('jsDocParam',             hue_2,   '', '')
  X('jsDocTags',              hue_3,   '', '')
  X('jsFuncBraces',           mono_2,  '', '')
  X('jsFuncCall',             hue_2,   '', '')
  X('jsFuncParens',           mono_2,  '', '')
  X('jsFunction',             hue_3,   '', '')
  X('jsGlobalObjects',        hue_6_2, '', '')
  X('jsModuleWords',          hue_3,   '', '')
  X('jsModules',              hue_3,   '', '')
  X('jsNoise',                mono_2,  '', '')
  X('jsNull',                 hue_6,   '', '')
  X('jsOperator',             hue_3,   '', '')
  X('jsParens',               mono_2,  '', '')
  X('jsStorageClass',         hue_3,   '', '')
  X('jsTemplateBraces',       hue_5_2, '', '')
  X('jsTemplateVar',          hue_4,   '', '')
  X('jsThis',                 hue_5,   '', '')
  X('jsUndefined',            hue_6,   '', '')
  X('jsObjectValue',          hue_2,   '', '')
  X('jsObjectKey',            hue_1,   '', '')
  X('jsReturn',               hue_3,   '', '')
  # http//github.com/othree/yajs.vim
  X('javascriptArrowFunc',    hue_3,   '', '')
  X('javascriptClassExtends', hue_3,   '', '')
  X('javascriptClassKeyword', hue_3,   '', '')
  X('javascriptDocNotation',  hue_3,   '', '')
  X('javascriptDocParamName', hue_2,   '', '')
  X('javascriptDocTags',      hue_3,   '', '')
  X('javascriptEndColons',    mono_3,  '', '')
  X('javascriptExport',       hue_3,   '', '')
  X('javascriptFuncArg',      mono_1,  '', '')
  X('javascriptFuncKeyword',  hue_3,   '', '')
  X('javascriptIdentifier',   hue_5,   '', '')
  X('javascriptImport',       hue_3,   '', '')
  X('javascriptObjectLabel',  mono_1,  '', '')
  X('javascriptOpSymbol',     hue_1,   '', '')
  X('javascriptOpSymbols',    hue_1,   '', '')
  X('javascriptPropertyName', hue_4,   '', '')
  X('javascriptTemplateSB',   hue_5_2, '', '')
  X('javascriptVariable',     hue_3,   '', '')
  #

  # JSON highlighting -------------------------------------------------------
  X('jsonCommentError',         mono_1,  '', ''        )
  X('jsonKeyword',              hue_5,   '', ''        )
  X('jsonQuote',                mono_3,  '', ''        )
  X('jsonTrailingCommaError',   hue_5,   '', 'reverse' )
  X('jsonMissingCommaError',    hue_5,   '', 'reverse' )
  X('jsonNoQuotesError',        hue_5,   '', 'reverse' )
  X('jsonNumError',             hue_5,   '', 'reverse' )
  X('jsonString',               hue_4,   '', ''        )
  X('jsonBoolean',              hue_3,   '', ''        )
  X('jsonNumber',               hue_6,   '', ''        )
  X('jsonStringSQError',        hue_5,   '', 'reverse' )
  X('jsonSemicolonError',       hue_5,   '', 'reverse' )
  #

  # Markdown highlighting ---------------------------------------------------
  X('markdownUrl',              mono_3,  '', '')
  X('markdownBold',             hue_6,   '', 'bold')
  X('markdownItalic',           hue_6,   '', 'bold')
  X('markdownCode',             hue_4,   '', '')
  X('markdownCodeBlock',        hue_5,   '', '')
  X('markdownCodeDelimiter',    hue_4,   '', '')
  X('markdownHeadingDelimiter', hue_5_2, '', '')
  X('markdownH1',               hue_5,   '', '')
  X('markdownH2',               hue_5,   '', '')
  X('markdownH3',               hue_5,   '', '')
  X('markdownH3',               hue_5,   '', '')
  X('markdownH4',               hue_5,   '', '')
  X('markdownH5',               hue_5,   '', '')
  X('markdownH6',               hue_5,   '', '')
  X('markdownListMarker',       hue_5,   '', '')
  #

  # Perl highlighting -------------------------------------------------------
  X('perlFunction',      hue_3,     '', '')
  X('perlMethod',        syntax_fg, '', '')
  X('perlPackageConst',  hue_3,     '', '')
  X('perlPOD',           mono_3,    '', '')
  X('perlSubName',       syntax_fg, '', '')
  X('perlSharpBang',     mono_3,    '', '')
  X('perlSpecialString', hue_4,     '', '')
  X('perlVarPlain',      hue_2,     '', '')
  X('podCommand',        mono_3,    '', '')

  # PHP highlighting --------------------------------------------------------
  X('phpClass',        hue_6_2, '', '')
  X('phpFunction',     hue_2,   '', '')
  X('phpFunctions',    hue_2,   '', '')
  X('phpInclude',      hue_3,   '', '')
  X('phpKeyword',      hue_3,   '', '')
  X('phpParent',       mono_3,  '', '')
  X('phpType',         hue_3,   '', '')
  X('phpSuperGlobals', hue_5,   '', '')
  #

  # Pug (Formerly Jade) highlighting ----------------------------------------
  X('pugAttributesDelimiter',   hue_6,    '', '')
  X('pugClass',                 hue_6,    '', '')
  X('pugDocType',               mono_3,   '', italic)
  X('pugTag',                   hue_5,    '', '')
  #

  # PureScript highlighting -------------------------------------------------
  X('purescriptKeyword',          hue_3,     '', '')
  X('purescriptModuleName',       syntax_fg, '', '')
  X('purescriptIdentifier',       syntax_fg, '', '')
  X('purescriptType',             hue_6_2,   '', '')
  X('purescriptTypeVar',          hue_5,     '', '')
  X('purescriptConstructor',      hue_5,     '', '')
  X('purescriptOperator',         syntax_fg, '', '')
  #

  # Python highlighting -----------------------------------------------------
  X('pythonImport',               hue_3,     '', '')
  X('pythonBuiltin',              hue_1,     '', '')
  X('pythonStatement',            hue_3,     '', '')
  X('pythonParam',                hue_6,     '', '')
  X('pythonEscape',               hue_5,     '', '')
  X('pythonSelf',                 mono_2,    '', italic)
  X('pythonClass',                hue_2,     '', '')
  X('pythonOperator',             hue_3,     '', '')
  X('pythonEscape',               hue_5,     '', '')
  X('pythonFunction',             hue_2,     '', '')
  X('pythonKeyword',              hue_2,     '', '')
  X('pythonModule',               hue_3,     '', '')
  X('pythonStringDelimiter',      hue_4,     '', '')
  X('pythonSymbol',               hue_1,     '', '')
  #

  # Ruby highlighting -------------------------------------------------------
  X('rubyBlock',                     hue_3,   '', '')
  X('rubyBlockParameter',            hue_5,   '', '')
  X('rubyBlockParameterList',        hue_5,   '', '')
  X('rubyCapitalizedMethod',         hue_3,   '', '')
  X('rubyClass',                     hue_3,   '', '')
  X('rubyConstant',                  hue_6_2, '', '')
  X('rubyControl',                   hue_3,   '', '')
  X('rubyDefine',                    hue_3,   '', '')
  X('rubyEscape',                    hue_5,   '', '')
  X('rubyFunction',                  hue_2,   '', '')
  X('rubyGlobalVariable',            hue_5,   '', '')
  X('rubyInclude',                   hue_2,   '', '')
  X('rubyIncluderubyGlobalVariable', hue_5,   '', '')
  X('rubyInstanceVariable',          hue_5,   '', '')
  X('rubyInterpolation',             hue_1,   '', '')
  X('rubyInterpolationDelimiter',    hue_5,   '', '')
  X('rubyKeyword',                   hue_2,   '', '')
  X('rubyModule',                    hue_3,   '', '')
  X('rubyPseudoVariable',            hue_5,   '', '')
  X('rubyRegexp',                    hue_1,   '', '')
  X('rubyRegexpDelimiter',           hue_1,   '', '')
  X('rubyStringDelimiter',           hue_4,   '', '')
  X('rubySymbol',                    hue_1,   '', '')
  #

  # Spelling highlighting ---------------------------------------------------
  X('SpellBad',     '', syntax_bg, 'undercurl')
  X('SpellLocal',   '', syntax_bg, 'undercurl')
  X('SpellCap',     '', syntax_bg, 'undercurl')
  X('SpellRare',    '', syntax_bg, 'undercurl')
  #

  # Vim highlighting --------------------------------------------------------
  X('vimCommand',      hue_3,  '', '')
  X('vimCommentTitle', mono_3, '', 'bold')
  X('vimFunction',     hue_1,  '', '')
  X('vimFuncName',     hue_3,  '', '')
  X('vimHighlight',    hue_2,  '', '')
  X('vimLineComment',  mono_3, '', italic)
  X('vimParenSep',     mono_2, '', '')
  X('vimSep',          mono_2, '', '')
  X('vimUserFunc',     hue_1,  '', '')
  X('vimVar',          hue_5,  '', '')
  #

  # XML highlighting --------------------------------------------------------
  X('xmlAttrib',  hue_6_2, '', '')
  X('xmlEndTag',  hue_5,   '', '')
  X('xmlTag',     hue_5,   '', '')
  X('xmlTagName', hue_5,   '', '')
  #

  # ZSH highlighting --------------------------------------------------------
  X('zshCommands',     syntax_fg, '', '')
  X('zshDeref',        hue_5,     '', '')
  X('zshShortDeref',   hue_5,     '', '')
  X('zshFunction',     hue_1,     '', '')
  X('zshKeyword',      hue_3,     '', '')
  X('zshSubst',        hue_5,     '', '')
  X('zshSubstDelim',   mono_3,    '', '')
  X('zshTypes',        hue_3,     '', '')
  X('zshVariableDef',  hue_6,     '', '')
  #

  # Rust highlighting -------------------------------------------------------
  X('rustExternCrate',          hue_5,    '', 'bold')
  X('rustIdentifier',           hue_2,    '', '')
  X('rustDeriveTrait',          hue_4,    '', '')
  X('SpecialComment',           mono_3,    '', '')
  X('rustCommentLine',          mono_3,    '', '')
  X('rustCommentLineDoc',       mono_3,    '', '')
  X('rustCommentLineDocError',  mono_3,    '', '')
  X('rustCommentBlock',         mono_3,    '', '')
  X('rustCommentBlockDoc',      mono_3,    '', '')
  X('rustCommentBlockDocError', mono_3,    '', '')
  #

  # man highlighting --------------------------------------------------------
  hi link manTitle String
  X('manFooter', mono_3, '', '')
  #

  # ALE (Asynchronous Lint Engine) highlighting -----------------------------
  X('ALEWarningSign', hue_6_2, '', '')
  X('ALEErrorSign', hue_5,   '', '')


  # Neovim NERDTree Background fix ------------------------------------------
  X('NERDTreeFile', syntax_fg, '', '')
  #
endif

if exists('dark') && dark
  set background=dark
endif

# vim: set fdl=0 fdm=marker:
