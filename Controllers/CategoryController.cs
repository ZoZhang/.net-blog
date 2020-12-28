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
    public class CategoryController : Controller
    {
        BlogEntities dbContext = new BlogEntities();

        public ActionResult Index(int page = 1)
        {
            if (Session["email"] == null)
            {
                Response.Redirect("/Admin/Login");
            }
            var result = (from c in dbContext.category
                          select c).ToList<category>();
            int pageSize = 8;
            ViewBag.user = Session["email"];
            ViewBag.isAdmin = Session["isAdmin"];
            ViewBag.Title = "Page d'administration - Catégorie";
            ViewBag.Page ="category";
            return View(result.ToPagedList<category>(page, pageSize));
        }

        public ActionResult AddCate()
        {
            return View();
        }

        public JsonResult ProcessAdd(string cateName, bool isMenu)
        {
            category mycategory = new category();
            var result = from c in dbContext.category
                         where c.title == cateName
                         select c;
            if (result.Count() > 0) return Json(new { status = 0, data = "Cette catégorie existe déjà, veuillez la réintégrer!" });
            else
            {
                mycategory.title = cateName;
                mycategory.is_menu = isMenu;
                dbContext.category.Add(mycategory);
                if (dbContext.SaveChanges() != 0)
                    return Json(new { status = 1, data = "Ajouté avec succès" });
                else return Json(new { status = 0, data = "Rien de changement" });
            }
        }

        public ActionResult UpdateCate(int id)
        {
            category mycategory = dbContext.category.Find(id);
            ViewBag.id = mycategory.id;
            ViewBag.title = mycategory.title;
            ViewBag.is_menu = mycategory.is_menu;
            return View();
        }

        public JsonResult ProcessUpdate(int cateId, string cateName, bool isMenu)
        {
            var result = from c in dbContext.category
                         where c.title == cateName
                         select c;
            if (result.Count() <= 0) return Json(new { status = 0, data = "Cette catégorie n'existe pas, veuillez la réintégrer!" });
            else
            {
                category mycategory = dbContext.category.Find(cateId);
                mycategory.title = cateName;
                mycategory.is_menu = isMenu;
                if (dbContext.SaveChanges() != 0)
                    return Json(new { status = 1, data = "Modifié avec succès" });
                else return Json(new { status = 0, data = "Échec de modifier" });
            }
        }

        public void ProcessDelete(int id)
        {
            category mycategory = dbContext.category.Find(id);
            var result = from a in dbContext.article
                         where a.category_id == id
                         select a;
            if (result.Count() > 0)
            {
                foreach (var a in result)
                    a.category_id = 1;
            }
            dbContext.category.Remove(mycategory);
            dbContext.SaveChanges();
        }

        public void ManyDelete(string idStr)
        {
            string str = idStr.Substring(0, idStr.LastIndexOf(","));
            string[] idTemp = str.Split(',');
            category mycategory;
            foreach (string s in idTemp)
            {
                Response.Write(int.Parse(s));
                mycategory = dbContext.category.Find(int.Parse(s));
                dbContext.category.Remove(mycategory);
            }
            dbContext.SaveChanges();
        }

    }
}
