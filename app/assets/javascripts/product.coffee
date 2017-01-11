$(document).on 'turbolinks:load', ()->


#------------------------------------------------------------------
#---------------    Предпросмотр картинок,    ---------------------
# --------------   загружаемых в product.new  ---------------------
#------------------------------------------------------------------

  $('#product_images_').change (e)->
    $('#images').empty()
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


  #------------------------------------------------------------------
  #---------------  Скрыть/отобразить поля, -------------------------
  # -----------  специфические для типа 'bedclothe'   ---------------
  #------------------------------------------------------------------

  bedclothe_toggle_fields=()->
    if $('#look_product_type').val()=='bedclothe'
      $('#b_material').removeClass('hidden')
      $('#b_size').removeClass('hidden')
    else
      $('#b_material').addClass('hidden')
      $('#b_size').addClass('hidden')
  $(window).on('load', bedclothe_toggle_fields)
  $('#look_product_type').on('change', bedclothe_toggle_fields)


  #------------------------------------------------------------------
  #---------------  Сохраняем значение полей формы ------------------
  # --------------   при перезагрузке страницы     ------------------
  #----------------  не работает в Chrome          ------------------
  #------------------------------------------------------------------

  $(window).unload ()->
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

  #------------------------------------------------------------------
  #---------------  Подсвечиваем активную вкладку ------------------
  # --------------  главного меню, поскольку bootstrap --------------
  # --------------  фокус с  data-toggle = 'tab' не работает  -------
  #------------------------------------------------------------------
  data_toggle = (sel)->
    sel.click (event)->
      li = $(event.target).parent()
      li.siblings().removeClass('active')
      li.addClass('active')

  data_toggle($('#categories_block_top li a'))
  data_toggle($('#main_menu li a'))
#------------------------------------------------------------------
#---------------  Поиск вида товара по названию  ------------------
#------------------------------------------------------------------

  #----------------  get_kinds---------------------------

# tr, содержащие запрашиваемое имя
  get_kinds = (search_name)->
    found_names = "td.name_td:contains('"+search_name+"')"
    kind = $("#products-table tr.kind:has(#{found_names})")

    #----------------  find_look  ----------------------
#Обработчик кнопки поиска по названию
#Если найдено совпадение, скрываем все, затем показываем, то, что нужно
  find_look = ()->
    # Поисковый запрос
    search = $('#search').val()
    if !search
      show_all()
      return
    # capitalize
    kind = get_kinds(search[0].toUpperCase() + search[1..-1].toLowerCase())
    if kind.length == 0
      show_all()
      return
    # Все скроем
    $("#products-table tr:not(:first)").addClass('hidden')
    # высветим, что необходимо
    loop
      kind.removeClass('hidden')
      kind = kind.next()
      break if kind.hasClass('kind')


#-------------   input.change input.enter_key_pressed  ----------------
  $('input#search').on 'change',find_look

#-------------    button_search.click----------
  $('#btn_search').on 'click',find_look

#-------------    show_all   -------------------
  # при нажатии кнопки списка показать всю таблицу
  show_all = ()->
    $('#products-table tr').removeClass('hidden')


#---------------- button_list.click--------------
  $('#btn_list').click ->
    show_all()

#------------   Автокомплит поисковой строки   -------------
  look_names = $('tr.kind td.name_td').map -> $(this).text()
  $('input#search').autocomplete {
    source: look_names.toArray()
    select: (event,ui)->
      find_look()
      return false
  }
  return