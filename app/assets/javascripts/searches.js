$(function() {
  $('#suggest').autocomplete({
    source: function(req, res){
      $.ajax({
        url: '/potepan/suggest',
        type: 'GET',
        data: { keyword: req.term, max_num: 5 },
        dataType: 'json',
        success: function(data){
          res(data);
        },
        error: function(xhr, ts, err){
          res(['']);
        },
      });
    },
    autoFocus: true
  });
});
