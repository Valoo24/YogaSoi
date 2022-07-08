using DAL.Entities;
using DAL.Interfaces;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Services
{
    /// <summary>
    /// Service spécifique aux entites de type "User". La classe doit être instanciée pour pouoir être utilisée.
    /// </summary>
    public class MemberService : IMemberService
    {
        /// <summary>
        /// L'objet IdBConnection permet d'utiliser des méthodes pour se connecter et envoyer des requêtes à une base de données.
        /// </summary>
        private IDbConnection _connection { get; set; }

        /// <summary>
        /// Le constructeur permet d'utiliser une connection spécifique à une base de donnée lors de son instanciation.
        /// </summary>
        public MemberService(IDbConnection connection)
        {
            _connection = connection;
        }

        #region Méthodes Privées
        /// <summary>
        /// Méthode Custom permettant de s'assurer que la connection à la base de donnée ne tente pas de s'ouvrir deux fois.
        /// </summary>
        private void UseConnection()
        {
            if (this._connection.State == ConnectionState.Open)
            {
                this._connection.Close();
            }
            this._connection.Open();
        }

        /// <summary>
        /// Méthode Custom permettant de traduire l'entity de type "Member" de la base de donnée en objet Member.
        /// </summary>
        /// <param name="record">Données contenue dans la base de donnée sous forme d'un dictionnaire</param>
        /// <returns>Renvoie un objet membre correspondant à l'entity "Member" de la base de donné.</returns>
        private Member FromDBToEntity(IDataRecord record)
        {
            return new Member
            {
                Id = (int)record["Id"],
                Firstname = (string)record["Firstname"],
                Surname = (string)record["Surname"],
                Password = (string)record["Hashed_password"],
                Pseudo = (string)record["Pseudo"],
                RoleId = (int)record["RoleId"],
                Is_admin = (bool)record["Is_admin"]
            };
        }
        #endregion

        Member IService<Member, int>.GetById(int id)
        {
            throw new NotImplementedException();
        }

        /// <summary>
        /// Méthode renvoyant tous les entities de type "Member" de la base de donnée en objet Member dans une liste sous forme de IEnumerable.
        /// </summary>
        /// <returns>Une liste sous forme d'IEnumerable de tous les entities de type Member en objet Member</returns>
        /// <exception cref="ArgumentNullException">Exception attrapée si le IDataReader est incapable de lire dans la base de donnée.</exception>
        public IEnumerable<Member> GetAll()
        {
            using (IDbCommand command = _connection.CreateCommand())
            {
                command.CommandText = "SELECT * FROM [Member]";

                UseConnection();
                using (IDataReader reader = command.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        while (reader.Read())
                        {
                            yield return FromDBToEntity(reader);
                        }
                    }
                    else
                    {
                        throw new ArgumentNullException("Impossible de récupéer les information de la table [User]. La table est vide ou inexistante.");
                    }
                }
            }
        }

        int IService<Member, int>.Add(Member entity)
        {
            throw new NotImplementedException();
        }

        bool IService<Member, int>.Delete(int id)
        {
            throw new NotImplementedException();
        }

        bool IService<Member, int>.Update(Member entity)
        {
            throw new NotImplementedException();
        }
    }
}