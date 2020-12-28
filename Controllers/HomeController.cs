using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PagedList;
using Blog.Models;

namespace Blog.Controllers
{
    public class HomeController : Controller
    {
        BlogEntities dbContext = new BlogEntities();

        public ActionResult Index(int page = 1)
        {
            int pageSize = 6;
            ViewBag.Title = "Page d'accueil";
            ViewBag.PageClass = "homepage";
            var result = (from a in dbContext.article 
                          orderby a.create_at descending
                          select a).ToList<article>();
            return View(result.ToPagedList<article>(page, pageSize));
        }

        [HttpGet]
        public ActionResult CategoryDetail(int id, int page=1)
        {
            int pageSize = 6;
            category myCategory = dbContext.category.Find(id);
            ViewBag.Title = "Page catégorie";
            ViewBag.PageClass = "homepage";
            ViewBag.CategoryTitle = myCategory.title;
            var articleResult = (from a in dbContext.article
                                 where a.category_id==id
                                 orderby a.create_at descending
                                 select a).ToList<article>();

            return View("Index", articleResult.ToPagedList<article>(page, pageSize));
        }

        public PartialViewResult ShowCategoryMenus()
        {
            var result = (from c in dbContext.category where c.is_menu==true select c).ToList<category>();
            return PartialView(result);
        }
    }
}
