# Shayari

A personal poetry collection website built with Pelican, designed to be hosted on GitHub Pages.

## Setup

1. Install requirements:
```bash
pip install -r requirements.txt
```

## Development

Run local development server:
```bash
make devserver PORT=8000
```

Visit http://localhost:8000 to view the site.

Stop the server:
```bash
make stopserver
```

## Publishing to GitHub Pages

1. Update your GitHub username in `publishconf.py`:
```python
SITEURL = 'https://your-github-username.github.io/shayari'
```

2. Generate production-ready files:
```bash
make publish
```

3. Deploy to GitHub Pages manually:
```bash
make github
```

4. Alternatively, push to the main branch and let GitHub Actions deploy automatically.

## Customization

### Adding Poetry Cards

Create new markdown files in the `content/shayari/` directory following this format:

```markdown
Title: Your Poetry Title
Date: YYYY-MM-DD HH:MM
Category: Category Name
Tags: tag1, tag2, tag3
Slug: url-friendly-title
Summary: A brief summary of your poetry.
Featured_image: images/your-image.jpg

---

Your poetry content here...

**Original Script:**
Original language script here...

**English Translation:**
English translation here...
```

### Adding Images

Place images in the `content/images/` directory and reference them in your poetry cards.

### Customizing Theme

Edit files in the `themes/shayari-theme/` directory to customize the appearance.
