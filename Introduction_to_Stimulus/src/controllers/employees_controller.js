import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "employee", "info" ]

  initialize() {
    console.log('Initialized')
    console.log(this)
  }

  connect() {
    this.loadFrom(this.data.get('url'), this.displayEmployees)
  }

  choose(e) {
    e.preventDefault()
    const id = e.target.getAttribute('data-id')

    if (this.currentEmployee !== id) {
      this.loadFrom(`employees/${id}.json`, this.displayInfo)
      this.currentEmployee = id

      this.employeeTargets.forEach((el, i) => {
        el.classList.toggle("chosen", id === el.getAttribute("data-id"))
      })
    }
  }

  displayEmployees(employees) {
    let html = "<ul>"
    employees.forEach((el) => {
      html += `<li><a href="#" data-target="employees.employee" data-id="${el.id}" data-action="employees#choose">${el.name}</a></li>`
    })
    html += "</ul>"
    this.element.innerHTML += html
  }

  loadFrom(url, callback) {
    fetch(url)
        .then(response => response.text())
        .then(json => { callback.call( this, JSON.parse(json) ) })
  }

  displayInfo(info) {
    const html = `<ul><li>Name: ${info.name}</li><li>Gender: ${info.gender}</li><li>Age: ${info.age}</li><li>Position: ${info.position}</li><li>Salary: ${info.salary}</li><li><img src="${info.image}"></li></ul>`
    this.infoTarget.innerHTML = html
  }

  get currentEmployee() {
    return this.data.get("current-employee")
  }

  set currentEmployee(id) {
    this.data.set("current-employee", id)
  }
}
