using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using ltddnc_backend.Model;

namespace ltddnc_backend
{
    public class DataDbContext: DbContext
    {
        public DataDbContext()
        {
        }

        public DataDbContext(DbContextOptions<DataDbContext> options) : base(options)
        {
        }
        public DbSet<Account> Accounts { get; set; }
        public DbSet<Cart> Carts { get; set; }
        public DbSet<Category> Categories { get; set; }
        public DbSet<Order> Orders { get; set; }
        public DbSet<OrderDetail> OrderDetails { get; set; }
        public DbSet<Product> Products { get; set; }
        public DbSet<Role> Roles { get; set; }
        public DbSet<User> Users { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<Account>(entity => {
                entity.HasKey(e => e.Id);

                entity.HasIndex(e => e.Email)
                        .IsUnique();

                entity.HasOne<Role>(e => e.Role)
                        .WithMany(role => role.Accounts)
                        .HasForeignKey(e => e.IdRole);

                entity.HasOne<User>(e => e.User)
                      .WithOne(user => user.Account)
                      .HasForeignKey<User>(customer => customer.IdAccount)
                      .OnDelete(DeleteBehavior.Cascade);
            });

            modelBuilder.Entity<Cart>(entity => {
                entity.HasKey(e => new { e.IdUser, e.IdProduct });

                entity.HasOne<User>(e => e.User)
                    .WithMany(c => c.Carts)
                    .HasForeignKey(e => e.IdUser);
            });

            modelBuilder.Entity<Category>(entity => {
                entity.HasKey(e => e.Id);

                entity.HasMany<Product>(e => e.Products)
                      .WithOne(product => product.Category)
                      .OnDelete(DeleteBehavior.Cascade);
            });


            modelBuilder.Entity<User>(entity => {
                entity.HasKey(e => e.IdAccount);
            });

            modelBuilder.Entity<OrderDetail>(entity => {
                entity.HasKey(e => new { e.IdOrder, e.IdProduct });

                entity.HasOne<Order>(e => e.Order)
                       .WithMany(order => order.OrderDetails)
                       .HasForeignKey(e => e.IdOrder)
                       .OnDelete(DeleteBehavior.Cascade);
            });

            modelBuilder.Entity<Product>(entity => {
                entity.HasKey(e => e.Id);

                entity.HasOne<Category>(e => e.Category)
                        .WithMany(category => category.Products)
                        .HasForeignKey(e => e.IdCategory);

            });


            modelBuilder.Entity<Role>(entity => {
                entity.HasKey(e => e.Id);
                entity.HasMany<Account>(e => e.Accounts)
                        .WithOne(account => account.Role)
                        .OnDelete(DeleteBehavior.Cascade);
            });

            SeedData(modelBuilder);
        }
        public void SeedData(ModelBuilder modelBuilder)
        {
            DateTime createdDate = new DateTime(2021, 07, 10);
            DateTime createdDatePayment = new DateTime(2021, 11, 10);
            DateTime createdDateShip = new DateTime(2021, 12, 10);
            DateTime createdDateNew = new DateTime(2021, 11, 11);
            DateTime endDate = new DateTime(2022, 7, 15);

            modelBuilder.Entity<Role>().HasData(
                new Role() { Id = 1, Name = "Admin", State = 1 },
                new Role() { Id = 2, Name = "Staff", State = 1 });

            // password: 123456789Abc!
            modelBuilder.Entity<Account>().HasData(
                new Account() { Id = 1, Email = "Admin@gmail.com", Password = "4bb0a94f21769c3b9d68cd8256a87104", State = 1, IdRole = 1 },
                new Account() { Id = 2, Email = "Admin2@gmail.com", Password = "4bb0a94f21769c3b9d68cd8256a87104", State = 1, IdRole = 1 },
                new Account() { Id = 3, Email = "Cust@gmail.com", Password = "4bb0a94f21769c3b9d68cd8256a87104", State = 1, IdRole = 1 },
                new Account() { Id = 4, Email = "Cust2@gmail.com", Password = "4bb0a94f21769c3b9d68cd8256a87104", State = 1, IdRole = 1 });

            modelBuilder.Entity<User>().HasData(
                new User() { IdAccount = 1, Name = "Giang", Phone = "0328807778", Address = "Bình Định" },
                new User() { IdAccount = 2, Name = "Thao", Phone = "0328807778", Address = "Bà Rịa-Vũng Tàu" },
                new User() { IdAccount = 3, Name = "Bao", Phone = "0328807778", Address = "Đồng Nai" },
                new User() { IdAccount = 4, Name = "Yen", Phone = "0328807778", Address = "Khánh Hòa" });

            modelBuilder.Entity<Category>().HasData(
                new Category() { Id = 1, Name = "Gà Rán",  State = 1 },
                new Category() { Id = 2, Name = "Burger",  State = 1 },
                new Category() { Id = 3, Name = "Mì Ý",  State = 1 },
                new Category() { Id = 4, Name = "Thức Uống",  State = 1 },
                new Category() { Id = 5, Name = "Kem",  State = 0 });

            modelBuilder.Entity<Product>().HasData(
              new Product() { Id = 1, Name = "Gà sốt đậu", Description = "Gà sốt với đậu", Stock = 100, State = 1, IdCategory = 1, UnitPrice = 100000 },
              new Product() { Id = 2, Name = "Gà sốt H&S", Description = "Gà sốt H&S", Stock = 100, State = 1, IdCategory = 1, UnitPrice = 100000 },
              new Product() { Id = 3, Name = "Burger Mozzarella", Description = "Burger Mozzarella", Stock = 100, State = 1, IdCategory = 2, UnitPrice = 100000 },
              new Product() { Id = 4, Name = "Burger Double Double", Description = "Burger Double Double", Stock = 100, State = 1, IdCategory = 2, UnitPrice = 100000 },
              new Product() { Id = 5, Name = "Mì Ý", Description = "Mì Ý", Stock = 100, State = 1, IdCategory = 3, UnitPrice = 100000 },
              new Product() { Id = 6, Name = "Mì Ý Thịt Bò", Description = "Mì Ý Thịt Bò", Stock = 100, State = 1, IdCategory = 3, UnitPrice = 100000 },
              new Product() { Id = 7, Name = "7Up Dưa Lưới Đào", Description = "7Up Dưa Lưới Đào", Stock = 100, State = 1, IdCategory = 4, UnitPrice = 100000 },
              new Product() { Id = 8, Name = "Nước Cam", Description = "Nước Cam", Stock = 100, State = 1, IdCategory = 4, UnitPrice = 100000 },
              new Product() { Id = 9, Name = "Burger Bulgogi", Description = "Burger Bulgogi", Stock = 100, State = 1, IdCategory = 2, UnitPrice = 100000 },
              new Product() { Id = 10, Name = "Burger Gà Thượng Hạng", Description = "Burger Gà Thượng Hạng", Stock = 100, State = 1, IdCategory = 2, UnitPrice = 100000 });

            modelBuilder.Entity<Cart>().HasData(
               new Cart() { IdUser = 3, IdProduct = 1, Quantity = 20 });
             
        }
    }
}