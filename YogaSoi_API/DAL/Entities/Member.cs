using DAL.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Entities
{
    public class Member : IEntity<int>
    {
        public int Id { get; set; }
        public string Firstname { get; set; }
        public string Surname { get; set; }
        public string Pseudo { get; set; }
        public string Password { get; set; }
        public int RoleId { get; set; }
        public bool Is_admin { get; set; }
    }
}
