$(function() {
  $('#suggest').autocomplete({
    source: function(req, resp){
      $.ajax({
        url: '/potepan/suggest',
        type: 'GET',
        data: { keyword: req.term, max_num: 5 },
        dataType: 'json',
        success: function(data){
          resp(data);
        },
        error: function(xhr, ts, err){
          resp(['']);
        },
      });
    },
    autoFocus: true
  });
});
