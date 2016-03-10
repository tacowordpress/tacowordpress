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
  
  // Each .upload field gets a button with a click event binding that launches the media modal
  $('input.upload').each(function() {
    var $input_upload = $(this);
    $(this).siblings('.browse').click(function() {
      // Make sure the modal inserts the URL into the correct field
      $upload = $input_upload;
      
      formfield = $upload.attr('name');
      tb_show('', 'media-upload.php?type=image&amp;TB_iframe=true');
      return false;
    });
  });

  // Method required by the modal that sends the URL back into the .upload field
  window.old_send_to_editor = window.send_to_editor;
  window.send_to_editor = function(element_html) {
    if(!$upload) {
      return window.old_send_to_editor(element_html);
    }

    // Update the URL
    var $element = $(element_html);
    var url = $element.attr('href');
    if(!url) {
      url = $element.attr('src');
    }
    url = url.replace(getBaseURL(), '/');
    $upload.val(url);
    
    // Append thumb
    if(url.match(/(jpeg|jpg|png|gif)$/)) {
      $upload.addImage(url);
    }
    
    // Close the modal
    tb_remove();
  };
  
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