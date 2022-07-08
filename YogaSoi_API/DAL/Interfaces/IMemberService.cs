using DAL.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    /// <summary>
    /// Interface spécifique aux services à utiliser pour les entities de type "User". Il faut y placer les signatures des méthodes spécifique à ce service pour pouvoir y avoir accès dans les couches supérieurs de l'application.
    /// </summary>
    public interface IMemberService : IService<Member, int>
    {
    
    }
}
