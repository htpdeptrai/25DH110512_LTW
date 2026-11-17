using System.Linq;
using System.Web.Mvc;
using _25DH110512_LTW.Models;

namespace _25DH110512_LTW.Controllers
{
    public class ProductsController : Controller
    {
        private MyStoreEntities db = new MyStoreEntities();

        public ActionResult Index(int? categoryId)
        {
            var products = db.Products.AsQueryable();
            if (categoryId.HasValue)
            {
                products = products.Where(p => p.CategoryID == categoryId.Value);
            }
            return View(products.ToList());
        }

        public ActionResult Details(int id)
        {
            var product = db.Products.SingleOrDefault(p => p.ProductID == id);
            if (product == null)
            {
                return HttpNotFound();
            }
            return View(product);
        }
    }
}