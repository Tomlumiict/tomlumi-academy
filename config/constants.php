<?php
/**
 * Tomlumi Academy Constants
 * System-wide constants for statuses, roles, and configuration
 */

// ============================================
// USER ROLES
// ============================================

define('ROLE_VISITOR', 'visitor');
define('ROLE_STUDENT', 'student');
define('ROLE_INSTRUCTOR', 'instructor');
define('ROLE_ADMIN', 'admin');

$ROLES = array(
    ROLE_VISITOR => 'Visitor',
    ROLE_STUDENT => 'Student',
    ROLE_INSTRUCTOR => 'Instructor',
    ROLE_ADMIN => 'Administrator'
);

// ============================================
// APPLICATION STATUS
// ============================================

define('APP_STATUS_PENDING', 'pending');
define('APP_STATUS_REVIEWING', 'reviewing');
define('APP_STATUS_MORE_INFO', 'more_info');
define('APP_STATUS_APPROVED', 'approved');
define('APP_STATUS_REJECTED', 'rejected');
define('APP_STATUS_ENROLLED', 'enrolled');
define('APP_STATUS_COMPLETED', 'completed');
define('APP_STATUS_CANCELLED', 'cancelled');

$APPLICATION_STATUSES = array(
    APP_STATUS_PENDING => 'Pending',
    APP_STATUS_REVIEWING => 'Under Review',
    APP_STATUS_MORE_INFO => 'More Information Required',
    APP_STATUS_APPROVED => 'Approved',
    APP_STATUS_REJECTED => 'Rejected',
    APP_STATUS_ENROLLED => 'Enrolled',
    APP_STATUS_COMPLETED => 'Completed',
    APP_STATUS_CANCELLED => 'Cancelled'
);

// ============================================
// PAYMENT STATUS
// ============================================

define('PAYMENT_PENDING', 'pending');
define('PAYMENT_SUCCESSFUL', 'successful');
define('PAYMENT_FAILED', 'failed');
define('PAYMENT_CANCELLED', 'cancelled');
define('PAYMENT_REFUNDED', 'refunded');

$PAYMENT_STATUSES = array(
    PAYMENT_PENDING => 'Pending',
    PAYMENT_SUCCESSFUL => 'Successful',
    PAYMENT_FAILED => 'Failed',
    PAYMENT_CANCELLED => 'Cancelled',
    PAYMENT_REFUNDED => 'Refunded'
);

// ============================================
// POST STATUS
// ============================================

define('POST_DRAFT', 'draft');
define('POST_PUBLISHED', 'published');
define('POST_UNPUBLISHED', 'unpublished');
define('POST_DELETED', 'deleted');

$POST_STATUSES = array(
    POST_DRAFT => 'Draft',
    POST_PUBLISHED => 'Published',
    POST_UNPUBLISHED => 'Unpublished',
    POST_DELETED => 'Deleted'
);

// ============================================
// COURSE STATUS
// ============================================

define('COURSE_DRAFT', 'draft');
define('COURSE_PUBLISHED', 'published');
define('COURSE_OPEN', 'open');
define('COURSE_CLOSED', 'closed');
define('COURSE_ARCHIVED', 'archived');
define('COURSE_DELETED', 'deleted');

$COURSE_STATUSES = array(
    COURSE_DRAFT => 'Draft',
    COURSE_PUBLISHED => 'Published',
    COURSE_OPEN => 'Open for Registration',
    COURSE_CLOSED => 'Closed for Registration',
    COURSE_ARCHIVED => 'Archived',
    COURSE_DELETED => 'Deleted'
);

// ============================================
// LEARNING MODES
// ============================================

define('MODE_PHYSICAL', 'physical');
define('MODE_ONLINE', 'online');
define('MODE_LIVE', 'live');
define('MODE_SELF_PACED', 'self_paced');
define('MODE_BLENDED', 'blended');

$LEARNING_MODES = array(
    MODE_PHYSICAL => 'Physical / Face-to-Face',
    MODE_ONLINE => 'Online',
    MODE_LIVE => 'Live Classes',
    MODE_SELF_PACED => 'Self-Paced',
    MODE_BLENDED => 'Blended Learning'
);

// ============================================
// COMMENT STATUS
// ============================================

define('COMMENT_PENDING', 'pending');
define('COMMENT_APPROVED', 'approved');
define('COMMENT_HIDDEN', 'hidden');
define('COMMENT_DELETED', 'deleted');

$COMMENT_STATUSES = array(
    COMMENT_PENDING => 'Pending',
    COMMENT_APPROVED => 'Approved',
    COMMENT_HIDDEN => 'Hidden',
    COMMENT_DELETED => 'Deleted'
);

// ============================================
// USER ACCOUNT STATUS
// ============================================

define('STATUS_ACTIVE', 'active');
define('STATUS_INACTIVE', 'inactive');
define('STATUS_SUSPENDED', 'suspended');
define('STATUS_DELETED', 'deleted');

$USER_STATUSES = array(
    STATUS_ACTIVE => 'Active',
    STATUS_INACTIVE => 'Inactive',
    STATUS_SUSPENDED => 'Suspended',
    STATUS_DELETED => 'Deleted'
);

// ============================================
// SECTIONS
// ============================================

define('SECTION_BUSINESS', 'business');
define('SECTION_TECHNOLOGY', 'technology');
define('SECTION_EDUCATION', 'education');
define('SECTION_BLOG', 'blog');

$SECTIONS = array(
    SECTION_BUSINESS => 'Business',
    SECTION_TECHNOLOGY => 'Technology',
    SECTION_EDUCATION => 'Education',
    SECTION_BLOG => 'Blog'
);

// ============================================
// ASSIGNMENT STATUS
// ============================================

define('ASSIGNMENT_PENDING', 'pending');
define('ASSIGNMENT_SUBMITTED', 'submitted');
define('ASSIGNMENT_GRADED', 'graded');
define('ASSIGNMENT_LATE', 'late');

$ASSIGNMENT_STATUSES = array(
    ASSIGNMENT_PENDING => 'Pending',
    ASSIGNMENT_SUBMITTED => 'Submitted',
    ASSIGNMENT_GRADED => 'Graded',
    ASSIGNMENT_LATE => 'Late'
);
