using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    /// <summary>
    /// Tout service doit Implémenter ou hériter d'un IService. L'interace permet d'implémenter toute les méthodes basique d'un CRUD.
    /// </summary>
    /// <typeparam name="TEntity">Le type d'Entity qui sera utilisé dans les méthodes du CRUD au sein du service qui implémentera l'interface.</typeparam>
    /// <typeparam name="TKey">Le type de clé primaire utilisé par l'Entity.</typeparam>
    public interface IService<TEntity, TKey> where TEntity : IEntity<TKey>
    {
        /// <summary>
        /// Implément la méthode permettant de récupérer un Entity spécifique grâce à son Id.
        /// </summary>
        /// <param name="id">valeur de la clé primaire de l'Entity à récupérer.</param>
        /// <returns>Renvoie l'Entity souhaité.</returns>
        protected TEntity GetById(TKey id);

        /// <summary>
        /// Implémente la méthode permettant de récupérer tous les Entities dans la table définie au sein de la méthode du service.
        /// </summary>
        /// <returns>Renvoie une liste sous forme de IEnumerable de tous les Entities souhaités.</returns>
        protected IEnumerable<TEntity> GetAll();

        /// <summary>
        /// Implément la méthode permettant d'ajouter un entity au sein de la table définie dans la méthode implémentée dans le service.
        /// </summary>
        /// <param name="entity">Entity à ajouter dans la table.</param>
        /// <returns>Renvoie la valeur de la clé primaire de l'entity ajouté.</returns>
        protected TKey Add(TEntity entity);

        /// <summary>
        /// Implément la méthode permettant de supprimer un entity grâce à son identifiant.
        /// </summary>
        /// <param name="id">Valeur de la clé primaire permettant d'identifier l'objet à supprimer.</param>
        /// <returns>True: si l'entity a été supprimé correctement/ False: si l'entity n'a pas été supprimé correctement.</returns>
        protected bool Delete(TKey id);

        /// <summary>
        /// Implémente la méthode permettant de mettre à jour un entity
        /// </summary>
        /// <param name="entity">Entity mis à jour</param>
        /// <returns>True: si l'entity a correctement été mis à jour/False: si l'ENtity n'a pas été mis à jour correctement.</returns>
        protected bool Update(TEntity entity);
    }
}
