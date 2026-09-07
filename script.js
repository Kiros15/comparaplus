const toastEl = document.getElementById('toast');
let toastTimer;
function toast(message){
  toastEl.textContent = message;
  toastEl.classList.add('show');
  clearTimeout(toastTimer);
  toastTimer = setTimeout(()=>toastEl.classList.remove('show'),2600);
}

const category = document.getElementById('category');
document.querySelectorAll('[data-cat]').forEach(card=>{
  card.addEventListener('click',()=>{
    category.value = card.dataset.cat;
  });
});

document.getElementById('compareForm').addEventListener('submit',(e)=>{
  e.preventDefault();
  if(!category.value){toast('Selecciona una categoría para empezar.');return;}
  toast(`Comparador de ${category.value}: esta demo está lista para conectar ofertas reales.`);
});

const menuBtn = document.getElementById('menuBtn');
const mobileMenu = document.getElementById('mobileMenu');
menuBtn.addEventListener('click',()=>{
  const open = mobileMenu.classList.toggle('open');
  menuBtn.setAttribute('aria-expanded', String(open));
  menuBtn.textContent = open ? '×' : '☰';
});
document.querySelectorAll('.mobile-menu a').forEach(a=>a.addEventListener('click',()=>{
  mobileMenu.classList.remove('open');
  menuBtn.setAttribute('aria-expanded','false');
  menuBtn.textContent='☰';
}));
