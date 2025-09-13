using Microsoft.EntityFrameworkCore;
using PedidoApi.Models;

namespace PedidoApi.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
            : base(options)
        {
        }

        // Propiedad DbSet para tus modelos (entidades)
        public DbSet<Pedido> pedidos { get; set; }
        // Agrega otras propiedades DbSet para otros modelos (ej. Clientes, Productos, etc.)
    }
}
