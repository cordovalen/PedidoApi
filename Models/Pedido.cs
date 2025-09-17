namespace PedidoApi.Models
{
    public class Pedido
    {
        public int id { get; set; }
        public required string cliente { get; set; }
        public required string producto { get; set; }
        public int cantidad { get; set; }
        public DateTime fecha { get; set; }
        public required decimal total { get; set; }
    }
}
