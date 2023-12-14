const { Hints, Visual, map, unmap, unmapAllExcept } = api

function main() {
  settings.smoothScroll = false
  settings.hintAlign = 'left'
  settings.enableEmojiInsertion = false

  setTheme()

  disableFor([
    /mail.google.com/,
    /ticktick.com/,
    /app.slack.com/,
    /outlook.office.com/,
  ])

  unmap('/', /github.com/)

  map('h', 'S')
  map('l', 'D')
}

function setTheme() {
  Hints.style('border: solid 1px #000; color:#000; background: initial; background-color: #f5a97f;padding:3px;')
  Visual.style('marks', 'background-color: #98be6599;')
  Visual.style('cursor', 'background-color: #f5a97f;')

  settings.theme = `
  .sk_theme {
      font-family: monospace;
      font-size: 10pt;
      background: #24272e;
      color: #abb2bf;
  }
  .sk_theme tbody {
      color: #fff;
  }
  .sk_theme input {
      color: #d0d0d0;
  }
  .sk_theme .url {
      color: #61afef;
  }
  .sk_theme .annotation {
      color: #56b6c2;
  }
  .sk_theme .omnibar_highlight {
      color: #528bff;
  }
  .sk_theme .omnibar_timestamp {
      color: #e5c07b;
  }
  .sk_theme .omnibar_visitcount {
      color: #98c379;
  }
  .sk_theme #sk_omnibarSearchResult ul li:nth-child(odd) {
      background: #303030;
  }
  .sk_theme #sk_omnibarSearchResult ul li.focused {
      background: #3e4452;
  }
  #sk_status, #sk_find {
      font-size: 20pt;
  }`
}

function disableFor(domains) {
  domains.forEach(domain => unmapAllExcept([], domain))
}

main()
