<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>职位</title>
	<link rel="stylesheet" type="text/css" href="resources/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="resources/bootstrap/css/bootstrap-theme.min.css">
	
	<script type="text/javascript" src="resources/jquery/jquery-1.9.0.js"></script>
    <script type="text/javascript" src="resources/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="resources/jquery/jquery.form.js"></script>
    <script type="text/javascript" src="resources/jquery/jquery.atmosphere.js"></script>	
</head>
<body>

	<h4>ServerTime:${serverTime}</h4>
	
	<br>
	this is pass
	
	<div id='pubsub'>
	    <input id='topic' type='text'/>
	</div>
	<h2>Select transport to use for subscribing</h2>
	
	<h3>You can change the transport any time.</h3>
	
	<div id='select_transport'>
	    <select id="transport">
	        <option id="autodetect" value="websocket">autodetect</option>
	        <option id="long-polling" value="long-polling">long-polling</option>
	        <option id="streaming" value="streaming">http streaming</option>
	        <option id="websocket" value="websocket">websocket</option>
	    </select>
	    <input id='connect' class='button' type='submit' name='connect' value='Connect'/>
	</div>
	<br/>
	<br/>
	
	<h2 id="s_h" class='hidden'>Publish Topic</h2>
	
	<div id='sendMessage' class='hidden'>
	    <input id='phrase' type='text'/>
	    <input id='send_message' class='button' type='submit' name='Publish' value='Publish Message'/>
	</div>
	<br/>
	
</body>
	
	
	<script type="text/javascript">
	    $(document).ready(function() {
            var detectedTransport = null;
            var socket = $.atmosphere;
            var subSocket;
	
	        function getKeyCode(ev) {
	            if (window.event) return window.event.keyCode;
	            return ev.keyCode;
	        }
	
	        function getElementById() {
	            return document.getElementById(arguments[0]);
	        }
	
	        function getTransport(t) {
	            transport = t.options[t.selectedIndex].value;
	            if (transport == 'autodetect') {
	                transport = 'websocket';
	            }
	
	            return false;
	        }
	
	        function getElementByIdValue() {
	            detectedTransport = null;
	            return document.getElementById(arguments[0]).value;
	        }
	
            function subscribe() {
                var request = { url : document.location.toString() + getElementByIdValue('topic'),
                    transport: getElementByIdValue('transport')};

                request.onMessage = function (response) {
                    detectedTransport = response.transport;
                    if (response.status == 200) {
                        var data = response.responseBody;
                        if (data.length > 0) {
                            $('ul').prepend($('<li></li>').text(" Message Received: " + data + " but detected transport is " + detectedTransport));
                        }
                    }
                };

                subSocket = socket.subscribe(request);
            }

            function unsubscribe(){
                socket.unsubscribe();
            }
	
	        function connect() {
	            unsubscribe();
	            getElementById('phrase').value = '';
	            getElementById('sendMessage').className = '';
	            getElementById('phrase').focus();
	            subscribe();
	            getElementById('connect').value = "Switch transport";
	        }
	
	        getElementById('connect').onclick = function(event) {
	            if (getElementById('topic').value == '') {
	                alert("Please enter a PubSub topic to subscribe");
	                return;
	            }
	            connect();
	        }
	
	        getElementById('topic').onkeyup = function(event) {
	            getElementById('sendMessage').className = 'hidden';
	            var keyc = getKeyCode(event);
	            if (keyc == 13 || keyc == 10) {
	                connect();
	                return false;
	            }
	        }
	
	        getElementById('phrase').setAttribute('autocomplete', 'OFF');
	        getElementById('phrase').onkeyup = function(event) {
	            var keyc = getKeyCode(event);
	            if (keyc == 13 || keyc == 10) {
	
	                var m = " sent using " + detectedTransport;
	                if (detectedTransport == null) {
	                    detectedTransport = getElementByIdValue('transport');
	                    m = " sent trying to use " + detectedTransport;
	                }
	
                    subSocket.push({data: 'message=' + getElementByIdValue('phrase') + m});
	
	                getElementById('phrase').value = '';
	                return false;
	            }
	            return true;
	        };
	
	        getElementById('send_message').onclick = function(event) {
	            if (getElementById('topic').value == '') {
	                alert("Please enter a message to publish");
	                return;
	            }
	
	            var m = " sent using " + detectedTransport;
	            if (detectedTransport == null) {
	                detectedTransport = getElementByIdValue('transport');
	                m = " sent trying to use " + detectedTransport;
	            }
	
                subSocket.push({data: 'message=' + getElementByIdValue('phrase') + m});
	
	            getElementById('phrase').value = '';
	            return false;
	        };
	
	        getElementById('topic').focus();
	    });
	</script>
</html>


