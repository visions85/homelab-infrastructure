# Resume

Professional LaTeX resume for David Mills showcasing DevOps and Infrastructure Engineering skills.

## Files
- `david-mills-resume.tex` - LaTeX source file
- `david-mills-resume.pdf` - Compiled PDF (generated)

## Compilation

### Using pdflatex
```bash
pdflatex david-mills-resume.tex
```

### Using Online Editors
Upload `david-mills-resume.tex` to:
- [Overleaf](https://www.overleaf.com/) (recommended)
- [Papeeria](https://papeeria.com/)

### Prerequisites (local compilation)
Install a LaTeX distribution:
- **macOS**: `brew install --cask mactex-no-gui`
- **Ubuntu/Debian**: `sudo apt-get install texlive-full`
- **Fedora**: `sudo dnf install texlive-scheme-full`

Required packages (usually included):
- fullpage
- titlesec
- enumitem
- hyperref
- fancyhdr
- fontawesome5
- xcolor

## Customization
Edit the `.tex` file to update:
- Contact information (lines 66-72)
- Professional summary (line 76)
- Technical skills (lines 80-92)
- Projects and experience
- Dates and details

## Output
Compilation produces:
- `david-mills-resume.pdf` - Final resume
- `david-mills-resume.aux`, `.log`, `.out` - Auxiliary files (can be deleted)

## Notes
- Resume is formatted for US Letter (8.5" × 11")
- Uses modern single-column layout
- Optimized for ATS (Applicant Tracking Systems)
- Clean, professional design with hyperlinks
