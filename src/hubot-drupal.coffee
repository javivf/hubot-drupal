# Description:
#   Display issue/page information from drupal.org
#
# Dependencies:
#   "cheerio": ""
#
# Configuration:
#   NONE
#
# Commands:
#   hubot drupal.org url - Show details about a drupal.org page or issue
#   hubot dm module name - Find module info from name
#
# Notes:
#
# Author:
#   mikebell

module.exports = (robot) ->
  robot.hear /https?:\/\/(www\.)?drupal.org\/node\/(\w+)(\smore)?/i, (msg) ->
    url = msg.match[0].replace(/\smore/, "")
    msg
      .http(url)
      .get() (err, res, body) ->
        console.log(msg.match[0])
        if err
          res.send "Encountered an error :( #{err}"
          return

        $ = require("cheerio").load(body)
        title = $('#page-subtitle').text()
        projectname = $('.field-name-field-project .field-item').text()
        issuestatus = $('.field-name-field-issue-status .field-item').text()

        msg.send '[' + projectname + '] - ' + title + ' [' + issuestatus + ']'

        if msg.match[3] is " more"
          priority = $('.field-name-field-issue-priority .field-item').text()
          created = $('.field-name-project-issue-created .field-item').text()
          updated = $('.field-name-project-issue-updated .field-item').text()
          category = $('.field-name-field-issue-category .field-item').text()
          msg.send 'Category: ' + category
          msg.send 'Priority: ' + priority
          msg.send 'Created: ' + created
          msg.send 'Updated: ' + updated

  robot.hear /dm (\w*)/i, (msg) ->
    msg
      .http('https://www.drupal.org/project/' + msg.match[1])
      .get() (err, res, body) ->
        if err
          res.send "Encountered an error :( #{err}"
          return
        $ = require("cheerio").load(body)
        title = $('#page-subtitle').text()
        url = 'https://www.drupal.org/project/' + msg.match[1]
        description = $('.field-name-body .field-item p').first().text()

        msg.send '[' + title + '] - ' + url
        msg.send description
