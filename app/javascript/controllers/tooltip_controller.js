import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tooltip"
export default class extends Controller {
  connect() {
    console.log("connected...");
  }
  
  showTooltip(){
    console.log("connected... to method");
    window.addEventListener('DOMContentLoaded', ()=>{
      const btn = document.querySelector('#btn');
      const tooltip = document.querySelector('#tooltip');
      tooltip.innerHTML = btn.dataset.tooltipText;

      btn.addEventListener('mouseenter', ()=>{
        tooltip.classList.remove('hidden');
      })
      btn.addEventListener('mouseleave', ()=>{
        tooltip.classList.add('hidden');
      })
    })
  }
}
