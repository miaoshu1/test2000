jQuery.fn.extend({
    initForm(url) {
        $.ajax({
            url,
            /*success: function(data) {
                this.find(":input[name]").val(function () {
                    return data[this.name];
                });
            }.bind(this)*/ // 手动绑定函数内部的this

            // 箭头函数：内部不与this绑定
            success: data => {
                this.find(":input[name]").val(function () {
                    return data[this.name];
                });
            }
        });
        return this; // 可以保证链式操作正常进行
    }
});