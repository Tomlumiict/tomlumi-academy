# Tomlumi Academy

A comprehensive, database-driven educational and professional development platform built with PHP, MySQL, and XAMPP.

## Features

- **Multi-Role System**: Visitors, Students, Instructors, Administrators
- **Course Management**: Create, manage, and deliver courses across multiple learning modes
- **Business, Technology & Education Sections**: Comprehensive content organization
- **Student Dashboard**: Track progress, submit assignments, access certificates
- **Instructor Portal**: Manage courses, grade assignments, monitor progress
- **Admin Portal**: Complete system management without code editing
- **Communication Channels**: Internal messaging, WhatsApp, Email, Social Media
- **Payment Management**: Track payments, generate receipts
- **Certificate System**: Auto-generate and verify certificates
- **Mobile Responsive**: Fully responsive design for all devices
- **Security**: Password hashing, CSRF protection, input validation, prepared statements

## Requirements

- XAMPP (Apache 2.4+, PHP 7.4+, MySQL 5.7+)
- Apache mod_rewrite enabled
- PHP Extensions: MySQLi, PDO, GD, Filter

## Installation

1. Download and extract to `htdocs/tomlumi_academy/`
2. Start XAMPP (Apache & MySQL)
3. Import database: `config/tomlumi_academy.sql` into phpMyAdmin
4. Update `config/config.php` with your database credentials
5. Navigate to `http://localhost/tomlumi_academy/`

## Quick Start

### Admin Access
- URL: `http://localhost/tomlumi_academy/admin/login.php`
- Access Code: `7323932000` (first login only)

### Student Access
- Register at homepage
- Login with email and password

### Instructor Access
- Admin creates instructor account
- Instructor logs in at student login portal

## Directory Structure

```
tomlumi_academy/
├── config/              # Configuration files
├── database/            # Database schema and migrations
├── includes/            # Reusable functions and helpers
├── assets/              # CSS, JS, images, icons
├── uploads/             # User uploads (documents, media, etc.)
├── public/              # Public-facing pages
├── courses/             # Course-related pages
├── authentication/      # Auth pages (register, login, etc.)
├── student/             # Student dashboard
├── instructor/          # Instructor dashboard
├── admin/               # Administrator portal
├── api/                 # AJAX endpoints
├── actions/             # Form processing
└── errors/              # Error pages
```

## Development Philosophy

- **Database-Driven**: All editable content stored in MySQL
- **Admin Control**: Manage website without editing code
- **Role-Based Access**: Permissions system controls what each user can do
- **Security First**: Validation, sanitization, and secure authentication from the start
- **Mobile First**: Responsive design works on all devices
- **No External Dependencies**: Pure PHP, MySQL, HTML, CSS, JavaScript (no Node.js, React, or frameworks)

## Admin Portal Access Code

Default admin access code: `7323932000`

**Important**: Change this immediately after first login. The code is converted to a secure hash in the database.

## Database

The system uses MySQL with the following main tables:

- Users (with roles: admin, instructor, student, visitor)
- Courses & Categories
- Applications & Enrollments
- Lessons & Materials
- Assignments & Submissions
- Payments & Receipts
- Certificates
- Posts & Comments
- Messages & Notifications
- Resources
- Settings (homepage, social links, etc.)
- Logs (audit trail)

## Security Features

- Password hashing (bcrypt)
- Session-based authentication
- CSRF token protection
- Input validation and sanitization
- SQL prepared statements (MySQLi)
- Output escaping
- Role-based access control
- File upload restrictions
- Private file access control

## Support

For issues or questions, please refer to the specification document included in the repository.

## License

Proprietary - Tomlumi Academy
