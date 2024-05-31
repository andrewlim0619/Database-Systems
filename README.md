# Database-Systems
__Programmers:__ Andrew Lim, Omid Kazemini, Stanley Hsieh, Travis Khiem Huynh<br />
__Program:__ UW Bothell Music (Spotify) Database<br />
__Quarter:__ Spring 2024, UW Bothell <br />
__Faculty:__ Professor Himanshu Zade <br />
__Live Website Link:__ https://students.washington.edu/alim26/index.php <br />

## List of Softwares Used
__vergil__ - UW Shared Web Host Server for students ([vergil.u.washington.edu]): [Installation Tutorial](https://itconnect.uw.edu/tools-services-support/storage-hosting/shared-web-hosting/getting-started/web-development-environments/vergil-u-washington-edu/)<br />
__FileZilla/WinSCP__ - SSH/Secure FTP File Transfer<br />
__PuTTy__ - Terminal Emulator for navigating directories and executing commands<br />
__MySQL__ - Database management system<br />
__VSCode__ - Source-code editor for development<br />

## Project Overview
__Part 1: What to do and submit?__<br />

Create sample tables with data you wish to populate in the database table. You can use simple screenshots of the CSV file or create tables in the Word/PDF you submit. It is important that the grader and I can read some of the data that you populated in the database tables. It is up to you if you get the data by yourself or (my advice) use ai-generated tabulated text for this. Check if all your queries from earlier teamwork work with the data. This is for you to ensure that things are in good shape. Come up with Insert commands that you will need to populate the tables. Submit these commands. Come up with a few Update commands that you will need to edit already entered data. Do not be exhaustive, but come up with a few relevant to some of your users, e.g., the movie title was entered wrongly and needs to be edited, the book price has increased, the record needs to be updated, etc.<br />
 
_Provide an interface to the database_<br />

Background: In Week 9 (Day 1), we set up a sample instance called POS database in the class. This point-of-sale database allows you to use all the PHP-based scripts (provided to you) to implement an actual database with a front-end mechanism to interact with the data. The documentation provided should suffice to set up the sample instance on the Vergil server. You might run into some technical issues, so allow yourself ample time. Once you have set this up, you can do the following better. 

__Part 2: What to do and submit?__<br />

I want you all to create a similar setup with a front-facing interface for your database. You already have insert queries (you created them in the above part) that will create the setup SQL file. You have Vergil server access and basic PHP code to connect the interface to the backend. Now that you have a few tabs on top, which, if you click, execute some query on the backend and show that data on the screen...

_Edit one of the tabs:_ include a form to allow filtering on some criteria you can use filter criteria from one of the queries that you already wrote when the user clicks "select/display/run/execute", it shows the relevant output<br />

_Edit a second tab:_ include a form to allow an update operation you can use one of the update queries that you already wrote when the user clicks "update", it updates and shows some evidence of the update You will include a web-url (hopefully vergil server based URL) to access your database online as a comment in the submission.

## Entity Relationship Diagram
![Refined Tentative ER Model](https://github.com/andrewlim0619/Database-Systems/assets/114616307/18e55616-3b94-4e0a-bb9f-13248c7fcc33)

## Relational Model/Schema
![Refined Tentative RM Model](https://github.com/andrewlim0619/Database-Systems/assets/114616307/7bafb491-52cd-4149-89e8-f494dfb35a81)

## GitHub Directory Guide
__Supporting_Files__ - Supporting files provided by Instructor<br />
__db_setup__ - Documentation, Relational Model, and Entity Relationship Diagram<br />
__src_code__ - Source code for the website PHP Database<br />
