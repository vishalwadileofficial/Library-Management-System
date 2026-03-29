// Confirm delete action
function confirmDelete() {
    return confirm("Are you sure you want to delete this item?");
}

// Highlight active sidebar menu
document.addEventListener('DOMContentLoaded', function() {
    const currentPath = window.location.pathname;
    const links = document.querySelectorAll('.sidebar-menu li a');
    
    links.forEach(link => {
        if (link.href.includes(currentPath)) {
            link.classList.add('active');
        }
    });
});
