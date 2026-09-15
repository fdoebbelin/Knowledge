---
title: "Install Drupal CMS locally with DDEV"
source: "https://new.drupal.org/docs/drupal-cms/get-started/install-drupal-cms/install-drupal-cms-locally-with-ddev"
author:
  - "[[Drupal.org]]"
published:
created: 2025-04-08
description: "Let’s get started by creating a sandbox on your computer. Instead of jumping straight into building online, you’ll create a local space on your computer where you can experiment, make mistakes (it’s okay, we all do!), and discover how Drupal CMS works–no pressure! In this tutorial, we’ll walk through how to set up this space using DDEV, a tool that makes it possible to build out your site at your own pace. It will help you get your Drupal CMS workspace up and running without you needing to know all of the technical details."
tags:
  - "clippings"
---
Last modified: March 20, 2025 at 9:38pm

Let’s get started by creating a sandbox on your computer. Instead of jumping straight into building online, you’ll create a local space on your computer where you can experiment, make mistakes (it’s okay, we all do!), and discover how Drupal CMS works–no pressure!

In this tutorial, we’ll walk through how to set up this space using DDEV, a tool that makes it possible to build out your site at your own pace. It will help you get your Drupal CMS workspace up and running without you needing to know all of the technical details.

If you’re ready to move beyond evaluating Drupal CMS and want a solution that will allow you to start building a real site, keep reading.

Or, if you want to explore Drupal CMS in a browser, and are not worried about losing any of the work you do, go to [Try out Drupal CMS](https://new.drupal.org/drupal-cms/trial) and come back when you’re ready to start customizing your site.

### How to install Drupal CMS using DDEV

#### Step #1: Install DDEV

[DDEV](https://ddev.com/) is a tool we use to create a sandbox space on our computer for building web sites. Since Drupal CMS is a web-based tool, DDEV will make sure your  *computer* has everything it needs to run Drupal CMS – then you’ll have everything  *you* need to create your website.

The steps for installing DDEV depend on your computer’s operating system. [Follow the instructions in the DDEV documentation to install it](https://ddev.readthedocs.io/en/stable/).

Confirm that it is installed on your machine by running the command `**ddev --version**` in the Terminal.

#### Step #2: Download Drupal CMS

Drupal CMS can be downloaded using Composer, which is included with DDEV.

Open a Terminal window and navigate with `**cd**` to where you would like Drupal CMS to be downloaded. Then run the following commands (change  *my-drupal-site* to the directory name you prefer):

```js
mkdir my-drupal-site && cd my-drupal-site
ddev config --project-type=drupal11 --docroot=web
ddev start
ddev composer create drupal/cms
```

This will take care of downloading any necessary files and setting up the Drupal CMS environment.

#### Step #3: Install Drupal CMS in DDEV

To launch the Drupal CMS setup assistant run the following command from within the directory created in the previous step:

```js
ddev launch
```

This will open the Drupal CMS installer in your browser.

You can find the URL of your local Drupal CMS site at any time by running the command `ddev status` from the root directory of your project.

You’ve now installed Drupal locally on your computer. Yay! 🎉

#### Step #4: Start / Stop

When you’re done using your local Drupal CMS installation, run the command `ddev stop` to shut it down. DDEV will keep the application, and you can pick up where you left off.

Start DDEV and your Drupal CMS project again by using the command `ddev launc`.

### What’s next?

- [Set up Drupal CMS](https://new.drupal.org/docs/drupal-cms/get-started/install-drupal-cms/run-the-drupal-cms-installer)

### Wrap-up

In this tutorial, we walked through the steps required to get Drupal CMS running on your computer using DDEV. You’re now ready to [set up Drupal CMS](https://new.drupal.org/docs/drupal-cms/get-started/install-drupal-cms/run-the-drupal-cms-installer) and start customizing your new site.

### Additional resources

[Moving Around the Command Line](https://drupalize.me/tutorial/moving-around-command-line) (Drupalize.Me)