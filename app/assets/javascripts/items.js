$(function() {
    $('select#currency_id').val(Cookies.get("currency_id"));
    $('select#currency_id').change(function () {
      let selectedCurrencyId = $(this).val();
      Cookies.set("currency_id", selectedCurrencyId);
      location.reload();
    });
});