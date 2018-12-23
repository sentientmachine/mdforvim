var head = document.getElementsByTagName('head')[0];
//Consider saying only update if the file has changed so we don't hammer the internet.
var RELOAD_TIME = 1000;
var previous = null;
var current = null;
window.setInterval(function(){
    reload();
    console.log("check");
    window.status = 'ready_to_print';
},RELOAD_TIME);

function reload() {
    var script = document.createElement('script');
    script.type = 'text/javascript';
    script.src = 'settext.js';
    script.charset = 'UTF-8';
    head.appendChild(script);
}

reload() 
