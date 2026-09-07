<?php
/**
 * Tomlumi Academy Permissions Matrix
 * Defines what each role can do in the system
 */

$PERMISSIONS = array(
    ROLE_VISITOR => array(
        'view_public_content' => true,
        'view_posts' => true,
        'view_courses' => true,
        'view_resources' => true,
        'search' => true,
        'comment' => true,
        'like_posts' => true,
        'register' => true,
        'contact_support' => true,
        'view_testimonials' => true,
        'view_faq' => true
    ),
    ROLE_STUDENT => array(
        'view_public_content' => true,
        'view_posts' => true,
        'view_courses' => true,
        'view_resources' => true,
        'search' => true,
        'comment' => true,
        'like_posts' => true,
        'register_course' => true,
        'contact_support' => true,
        'view_testimonials' => true,
        'view_faq' => true,
        'view_dashboard' => true,
        'view_own_profile' => true,
        'edit_own_profile' => true,
        'view_applications' => true,
        'view_enrolled_courses' => true,
        'view_lessons' => true,
        'view_materials' => true,
        'submit_assignment' => true,
        'view_progress' => true,
        'join_live_classes' => true,
        'view_payments' => true,
        'view_certificates' => true,
        'download_materials' => true,
        'upload_assignments' => true,
        'message_support' => true,
        'manage_own_payments' => true
    ),
    ROLE_INSTRUCTOR => array(
        'view_public_content' => true,
        'view_dashboard' => true,
        'view_own_profile' => true,
        'edit_own_profile' => true,
        'manage_assigned_courses' => true,
        'view_enrolled_students' => true,
        'view_student_details' => true,
        'manage_lessons' => true,
        'manage_materials' => true,
        'manage_assignments' => true,
        'review_submissions' => true,
        'grade_assignments' => true,
        'view_student_progress' => true,
        'manage_live_classes' => true,
        'view_schedule' => true,
        'message_students' => true,
        'view_notifications' => true,
        'create_certificates' => false,
        'manage_courses' => false,
        'manage_users' => false,
        'manage_payments' => false,
        'access_admin_panel' => false
    ),
    ROLE_ADMIN => array(
        'view_public_content' => true,
        'access_admin_panel' => true,
        'view_dashboard' => true,
        'manage_posts' => true,
        'create_post' => true,
        'edit_post' => true,
        'delete_post' => true,
        'publish_post' => true,
        'manage_courses' => true,
        'create_course' => true,
        'edit_course' => true,
        'delete_course' => true,
        'publish_course' => true,
        'open_course' => true,
        'close_course' => true,
        'manage_students' => true,
        'approve_student' => true,
        'suspend_student' => true,
        'delete_student' => true,
        'manage_instructors' => true,
        'create_instructor' => true,
        'edit_instructor' => true,
        'activate_instructor' => true,
        'suspend_instructor' => true,
        'manage_applicants' => true,
        'approve_application' => true,
        'reject_application' => true,
        'manage_payments' => true,
        'confirm_payment' => true,
        'refund_payment' => true,
        'issue_receipt' => true,
        'manage_certificates' => true,
        'create_certificate' => true,
        'verify_certificate' => true,
        'revoke_certificate' => true,
        'manage_comments' => true,
        'approve_comment' => true,
        'hide_comment' => true,
        'delete_comment' => true,
        'manage_messages' => true,
        'reply_message' => true,
        'manage_notifications' => true,
        'send_notification' => true,
        'manage_resources' => true,
        'upload_resource' => true,
        'delete_resource' => true,
        'manage_media' => true,
        'upload_media' => true,
        'manage_live_classes' => true,
        'create_live_class' => true,
        'manage_testimonials' => true,
        'approve_testimonial' => true,
        'manage_faq' => true,
        'create_faq' => true,
        'manage_users' => true,
        'create_user' => true,
        'edit_user' => true,
        'manage_roles' => true,
        'manage_settings' => true,
        'change_homepage' => true,
        'change_appearance' => true,
        'change_contact' => true,
        'change_social' => true,
        'toggle_sections' => true,
        'manage_rules' => true,
        'create_backup' => true,
        'restore_backup' => true,
        'view_logs' => true,
        'restore_content' => true,
        'manage_vision' => true,
        'manage_mission' => true,
        'manage_goals' => true
    )
);

/**
 * Check if a user role has a specific permission
 *
 * @param string $role User role
 * @param string $permission Permission to check
 * @return bool
 */
function hasPermission($role, $permission) {
    global $PERMISSIONS;
    
    if (!isset($PERMISSIONS[$role])) {
        return false;
    }
    
    return isset($PERMISSIONS[$role][$permission]) && $PERMISSIONS[$role][$permission] === true;
}

/**
 * Check if user has multiple permissions (all must be true)
 *
 * @param string $role User role
 * @param array $permissions Array of permissions
 * @return bool
 */
function hasAllPermissions($role, $permissions) {
    foreach ($permissions as $permission) {
        if (!hasPermission($role, $permission)) {
            return false;
        }
    }
    return true;
}

/**
 * Check if user has any of the permissions
 *
 * @param string $role User role
 * @param array $permissions Array of permissions
 * @return bool
 */
function hasAnyPermission($role, $permissions) {
    foreach ($permissions as $permission) {
        if (hasPermission($role, $permission)) {
            return true;
        }
    }
    return false;
}
