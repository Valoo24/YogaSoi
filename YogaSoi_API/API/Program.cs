using DAL.Interfaces;
using DAL.Services;
using System.Data;
using System.Data.SqlClient;

var builder = WebApplication.CreateBuilder(args);

#region Services ajouté dans le builder.

builder.Services.AddControllers();

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

#region Injection de dépendances
// A chaque fois que l'on instancie un objet qui demande une interface IUserService (comme c'est le cas pour MemberController), un nouvel objet UserService (sans propriété initialisés) lui est attribué pour chaque personne utilisant l'API. La durée de vie de cette instance dure jusqu'à la fermeture de l'API.
builder.Services.AddScoped<IMemberService, MemberService>();

// A chaque fois que l'on instancie un objet qui demande une interface IDbConnection (Comme c'est le cas pour tous les services), On lui envoie une connection SQL avec comme paramètre la "Connection String" contenue dans le fichier AppSettings.Json dans la propriété "default" du champ "ConnectionString".
builder.Services.AddScoped<IDbConnection>(sp =>
{
    return new SqlConnection(builder.Configuration.GetConnectionString("default"));
});

#endregion

#endregion

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
