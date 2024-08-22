//= require rails-ujs
//= require_tree .
// app/javascripts/packs/application.js or another JavaScript file

document.addEventListener('DOMContentLoaded', () => {
    const rows = document.querySelectorAll('.clickable-row');
    rows.forEach(row => {
        row.addEventListener('click', () => {
            window.location = row.getAttribute('data-href');
        });
    });
});

document.addEventListener('DOMContentLoaded', function() {
    const input = document.getElementById('tech-stack-input');
    const container = document.getElementById('tech-stack-container');
    const hiddenField = document.getElementById('technology_stack_hidden');

    let techStack = hiddenField.value ? hiddenField.value.split(',') : [];

    function updateHiddenField() {
        hiddenField.value = techStack.join(',');
    }

    function createTag(text) {
        const tag = document.createElement('span');
        tag.className = 'badge bg-secondary me-2 mb-2';
        tag.textContent = text;

        const removeIcon = document.createElement('span');
        removeIcon.className = 'ms-2 text-danger cursor-pointer';
        removeIcon.textContent = '×';
        removeIcon.style.cursor = 'pointer';

        removeIcon.addEventListener('click', function() {
            container.removeChild(tag);
            techStack = techStack.filter(t => t !== text);
            updateHiddenField();
        });

        tag.appendChild(removeIcon);
        container.appendChild(tag);
    }

    input.addEventListener('keypress', function(event) {
        if (event.key === 'Enter') {
            event.preventDefault();
            const text = input.value.trim();
            if (text && !techStack.includes(text)) {
                techStack.push(text);
                createTag(text);
                updateHiddenField();
                input.value = '';
            }
        }
    });

    // Initialize tags from hidden field value
    techStack.forEach(tag => createTag(tag));
});
