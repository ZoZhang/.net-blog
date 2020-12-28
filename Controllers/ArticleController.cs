using System;
using System.Collections.Generic;
using System.Data.Entity.Validation;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PagedList;
using Blog.Models;

namespace Blog.Controllers
{
    public class ArticleController : Controller
    {
        BlogEntities dbContext = new BlogEntities();
        // GET: Article
        public ActionResult Index(int page = 1)
        {
            if (Session["email"] == null)
            {
                Response.Redirect("~/Admin/Login");
            }
            int pageSize = 8;
            ViewBag.user = Session["email"];
            ViewBag.isAdmin = Session["isAdmin"];
            ViewBag.Title = "Page d'administration - Article";
            ViewBag.Page ="article";

            if (ViewBag.isAdmin)
            {
                var result = (from a in dbContext.article
                              orderby a.create_at descending
                              select a).ToList<article>();
                return View(result.ToPagedList<article>(page, pageSize));
            }
            else
            {
                string user = Session["email"].ToString();
                var result = (from a in dbContext.article
                              where a.users.email == user
                              orderby a.create_at descending
                              select a).ToList<article>();
                return View(result.ToPagedList<article>(page, pageSize));
            }
        }

        public ActionResult addArticle()
        {
            if (Session["email"] == null)
            {
                Response.Redirect("~/Admin/Login");
            }
            ViewBag.user = Session["email"];
            ViewBag.isAdmin = Session["isAdmin"];
            ViewBag.Title = "Page d'article";
            ViewBag.Page ="article";
            var result = (from c in dbContext.category
                          select c).ToList<category>();
            ViewBag.author = Session["email"].ToString();
            return View(result);
        }

        [HttpPost]
        [ValidateInput(false)]
        public JsonResult ProcessAdd(string title, int catid, string author, string content)
        {
            article myarticle = new article();
            myarticle.title = title;
            myarticle.category_id = catid;
            myarticle.content = content;
            myarticle.create_at = DateTime.Now;
            var result = from a in dbContext.users
                         where a.email == author
                         select a;
            foreach (var a in result)
            {
                myarticle.user_id = a.id;
            }
            dbContext.article.Add(myarticle);
            if (dbContext.SaveChanges() != 0)
            {
                return Json(new { status = 1, data = "Ajouté avec succès" });
            }
            else
            {
                return Json(new { status = 0, data = "Échec d'ajouté" });
            }

        }

        public ActionResult UpdateArticle(int id)
        {
            if (Session["email"] == null)
            {
                Response.Redirect("~/Admin/Login");
            }

            article myarticle = dbContext.article.Find(id);
            ViewBag.id = myarticle.id;
            ViewBag.atitle = myarticle.title;
            ViewBag.author = myarticle.users.email;
            ViewBag.title = myarticle.category.title;
            ViewBag.content = myarticle.content;
            var result = (from c in dbContext.category
                          select c).ToList<category>();
            return View(result);
        }

        [HttpPost]
        [ValidateInput(false)]
        public JsonResult ProcessUpdate(int id, string title, int catid, string author, string content)
        {
            article myarticle = dbContext.article.Find(id);
            myarticle.title = title;
            myarticle.category_id = catid;
            myarticle.content = content;
            myarticle.create_at = DateTime.Now;
            if (dbContext.SaveChanges() != 0)
            {
                return Json(new { status = 1, data = "Modifié avec succès" });
            }
            else
            {
                return Json(new { status = 0, data = "Échec de modifier" });
            }
        }

        public void ProcessDelete(int id)
        {
            article myarticle = dbContext.article.Find(id);
            dbContext.article.Remove(myarticle);
            dbContext.SaveChanges();
        }

        public void ManyDelete(string idStr)
        {
            string str = idStr.Substring(0, idStr.LastIndexOf(","));
            string[] idTemp = str.Split(',');
            article myarticle;
            foreach (string s in idTemp)
            {
                myarticle = dbContext.article.Find(int.Parse(s));
                dbContext.article.Remove(myarticle);

            }
            dbContext.SaveChanges();
        }

        public ViewResult Detail(int id)
        {
            article myarticle = dbContext.article.Find(id);
            ViewBag.sid = myarticle.id;
            ViewBag.stitle = myarticle.title;
            ViewBag.author = myarticle.users.email;
            ViewBag.date = myarticle.create_at;
            ViewBag.aid = myarticle.category.id;
            ViewBag.atitle = myarticle.category.title;
            ViewBag.content = HttpUtility.HtmlDecode(myarticle.content);
            var result = (from c in dbContext.comments
                          where c.article_id == id && c.is_show == true
                          select c).ToList<comments>();

            return View(result);
        }

    }
}
