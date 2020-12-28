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
    public class CommentsController : Controller
    {
        BlogEntities dbContext = new BlogEntities();

        public ActionResult Index(int page = 1)
        {
            if (Session["email"] == null || Session["isAdmin"] == null)
            {
                Response.Redirect("~/Admin/Login");
            }

            int pageSize = 8;
            ViewBag.user = Session["email"];
            ViewBag.isAdmin = Session["isAdmin"];
            ViewBag.Title = "Page d'administration - Article";
            ViewBag.Page = "comments";

            var result = (from a in dbContext.comments
                          orderby a.create_at descending
                          select a).ToList<comments>();
            return View(result.ToPagedList<comments>(page, pageSize));
        }

        [HttpPost]
        [ValidateInput(false)]
        public JsonResult ProcessAdd(int article_id, string username, string email, string comment)
        {
            comments newcomments = new comments();
            newcomments.username = username;
            newcomments.article_id = article_id;
            newcomments.email = email;
            newcomments.content = comment;
            newcomments.create_at = DateTime.Now;
            dbContext.comments.Add(newcomments);
            if (dbContext.SaveChanges() != 0)
            {
                return Json(new { status = 1, data = "Merci pour votre message, il sera affiché après les révisions de l'administrateur" });
            }
            else
            {
                return Json(new { status = 0, data = "Panne du système, veuillez réessayer plus tard." });
            }
        }

        public JsonResult UpdateStatus(string idStr, bool isShow)
        {
            string str = idStr.Substring(0, idStr.LastIndexOf(","));
            string[] idTemp = str.Split(',');
            foreach (string id in idTemp)
            {
               int cid = Int32.Parse(id);
               var result = from c in dbContext.comments
                         where c.id == cid
                         select c;
               if (result.Count() <= 0) return Json(new { status = 0, data = "Cette commentaire n'existe pas, veuillez la réintégrer!" });
               else
               {
                    comments mycomments = dbContext.comments.Find(Int32.Parse(id));
                    mycomments.is_show = isShow;
                    if (dbContext.SaveChanges() != 0)
                        return Json(new { status = 1, data = "Modifié avec succès" });
                    else return Json(new { status = 0, data = "Échec de modifier" });
                }
            }
            return Json(new { status = 0, data = "Échec de modifier" });
        }
    }
}
