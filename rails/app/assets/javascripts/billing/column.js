var admin = {

  init: function(){
    admin.set_admin_editable_events();
  },

  set_admin_editable_events: function(){
    $(".admin-editable").on("keypress", function(e){
      if ( e.keyCode==27 )
        $( e.currentTarget ).hide();

      if ( e.keyCode==13 ){
        var path        = $( e.currentTarget ).attr("data-path");
        var attr        = $( e.currentTarget ).attr("data-attr");
        var resource_id = $( e.currentTarget ).attr("data-resource-id");
        var val         = $( e.currentTarget ).val();

        val = $.trim(val)
        if (val.length==0)
          val = "&nbsp;";

        $("div#"+$( e.currentTarget ).attr("id")).html(val);
        $( e.currentTarget ).hide();

        var payload = { }
        payload[attr] = val;
        $.ajax({
          url: "/admins/"+path,
          type: 'POST',
          data: payload
        })
          .done(function(result){
            console.log(result);
          })
          .fail(function(result){
            console.log('fail');
          });
      }
    });

    $(".admin-editable").on("blur", function(e){
      $( e.currentTarget ).hide();
    });
  },

  editable_text_column_do: function(el){
    var input = "input#"+$(el).attr("id")

    $(input).width( $(el).width()+4 ).height( $(el).height()+4 );
    $(input).css({top: ( $(el).offset().top-2 ), left: ( $(el).offset().left-2 ), position:'absolute'});

    val = $.trim( $(el).html() );
    if (val=="&nbsp;")
      val = "";

    $(input).val( val );
    $(input).show();
    $(input).focus();
  }
}

$( document ).ready(function() {
  admin.init();
});

