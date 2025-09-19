using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PedidoApi.Data;
using PedidoApi.Models;

namespace PedidoApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class PedidosController(ApplicationDbContext context) : ControllerBase
    {
        private readonly ApplicationDbContext _context = context;

        [HttpGet]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<ActionResult> GetPedidos()
        {
            return Ok(await _context.pedidos.ToListAsync());
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Pedido>> GetPedido(int id)
        {
            Pedido? pedido = await _context.pedidos.FindAsync(id);

            if (pedido == null)
            {
                return NotFound();
            }

            return pedido;
        }


        [HttpPost]
        public async Task<ActionResult<Pedido>> CreatePedido(Pedido pedido)
        {
            pedido.fecha = DateTime.Now.ToUniversalTime();
            _context.pedidos.Add(pedido);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetPedido", new { pedido.id }, pedido);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> UpdatePedido(int id, Pedido pedido)
        {
            if (id != pedido.id)
            {
                return BadRequest();
            }

            _context.Entry(pedido).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!PedidoExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }


        [HttpDelete("{id}")]
        public async Task<IActionResult> DeletePedido(int id)
        {
            Pedido? pedido = await _context.pedidos.FindAsync(id);
            if (pedido == null)
            {
                return NotFound();
            }

            _context.pedidos.Remove(pedido);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool PedidoExists(int id)
        {
            return _context.pedidos.Any(e => e.id == id);
        }
    }
}
