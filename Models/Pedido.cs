namespace PedidoApi.Models
{
    public class Pedido
    {
        public int id { get; set; }
        public required string cliente { get; set; }
        public required decimal total { get; set; }
    }
}
