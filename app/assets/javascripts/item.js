function Item(attributes) {
    this.description = attributes.description;
    this.id = attributes.id;
}

Item.formSubmitListener = function() {
    $('form#new_item').on("submit", Item.formSubmit);
}

Item.ready = function() {
    Item.templateSource = $("#item-template").html();
    Item.template = Handlebars.compile(Item.templateSource);
    Item.formSubmitListener();
}

Item.success = function(json) {
    var item = new Item(json)
    var itemLi = item.renderLI();
    $('ul.todo-list').append(itemLi)
}

Item.formSubmit = function(e) {
    e.preventDefault();
    const $form = $(e.target);
    const action = $form.attr("action");
    const params = $form.serialize();
    $form.find('input.new-todo').val('')
    $.ajax({
        method: "POST",
        url: action,
        data: params,
        dataType: "json"
    })
    .success(Item.success)
    .error(Item.error)
}

// Item.template()
Item.prototype.renderLI = function() {
    return Item.template(this);
}

$(function() {
    Item.ready();
});

