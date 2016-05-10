jQuery(function() {

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

  var custom_media = true,
  orig_send_attachment = wp.media.editor.send.attachment;

  $(document).on('click', '.browse', function() {
    var $parent = $(this).parent().find('.upload');
    var send_attachment_bkp = wp.media.editor.send.attachment;
    var button = $parent;
    var id = button.attr('id');
    custom_media = true;
    wp.media.editor.send.attachment = function(props, attachment) {
      if(custom_media) {
        var host_name = document.location.hostname;
        var regex = new RegExp('https?://' + host_name);
        var attachment_url = attachment.url.replace(regex, '');

        $('#' + id).val(attachment_url);
        if(attachment_url.match(/(jpg|jpeg|png|gif)$/)) {
          $parent.addImage($('#' + id).val());
        } else {
          $parent.removeImage();
        }
      } else {
        return orig_send_attachment.apply(this, [props, attachment]);
      }
    };
    wp.media.editor.open(button);
    return false;
  });

  $(document).on('click', '.add_media', function() {
    custom_media = false;
  });

  // Clear buttons
  $(document).on('click', '.clear', function() {
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
  $(document).on('paste', '.upload', function() {
    var $field = $(this);

    // Use setTimeout so that the value can populate before you try grabbing it
    setTimeout(function() {
      $field.addImage($field.val());
    }, 100);
  });

  // On key up, check for images
  $(document).on('keyup', '.upload', function() {
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
