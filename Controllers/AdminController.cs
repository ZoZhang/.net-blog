using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PagedList;
using Blog.Models;

namespace Blog.Controllers
{
    public class AdminController : Controller
    {
        BlogEntities dbContext = new BlogEntities();

        public ActionResult Index(int page = 1)
        {
            if (Session["email"] == null)
            {
                Response.Redirect("Admin/Login");
            }
            var result = (from u in dbContext.users
                          select u).ToList<users>();

            int pageSize = 20;
            ViewBag.user = Session["email"];
            ViewBag.isAdmin = Session["isAdmin"];
            ViewBag.Title = "Page d'administration";
            ViewBag.Page =  ViewBag.isAdmin == true ? "dashboard": "catagory";
            ViewBag.PageClass ="backendlogin";

            return View(result.ToPagedList<users>(page, pageSize));
        }

        public ActionResult Login()
        {
            ViewBag.Title = "Page d'administration";
            ViewBag.PageClass ="backendlogin";
            if (Session["email"] != null)
            {
                ViewBag.isAdmin = Session["isAdmin"];

                if (ViewBag.isAdmin == true) {
                    Response.Redirect("Admin/Index");
                } else {
                    Response.Redirect("Category/Index");
                }
            }
            return View();
        }

        public JsonResult CkeckLogin(string email, string password)
        {
            var result = from u in dbContext.users
                         where u.email == email && u.password == password
                         select u;

            if (result.Count() > 0)
            {

                foreach (var u in result)
                {
                    Session["email"] = email;
                    Session["isAdmin"] = u.is_admin;
                }
                return Json(new { status = 1, is_admin = Session["isAdmin"], data = "Connexion réussie, redirection la page d'administration..." });
            }
            else
            {
                return Json(new { status = 0, is_admin = false, data = "Échec de la connexion" });
            }
        }

        public ActionResult Logout()
        {
            if (Session["email"] == null)
            {
                Response.Redirect("Admin/Login");
            }
            ViewBag.Title = "Page d'administration";
            ViewBag.PageClass ="backendlogin";
            Session["email"] = null;
            return View("Login");
        }

        public ActionResult UserAdd()
        {
            if (Session["email"] == null)
            {
                Response.Redirect("Admin/Login");
            }
            return View();
        }

        public JsonResult ProcessAdd(string email, string pwd, string pwdd, string userType)
        {
            if (Session["email"] == null)
            {
                Response.Redirect("Admin/Login");
            }
            users myuser = new users();
            var result = from u in dbContext.users
                         where u.email == email
                         select u;
            if (result.Count() > 0) return Json(new { status = 0, data = "L'utilisateur existe déjà, veuillez le saisir à nouveau!" });
            else
            {
                myuser.email = email;
                myuser.password = pwd;
                myuser.is_admin =  userType == "admin" ? true : false;
                dbContext.users.Add(myuser);
                if (dbContext.SaveChanges() != 0)
                    return Json(new { status = 1, data = "Ajouté avec succès" });
                else return Json(new { status = 0, data = "Échec d'ajouté" });
            }
        }

        public ActionResult UpdateUser(int id)
        {
            if (Session["email"] == null)
            {
                Response.Redirect("Admin/Login");
            }

            users myuser = dbContext.users.Find(id);
            ViewBag.id = id;
            ViewBag.email = myuser.email;
            ViewBag.is_admin = myuser.is_admin;
            return View();
        }

        public JsonResult ProcessUpdate(int userId, string userName, string pwd, string pwdd)
        {
            if (Session["email"] == null)
            {
                Response.Redirect("Admin/Login");
            }
            users myuser = dbContext.users.Find(userId);
            myuser.password = pwd;
            if (dbContext.SaveChanges() != 0)
                return Json(new { status = 1, data = "Modifié avec succès" });
            else return Json(new { status = 0, data = "Échec de modifier" });
        }

        public void ProcessDelete(int id)
        {
            if (Session["email"] == null)
            {
                Response.Redirect("Admin/Login");
            }
            users myuser = dbContext.users.Find(id);
            var result = from a in dbContext.article
                         where a.user_id == id
                         select a;
            if (result.Count() > 0)
            {
                foreach (var a in result)
                    a.user_id = 1;
            }
            dbContext.users.Remove(myuser);
            dbContext.SaveChanges();
        }

        public void ManyDelete(string idStr)
        {
            if (Session["email"] == null)
            {
                Response.Redirect("Admin/Login");
            }
            string str = idStr.Substring(0, idStr.LastIndexOf(","));
            string[] idTemp = str.Split(',');
            users myuser;
            foreach (string s in idTemp)
            {
                myuser = dbContext.users.Find(int.Parse(s));
                dbContext.users.Remove(myuser);
            }
            dbContext.SaveChanges();
        }
    }
}
