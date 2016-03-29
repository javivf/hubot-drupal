# hubot-drupal

Drupal.org URL handler

See [`src/hubot-drupal.coffee`](src/hubot-drupal.coffee) for full documentation.

## Installation

In hubot project repo, run:

`npm install hubot-drupal --save`

Then add **hubot-drupal** to your `external-scripts.json`:

```json
[
  "hubot-drupal"
]
```

## Sample Interaction

```
user1>> dm views
hubot>> [Views] - https://www.drupal.org/project/views ...

user1>> https://www.drupal.org/node/2645010
hubot>> [Coding Standards] - Switch to PSR-2 as of Drupal 9 [Closed (won't fix)]
```
