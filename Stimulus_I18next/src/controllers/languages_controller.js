import { Controller } from "stimulus"
import { i18n, loci18n } from '../i18n/config'

export default class extends Controller {
  static targets = [ "switcher" ]

  initialize() {
    i18n.on('loaded', (loaded) => {
      let languages = [
        {title: 'English', code: 'en'},
        {title: 'Русский', code: 'ru'}
      ]

      this.element.innerHTML = languages.map((lang) => {
        return `<li data-action="click->languages#switchLanguage"
        data-target="languages.switcher" data-lang="${lang.code}">${lang.title}</li>`
      }).join('')

      this.currentLang = i18n.language
    })
  }

  switchLanguage(e) {
    this.currentLang = e.target.getAttribute("data-lang")
  }

  highlightCurrentLang() {
    this.switcherTargets.forEach((el, i) => {
      el.classList.toggle("current", this.currentLang === el.getAttribute("data-lang"))
    })
  }

  //set currentLang(lang) {
  //    if(this.currentLang !== lang) {
  //    this.data.set("currentLang", lang)
  //      this.highlightCurrentLang()
  //  }
  //  }

  get currentLang() {
    return this.data.get("currentLang")
  }

  set currentLang(lang) {
    if(i18n.language !== lang) {
      i18n.changeLanguage(lang)
      window.history.pushState(null, null, `?lang=${lang}`)
    }

    if(this.currentLang !== lang) {
      this.data.set("currentLang", lang)
      loci18n('body')
      this.highlightCurrentLang()
    }
  }
}
