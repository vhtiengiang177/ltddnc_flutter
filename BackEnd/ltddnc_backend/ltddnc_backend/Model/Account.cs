using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;

namespace ltddnc_backend.Model
{
    public class Account
    {
        public int Id { get; set; }
        public string Email { get; set; }
        [DataType(DataType.Password)]
        public string Password { get; set; }
        public int State { get; set; } = 1; // 0: Delete, 1: Active, 2: Block
        public int IdTypeAccount { get; set; }
        public Role TypeAccount { get; set; }
    }
}
