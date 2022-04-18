using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ltddnc_backend.Model
{
    public class User
    {
        public string Name { get; set; }
        public string? Image { get; set; }
        public int IdAccount { get; set; }
        public string? Phone { get; set; }
        public string? Address { get; set; }
        public virtual Account Account { get; set; }
        public virtual ICollection<Cart> Carts { get; set; }
        public virtual ICollection<Order> Orders { get; set; }
    }
}
