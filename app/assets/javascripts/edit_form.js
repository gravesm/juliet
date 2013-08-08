$(function() {
    $('form').on('click', '.delete_alias', function(ev) {
        ev.preventDefault();
        $.ajax({
            url: $(this).attr("data-url"),
            data: {
                _method: "delete"
            },
            type: "POST",
            context: this
        }).done(function(data) {
            $(this).parents(".control-group").remove();
            $("#alias_message")
                .removeClass()
                .addClass("alert alert-success")
                .text("Alias \"" + data + "\" successfully deleted.")
            ;
        }).fail(function() {
            $("#alias_message")
                .removeClass()
                .addClass("alert alert-error")
                .text("Problem deleting alias.")
            ;
        });
    });

    $("#add_alias_button").on('click', function(ev) {
        ev.preventDefault();
        $.ajax({
            url: $(this).attr("data-url"),
            data: {
                entity_ref: {
                    refvalue: $("#add_alias").val()
                }
            },
            type: "POST",
            context: this
        }).done(function(data) {
            $("#add_alias").val("");
            $(".alias-input").append(JST['templates/alias_input']({
                refvalue: data.refvalue,
                url: data.url
            }));
            $("#add_dialog").modal("hide");
        }).fail(function() {
            $("#add_message")
                .removeClass()
                .addClass("alert alert-error")
                .text("Problem adding alias.")
            ;
        });
    });
});