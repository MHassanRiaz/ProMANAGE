// Import dependencies at the top level
import '@hotwired/turbo-rails';
import 'controllers';
import 'bootstrap';
import $ from 'jquery';

// Ensure jQuery is available globally
window.$ = $; // Make jQuery available globally
window.jQuery = $; // For compatibility with plugins that expect jQuery to be globally available

// Use a single DOMContentLoaded event listener
document.addEventListener('DOMContentLoaded', () => {
    // Handle clickable rows
    const rows = document.querySelectorAll('.clickable-row');
    rows.forEach(row => {
        row.addEventListener('click', () => {
            window.location = row.getAttribute('data-href');
        });
    });

    // Handle tech stack input
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

        removeIcon.addEventListener('click', () => {
            container.removeChild(tag);
            techStack = techStack.filter(t => t !== text);
            updateHiddenField();
        });

        tag.appendChild(removeIcon);
        container.appendChild(tag);
    }

    input.addEventListener('keypress', (event) => {
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

    // Handle assigned users based on project selection
    const projectSelect = document.getElementById("project_select");
    if (projectSelect) {
        projectSelect.addEventListener("change", function() {
            const projectId = this.value;

            if (projectId) {
                fetch(`/projects/${projectId}/assigned_users`)
                    .then(response => response.json())
                    .then(data => {
                        const userSelect = document.getElementById("task_assigned_user_id");
                        userSelect.innerHTML = '<option value="">Select User</option>';

                        data.forEach(user => {
                            const option = document.createElement("option");
                            option.value = user.id;
                            option.text = user.name;
                            userSelect.appendChild(option);
                        });
                    });
            } else {
                document.getElementById("task_assigned_user_id").innerHTML = '<option value="">Select User</option>';
            }
        });
    }

    // Handle users based on project selection
    const taskProjectSelect = document.getElementById("task_project_id");
    const userSelect = document.getElementById("task_assigned_user_id");
    if (taskProjectSelect && userSelect) {
        taskProjectSelect.addEventListener("change", function() {
            const projectId = taskProjectSelect.value;
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
        });
    }
});
