let Blog = {};
;(function($) {
  $(function () {

    Blog = {

        addLayer: function(title, url) {
          layer.open({
            type: 2,
            title: title,
            maxmin: true,
            shadeClose: true,
            area: ['550px', '470px'],
            content: url
          });
       },

       updateLayer: function(id, title, url) {
          layer.open({
            type: 2,
            title: title,
            maxmin: true,
            shadeClose: true,
            area: ['550px', '470px'],
            content: url + id
          });
         },

        manyRequestDel: function (url) {
         let idStr = '';

         $(".singleChoose").each(function () {
            if ($(this)[0].checked) {
              idStr += $(this).val() + ',';
            }
         });

         if (!idStr) {
            Blog.alertMsg("Vous devez chsoissir au moins un élément !", 1);
            return ;
         }

         layer.confirm('Etes-vous sûr que vous voulez supprimer ?', function (index) {
            $.get(url, { idStr: idStr }, function(){
              layer.msg('supprimé avec succès !', { icon: 1, time: 800 });
              window.location.reload();
            });
         });
      },

      RequestDel: function (id, obj, url) {
        layer.confirm('Etes-vous sûr que vous voulez supprimer ?', function (index) {
            $.get(url, { id: id }, function(){
              $(obj).parents("tr").remove();
              layer.msg('supprimé avec succès !', { icon: 1, time: 1000 });
            });
         });
      },

      RequestUpdateStatus: function (id, status, url) {
        let idStr = '';

        if (id) {
          idStr = id + ',';
        }

        if (!idStr) {
          $(".singleChoose").each(function () {
            if ($(this)[0].checked) {
              idStr += $(this).val() + ',';
            }
          });

          if (!idStr) {
            Blog.alertMsg("Vous devez chsoissir au moins un élément !", 1);
            return ;
          }
        }

        layer.confirm('Etes-vous sûr que vous voulez changer ?', function (index) {
          $.post(url, { idStr: idStr, isShow: status}, function(){
            layer.msg('changer avec succès !', { icon: 1, time: 1000 });
            window.location.reload();
          });
        });
      },

      RequestAjax: function(form, callback) {
        const url = form.attr('action');
        const data = form.serialize();

        $.ajax({
          type: "post",
          url: url,
          data: data,
          dataType: "json",
          success: callback
        });
      },

      alertMsg: function(msg, err) {
        const message = $("#alert-message");
        message.text(msg);

        if (err) {
          message.addClass('alert-danger').removeClass('d-none');
        } else {
          message.removeClass('alert-danger').addClass('alert-success').removeClass('d-none');
        }
      }

    };

    $('.allChoose').on('change', function () {
      if ($(this).is(':checked')) {
        $('.singleChoose').prop('checked', 'checked');
      } else {
        $('.singleChoose').prop('checked', '');
      }
    })

      // Floating label headings for the contact form
    $("body").on("input propertychange", ".floating-label-form-group", function(e) {
      $(this).toggleClass("floating-label-form-group-with-value", !!$(e.target).val());
    }).on("focus", ".floating-label-form-group", function() {
      $(this).addClass("floating-label-form-group-with-focus");
    }).on("blur", ".floating-label-form-group", function() {
      $(this).removeClass("floating-label-form-group-with-focus");
    });

    // Show the navbar when the page is scrolled up
    var MQL = 992;

    //primary navigation slide-in effect
    if ($(window).width() > MQL) {
      var headerHeight = $('#mainNav').height();
      $(window).on('scroll', {
          previousTop: 0
        },
        function() {
          var currentTop = $(window).scrollTop();
          //check if user is scrolling up
          if (currentTop < this.previousTop) {
            //if scrolling up...
            if (currentTop > 0 && $('#mainNav').hasClass('is-fixed')) {
              // $('#mainNav').addClass('is-visible');
            } else {
              $('#mainNav').removeClass('is-fixed');
            }
          } else if (currentTop > this.previousTop) {
            //if scrolling down...
            //$('#mainNav').removeClass('is-visible');
            if (currentTop > headerHeight && !$('#mainNav').hasClass('is-fixed')) $('#mainNav').addClass('is-fixed');
          }
          this.previousTop = currentTop;
        });
    }

    $("#form-login").submit(function () {

      const email = $('#email').val();
      const password = $('#password').val();

      if (!email || !password) {
        Blog.alertMsg("Vous devez entrer votre adresse email ou mot de passe !", 1);
        return false;
      }

      const formulaire = $("#form-login").serialize();
      $.ajax({
        type: "post",
        url: "CkeckLogin",
        data: formulaire,
        dataType: "json",
        success: function (msg) {

          if (!msg.status) {
              Blog.alertMsg("Vous devez entrer votre adresse email ou mot de passe !", 1);
              return;
          }

          Blog.alertMsg(msg.data);

          let redirect = 'Index';
          if (!msg.is_admin) {
            redirect = '/Category/Index';
          }

          window.setTimeout(function(){
            window.location.href = redirect;
          }, 500);
        }
      });

      return false;
    });

    $("#form-category-update").submit(function () {
      const catName = $('#cateName').val();

      if (!catName) {
        return false;
      }

      const url = $(this).attr('action');
      const data = $(this).serialize();

      $.ajax({
        type: "post",
        url: url,
        data: data,
        dataType: "json",
        success: function (msg) {
          if (msg.status== 1) {
            window.parent.location.reload();
            var index = parent.layer.getFrameIndex(window.name);
            parent.layer.close(index);
          } else {
            Blog.alertMsg(msg.data, 1);
          }
        }
      });
      return false;
    });

    $("#form-article-update").submit(function () {
      const title = $('#title').val();
      const catid = $('#catid').val();
      const editor = $('#article-textarea').val();

      if (!title || !catid || !editor) {
        return false;
      }

      const url = $(this).attr('action');
      const data = $(this).serialize();

      $.ajax({
        type: "post",
        url: url,
        data: data,
        dataType: "json",
        success: function (msg) {
          if (msg.status== 1) {
            Blog.alertMsg(msg.data);
            window.location.href = '/Article';
          } else {
            Blog.alertMsg(msg.data, 1);
          }
        }
      });
      return false;
    });

    $("#form-user-update").submit(function () {
      const email = $('#email').val();
      const pwd = $('#pwd').val();
      const pwdd = $('#pwdd').val();

      if (!email || !pwd || !pwdd) {
        Blog.alertMsg("Vous devez saissir l'information correcte !", 1);
        return false;
      }

      if (pwd  != pwdd) {
        Blog.alertMsg("Votre mot de passe est différent !", 1);
        return false;
      }

      Blog.RequestAjax($(this), function (msg) {
        if (msg.status== 1) {
          window.parent.location.reload();
          var index = parent.layer.getFrameIndex(window.name);
          parent.layer.close(index);
        } else {
          Blog.alertMsg(msg.data, 1);
        }
      });

      return false;
    });

    $("#form-user-pwd-update").submit(function () {
      const email = $('#email').val();
      const pwd = $('#pwd').val();
      const pwdd = $('#pwdd').val();

      if (!email || !pwd || !pwdd) {
        Blog.alertMsg("Vous devez saissir l'information correcte !", 1);
        return false;
      }

      if (pwd  != pwdd) {
        Blog.alertMsg("Votre mot de passe est différent !", 1);
        return false;
      }

      Blog.RequestAjax($(this), function (msg) {
        if (msg.status== 1) {
          window.location.href = "Login";
        } else {
          Blog.alertMsg(msg.data, 1);
        }
      });

      return false;
    });

    $("#articleCommentsAdd").submit(function () {
      const username = $('#username').val();
      const email = $('#email').val();
      const comment = $('#comment').val();

      if (!username || !email || !comment) {
        Blog.alertMsg("Vous devez saissir l'information correcte !", 1);
        return false;
      }

      const form = $(this);
      Blog.RequestAjax(form, function (msg) {
        if (msg.status== 1) {
          Blog.alertMsg(msg.data);
          form[0].reset();
        } else {
          Blog.alertMsg(msg.data, 1);
        }
      });

      return false;
    });

    const articleTextarea = $('#article-textarea');

    if (articleTextarea.length) {
      Simditor.locale = 'fr-FR';

      const editor = new Simditor({
        textarea: articleTextarea,
        placeholder: 'Entrez le texte ici...',
        toolbar: ['title', 'bold', 'italic', 'underline', 'strikethrough', 'fontScale', 'color', '|', 'ol', 'ul', 'blockquote', 'code', 'table', '|', 'link', 'image', 'hr', '|', 'indent', 'outdent', 'alignment'],
        pasteImage: true,
        upload: location.search === '?upload' ? {
          url: '/upload'
        } : false
      });
    }

  });
})(jQuery); // End of use strict
