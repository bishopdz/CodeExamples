using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using DanielBishop_CSCI3110_Project2_ProjectManager.Models.Services;
using DanielBishop_CSCI3110_Project2_ProjectManager.Services;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace DanielBishop_CSCI3110_Project2_ProjectManager
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.Configure<CookiePolicyOptions>(options =>
            {
                // This lambda determines whether user consent for non-essential cookies is needed for a given request.
                options.CheckConsentNeeded = context => true;
                options.MinimumSameSitePolicy = SameSiteMode.None;
            });


            services.AddMvc().SetCompatibilityVersion(CompatibilityVersion.Version_2_2);

            services.AddDbContext<ProjectManagerDbContext>(options =>
            options.UseSqlServer(Configuration.GetConnectionString("ProManConnString")));

            services.AddScoped<IPersonRepository, DbPersonRepository>();
            services.AddScoped<IProjectRepository, DbProjectRepository>();
            services.AddScoped<IRoleRepository, DbRoleRepository>();
            services.AddScoped<IProjectRoleRepository, DbProjectRoleRepository>();
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                app.UseExceptionHandler("/Home/Error");
            }

            app.UseStaticFiles();

            app.UseMvc(routes =>
            {
                routes.MapRoute(
                    name: "default",
                    template: "{controller=Home}/{action=Index}/{id?}");

                routes.MapRoute(
                    name: "assign",
                    template: "{controller=ProjectRole}/{action=Assign}");
            });
        }
    }
}
