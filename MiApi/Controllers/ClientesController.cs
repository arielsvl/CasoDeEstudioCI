using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MiApi.Data;
using MiApi.Models;

namespace MiApi.Controllers;

[ApiController]
[Route("api/[controller]")]
public class ClientesController : ControllerBase
{
    private readonly AppDbContext _context;

    public ClientesController(AppDbContext context)
    {
        _context = context;
    }

    // GET: api/clientes
    [HttpGet]
    public async Task<ActionResult<IEnumerable<Cliente>>> GetClientes()
    {
        return await _context.Clientes
            .AsNoTracking()
            .ToListAsync();
    }

    // GET: api/clientes/{id}
    [HttpGet("{id:guid}")]
    public async Task<ActionResult<Cliente>> GetCliente(Guid id)
    {
        var cliente = await _context.Clientes.FindAsync(id);

        if (cliente == null)
            return NotFound();

        return cliente;
    }

    // POST: api/clientes
    [HttpPost]
    public async Task<ActionResult<Cliente>> CrearCliente(Cliente cliente)
    {
        cliente.Id = Guid.NewGuid();

        _context.Clientes.Add(cliente);
        await _context.SaveChangesAsync();

        return CreatedAtAction(
            nameof(GetCliente),
            new { id = cliente.Id },
            cliente
        );
    }

    // PUT: api/clientes/{id}
    [HttpPut("{id:guid}")]
    public async Task<IActionResult> ActualizarCliente(
        Guid id, Cliente cliente)
    {
        if (id != cliente.Id)
            return BadRequest("El ID de la URL no coincide con el del cliente.");

        var existente = await _context.Clientes.FindAsync(id);

        if (existente == null)
            return NotFound();

        existente.Nombre = cliente.Nombre;
        existente.FechaRegistro = cliente.FechaRegistro;
        existente.Direccion = cliente.Direccion;
        existente.Correo = cliente.Correo;
        existente.Telefono = cliente.Telefono;
        existente.EstadoCliente = cliente.EstadoCliente;
        existente.MotivoBloqueo = cliente.MotivoBloqueo;
        existente.FechaBloqueo = cliente.FechaBloqueo;

        await _context.SaveChangesAsync();

        return NoContent();
    }

    // DELETE: api/clientes/{id}
    [HttpDelete("{id:guid}")]
    public async Task<IActionResult> EliminarCliente(Guid id)
    {
        var cliente = await _context.Clientes.FindAsync(id);

        if (cliente == null)
            return NotFound();

        _context.Clientes.Remove(cliente);
        await _context.SaveChangesAsync();

        return NoContent();
    }
}