using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace SkinCancer.Entities.Migrations
{
    /// <inheritdoc />
    public partial class AddPatientRateClinicTable : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "PatientRateClinic",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ClinicId = table.Column<int>(type: "int", nullable: false),
                    PatientId = table.Column<string>(type: "nvarchar(450)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PatientRateClinic", x => x.Id);
                    table.ForeignKey(
                        name: "FK_PatientRateClinic_AspNetUsers_PatientId",
                        column: x => x.PatientId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_PatientRateClinic_Clinics_ClinicId",
                        column: x => x.ClinicId,
                        principalTable: "Clinics",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_PatientRateClinic_ClinicId",
                table: "PatientRateClinic",
                column: "ClinicId");

            migrationBuilder.CreateIndex(
                name: "IX_PatientRateClinic_PatientId",
                table: "PatientRateClinic",
                column: "PatientId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "PatientRateClinic");
        }
    }
}
