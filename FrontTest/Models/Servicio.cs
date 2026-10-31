namespace MiFrontend.Models;

public class Servicio
{
    public long Id { get; set; }
    public Guid IdCliente { get; set; }
    public int IdTipo { get; set; }
    public decimal CostoMensual { get; set; }
    public string DireccionInstalacion { get; set; } = "";
    public bool Estado { get; set; } = true;
}