using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MiApi.Data;
using MiApi.Models;
using System.Data;
using Microsoft.Data.SqlClient;

namespace MiApi.Controllers;

[ApiController]
[Route("api/[controller]")]
public class ServiciosController : ControllerBase
{
    private readonly AppDbContext _context;

    public ServiciosController(AppDbContext context)
    {
        _context = context;
    }

    [HttpGet("cliente/{idCliente:guid}/descuento")]
    public async Task<IActionResult> CalcularDescuento(Guid idCliente)
    {
        var connection = _context.Database.GetDbConnection();

        await using var command = connection.CreateCommand();

        command.CommandText = "sp_CalcularDescuentoPaquete";
        command.CommandType = CommandType.StoredProcedure;

        var parametro = command.CreateParameter();
        parametro.ParameterName = "@IdCliente";
        parametro.Value = idCliente;
        command.Parameters.Add(parametro);

        if (connection.State != ConnectionState.Open)
            await connection.OpenAsync();

        try
        {
            await using var reader = await command.ExecuteReaderAsync();

            if (!await reader.ReadAsync())
                return NotFound();

            return Ok(new
            {
                subtotal = reader["subtotal"],
                descuento = reader["descuento"],
                totalMensual = reader["total_mensual"]
            });
        }
        finally
        {
            await connection.CloseAsync();
        }
    }

    [HttpGet("cliente/{idCliente:guid}")]
    public async Task<ActionResult<IEnumerable<Servicio>>> GetServiciosPorCliente(Guid idCliente)
    {
        var servicios = await _context.Servicios
            .AsNoTracking()
            .Where(s => s.IdCliente == idCliente)
            .ToListAsync();

        return Ok(servicios);
    }

    // GET: api/Servicios
    [HttpGet]
    public async Task<ActionResult<IEnumerable<Servicio>>> GetServicios()
    {
        return await _context.Servicios.AsNoTracking().ToListAsync();
    }

    // GET: api/Servicios/{id}
    [HttpGet("{id:long}")]
    public async Task<ActionResult<Servicio>> GetServicio(long id)
    {
        var servicio = await _context.Servicios.FindAsync(id);

        if (servicio == null)
            return NotFound();

        return servicio;
    }

    // POST: api/Servicios
    [HttpPost]
    public async Task<ActionResult<Servicio>> CrearServicio(Servicio servicio)
    {
        _context.Servicios.Add(servicio);
        await _context.SaveChangesAsync();

        return CreatedAtAction(
            nameof(GetServicio),
            new { id = servicio.Id },
            servicio
        );
    }

    // PUT: api/Servicios/{id}
    [HttpPut("{id:long}")]
    public async Task<IActionResult> ActualizarServicio(long id, Servicio servicio)
    {
        if (id != servicio.Id)
            return BadRequest("El ID de la URL no coincide con el del servicio.");

        var existente = await _context.Servicios.FindAsync(id);

        if (existente == null)
            return NotFound();

        existente.IdCliente = servicio.IdCliente;
        existente.IdTipo = servicio.IdTipo;
        existente.CostoMensual = servicio.CostoMensual;
        existente.DireccionInstalacion = servicio.DireccionInstalacion;

        await _context.SaveChangesAsync();

        return NoContent();
    }

    // DELETE: api/Servicios/{id}
    [HttpDelete("{id:long}")]
    public async Task<IActionResult> EliminarServicio(long id)
    {
        var servicio = await _context.Servicios.FindAsync(id);

        if (servicio == null)
            return NotFound();

        _context.Servicios.Remove(servicio);
        await _context.SaveChangesAsync();

        return NoContent();
    }
}