import "@hotwired/turbo-rails";
import "controllers";
import 'bootstrap';
import $ from 'jquery';

//= require rails-ujs
//= require_tree .
//= require bootstrap-datetimepicker
//= require_tree .

// Clickable rows logic
window.$ = $;
window.jQuery = $;
document.addEventListener('DOMContentLoaded', () => {

    const rows = document.querySelectorAll('.clickable-row');
    rows.forEach(row => {
        row.addEventListener('click', () => {
            window.location = row.getAttribute('data-href');
        });
    });

    // Technology Stack input logic
    const input = document.getElementById('tech-stack-input');
    const container = document.getElementById('tech-stack-container');
    const hiddenField = document.getElementById('technology_stack_hidden');

    if (input && container && hiddenField) {
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
    }

    // Project and User selection logic
    const projectSelects = [
        document.getElementById("project_select"),
        document.getElementById("task_project_id")
    ];

    function fetchAndPopulateUsers(projectId, userSelect) {
        if (projectId) {
            fetch(`/projects/${projectId}/users`)
                .then(response => {
                    if (!response.ok) {
                        throw new Error("Network response was not ok");
                    }
                    return response.json();
                })
                .then(users => {
                    userSelect.innerHTML = '<option value="">Select User</option>';
                    users.forEach(user => {
                        const option = document.createElement("option");
                        option.value = user.id;
                        option.textContent = user.name;
                        userSelect.appendChild(option);
                    });
                    userSelect.disabled = false;
                })
                .catch(error => {
                    console.error("Error fetching users:", error);
                });
        } else {
            userSelect.innerHTML = '<option value="">Select User</option>';
            userSelect.disabled = true;
        }
    }

    projectSelects.forEach(projectSelect => {
        if (projectSelect) {
            projectSelect.addEventListener("change", function() {
                const userSelect = document.getElementById("task_assigned_user_id");
                fetchAndPopulateUsers(this.value, userSelect);
            });
        }
    });
});
