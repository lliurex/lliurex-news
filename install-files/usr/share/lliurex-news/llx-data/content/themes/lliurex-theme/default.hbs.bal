<!DOCTYPE html>
<html lang="{{@site.lang}}">
<head>

    {{!-- Document Settings --}}
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />

    {{!-- Base Meta --}}
    <title>{{meta_title}}</title>
    <meta name="HandheldFriendly" content="True" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    {{!-- Styles'n'Scripts --}}
    <link rel="stylesheet" type="text/css" href="{{asset "built/screen.css"}}" />

    {{!-- This tag outputs SEO meta+structured data and other important settings --}}
    {{ghost_head}}

</head>
<body class="{{body_class}}">

    <div class="site-wrapper">

        {{!-- All the main content gets inserted here, index.hbs, post.hbs, etc --}}
        {{{body}}}

        {{!-- The footer at the very bottom of the screen --}}
        <footer class="site-footer outer">
            <div class="site-footer-content inner">
                <section class="copyright"><a href="{{@site.url}}">{{@site.title}}</a> &copy; {{date format="YYYY"}}</section>
                <nav class="site-footer-nav">
		   <a href="{{@site.url}}">Latest Posts</a>
		   
                    {{!--
		    {{#if @site.facebook}}<a href="{{facebook_url @site.facebook}}" target="_blank" rel="noopener">Facebook</a>{{/if}}
                    {{#if @site.twitter}}<a href="{{twitter_url @site.twitter}}" target="_blank" rel="noopener">Twitter</a>{{/if}}
		    --}}
                    <!--
		    <a href="https://ghost.org" target="_blank" rel="noopener">Ghost</a>
                </nav>
		-->
            </div>
        </footer>

    </div>

    {{!-- The big email subscribe modal content --}}
    {{#if @labs.members}}
    <div class="subscribe-success-message">
        <a class="subscribe-close" href="javascript:;"></a>
        You've successfully subscribed to {{@site.title}}!
    </div>

    <div id="subscribe" class="subscribe-overlay">
        <a class="subscribe-close-overlay" href="#"></a>
        <a class="subscribe-close-button" href="#"></a>
        <div class="subscribe-overlay-content">
            {{#if @site.logo}}
                <img class="subscribe-overlay-logo" src="{{@site.logo}}" alt="{{@site.title}}" />
            {{/if}}
            <div class="subscribe-form">
                <h1 class="subscribe-overlay-title">Subscribe to {{@site.title}}</h1>
                <p class="subscribe-overlay-description">Stay up to date! Get all the latest & greatest posts delivered straight to your inbox</p>
                <form data-members-form="subscribe">
                    <div class="form-group">
                        <input class="subscribe-email" data-members-email placeholder="youremail@example.com"
                            autocomplete="false" />
                        <button class="button primary" type="submit">
                            <span class="button-content">Subscribe</span>
                            <span class="button-loader">{{> "icons/loader"}}</span>
                        </button>
                    </div>
                    <div class="message-success">
                        <strong>Great!</strong> Check your inbox and click the link to confirm your subscription.
                    </div>
                    <div class="message-error">
                        Please enter a valid email address!
                    </div>
                </form>
            </div>
        </div>
    </div>
    {{/if}}

    {{!-- jQuery, required for fitvids --}}
    <script
        src="https://code.jquery.com/jquery-3.4.1.min.js"
        integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
        crossorigin="anonymous">
    </script>
    {{!-- Fitvids (for responsive video embeds), infinite scroll, floating header, and gallery card support --}}
    <script src="{{asset "built/casper.js"}}"></script>

    {{!-- Scripts for Members subscription --}}
    <script>
        // Parse the URL parameter
        function getParameterByName(name, url) {
            if (!url) url = window.location.href;
            name = name.replace(/[\[\]]/g, "\\$&");
            var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
                results = regex.exec(url);
            if (!results) return null;
            if (!results[2]) return '';
            return decodeURIComponent(results[2].replace(/\+/g, " "));
        }

        // Give the parameter a variable name
        var action = getParameterByName('action');

        $(document).ready(function () {
            if (action == 'subscribe') {
                $('body').addClass("subscribe-success");
            }

            $('.subscribe-success-message .subscribe-close').click(function () {
                $('.subscribe-success-message').addClass('close');
            });

            // Reset form on opening subscrion overlay
            $('.subscribe-button').click(function() {
                $('.subscribe-overlay form').removeClass();
                $('.subscribe-email').val('');
            });
        });
    </script>

    {{!-- The #block helper will pull in data from the #contentFor other template files. In this case, there's some JavaScript which we only want to use in post.hbs, but it needs to be included down here, after jQuery has already loaded. --}}
    {{{block "scripts"}}}

    {{!-- Ghost outputs important scripts and data with this tag - it should always be the very last thing before the closing body tag --}}
    {{ghost_foot}}

</body>
</html>
