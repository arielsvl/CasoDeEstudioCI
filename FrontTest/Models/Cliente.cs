namespace MiFrontend.Models;

public class Cliente
{
    public Guid Id { get; set; }
    public string Nombre { get; set; } = "";
    public DateTime FechaRegistro { get; set; } = DateTime.Today;
    public string Direccion { get; set; } = "";
    public string Correo { get; set; } = "";
    public string Telefono { get; set; } = "";
    public bool EstadoCliente { get; set; } = true;
    public string? MotivoBloqueo { get; set; }
    public DateTime? FechaBloqueo { get; set; }
}