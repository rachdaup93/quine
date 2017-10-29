source_code ={
  code:
%(source_code=;
require 'sinatra'
require 'sinatra/reloader'
require 'json'

get '/' do
  redirect to('/home')
end

get '/home' do
  erb :home
end

get '/code' do
  content_type :json
  source_code.to_json
end

template :home do
  <<-EOF
<html>
  <head>
    <meta http-equiv="content-type" content="text/html;charset=utf-8">
    <title>Quine</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/styles/railscasts.min.css">
  </head>

  <body>
    <nav class="navbar navbar-default"><h1 style="text-align:center;"><span class="glyphicon glyphicon-console"></span> Source Code Request</h1></nav>

    <div style="width:600px;margin:20px auto;">
    <h2>Instructions</h2>
    <ol>
      <li>Build a Sinatra app and deploy to Heroku.</li>
      <li><div>
        <p>The app should respond to the endpoints:</p>
        <p>/home</p>
        <p>/code</p>
      </div></li>
      <li><div>
        <p>To test the /code endpoint the following command should run:</p>
        <code>curl http://pure-mesa-42794.herokuapp.com/code</code>
        <p>…and receive the JSON response:{ "code": "the source code of the app" }</p>
      </div></li>
      <li>For the /home endpoint, http://your-app.herokuapp.com/home will be visited in a web browser to see:</li>
      <ul>
        <li>A home page with introductions</li>
        <li>A main section with a 3 second countdown</li>
        <li>At the end of the countdown, an AJAX get request to the /code endpoint is made, and the code is then displayed in the main section properly formatted with syntax highlighting</li>
      </ul>
    </ol>
    </div>
    <div style="width:80%; margin:0 auto;" class="panel panel-warning">
      <div class="panel-heading"><b>Source Code Loading</b></div>
      <div style="background-color:#232323" class="panel-body">
        <h2 style="text-align:center;color:white"></h2>
      </div>
    </div>

    <script src="https://code.jquery.com/jquery.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/highlight.min.js"></script>
    <script>
      hljs.initHighlightingOnLoad();
      let counter = 3;
      $(".panel-body h2").html(counter);
      const interval = setInterval(function() {
        counter--;
        $(".panel-body h2").html(counter);
        if (counter === 0) {
            $(".panel-body").html(`<pre style="background:none;border:none;"><code id="ruby-start" class="highlight hljs ruby"></code></pre>`);
            requestCode();
            clearInterval(interval);
        }}, 1000);

      function requestCode() {
         $.ajax({
              url: "/code",
              success: (source) => {
              $(".panel").removeClass("panel-warning").addClass("panel-success");
              $(".panel-heading").html("<b>Source Code Loaded Successfully<b>");
              tag = 'html';
              separators=[`<${tag}>`,`</${tag}>`]
              source = source.code.split(new RegExp(separators.join('|'), 'g'));
              rubyStart = source[0];
              html = source[1].replace(/</g, "&lt;").replace(/>/g, "&gt;");
              rubyEnd = source[2];
              
              $('#ruby-start').html(rubyStart);
              $(".panel-body pre").append(`<code id="html" class="highlight hljs html">&lt;html&gt;${html}&lt;html&gt;</code>`);
              $(".panel-body pre").append(`<code id="html" class="highlight hljs ruby">${rubyEnd}</code>`)
              $('.highlight').each((index, block)=> {
                hljs.highlightBlock(block);
                });
              }});
      }
    </script>
  </body>
</html>
EOF
end)
}

require 'sinatra'
require 'sinatra/reloader'
require 'json'

# Redirect root path to /home path
get '/' do
  redirect to('/home')
end

get '/home' do
  erb :home
end

get '/code' do
  content_type :json
  source_code.to_json
end

template :home do
  <<-EOF
<html>
  <head>
    <meta http-equiv="content-type" content="text/html;charset=utf-8">
    <title>Quine</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/styles/railscasts.min.css">
  </head>

  <body>
    <nav class="navbar navbar-default"><h1 style="text-align:center;"><span class="glyphicon glyphicon-console"></span> Source Code Request</h1></nav>

    <div style="width:600px;margin:20px auto;">
    <h2>Instructions</h2>
    <ol>
      <li>Build a Sinatra app and deploy to Heroku.</li>
      <li><div>
        <p>The app should respond to the endpoints:</p>
        <p>/home</p>
        <p>/code</p>
      </div></li>
      <li><div>
        <p>To test the /code endpoint the following command should run:</p>
        <code>curl http://pure-mesa-42794.herokuapp.com/code</code>
        <p>…and receive the JSON response:{ "code": "the source code of the app" }</p>
      </div></li>
      <li>For the /home endpoint, http://your-app.herokuapp.com/home will be visited in a web browser to see:</li>
      <ul>
        <li>A home page with introductions</li>
        <li>A main section with a 3 second countdown</li>
        <li>At the end of the countdown, an AJAX get request to the /code endpoint is made, and the code is then displayed in the main section properly formatted with syntax highlighting</li>
      </ul>
    </ol>
    </div>
    <div style="width:80%; margin:0 auto;" class="panel panel-warning">
      <div class="panel-heading"><b>Source Code Loading</b></div>
      <div style="background-color:#232323" class="panel-body">
        <h2 style="text-align:center;color:white"></h2>
      </div>
    </div>

    <script src="https://code.jquery.com/jquery.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/highlight.min.js"></script>
    <script>
      hljs.initHighlightingOnLoad();
      let counter = 3;
      $(".panel-body h2").html(counter);
      const interval = setInterval(function() {
        counter--;
        $(".panel-body h2").html(counter);
        if (counter === 0) {
            $(".panel-body").html(`<pre style="background:none;border:none;"><code id="ruby-start" class="highlight hljs ruby"></code></pre>`);
            requestCode();
            clearInterval(interval);
        }}, 1000);

      function requestCode() {
         $.ajax({
              url: "/code",
              success: (source) => {
              $(".panel").removeClass("panel-warning").addClass("panel-success");
              $(".panel-heading").html("<b>Source Code Loaded Successfully<b>");
              tag = 'html';
              separators=[`<${tag}>`,`</${tag}>`]
              source = source.code.split(new RegExp(separators.join('|'), 'g'));
              rubyStart = source[0];
              html = source[1].replace(/</g, "&lt;").replace(/>/g, "&gt;");
              rubyEnd = source[2];
              
              $('#ruby-start').html(rubyStart);
              $(".panel-body pre").append(`<code id="html" class="highlight hljs html">&lt;html&gt;${html}&lt;html&gt;</code>`);
              $(".panel-body pre").append(`<code id="html" class="highlight hljs ruby">${rubyEnd}</code>`)
              $('.highlight').each((index, block)=> {
                hljs.highlightBlock(block);
                });
              }});
      }
    </script>
  </body>
</html>
EOF
end