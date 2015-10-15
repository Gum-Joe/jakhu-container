var requestify = require('requestify');

requestify.post('http://example.com', {
    hello: 'world'
})
.then(function(response) {
    // Get the response body (JSON parsed or jQuery object for XMLs)
    response.getBody();
});
