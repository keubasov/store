$(document).on 'turbolinks:load', ()->
#Предпросмотр картинок, загружаемых в product.new
  $('#product_image').change (e)->
    for file in this.files
      img = $('<img/>').attr({alt: file.name, class: '.col-sm-1', height: '34'})
      img.file = file
      $('#images').append(img)
      reader = new FileReader()
      reader.onload = ((aImg) ->
        (event) ->
          aImg.attr('src', event.target.result)
          return
      )(img)
      reader.readAsDataURL(file);
    return

#Скрыть/отобразить поля, специфические для типа 'bedclothe'
  bedclothe_toggle_fields=()->
    if $('#product_product_type').val()=='bedclothe'
      $('#b_material').removeClass('hidden')
      $('#b_size').removeClass('hidden')
    else
      $('#b_material').addClass('hidden')
      $('#b_size').addClass('hidden')
  $(window).on('load', bedclothe_toggle_fields)
  $('#product_product_type').on('change', bedclothe_toggle_fields)

#Сохраняем значение полей формы при перезагрузке страницы
  $(window).beforeunload ()->
    target_fields = $('form input, select :visible').not("[type='submit']")
    for tf in target_fields
      sessionStorage.setItem(tf.id, tf.val())

  $(window).load ()->
    target_fields = $('form input, select').not("[type='submit']")
    for tf in target_fields
      val = sessionStorage.getItem tf.id
      if val
        tf.val(val)
    sessionStorage.clear()
  return



