PROJECT 25DH110512_LTW - ASP.NET MVC 5 / .NET Framework 4.7.2

THONG TIN DA DOI
- MSSV: 25DH110463 -> 25DH110512
- Ho ten: Ho Gia Nghia -> Ho Thanh Phuc
- Namespace / assembly / ten solution / ten project da doi sang 25DH110512_LTW.
- Da bo .git va .vs cache cu de tranh mang theo lich su va cau hinh may cu.

MO PROJECT
1. Giai nen toan bo ZIP vao mot thu muc.
2. Mo file 25DH110512_LTW.sln bang Visual Studio 2022.
3. Neu Visual Studio hoi restore NuGet, chon Restore.
4. Kiem tra project target .NET Framework 4.7.2 va dam bao da cai workload ASP.NET and web development.
5. Mo Web.config va sua data source trong connection string MyStoreEntities cho dung ten SQL Server instance tren may ban.
   Hien tai project ZIP goc dang tro toi localhost\SQLEXPRESS03; ten nay co the khong trung instance tren may ban.
6. Tao database MyStore va cac bang theo database SQL ban dang dung.
7. Neu dung database2024.txt ban gui truoc, xem MyStore_Compatibility_Patch.sql. Chay patch sau khi da tao cac bang de bo sung cac cot ma EDMX cua project dang mong doi.
8. Neu muon dung PayPal, thay cac gia tri placeholder clientId/clientSecret trong Web.config bang thong tin sandbox moi. Thong tin PayPal co trong ZIP goc da duoc go bo vi la thong tin rieng tu; hay thu hoi/rotate credential cu.

CHAY THU
- Chon project 25DH110512_LTW lam Startup Project.
- Chon IIS Express va nhan F5.
- Neu gap loi ket noi DB, kiem tra data source va ten database truoc.
- Neu gap loi model/column, doi chieu EDMX voi schema MyStore; khong tu y xoa bang.

GIOI HAN KIEM TRA TRONG MOI TRUONG NAY
- Da kiem tra ZIP, duong dan solution/project, XML config/EDMX, cac file duoc csproj tham chieu va thay the chuoi MSSV/ho ten.
- Khong the chay IIS Express hoac build ASP.NET MVC 5 tren moi truong xu ly hien tai (khong co Visual Studio/MSBuild/.NET Framework). Vi vay can mo bang Visual Studio 2022 tren Windows de xac nhan build va runtime.
