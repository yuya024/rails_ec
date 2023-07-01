document.addEventListener("turbo:load", function () {
  let select = document.querySelector("select#country_id");
  select.addEventListener("change", function () {
    let country_id = this.value;
    
    fetch(this.dataset.url, {
      method: this.dataset.turboMethod,
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").getAttribute("content")
      },
      body: JSON.stringify({ country_id: country_id }),
    })
    .then(response => {
      if (!response.ok) {
        throw new Error('データの取得に失敗しました');
      }
      return response.json();
    })
    .then(data => {
      let city_select = document.querySelector("select#city_id"); 
      city_select.innerHTML = "";
      let option = document.createElement("option");
      option.value = "";
      option.text = "選択してください";
      city_select.appendChild(option);
      data.cities.forEach(city => {
        let option = document.createElement("option");
        option.value = city.id;
        option.text = city.name;
        city_select.appendChild(option);
      });
    });
  });
});
