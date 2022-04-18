using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ltddnc_backend.Model
{
    public class Role
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int State { get; set; } = 1;
        public virtual ICollection<Account> Accounts { get; set; }
    }
}
