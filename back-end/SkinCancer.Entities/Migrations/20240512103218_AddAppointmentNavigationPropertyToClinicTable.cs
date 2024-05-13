using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace SkinCancer.Entities.Migrations
{
    /// <inheritdoc />
    public partial class AddAppointmentNavigationPropertyToClinicTable : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_Appointments_ClinicId",
                table: "Appointments");

            migrationBuilder.CreateIndex(
                name: "IX_Appointments_ClinicId",
                table: "Appointments",
                column: "ClinicId",
                unique: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_Appointments_ClinicId",
                table: "Appointments");

            migrationBuilder.CreateIndex(
                name: "IX_Appointments_ClinicId",
                table: "Appointments",
                column: "ClinicId");
        }
    }
}
