# Album Tags Rails

### Overview
This is currently a work-in-progress repo as I try my hand at rebuilding my Album Tags app in Rails.

This has been a fun domain for me to work in and I have found it valuable to return every now and again and use it as a launching pad for new growth, whether in a new language, or simply to try out better coding and testing practices.

### What's new in V4?
From a user perspective, there are some noticeable differences in this version of Album Tags compared to versions past. To start with, the entire app is taking an HTML-first approach, using JavaScript as necessary for user interaction, but focusing mainly on the site as a set of documents. Next, rather than using O-auth through Google, this is the first version of the app that uses its own user authentication system. In terms of UI components, I am using the Bulma library this time around, which represents the third full face-lift the app has seen since V0. The modern, yet subtle look of Bulma components will compliment the new user-flows in a way that helps the app feel intuitive to use on mobile or desktop browsers.

From a technology perspective, I'm using Devise for authentication and Typescript for client-side interactivity. The big UI lift for the app historically has been the "list" page, and I am currently looking into building portions of this UI with React _(since the page functions like a mini PWA all on its own.)_ Finally, the whole project is being written in Rails 6 for a clean, intuitive development flow that helps me write well-tested code while pulling in a wide-ranging set of technologies to fill out the app experience.

### Timeline
I don't have an exact timeline for this project at the moment as [Album Tags V3](https://github.com/jhunschejones/Album-Tags-Phoenix) was built with a powerful feature-set and a nicely comprehensive test suite that have made it easy to maintain over the last year. Instead, my plan is work on this app in between other commitments and we'll see where it goes from there! So far it has been a great learning experience integrating new technologies into my familiar Rails app environment, and I'm looking forward to even more challenges before the app is ready to ship!
