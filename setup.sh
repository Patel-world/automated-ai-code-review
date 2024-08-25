#!/bin/bash

# Define variables
APP_NAME="my-react-app"
GITHUB_WORKFLOWS_DIR=".github/workflows"
WORKFLOW_FILE="ai-code-review.yml"

# Create React app with TypeScript
npx create-react-app $APP_NAME --template typescript

# Navigate into the app directory
cd $APP_NAME

# Install Tailwind CSS and other dependencies
npm install tailwindcss postcss autoprefixer

# Initialize Tailwind CSS
npx tailwindcss init

# Create PostCSS config
cat <<EOT > postcss.config.js
module.exports = {
  plugins: [
    'postcss-import',
    'tailwindcss',
    'autoprefixer',
  ],
}
EOT

# Configure Tailwind CSS
cat <<EOT > tailwind.config.js
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./src/**/*.{js,jsx,ts,tsx}",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
EOT

# Add Tailwind CSS to index.css
cat <<EOT > src/index.css
@tailwind base;
@tailwind components;
@tailwind utilities;
EOT

# Create the blog page component
mkdir -p src/components
cat <<EOT > src/components/BlogPage.tsx
import React from 'react';

const BlogPage: React.FC = () => {
  return (
    <div className="p-6 max-w-3xl mx-auto">
      <h1 className="text-3xl font-bold mb-4">
        Pull Request Review and AI Code Reviewer: Enhancing Code Quality with AI
      </h1>
      <p className="mb-4">
        Pull request reviews are a crucial process that allows us to improve code quality through collaboration with our team members and make use of automation tools within a pipeline to optimize our time efficiently. With advancements in artificial intelligence, I thought, "Why not leverage AI for something as important as pull request reviews in software development teams?" After a bit of research, I came across a solution: AI Code Reviewer.
      </p>
      <h2 className="text-2xl font-semibold mb-2">
        AI Code Reviewer: What Is It?
      </h2>
      <p className="mb-4">
        AI Code Reviewer is an innovative tool that utilizes OpenAI's GPT-4 technology integrated with GitHub Actions to perform automatic code reviews for pull requests. This tool is designed to simplify the software development process by providing developers with intelligent feedback on potential issues and opportunities for improvement in their code. AI Code Reviewer analyzes pull requests in real time, offering detailed suggestions for code changes and customizable comments. Additionally, it allows for the exclusion of specific files and patterns, focusing only on the critical areas. This tool is ideal for teams looking to enhance code quality and efficiently manage development processes.
      </p>
      <h2 className="text-2xl font-semibold mb-2">
        Why Use AI Code Reviewer?
      </h2>
      <p className="mb-4">
        I am aware that tools like SonarQube already exist for analyzing code quality, checking rules, and patterns. However, AI Code Reviewer offers a different approach by using OpenAI's GPT-4 technology to provide more dynamic and context-aware automatic reviews on pull requests.
      </p>
      <p className="mb-4">
        While SonarQube identifies general code quality and security vulnerabilities through static code analysis, AI Code Reviewer offers customizable and interactive feedback by reviewing code changes in real-time and integrates with GitHub. Thus, it can be said that both tools serve different needs in the software development process and complement each other.
      </p>
      <h2 className="text-2xl font-semibold mb-2">
        How to Set Up AI Code Reviewer
      </h2>
      <ol className="list-decimal list-inside mb-4">
        <li>
          <strong>Obtain an OpenAI API Key:</strong> To use AI Code Reviewer with GitHub Actions, you first need to obtain an OpenAI API key.
        </li>
        <li>
          <strong>Store OpenAI API Key in GitHub Secrets:</strong> Save the OpenAI API key as a GitHub Secret with the name <code>OPENAI_API_KEY</code>.
        </li>
        <li>
          <strong>Create a Workflow File:</strong>
          <ol className="list-disc list-inside mb-4">
            <li>Create a folder named <code>.github</code> in your repository.</li>
            <li>Within the <code>.github</code> folder, create another folder named <code>workflows</code>.</li>
            <li>Inside the <code>workflows</code> folder, create a file with the format <code>[name].yml</code> and paste the following content:</li>
          </ol>
          <pre className="bg-gray-100 p-4 rounded mb-4">
            <code>
              {`name: AI Code Reviewer

on:
  pull_request:
    types:
      - opened
      - synchronize
permissions: write-all
jobs:
  review:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Repo
        uses: actions/checkout@v3

      - name: AI Code Reviewer
        uses: your-username/ai-codereviewer@main
        with:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          OPENAI_API_KEY: ${{ secrets.OPENAI_API_KEY }}
          OPENAI_API_MODEL: "gpt-4" # Optional: defaults to "gpt-4"
          exclude: "**/*.json, **/*.md" # Optional: exclude patterns separated by commas`}
            </code>
          </pre>
          <p>Note: If you don’t know how to add a secret named <code>GITHUB_TOKEN</code>, click here for more information.</p>
        </li>
        <li>
          <strong>Customize the Exclude Feature:</strong> Customize the exclude option to specify files you don't want to be reviewed.
        </li>
        <li>
          <strong>Commit Your Changes:</strong> Once you've committed your changes, AI Code Reviewer will be up and running on your next pull request.
        </li>
      </ol>
      <h2 className="text-2xl font-semibold mb-2">
        Examples and Benefits
      </h2>
      <p className="mb-4">
        With this tool, we will receive AI support before our team members, making the job of the reviewer easier.
      </p>
      <p className="mb-4">
        Wishing everyone productive work!
      </p>
    </div>
  );
};

export default BlogPage;
EOT

# Create the main App component
cat <<EOT > src/App.tsx
import React from 'react';
import BlogPage from './components/BlogPage';
import './index.css'; // Make sure Tailwind CSS is imported

const App: React.FC = () => {
  return (
    <div className="App">
      <BlogPage />
    </div>
  );
};

export default App;
EOT

# Create GitHub Actions workflow
mkdir -p $GITHUB_WORKFLOWS_DIR
cat <<EOT > $GITHUB_WORKFLOWS_DIR/$WORKFLOW_FILE
name: AI Code Reviewer

on:
  pull_request:
    types:
      - opened
      - synchronize
permissions: write-all
jobs:
  review:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Repo
        uses: actions/checkout@v3

      - name: AI Code Reviewer
        uses: your-username/ai-codereviewer@main
        with:
          GITHUB_TOKEN: \$\{ secrets.GITHUB_TOKEN \}
          OPENAI_API_KEY: \$\{ secrets.OPENAI_API_KEY \}
          OPENAI_API_MODEL: "gpt-4" # Optional: defaults to "gpt-4"
          exclude: "**/*.json, **/*.md" # Optional: exclude patterns separated by commas
EOT

# Install ESLint and Prettier
npm install --save-dev eslint @typescript-eslint/eslint-plugin @typescript-eslint/parser eslint-config-airbnb eslint-plugin-import eslint-plugin-jsx-a11y eslint-plugin-react eslint-plugin-react-hooks prettier eslint-config-prettier

# Create ESLint config
cat <<EOT > .eslintrc.json
{
  "extends": [
    "react-app",
    "react-app/jest",
    "airbnb",
    "prettier"
  ]
}
EOT

# Create Prettier config
cat <<EOT > .prettierrc
{
  "singleQuote": true,
  "trailingComma": "es5",
  "printWidth": 80,
  "tabWidth": 2
}
EOT

# Inform the user
echo "Setup completed! You can now run 'npm install' and 'npm start' to see your application."
