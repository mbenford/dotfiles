const { Hints, Visual, map, unmap, unmapAllExcept, removeSearchAlias } = api

function main() {
  settings.smoothScroll = false
  settings.hintAlign = 'left'
  settings.enableEmojiInsertion = false
  settings.tabsThreshold = 0

  setTheme()

  disableFor([
    /mail.google.com/,
    /drive.google.com/,
    /ticktick.com/,
    /app.slack.com/,
    /outlook.office.com/,
    /.*.youtube.com/,
    /codesandbox.io/,
  ])

  removeSearchAlias('g')
  removeSearchAlias('d')
  removeSearchAlias('b')
  removeSearchAlias('e')
  removeSearchAlias('w')
  removeSearchAlias('s')
  removeSearchAlias('y')

  unmap('/', /github.com/)

  map('h', 'S')
  map('l', 'D')
  map('oo', 'go')
  map('ob', 'b')
  map('ot', 'T')
  map('oh', 'oh')
}

function setTheme() {
  const palette = {
    bg: '#24283b',
    bg_dark: '#1f2335',
    bg_darker: '#1d202f',
    bg_highlight: '#292e42',
    blue: '#7aa2f7',
    blue0: '#3d59a1',
    blue1: '#2ac3de',
    blue2: '#0db9d7',
    blue5: '#89ddff',
    blue6: '#b4f9f8',
    blue7: '#394b70',
    comment: '#565f89',
    cyan: '#7dcfff',
    dark3: '#545c7e',
    dark5: '#737aa2',
    fg: '#c0caf5',
    fg_dark: '#a9b1d6',
    fg_gutter: '#3b4261',
    green: '#9ece6a',
    green1: '#73daca',
    green2: '#41a6b5',
    magenta: '#bb9af7',
    magenta2: '#ff007c',
    orange: '#ff9e64',
    purple: '#9d7cd8',
    red: '#f7768e',
    red1: '#db4b4b',
    teal: '#1abc9c',
    terminal_black: '#414868',
    yellow: '#e0af68',
  }

  Hints.style(objToCssProps({
    'border': 'solid 1px #000',
    'color': palette.bg_dark,
    'background': 'initial',
    'background-color': palette.orange,
    'padding':'3px',
  }))
  Visual.style('marks', objToCssProps({
    'background-color': '#98be6599',
  }))
  Visual.style('cursor', objToCssProps({
    'background-color': '#f5a97f',
  }))

  settings.theme = objToCss({
    ':root': {
      '--theme-ace-bg': palette.bg,
      '--theme-ace-bg-accent': palette.bg,
      '--theme-ace-fg': palette.fg,
      '--theme-ace-fg-accent': palette.fg_gutter,
      '--theme-ace-cursor': palette.fg,
      '--theme-ace-select': palette.bg_highlight,
      '--theme-ace-dialog-bg': palette.bg_darker,
    },
    '.sk_theme': {
      'font-family': 'monospace',
      'font-size':'12pt',
      'background': palette.bg,
      'color': palette.fg,
    },
    '.sk_theme tbody': {
      'color': '#fff',
    },
    '.sk_theme input': {
      'color': palette.fg,
    },
    '.sk_theme .url': {
      'color': palette.blue,
    },
    '.sk_theme .annotation': {
      'color': '#56b6c2',
    },
    '.sk_theme .omnibar_highlight': {
      'color': palette.orange,
    },
    '.sk_theme .omnibar_timestamp': {
      'color': '#e5c07b',
    },
    '.sk_theme .omnibar_visitcount': {
      'color': '#98c379',
    },
    '.sk_theme #sk_omnibarSearchResult ul li:nth-child(odd)': {
      'background': palette.bg,
    },
    '.sk_theme #sk_omnibarSearchResult ul li.focused': {
      'background': palette.blue7,
    },
    '#sk_status, #sk_find': {
      'font-size': '20pt',
    },
    '#sk_editor': {
      'height': '75% !important',
      'background': 'var(--theme-ace-bg) !important',
      'font-size': '16pt !important',
    },
    '.ace_editor': {
      'font': '16pt !important',
    },
    '.ace-chrome .ace_print-margin, .ace_gutter, .ace_gutter-cell, .ace_dialog': {
      'background': 'var(--theme-ace-bg-accent) !important',
    },
    '.ace_dialog-bottom': {
      'border-top': '1px solid var(--theme-ace-bg) !important',
    },
    '.ace-chrome': {
      'color': 'var(--theme-ace-fg) !important',
    },
    '.ace_gutter': {
      'color': 'var(--theme-ace-fg-accent) !important',
    },
    '.ace_active-line': {
      'background-color': `${palette.bg_highlight} !important`,
    },
    '.ace_gutter-active-line': {
      'color': `${palette.orange} !important`,
    },
    '.ace_dialog': {
      'font-size': '16pt !important',
      'color': 'var(--theme-ace-fg) !important',
      'background-color': 'var(--theme-ace-dialog-bg) !important',
    },
    '.ace_dialog input': {
      'font-size': '16pt !important',
    },
    '.ace_cursor': {
      'color': 'var(--theme-ace-cursor) !important',
    },
    '.normal-mode .ace_cursor': {
      'color': 'var(--theme-ace-bg) !important',
      'background-color': 'var(--theme-ace-cursor) !important',
      'border': 'var(--theme-ace-cursor) !important',
    },
    '.ace_marker-layer .ace_selection': {
      'background': 'var(--theme-ace-select) !important',
    },
  })
}

function disableFor(domains) {
  domains.forEach(domain => unmapAllExcept([], domain))
}

function objToCss(obj) {
  return Object.keys(obj).reduce((classes, key) => {
    classes.push(`${key}{${objToCssProps(obj[key])}}`)
    return classes
  }, []).join('')
}

function objToCssProps(obj) {
  return Object.keys(obj).reduce((props, key) => {
    props.push(`${key}: ${obj[key]};`)
    return props
  }, []).join('')
}

main()
