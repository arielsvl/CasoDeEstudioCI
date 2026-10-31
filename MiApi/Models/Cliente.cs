namespace MiApi.Models;

public class Cliente
{
    public Guid Id { get; set; }

    public string Nombre { get; set; } = string.Empty;

    public DateTime FechaRegistro { get; set; }

    public string Direccion { get; set; } = string.Empty;

    public string Correo { get; set; } = string.Empty;

    public string Telefono { get; set; } = string.Empty;

    public bool EstadoCliente { get; set; }

    public string? MotivoBloqueo { get; set; }

    public DateTime? FechaBloqueo { get; set; }
}