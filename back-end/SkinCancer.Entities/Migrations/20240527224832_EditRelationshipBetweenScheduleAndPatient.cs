using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace SkinCancer.Entities.Migrations
{
    /// <inheritdoc />
    public partial class EditRelationshipBetweenScheduleAndPatient : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_Schedules_PatientId",
                table: "Schedules");

            migrationBuilder.CreateIndex(
                name: "IX_Schedules_PatientId",
                table: "Schedules",
                column: "PatientId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_Schedules_PatientId",
                table: "Schedules");

            migrationBuilder.CreateIndex(
                name: "IX_Schedules_PatientId",
                table: "Schedules",
                column: "PatientId",
                unique: true,
                filter: "[PatientId] IS NOT NULL");
        }
    }
}
