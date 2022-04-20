using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ltddnc_backend.Model
{
    public class Cart
    {
        public int IdUser { get; set; }
        public int IdProduct { get; set; }
        public int Quantity { get; set; }
        public virtual User User { get; set; }
    }
}
