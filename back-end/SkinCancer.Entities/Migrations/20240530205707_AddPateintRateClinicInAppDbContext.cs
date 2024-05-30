using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace SkinCancer.Entities.Migrations
{
    /// <inheritdoc />
    public partial class AddPateintRateClinicInAppDbContext : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_PatientRateClinic_AspNetUsers_PatientId",
                table: "PatientRateClinic");

            migrationBuilder.DropForeignKey(
                name: "FK_PatientRateClinic_Clinics_ClinicId",
                table: "PatientRateClinic");

            migrationBuilder.DropPrimaryKey(
                name: "PK_PatientRateClinic",
                table: "PatientRateClinic");

            migrationBuilder.RenameTable(
                name: "PatientRateClinic",
                newName: "PatientRateClinics");

            migrationBuilder.RenameIndex(
                name: "IX_PatientRateClinic_PatientId",
                table: "PatientRateClinics",
                newName: "IX_PatientRateClinics_PatientId");

            migrationBuilder.RenameIndex(
                name: "IX_PatientRateClinic_ClinicId",
                table: "PatientRateClinics",
                newName: "IX_PatientRateClinics_ClinicId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_PatientRateClinics",
                table: "PatientRateClinics",
                column: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_PatientRateClinics_AspNetUsers_PatientId",
                table: "PatientRateClinics",
                column: "PatientId",
                principalTable: "AspNetUsers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_PatientRateClinics_Clinics_ClinicId",
                table: "PatientRateClinics",
                column: "ClinicId",
                principalTable: "Clinics",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_PatientRateClinics_AspNetUsers_PatientId",
                table: "PatientRateClinics");

            migrationBuilder.DropForeignKey(
                name: "FK_PatientRateClinics_Clinics_ClinicId",
                table: "PatientRateClinics");

            migrationBuilder.DropPrimaryKey(
                name: "PK_PatientRateClinics",
                table: "PatientRateClinics");

            migrationBuilder.RenameTable(
                name: "PatientRateClinics",
                newName: "PatientRateClinic");

            migrationBuilder.RenameIndex(
                name: "IX_PatientRateClinics_PatientId",
                table: "PatientRateClinic",
                newName: "IX_PatientRateClinic_PatientId");

            migrationBuilder.RenameIndex(
                name: "IX_PatientRateClinics_ClinicId",
                table: "PatientRateClinic",
                newName: "IX_PatientRateClinic_ClinicId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_PatientRateClinic",
                table: "PatientRateClinic",
                column: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_PatientRateClinic_AspNetUsers_PatientId",
                table: "PatientRateClinic",
                column: "PatientId",
                principalTable: "AspNetUsers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_PatientRateClinic_Clinics_ClinicId",
                table: "PatientRateClinic",
                column: "ClinicId",
                principalTable: "Clinics",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
