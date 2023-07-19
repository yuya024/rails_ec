import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="promotion"
export default class extends Controller {
  static values = {
    url: String
  }
  static targets = [ "readCode", "code", "discount", "totalPrice", "errorMessage" ]
  
  apply(event) {
    event.preventDefault()
    const code = this.codeTarget.value
    const url = this.urlValue
    fetch(url, {
      method: "POST",
      headers: {
        "X-CSRF-Token": document.querySelector("[name='csrf-token']").content,
        "Content-Type": "application/json"
      },
      body: JSON.stringify({ code: code })
    })
    .then(response => {
      if (!response.ok) {
        throw new Error('データの取得に失敗しました')
      }
      return response.json()
    })
    .then(data => {
      this.updateOrderForm(data)
    })
  }

  updateOrderForm(data) {
    let orderForm = document.querySelector("form[data-promotion-target='form']")
    let orderFormAction = orderForm.getAttribute("data-action")
    if (!data.message) {
      let subtotal = data.total_price
      let discount = data.promotion.discount
      let total_price = subtotal - discount < 0 ? 0 : subtotal - discount

      this.codeTarget.value = ""
      this.errorMessageTarget.textContent = ""
      this.readCodeTarget.textContent = data.promotion.code
      this.discountTarget.textContent = `-${data.promotion.discount}円`
      this.totalPriceTarget.textContent = `${total_price}円`

      orderForm.action = orderFormAction + "?promotion_id=" + data.promotion.id
    }else{
      this.readCodeTarget.textContent = ""
      this.discountTarget.textContent = ""
      this.totalPriceTarget.textContent = data.total_price
      this.errorMessageTarget.textContent = data.message

      orderForm.action = orderFormAction
    }
  }
}
