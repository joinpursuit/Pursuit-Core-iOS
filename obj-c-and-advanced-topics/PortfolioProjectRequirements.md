# Portfolio Project Requirements

## Introduction

In order to stand out in the application process, it is important to have a strong portfolio that highlights iOS applications that you have built.  Hiring managers and recruiters may look at your projects to gauge your understanding of iOS development, then use that information to reach out for initial interviews.  Additionally, a frequent step in the hiring process is discussing projects that you have worked on previously.  Having projects close at hand will help you with that style of interview.

A good portfolio project should:

1. Have a strong README
1. Make use of core iOS technologies and frameworks
1. Include testing
1. Be on a path towards deployment in the App Store

## 1. README

Adding clear and thorough documentation to your projects is very important both for yourself and for others. It is important for yourself so that when you revisit your code in the future, you have ways to remember the purpose, tooling, and development history of what you made. Documentation is also important for others because without it, no one will use or contribute to your code. From [A beginner’s guide to writing documentation](http://www.writethedocs.org/guide/writing/beginners-guide-to-docs/):

> If people don’t know why your project exists,
they won’t use it.
> If people can’t figure out how to install your code,
they won’t use it.  
> If people can’t figure out how to use your code,
they won’t use it.  

In short, writing good documentation is a way for developers to transfer the *why* behind the code that they create. Code without documentation is not useful.

### Adding Documentation to a Repo
The first step to adding documentation to a project is to a create a `readme.md` file (sometimes capitalized as `README.md`) to the **root directory** of your project's repository. By using this naming convention, code hosting platforms such as GitHub will automatically detect this file, render it into HTML, and display it when users navigate to your repository.

This is especially important for portfolio projects! Anyone who visits your project repository should be able to read about the project, whether they are technical or not.

### Documentation Content
You want to provide your readers with all of the information that they need to know, but no more. Unlike some other forms of writing, documentation should be clear, concise, and to the point. Additionally, it should be written in a way to appeal both to normal users (who don't know or care how the code works) and developers (who may want to evaluate or contribute to your code).

Generally, a good `readme` will contain (or link to) *at least* the following sections:
- **Description**
  - What your project is / should be used for
  - What problem(s) your projects solves
- **Brief Example**
  - This could be a code snippet showing how your project should be used (if it is meant to be integrated into another app)
  - This could be a screenshot of your project running in the browser (if it is a stand-alone application)
- **List of Features**
  - This typically will be a short list of the features that you planned during the development phase of the project
  - To provide more detail, you can show how you categorized these features. List the features that make up the MVP, Silver, and Gold Levels (or whatever structure you designed) and indicate which features you completed / have yet to complete.
- **List of Technologies Used**
  - Often you will want to list the technologies you used to create the project.
  - This typically would consist of all primary languages, frameworks, and libraries your app is composed of
  - This is particularly important when it comes to recruiters scanning your projects for keywords
- **Installation Instructions / Getting Started**
  - This section should walk a reader, step by step, through the process of setting up your project
  - For a tool meant to be integrated into other projects, this would likely outline the process of installing and accessing this tool in your project, and some code examples.
  - For an application, this would likely outline the process of forking, cloning, and starting the app locally
- **Contribution Guidelines**
  - This section should offer guidance on where and how users can contribute to your code, identify bugs, and propose improvements

### Markdown

The `.md` extension on your `readme.md` stands for [Markdown](https://en.wikipedia.org/wiki/Markdown), which is a light-weight markup language that can be easily rendered into HTML (or other formats). However, its syntax is much simpler and faster to write than HTML, making it a good choice for writing up documentation.

Markdown is used widely across the internet for documentation.

If you've never written any (or much) markdown, take 15 minutes to complete this [Markdown Tutorial](http://www.markdowntutorial.com/)


### Markdown Cheatsheet

See the [Markdown Cheatsheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) for quick and easy reference!

### Examples

[Here is a great resource](https://github.com/matiassingers/awesome-readme) for examples of good readmes. It has various kinds of projects, as well as links on how to make gifs for your readme and links to guides on writing good readmes.

## 2. Technologies

Any portfolio project should make use of technologies relevant to getting a job as an iOS developer.  While projects that make use of other frameworks are also valuable, you should first ensure that you have strong iOS projects.  An ideal project should have the following components:

- Get data from an external API
- Parse JSON into a model
- Display information in a Table View / Collection View
- Tap on a cell to segue to a View Controller that displays more information
- Persist data locally with UserDefaults / FileManager / Core Data


## 3. Testing

A strong portfolio project should make use of testing to some degree.  All companies use testing in their codebase, and having a project with testing helps give you an edge in the application process.  Your project should at least include unit testing for serializing your model from JSON data.  Additionally, try to add additional unit tests for functions you write and consider adding [UI Testing](https://www.raywenderlich.com/960290-ios-unit-testing-and-ui-testing-tutorial#toc-anchor-014). 

## 4. App Store Deployment

At least one project in your portfolio should be available for download in the App Store.  This will help make your application stand out and enables non-technical people to download and use your application.  For other projects that you make, you should have a plan for how it could make it to the App Store.  This means that you should avoid projects that wouldn't be accepted (e.g Don't make an app that streams non-public domain movies from the Bundle.)
