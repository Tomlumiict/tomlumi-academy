-- Tomlumi Academy Database Schema
-- MySQL 5.7+ / MariaDB

CREATE DATABASE IF NOT EXISTS `tomlumi_academy` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE `tomlumi_academy`;

-- ============================================
-- USERS TABLE
-- ============================================

CREATE TABLE IF NOT EXISTS `users` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `role` ENUM('visitor', 'student', 'instructor', 'admin') NOT NULL DEFAULT 'visitor',
  `first_name` VARCHAR(100) NOT NULL,
  `last_name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(255) UNIQUE NOT NULL,
  `phone` VARCHAR(20),
  `password_hash` VARCHAR(255) NOT NULL,
  `bio` TEXT,
  `profile_image` VARCHAR(255),
  `status` ENUM('active', 'inactive', 'suspended', 'deleted') NOT NULL DEFAULT 'active',
  `email_verified` BOOLEAN DEFAULT FALSE,
  `email_token` VARCHAR(255),
  `last_login` DATETIME,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_email (email),
  INDEX idx_role (role),
  INDEX idx_status (status),
  INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- COURSES TABLE
-- ============================================

CREATE TABLE IF NOT EXISTS `courses` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `title` VARCHAR(255) NOT NULL,
  `slug` VARCHAR(255) UNIQUE,
  `description` TEXT,
  `objectives` TEXT,
  `topics` TEXT,
  `section` ENUM('business', 'technology', 'education', 'blog') NOT NULL,
  `duration` VARCHAR(100),
  `learning_modes` JSON,
  `entry_requirements` TEXT,
  `fee` DECIMAL(10, 2) DEFAULT 0.00,
  `instructor_id` INT,
  `featured_image` VARCHAR(255),
  `status` ENUM('draft', 'published', 'open', 'closed', 'archived', 'deleted') NOT NULL DEFAULT 'draft',
  `registration_deadline` DATE,
  `start_date` DATE,
  `end_date` DATE,
  `max_students` INT,
  `enrolled_count` INT DEFAULT 0,
  `created_by` INT,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (instructor_id) REFERENCES users(id),
  FOREIGN KEY (created_by) REFERENCES users(id),
  INDEX idx_section (section),
  INDEX idx_status (status),
  INDEX idx_instructor_id (instructor_id),
  INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- COURSE CATEGORIES
-- ============================================

CREATE TABLE IF NOT EXISTS `course_categories` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `slug` VARCHAR(255) UNIQUE,
  `description` TEXT,
  `icon` VARCHAR(255),
  `color` VARCHAR(7),
  `status` ENUM('active', 'inactive') DEFAULT 'active',
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- COURSE_CATEGORY JUNCTION
-- ============================================

CREATE TABLE IF NOT EXISTS `course_categories_map` (
  `course_id` INT NOT NULL,
  `category_id` INT NOT NULL,
  PRIMARY KEY (course_id, category_id),
  FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE,
  FOREIGN KEY (category_id) REFERENCES course_categories(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- APPLICATIONS
-- ============================================

CREATE TABLE IF NOT EXISTS `applications` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `course_id` INT NOT NULL,
  `learning_mode` VARCHAR(50),
  `educational_background` TEXT,
  `relevant_experience` TEXT,
  `motivation` TEXT,
  `status` ENUM('pending', 'reviewing', 'more_info', 'approved', 'rejected', 'enrolled', 'completed', 'cancelled') NOT NULL DEFAULT 'pending',
  `reviewed_by` INT,
  `review_notes` TEXT,
  `submitted_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `reviewed_at` DATETIME,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (course_id) REFERENCES courses(id),
  FOREIGN KEY (reviewed_by) REFERENCES users(id),
  INDEX idx_user_id (user_id),
  INDEX idx_course_id (course_id),
  INDEX idx_status (status),
  UNIQUE KEY unique_application (user_id, course_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- ENROLLMENTS
-- ============================================

CREATE TABLE IF NOT EXISTS `enrollments` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `course_id` INT NOT NULL,
  `learning_mode` VARCHAR(50),
  `enrollment_date` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `completion_date` DATETIME,
  `progress_percentage` INT DEFAULT 0,
  `status` ENUM('active', 'completed', 'dropped') NOT NULL DEFAULT 'active',
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (course_id) REFERENCES courses(id),
  INDEX idx_user_id (user_id),
  INDEX idx_course_id (course_id),
  INDEX idx_status (status),
  UNIQUE KEY unique_enrollment (user_id, course_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- LESSONS
-- ============================================

CREATE TABLE IF NOT EXISTS `lessons` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `course_id` INT NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `description` TEXT,
  `content` LONGTEXT,
  `sequence` INT,
  `video_url` VARCHAR(255),
  `duration_minutes` INT,
  `status` ENUM('draft', 'published', 'hidden') NOT NULL DEFAULT 'draft',
  `created_by` INT,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE,
  FOREIGN KEY (created_by) REFERENCES users(id),
  INDEX idx_course_id (course_id),
  INDEX idx_sequence (sequence)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- LEARNING MATERIALS
-- ============================================

CREATE TABLE IF NOT EXISTS `learning_materials` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `lesson_id` INT,
  `course_id` INT,
  `title` VARCHAR(255) NOT NULL,
  `description` TEXT,
  `material_type` ENUM('pdf', 'document', 'image', 'video', 'note', 'link') NOT NULL,
  `file_path` VARCHAR(255),
  `file_url` VARCHAR(255),
  `sequence` INT,
  `status` ENUM('published', 'hidden', 'deleted') NOT NULL DEFAULT 'published',
  `uploaded_by` INT,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (lesson_id) REFERENCES lessons(id) ON DELETE CASCADE,
  FOREIGN KEY (course_id) REFERENCES courses(id),
  FOREIGN KEY (uploaded_by) REFERENCES users(id),
  INDEX idx_lesson_id (lesson_id),
  INDEX idx_course_id (course_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- ASSIGNMENTS
-- ============================================

CREATE TABLE IF NOT EXISTS `assignments` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `course_id` INT NOT NULL,
  `lesson_id` INT,
  `title` VARCHAR(255) NOT NULL,
  `description` TEXT,
  `instructions` LONGTEXT,
  `due_date` DATETIME,
  `total_marks` INT DEFAULT 100,
  `status` ENUM('active', 'closed', 'deleted') NOT NULL DEFAULT 'active',
  `created_by` INT,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE,
  FOREIGN KEY (lesson_id) REFERENCES lessons(id) ON DELETE SET NULL,
  FOREIGN KEY (created_by) REFERENCES users(id),
  INDEX idx_course_id (course_id),
  INDEX idx_due_date (due_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- ASSIGNMENT SUBMISSIONS
-- ============================================

CREATE TABLE IF NOT EXISTS `assignment_submissions` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `assignment_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `submission_text` LONGTEXT,
  `file_path` VARCHAR(255),
  `submitted_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `is_late` BOOLEAN DEFAULT FALSE,
  `marks_obtained` INT,
  `feedback` LONGTEXT,
  `graded_by` INT,
  `graded_at` DATETIME,
  `status` ENUM('submitted', 'graded', 'resubmitted') NOT NULL DEFAULT 'submitted',
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (assignment_id) REFERENCES assignments(id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (graded_by) REFERENCES users(id),
  INDEX idx_assignment_id (assignment_id),
  INDEX idx_user_id (user_id),
  INDEX idx_status (status),
  UNIQUE KEY unique_submission (assignment_id, user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- PAYMENTS
-- ============================================

CREATE TABLE IF NOT EXISTS `payments` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `course_id` INT,
  `amount` DECIMAL(10, 2) NOT NULL,
  `payment_method` VARCHAR(50),
  `transaction_id` VARCHAR(255) UNIQUE,
  `reference_number` VARCHAR(100) UNIQUE,
  `status` ENUM('pending', 'successful', 'failed', 'cancelled', 'refunded') NOT NULL DEFAULT 'pending',
  `payment_date` DATETIME,
  `notes` TEXT,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (course_id) REFERENCES courses(id),
  INDEX idx_user_id (user_id),
  INDEX idx_status (status),
  INDEX idx_payment_date (payment_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- RECEIPTS
-- ============================================

CREATE TABLE IF NOT EXISTS `receipts` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `payment_id` INT NOT NULL,
  `receipt_number` VARCHAR(100) UNIQUE NOT NULL,
  `student_name` VARCHAR(255),
  `course_title` VARCHAR(255),
  `amount` DECIMAL(10, 2),
  `payment_method` VARCHAR(50),
  `status` ENUM('issued', 'cancelled') DEFAULT 'issued',
  `issued_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (payment_id) REFERENCES payments(id),
  INDEX idx_payment_id (payment_id),
  INDEX idx_receipt_number (receipt_number)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- CERTIFICATES
-- ============================================

CREATE TABLE IF NOT EXISTS `certificates` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `course_id` INT NOT NULL,
  `certificate_number` VARCHAR(100) UNIQUE NOT NULL,
  `issue_date` DATE,
  `expiry_date` DATE,
  `verification_code` VARCHAR(255) UNIQUE,
  `status` ENUM('issued', 'revoked', 'expired') NOT NULL DEFAULT 'issued',
  `issued_by` INT,
  `revoked_at` DATETIME,
  `revocation_reason` TEXT,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (course_id) REFERENCES courses(id),
  FOREIGN KEY (issued_by) REFERENCES users(id),
  INDEX idx_user_id (user_id),
  INDEX idx_course_id (course_id),
  INDEX idx_status (status),
  INDEX idx_verification_code (verification_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- POSTS / BLOG
-- ============================================

CREATE TABLE IF NOT EXISTS `posts` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `title` VARCHAR(255) NOT NULL,
  `slug` VARCHAR(255) UNIQUE,
  `content` LONGTEXT,
  `excerpt` TEXT,
  `featured_image` VARCHAR(255),
  `category` ENUM('business', 'technology', 'education', 'news', 'announcement', 'tutorial') NOT NULL,
  `tags` JSON,
  `author_id` INT NOT NULL,
  `status` ENUM('draft', 'published', 'unpublished', 'deleted') NOT NULL DEFAULT 'draft',
  `published_at` DATETIME,
  `comment_count` INT DEFAULT 0,
  `view_count` INT DEFAULT 0,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (author_id) REFERENCES users(id),
  INDEX idx_slug (slug),
  INDEX idx_status (status),
  INDEX idx_category (category),
  INDEX idx_published_at (published_at),
  INDEX idx_author_id (author_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- COMMENTS
-- ============================================

CREATE TABLE IF NOT EXISTS `comments` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `post_id` INT NOT NULL,
  `user_id` INT,
  `content` TEXT NOT NULL,
  `parent_id` INT,
  `status` ENUM('pending', 'approved', 'hidden', 'deleted') NOT NULL DEFAULT 'pending',
  `approved_by` INT,
  `approved_at` DATETIME,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,
  FOREIGN KEY (parent_id) REFERENCES comments(id) ON DELETE CASCADE,
  FOREIGN KEY (approved_by) REFERENCES users(id),
  INDEX idx_post_id (post_id),
  INDEX idx_status (status),
  INDEX idx_user_id (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- POST REACTIONS / LIKES
-- ============================================

CREATE TABLE IF NOT EXISTS `post_reactions` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `post_id` INT NOT NULL,
  `user_id` INT,
  `reaction_type` ENUM('like', 'love', 'wow', 'sad', 'angry') NOT NULL DEFAULT 'like',
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,
  INDEX idx_post_id (post_id),
  INDEX idx_user_id (user_id),
  UNIQUE KEY unique_reaction (post_id, user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- MESSAGES
-- ============================================

CREATE TABLE IF NOT EXISTS `messages` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `sender_id` INT NOT NULL,
  `recipient_id` INT NOT NULL,
  `subject` VARCHAR(255),
  `content` LONGTEXT NOT NULL,
  `is_read` BOOLEAN DEFAULT FALSE,
  `read_at` DATETIME,
  `status` ENUM('sent', 'deleted', 'archived') NOT NULL DEFAULT 'sent',
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (sender_id) REFERENCES users(id),
  FOREIGN KEY (recipient_id) REFERENCES users(id),
  INDEX idx_sender_id (sender_id),
  INDEX idx_recipient_id (recipient_id),
  INDEX idx_is_read (is_read)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- NOTIFICATIONS
-- ============================================

CREATE TABLE IF NOT EXISTS `notifications` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `user_id` INT,
  `title` VARCHAR(255) NOT NULL,
  `message` TEXT NOT NULL,
  `type` VARCHAR(50),
  `related_id` INT,
  `related_type` VARCHAR(50),
  `is_read` BOOLEAN DEFAULT FALSE,
  `read_at` DATETIME,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  INDEX idx_user_id (user_id),
  INDEX idx_is_read (is_read),
  INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- RESOURCES
-- ============================================

CREATE TABLE IF NOT EXISTS `resources` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `title` VARCHAR(255) NOT NULL,
  `description` TEXT,
  `resource_type` ENUM('document', 'pdf', 'video', 'link', 'image') NOT NULL,
  `file_path` VARCHAR(255),
  `file_url` VARCHAR(255),
  `section` ENUM('business', 'technology', 'education', 'general') NOT NULL,
  `tags` JSON,
  `download_count` INT DEFAULT 0,
  `status` ENUM('published', 'hidden', 'deleted') NOT NULL DEFAULT 'published',
  `uploaded_by` INT,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (uploaded_by) REFERENCES users(id),
  INDEX idx_section (section),
  INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- TESTIMONIALS
-- ============================================

CREATE TABLE IF NOT EXISTS `testimonials` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `user_id` INT,
  `course_id` INT,
  `title` VARCHAR(255),
  `content` LONGTEXT NOT NULL,
  `rating` INT,
  `status` ENUM('pending', 'approved', 'hidden', 'deleted') NOT NULL DEFAULT 'pending',
  `approved_by` INT,
  `approved_at` DATETIME,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (course_id) REFERENCES courses(id),
  FOREIGN KEY (approved_by) REFERENCES users(id),
  INDEX idx_status (status),
  INDEX idx_approved_at (approved_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- FAQs
-- ============================================

CREATE TABLE IF NOT EXISTS `faqs` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `question` VARCHAR(255) NOT NULL,
  `answer` LONGTEXT NOT NULL,
  `category` VARCHAR(100),
  `sequence` INT,
  `status` ENUM('published', 'hidden', 'deleted') NOT NULL DEFAULT 'published',
  `created_by` INT,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (created_by) REFERENCES users(id),
  INDEX idx_status (status),
  INDEX idx_sequence (sequence)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- LIVE CLASSES
-- ============================================

CREATE TABLE IF NOT EXISTS `live_classes` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `course_id` INT NOT NULL,
  `instructor_id` INT NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `description` TEXT,
  `scheduled_date` DATETIME NOT NULL,
  `duration_minutes` INT,
  `meeting_link` VARCHAR(255),
  `status` ENUM('scheduled', 'live', 'completed', 'cancelled') NOT NULL DEFAULT 'scheduled',
  `recording_url` VARCHAR(255),
  `created_by` INT,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (course_id) REFERENCES courses(id),
  FOREIGN KEY (instructor_id) REFERENCES users(id),
  FOREIGN KEY (created_by) REFERENCES users(id),
  INDEX idx_course_id (course_id),
  INDEX idx_scheduled_date (scheduled_date),
  INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- SETTINGS
-- ============================================

CREATE TABLE IF NOT EXISTS `settings` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `setting_key` VARCHAR(255) UNIQUE NOT NULL,
  `setting_value` LONGTEXT,
  `setting_type` ENUM('string', 'text', 'number', 'json', 'boolean') DEFAULT 'string',
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_setting_key (setting_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- ACTIVITY LOGS
-- ============================================

CREATE TABLE IF NOT EXISTS `activity_logs` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `user_id` INT,
  `action` VARCHAR(255) NOT NULL,
  `resource_type` VARCHAR(100),
  `resource_id` INT,
  `description` TEXT,
  `ip_address` VARCHAR(45),
  `user_agent` VARCHAR(255),
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,
  INDEX idx_user_id (user_id),
  INDEX idx_action (action),
  INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- INITIAL SETTINGS DATA
-- ============================================

INSERT INTO `settings` (`setting_key`, `setting_value`, `setting_type`) VALUES
('system_name', 'Tomlumi Academy', 'string'),
('system_tagline', 'Personal, Educational, Professional, Digital-Learning & Communication Platform', 'string'),
('logo_url', '/assets/images/logo.png', 'string'),
('favicon_url', '/assets/images/favicon.png', 'string'),
('hero_title', 'Welcome to Tomlumi Academy', 'string'),
('hero_subtitle', 'Learn, Grow, and Succeed', 'string'),
('hero_background', '/assets/images/backgrounds/hero.jpg', 'string'),
('vision', 'To be a leading digital learning platform transforming education and professional development globally.', 'text'),
('mission', 'Providing accessible, quality education in Business, Technology, and Education to empower individuals and communities.', 'text'),
('goals', 'Deliver excellence in education, Support student success, Foster innovation, Build community', 'text'),
('contact_phone', '+260971234567', 'string'),
('contact_email', 'info@tomlumi.com', 'string'),
('contact_whatsapp', '+260971234567', 'string'),
('social_facebook', 'https://facebook.com/tomlumiacademy', 'string'),
('social_twitter', 'https://twitter.com/tomlumiacademy', 'string'),
('social_instagram', 'https://instagram.com/tomlumiacademy', 'string'),
('social_youtube', 'https://youtube.com/@tomlumiacademy', 'string'),
('social_tiktok', 'https://tiktok.com/@tomlumiacademy', 'string'),
('show_business', '1', 'boolean'),
('show_technology', '1', 'boolean'),
('show_education', '1', 'boolean'),
('show_blog', '1', 'boolean'),
('show_courses', '1', 'boolean'),
('show_resources', '1', 'boolean'),
('show_communication', '1', 'boolean'),
('allow_visitor_comments', '1', 'boolean'),
('allow_visitor_registration', '1', 'boolean'),
('require_email_verification', '0', 'boolean'),
('timezone', 'Africa/Lusaka', 'string');
