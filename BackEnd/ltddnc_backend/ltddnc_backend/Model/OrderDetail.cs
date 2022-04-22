using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ltddnc_backend.Model
{
    public class OrderDetail
    {
        public int IdOrder { get; set; }
        public int IdProduct { get; set; }
        public double UnitPrice { get; set; }
        public int Quantity { get; set; }
        public virtual Product Product { get; set; }
        public virtual Order Order { get; set; }
    }
}
