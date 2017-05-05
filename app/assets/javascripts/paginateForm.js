window.onload = () => {
  if (window.location.href.match(/^.*\/books\/new$/)) {
    let fields = document.getElementsByClassName('formPage');
    for (let i = 0; i < fields.length; i++) {
      fields[i].style.display = 'none';
    }

    let i = 0;
    fields[i].style.display = 'block';
    let current = document.getElementById('currentField');
    let next = document.getElementById('nextField');
    let prev = document.getElementById('prevField');

    next.onclick = () => {
      current.innerText = parseInt(current.innerText) + 1;
      fields[i].style.display = 'none';
      fields[i + 1].style.display = 'block';
      if (i === fields.length - 2) {
        next.style.display = 'none';
      } else if (i === 0) {
        prev.style.display = 'block';
      }
      i++;
    };

    prev.onclick = () => {
      current.innerText = parseInt(current.innerText) - 1;
      fields[i].style.display = 'none';
      fields[i - 1].style.display = 'block';
      if (i === 1) {
        prev.style.display = 'none';
      } else if (i === fields.length - 1) {
        next.style.display = 'block';
      }
      i--;
    };
  }
};
