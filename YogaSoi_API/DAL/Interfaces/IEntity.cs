using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    /// <summary>
    /// Tout objet en lien avec la Base de donnée DOIT implémenter IENtity. L'interface permet de d'implémenter un objet avec une clé primaire à définir et dont le nom de la propriété est "Id".
    /// </summary>
    /// <typeparam name="TKey">propriété générique servant d'identifiant pour retrouver un objet implémentant IEntity</typeparam>
    public interface IEntity<TKey>
    {
        /// <summary>
        /// Primary Key devant implémenter chaque "Entity" en lien avec la Base de donnée.
        /// </summary>
        public TKey Id { get; set; }
    }
}
