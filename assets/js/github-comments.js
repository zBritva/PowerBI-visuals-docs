function loadComments(comments) {

    const items = comments.map(function (item) {
        const posted_at = (new Date(item.updated_at)).toLocaleString();
        return `
        <div class="js-timeline-item js-timeline-progressive-focus-container">
            <div class="timeline-comment-wrapper js-comment-container">
                <div class="avatar-parent-child timeline-comment-avatar">
                    <a class="d-inline-block" data-octo-click="hovercard-link-click" aria-describedby="hovercard-aria-description">
                        <img class="avatar rounded-1" height="44" width="44" alt="@${item.user.login}" src="${item.user.avatar_url}"></a>

                </div>

                <div class="timeline-comment-group js-minimizable-comment-group">
    
                    <div class="unminimized-comment editable-comment comment previewable-edit js-comment js-task-list-container timeline-comment reorderable-task-lists current-user">
   
                        <div class="timeline-comment-header clearfix">
                            <h3 class="timeline-comment-header-text f5 text-normal">
                                <strong class="css-truncate">
                                    <a class="author text-inherit css-truncate-target" data-octo-click="hovercard-link-click" data-octo-dimensions="link_type:self" href="${item.user.html_url}" aria-describedby="hovercard-aria-description">${item.user.login}</a>
                                  </strong>

                                commented
                                <a href="${item.html_url}" class="timestamp"><relative-time datetime="${item.updated_at}" title="${posted_at}">${posted_at}</relative-time></a>
                            </h3>
                        </div>


                    <div class="edit-comment-hide">
                    
                        <task-lists sortable="">
                            <table class="d-block">
                                <tbody class="d-block">
                                    <tr class="d-block">
                                        <td class="d-block comment-body markdown-body js-comment-body">
                                        ${item.body_html}
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </task-lists>
                    </div>
            </div>

        </div>
    `
    });

    let placeholder = document.getElementById("gh-comments-list");
    if (placeholder) {
        placeholder.innerHTML = items.join();
    }
}


function initGithubComments() {
    const ghComments = document.getElementById("gh-comments");

    if (!ghComments) {
        return false;
    }
    const repo_name = ghComments.getAttribute("data-repository");
    const comment_id = ghComments.getAttribute("data-issue-id");

    if (!repo_name || !comment_id) {
        return false;
    }

    const page_id = 1;

    const url = `https://api.github.com/repos/${repo_name}/issues/${comment_id}/comments?page=${page_id}`;

    fetch(url, {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/vnd.github.v3.html+json'
        }
    }).then(res => res.json())
        .then(response => loadComments(response))
        .catch(error => console.error('Error:', error));

}

initGithubComments();