# Merge

`Merge` is a simple **Bash** script that recursively merges all files in a specified directory (including nested subdirectories) into a single output. Each file's content is prefixed by its relative path, making it easy to identify the source of each section. This is especially useful when you need to combine multiple text files—logs, configuration snippets, notes—into one document to feed into Chat-based AI models or for archiving and review.

## Features

- **Recursive merging**: Walks through all subfolders and merges every regular file.
- **Relative path headers**: Inserts headers like `=== subdir/example.txt ===` before each file's content.
- **Output to file**: Write merged content to a file (`merged.txt` by default or a custom filename).
- **Clipboard-only mode**: Use `-c` to copy the merged result directly to your macOS clipboard without creating any file—perfect for quick pasting into chat AI or other editors.
- **Portable**: Written in pure Bash with no external dependencies (aside from `pbcopy` on macOS for clipboard mode).
- **Homebrew-installable**: Easily install via Homebrew for global availability.

## Installation

### 1. Homebrew (macOS / Linux)

```bash
# Tap the repository
brew tap dhivatiradika/merge https://github.com/dhivatiradika/merge.git

# Install the merge command
brew install merge
```

After installation, you can run `merge` from any location in your terminal.

### 2. Local Install

```bash
# Clone this repo
git clone https://github.com/dhivatiradika/merge.git
cd merge

# Make it executable
chmod +x merge.sh

# (Optional) Move to a directory in your PATH
mv merge.sh ~/bin/merge
```

## Usage

```bash
# Merge into default 'merged.txt'
merge /path/to/folder

# Merge into custom output file
overlay_merge /path/to/folder combined.txt

# Copy only (no file) to macOS clipboard
merge -c /path/to/folder

# Show help
merge -h
```

## Why `Merge`?

When working with Chat AI (e.g., ChatGPT, Claude, etc.), it’s often helpful to provide multiple context files—logs, code snippets, configuration files—in a single prompt. Manually concatenating these can be error-prone and tedious. `merge` automates that process:

1. **Consolidate** your files into one clean, structured document.  
2. **Feed** the merged output directly into your AI chat as context.  
3. **Iterate** quickly—update your source files, rerun `merge`, and paste updated content into your AI of choice.

## License

This project is licensed under the [MIT License](LICENSE).
