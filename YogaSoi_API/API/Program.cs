using DAL.Interfaces;
using DAL.Services;
using System.Data;
using System.Data.SqlClient;

var builder = WebApplication.CreateBuilder(args);

#region Services ajout� dans le builder.

builder.Services.AddControllers();

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

#region Injection de d�pendances
// A chaque fois que l'on instancie un objet qui demande une interface IUserService (comme c'est le cas pour MemberController), un nouvel objet UserService (sans propri�t� initialis�s) lui est attribu� pour chaque personne utilisant l'API. La dur�e de vie de cette instance dure jusqu'� la fermeture de l'API.
builder.Services.AddScoped<IMemberService, MemberService>();

// A chaque fois que l'on instancie un objet qui demande une interface IDbConnection (Comme c'est le cas pour tous les services), On lui envoie une connection SQL avec comme param�tre la "Connection String" contenue dans le fichier AppSettings.Json dans la propri�t� "default" du champ "ConnectionString".
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
