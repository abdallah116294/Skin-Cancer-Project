using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace SkinCancer.Entities.Migrations
{
    /// <inheritdoc />
    public partial class MakingUserIdColumnInClinicAllowsNull : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Clinics_AspNetUsers_UserId",
                table: "Clinics");

            migrationBuilder.DropIndex(
                name: "IX_Clinics_UserId",
                table: "Clinics");

            migrationBuilder.AlterColumn<string>(
                name: "UserId",
                table: "Clinics",
                type: "nvarchar(450)",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(450)");

            migrationBuilder.CreateIndex(
                name: "IX_Clinics_UserId",
                table: "Clinics",
                column: "UserId",
                unique: true,
                filter: "[UserId] IS NOT NULL");

            migrationBuilder.AddForeignKey(
                name: "FK_Clinics_AspNetUsers_UserId",
                table: "Clinics",
                column: "UserId",
                principalTable: "AspNetUsers",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Clinics_AspNetUsers_UserId",
                table: "Clinics");

            migrationBuilder.DropIndex(
                name: "IX_Clinics_UserId",
                table: "Clinics");

            migrationBuilder.AlterColumn<string>(
                name: "UserId",
                table: "Clinics",
                type: "nvarchar(450)",
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "nvarchar(450)",
                oldNullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Clinics_UserId",
                table: "Clinics",
                column: "UserId",
                unique: true);

            migrationBuilder.AddForeignKey(
                name: "FK_Clinics_AspNetUsers_UserId",
                table: "Clinics",
                column: "UserId",
                principalTable: "AspNetUsers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
