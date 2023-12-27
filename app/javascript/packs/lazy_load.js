// app/javascript/packs/lazy_load.js

document.addEventListener('DOMContentLoaded', () => {
    const loadButton = document.getElementById('load-button');
    const lazyLoadedContent = document.getElementById('lazy-loaded-content');
  
    loadButton.addEventListener('click', () => {
      // 商品一覧の内容を非同期で取得し、lazyLoadedContentに追加する
      fetch('/products/lazy_load')
        .then(response => response.text())
        .then(data => {
          lazyLoadedContent.innerHTML = data;
        });
    });
  });
  