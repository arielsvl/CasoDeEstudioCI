using Microsoft.EntityFrameworkCore;
using MiApi.Models;

namespace MiApi.Data;

public class AppDbContext : DbContext
{
    public AppDbContext(DbContextOptions<AppDbContext> options)
        : base(options)
    {
    }

    public DbSet<Cliente> Clientes => Set<Cliente>();

    public DbSet<Servicio> Servicios => Set<Servicio>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Cliente>(entity =>
        {
            entity.ToTable("Cliente");

            entity.HasKey(c => c.Id);

            entity.Property(c => c.Id).HasColumnName("id");
            entity.Property(c => c.Nombre).HasColumnName("nombre");
            entity.Property(c => c.FechaRegistro).HasColumnName("fecha_registro");
            entity.Property(c => c.Direccion).HasColumnName("direccion");
            entity.Property(c => c.Correo).HasColumnName("correo");
            entity.Property(c => c.Telefono).HasColumnName("telefono");
            entity.Property(c => c.EstadoCliente).HasColumnName("estado_cliente");
            entity.Property(c => c.MotivoBloqueo).HasColumnName("motivo_bloqueo");
            entity.Property(c => c.FechaBloqueo).HasColumnName("fecha_bloqueo");
        });

        modelBuilder.Entity<Servicio>(entity =>
        {
            entity.ToTable("Servicio");
            
            entity.HasKey(s => s.Id);

            entity.Property(s => s.Id).HasColumnName("id").ValueGeneratedOnAdd();
            entity.Property(s => s.IdCliente).HasColumnName("id_cliente");
            entity.Property(s => s.IdTipo).HasColumnName("id_tipo");
            entity.Property(s => s.CostoMensual).HasColumnName("costo_mensual");
            entity.Property(s => s.DireccionInstalacion).HasColumnName("direccion_instalacion");
        });
    }
}