const fs = require('fs');
const Handlebars = require("handlebars");

const templateContent = fs.readFileSync('./index.hbs', 'utf8');
const templateFunc = Handlebars.compile(templateContent);

const templateDataStr = fs.readFileSync('./emojiList.json', 'utf8');
const templateData = JSON.parse(templateDataStr);
const compiledTemplate = templateFunc(templateData);
fs.writeFile('./index.html', compiledTemplate, ['utf8'], () => { });