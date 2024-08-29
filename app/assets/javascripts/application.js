//= require rails-ujs
//= require_tree .
//= require bootstrap-datetimepicker
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

// Assigned users call
document.addEventListener("DOMContentLoaded", function() {
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
                // Clear the assigned users dropdown if no project is selected
                document.getElementById("task_assigned_user_id").innerHTML = '<option value="">Select User</option>';
            }
        });
    }
});

// jQuery and Bootstrap integration
jQuery(document).ready(function($) {
    import $ from "jquery";
    window.$ = $; // Make jQuery available globally
    window.jQuery = $; // For compatibility with plugins that expect jQuery to be globally available
    import 'bootstrap';

    // Your code that uses $ (which is an alias for jQuery)
});
