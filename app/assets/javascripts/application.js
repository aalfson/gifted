// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .

jQuery(function() {
	
	$("#sampleEmailButton").bind("click", function(e) {
		$.ajax({
				type: 'POST', 
				url: '/sample',
				success: function() {
					$("#mainContainer").prepend('<div class="alert fade in alert-success"><button class="close" data-dismiss="alert">×</button>Sample email sent successfully.</div>');
				},
				error: function(data) {
					$("#mainContainer").prepend('<div class="alert fade in "alert alert-error"><button class="close" data-dismiss="alert">×</button>There was a problem sending your email. Do you have any Svpply wants that are for sale on Zappos?</div>');
					console.log(data);
				}
			});
	}); 
	
}); 