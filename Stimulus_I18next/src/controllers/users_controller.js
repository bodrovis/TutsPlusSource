import { Controller } from "stimulus"
import { loci18n } from '../i18n/config'

export default class extends Controller {
  connect() {
    this.loadUsers()
  }

  loadUsers() {
    fetch(this.data.get("url"))
    .then(response => response.text())
    .then(json => {
      this.renderUsers(json)
      this.localize()
    })
  }

  renderUsers(users) {
    let content = ''
    JSON.parse(users).forEach((user) => {
      content += `<div class="users"><span data-i18n="login"></span>: ${user.login}<br><span data-i18n="uploaded" data-i18n-options="{ 'context': '${user.gender}' }"></span> <span data-i18n="photos" data-i18n-options="{ 'count': ${user.photos_count} }"></span></div><hr>`
    })
    this.element.innerHTML = content
  }

  localize() {
    loci18n('.users')
  }
}
