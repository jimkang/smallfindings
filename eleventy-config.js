var pluginRss = require('@11ty/eleventy-plugin-rss');
var fs = require('fs');

module.exports = function(eleventyConfig) {
  // This makes `make serve` serve the site at localhost:8080/smallfindings
  eleventyConfig.setBrowserSyncConfig({
    server: '.'
  });
  eleventyConfig.addPassthroughCopy('media/*');
  eleventyConfig.addPassthroughCopy('app.css');
  eleventyConfig.addPassthroughCopy('episodes/**/*.mp3');

  eleventyConfig.addCollection('episodes', function(collection) {
    var filteredCollection = collection
      .getFilteredByGlob(['episodes/*.njk'])
      .sort(compareDatesDesc);
    console.log('filteredCollection', filteredCollection);
    return filteredCollection;
  });
  eleventyConfig.addPlugin(pluginRss);
  eleventyConfig.addFilter('length', getFileLength);
};

function compareDatesDesc(a, b) {
  return b.data.stuff.date - a.data.stuff.date;
}

function getFileLength(filePath) {
  var stats = fs.statSync(filePath);
  return stats.size;
}

// TODO: Duration filter via music-metadata.
