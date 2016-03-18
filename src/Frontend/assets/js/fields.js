jQuery(function() {
  /**
   * Gets the base URL including trailing slash
   * @return string
   */
  var getBaseURL = function() {
    return [
      location.protocol,
      '//',
      location.hostname,
      (location.port && ":" + location.port),
      '/'
    ].join('');
  };
  
  // Use $ as shorthand for jQuery
  var $ = jQuery;
  
  // Add an associated image thumbnail
  $.fn.addImage = function(url) {
    $(this).removeImage();
    $(this).closest('.upload_field').prepend('<img src="' + url + '" class="thumbnail" />');
    return $(this);
  };
  
  // Remove an associated image thumbnail
  $.fn.removeImage = function() {
    $(this).closest('.upload_field').find('.thumbnail').remove();
    return $(this);
  };
  
  // The recipient of our upload URLs
  // This lets us have multiple file uploads per post
  var $upload;

  var custom_media = true,
  orig_send_attachment = wp.media.editor.send.attachment;
  
  $('.upload').each(function(e) {
    var $self = $(this);
    $(this).parent().find('.browse').on('click', function() {
      var send_attachment_bkp = wp.media.editor.send.attachment;
      var button = $self;
      var id = button.attr('id').replace('_button', '');
      custom_media = true;
      wp.media.editor.send.attachment = function(props, attachment) {
        if(custom_media) {
          $('#'+id).val(attachment.url);
          if(attachment.url.match(/(jpg|jpeg|png|gif)$/)) {
            $self.addImage($('#'+id).val());
          } else {
            $self.removeImage();
          }
        } else {
          return orig_send_attachment.apply(this, [props, attachment]);
        }
      };
      wp.media.editor.open(button);
      return false;
    });
  });

  $('.add_media').on('click', function() {
    custom_media = false;
  });
  
  // Clear buttons
  $('.clear').click(function() {
    if(confirm('Are you sure you want to clear this field?')) {
      $(this).siblings('.upload').val('');
      $(this).removeImage();
    }
  });
  
  // Initial loading of thumbnail
  $('.upload').each(function() {
    if($(this).val().match(/(jpg|jpeg|png|gif)$/)) {
      $(this).addImage($(this).val());
    }
  });

  // Track paste event in case a URL is added
  $('.upload').on('paste', function() {
    var $field = $(this);
    
    // Use setTimeout so that the value can populate before you try grabbing it
    setTimeout(function() {
      $field.addImage($field.val());
    }, 100);
  });
  
  // On key up, check for images
  $('.upload').on('keyup', function() {
    if($(this).val().match(/(jpg|jpeg|png|gif)$/)) {
      $(this).addImage($(this).val());
    } else {
      $(this).removeImage();
    }
  });
  
  // WYSIWYG editors
  $('.wysiwyg').each(function() {
    $(this).addClass('mceEditor');
    if(typeof(tinyMCE) == 'object' && typeof( tinyMCE.execCommand ) == 'function') {
      tinyMCE.execCommand('mceAddControl', false, $(this).attr('id'));
    }
  });
});
