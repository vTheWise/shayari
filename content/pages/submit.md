Title: Submit Poetry
Date: 2024-08-01
Slug: submit

<div class="submit-poetry-container">
    <h2>Submit Your Poetry</h2>
    <p class="lead">Share your beautiful words with the world. Fill out the form below to submit your poetry.</p>

    <form id="poetry-submission-form" class="needs-validation" novalidate>
        <div class="row g-3">
            <div class="col-md-6">
                <label for="poetry-title" class="form-label">Title</label>
                <input type="text" class="form-control" id="poetry-title" required>
                <div class="invalid-feedback">
                    Please provide a title for your poetry.
                </div>
            </div>
            
            <div class="col-md-6">
                <label for="poetry-language" class="form-label">Primary Language</label>
                <select class="form-select" id="poetry-language" required>
                    <option value="" selected disabled>Choose...</option>
                    <option value="Hindi">Hindi</option>
                    <option value="Urdu">Urdu</option>
                    <option value="English">English</option>
                    <option value="Punjabi">Punjabi</option>
                    <option value="Other">Other</option>
                </select>
                <div class="invalid-feedback">
                    Please select a language.
                </div>
            </div>
            
            <div class="col-12">
                <label for="poetry-tags" class="form-label">Tags (comma separated)</label>
                <input type="text" class="form-control" id="poetry-tags" placeholder="e.g., love, nature, reflection" required>
                <div class="invalid-feedback">
                    Please provide at least one tag.
                </div>
            </div>
            
            <div class="col-12">
                <label for="poetry-summary" class="form-label">Summary</label>
                <input type="text" class="form-control" id="poetry-summary" placeholder="A brief description of your poetry" required>
                <div class="invalid-feedback">
                    Please provide a summary.
                </div>
            </div>
            
            <div class="col-12">
                <label for="poetry-content" class="form-label">Poetry Content</label>
                <textarea class="form-control" id="poetry-content" rows="6" required></textarea>
                <div class="invalid-feedback">
                    Please enter your poetry.
                </div>
                <small class="form-text text-muted">You can use Markdown formatting.</small>
            </div>
            
            <div class="col-12">
                <label for="poetry-original" class="form-label">Original Script (optional)</label>
                <textarea class="form-control" id="poetry-original" rows="4"></textarea>
                <small class="form-text text-muted">If your poetry is in a language other than English, you can provide the original script here.</small>
            </div>
            
            <div class="col-12">
                <label for="poetry-translation" class="form-label">English Translation (optional)</label>
                <textarea class="form-control" id="poetry-translation" rows="4"></textarea>
                <small class="form-text text-muted">If your poetry is not in English, you can provide an English translation here.</small>
            </div>
            
            <div class="col-12">
                <label for="author-name" class="form-label">Your Name</label>
                <input type="text" class="form-control" id="author-name" required>
                <div class="invalid-feedback">
                    Please provide your name.
                </div>
            </div>
            
            <div class="col-12">
                <label for="author-email" class="form-label">Your Email</label>
                <input type="email" class="form-control" id="author-email" required>
                <div class="invalid-feedback">
                    Please provide a valid email address.
                </div>
                <small class="form-text text-muted">Your email will not be published.</small>
            </div>
            
            <div class="col-12 mt-4">
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="terms-checkbox" required>
                    <label class="form-check-label" for="terms-checkbox">
                        I agree that my submission may be published on this website.
                    </label>
                    <div class="invalid-feedback">
                        You must agree before submitting.
                    </div>
                </div>
            </div>
            
            <div class="col-12 mt-4">
                <button class="btn btn-primary" type="submit">Submit Poetry</button>
                <button class="btn btn-outline-secondary" type="button" id="preview-button">Preview</button>
            </div>
        </div>
    </form>
    
    <div class="mt-5 d-none" id="preview-container">
        <h3>Preview</h3>
        <div class="card">
            <div class="card-body" id="preview-content">
            </div>
        </div>
    </div>
    
    <div class="mt-5 d-none" id="submission-result">
        <div class="alert alert-success">
            <h4>Thank you for your submission!</h4>
            <p>Your poetry has been submitted successfully. We will review it and publish it soon.</p>
            <p>In the meantime, you can <a href="#" id="download-markdown">download your poetry as a Markdown file</a> to save it or submit it via GitHub.</p>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Form validation
    const form = document.getElementById('poetry-submission-form');
    const previewButton = document.getElementById('preview-button');
    const previewContainer = document.getElementById('preview-container');
    const previewContent = document.getElementById('preview-content');
    const submissionResult = document.getElementById('submission-result');
    const downloadLink = document.getElementById('download-markdown');
    
    // Preview functionality
    previewButton.addEventListener('click', function() {
        const title = document.getElementById('poetry-title').value;
        const content = document.getElementById('poetry-content').value;
        const original = document.getElementById('poetry-original').value;
        const translation = document.getElementById('poetry-translation').value;
        
        let previewHtml = `<h4>${title}</h4>`;
        previewHtml += `<div class="poetry-content">${content.replace(/\n/g, '<br>')}</div>`;
        
        if (original) {
            previewHtml += `<div class="mt-3"><strong>Original Script:</strong><br>${original.replace(/\n/g, '<br>')}</div>`;
        }
        
        if (translation) {
            previewHtml += `<div class="mt-3"><strong>English Translation:</strong><br>${translation.replace(/\n/g, '<br>')}</div>`;
        }
        
        previewContent.innerHTML = previewHtml;
        previewContainer.classList.remove('d-none');
    });
    
    // Form submission
    form.addEventListener('submit', function(event) {
        event.preventDefault();
        
        if (!form.checkValidity()) {
            event.stopPropagation();
            form.classList.add('was-validated');
            return;
        }
        
        // Generate markdown content
        const title = document.getElementById('poetry-title').value;
        const language = document.getElementById('poetry-language').value;
        const tags = document.getElementById('poetry-tags').value;
        const summary = document.getElementById('poetry-summary').value;
        const content = document.getElementById('poetry-content').value;
        const original = document.getElementById('poetry-original').value;
        const translation = document.getElementById('poetry-translation').value;
        const authorName = document.getElementById('author-name').value;
        
        // Create slug from title
        const slug = title.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/(^-|-$)/g, '');
        
        // Get current date
        const now = new Date();
        const dateStr = now.toISOString().split('T')[0];
        
        // Create markdown content
        let markdown = `Title: ${title}\n`;
        markdown += `Date: ${dateStr}\n`;
        markdown += `Category: ${language}\n`;
        markdown += `Tags: ${tags}\n`;
        markdown += `Slug: ${slug}\n`;
        markdown += `Summary: ${summary}\n\n`;
        markdown += `---\n\n`;
        markdown += `${content}\n\n`;
        
        if (original) {
            markdown += `**Original Script:**\n${original}\n\n`;
        }
        
        if (translation) {
            markdown += `**English Translation:**\n${translation}\n\n`;
        }
        
        markdown += `---\n\n`;
        markdown += `*Submitted by: ${authorName}*`;
        
        // Create download link
        const blob = new Blob([markdown], { type: 'text/markdown' });
        const url = URL.createObjectURL(blob);
        downloadLink.href = url;
        downloadLink.download = `${slug}.md`;
        
        // Show submission result
        form.classList.add('d-none');
        submissionResult.classList.remove('d-none');
        previewContainer.classList.add('d-none');
        
        // In a real application, you would send this data to a server
        console.log('Markdown content:', markdown);
    });
});
</script>
