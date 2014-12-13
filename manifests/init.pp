class icinga(
  $accept_passive_host_checks = "1",
  $accept_passive_service_checks = "1",
  $additional_freshness_latency = "15",
  $admin_email = "root@localhost",
  $admin_pager = "pageroot@localhost",
  $auto_reschedule_checks = "0",
  $auto_rescheduling_interval = "30",
  $auto_rescheduling_window = "180",
  $broker_module = [
  ],
  $cached_host_check_horizon = "15",
  $cached_service_check_horizon = "15",
  $cfg_dir = [
    "/etc/icinga/modules",
    "/etc/icinga/objects/",
    "/etc/nagios-plugins/config",
  ],
  $cfg_file = [
    "/etc/icinga/commands.cfg",
  ],
  $check_external_commands = "0",
  $check_for_orphaned_hosts = "1",
  $check_for_orphaned_services = "1",
  $check_host_freshness = "0",
  $check_result_path = "/var/lib/icinga/spool/checkresults",
  $check_result_reaper_frequency = "10",
  $check_service_freshness = "1",
  $command_check_interval = "-1",
  $command_file = "/var/lib/icinga/rw/icinga.cmd",
  $daemon_dumps_core = "0",
  $date_format = "iso8601",
  $debug_file = "/var/log/icinga/icinga.debug",
  $debug_level = "0",
  $debug_verbosity = "2",
  $dump_retained_host_service_states_to_neb = "0",
  $enable_embedded_perl = "1",
  $enable_environment_macros = "1",
  $enable_event_handlers = "1",
  $enable_flap_detection = "1",
  $enable_notifications = "1",
  $enable_predictive_host_dependency_checks = "1",
  $enable_predictive_service_dependency_checks = "1",
  $event_broker_options = "-1",
  $event_handler_timeout = "30",
  $event_profiling_enabled = "0",
  $execute_host_checks = "1",
  $execute_service_checks = "1",
  $external_command_buffer_slots = "4096",
  $high_host_flap_threshold = "20.0",
  $high_service_flap_threshold = "20.0",
  $host_check_timeout = "30",
  $host_freshness_check_interval = "60",
  $host_inter_check_delay_method = "s",
  $icinga_group = "nagios",
  $icinga_user = "nagios",
  $illegal_macro_output_chars = "`~$&|'\"<>",
  $illegal_object_name_chars = "`~!$%^&*|'\"<>?,()",
  $interval_length = "60",
  $keep_unknown_macros = "0",
  $lock_file = "/var/run/icinga/icinga.pid",
  $log_anonymized_external_command_author = "0",
  $log_archive_path = "/var/log/icinga/archives",
  $log_current_states = "1",
  $log_event_handlers = "1",
  $log_external_commands = "1",
  $log_file = "/var/log/icinga/icinga.log",
  $log_host_retries = "1",
  $log_initial_states = "0",
  $log_long_plugin_output = "0",
  $log_notifications = "1",
  $log_passive_checks = "1",
  $log_rotation_method = "d",
  $log_service_retries = "1",
  $low_host_flap_threshold = "5.0",
  $low_service_flap_threshold = "5.0",
  $max_check_result_file_age = "3600",
  $max_check_result_reaper_time = "30",
  $max_concurrent_checks = "0",
  $max_debug_file_size = "100000000",
  $max_host_check_spread = "30",
  $max_service_check_spread = "30",
  $notification_timeout = "30",
  $object_cache_file = "/var/cache/icinga/objects.cache",
  $obsess_over_hosts = "0",
  $obsess_over_services = "0",
  $ocsp_timeout = "5",
  $p1_file = "/usr/lib/icinga/p1.pl",
  $passive_host_checks_are_soft = "0",
  $perfdata_timeout = "5",
  $precached_object_file = "/var/cache/icinga/objects.precache",
  $process_performance_data = "0",
  $resource_file = [
    "/etc/icinga/resource.cfg",
  ],
  $retained_contact_host_attribute_mask = "0",
  $retained_contact_service_attribute_mask = "0",
  $retained_host_attribute_mask = "0",
  $retained_process_host_attribute_mask = "0",
  $retained_process_service_attribute_mask = "0",
  $retained_service_attribute_mask = "0",
  $retain_state_information = "1",
  $retention_update_interval = "60",
  $service_check_timeout = "60",
  $service_check_timeout_state = "u",
  $service_freshness_check_interval = "60",
  $service_inter_check_delay_method = "s",
  $service_interleave_factor = "s",
  $sleep_time = "0.25",
  $soft_state_dependencies = "0",
  $stalking_event_handlers_for_hosts = "0",
  $stalking_event_handlers_for_services = "0",
  $stalking_notifications_for_hosts = "0",
  $stalking_notifications_for_services = "0",
  $state_retention_file = "/var/cache/icinga/retention.dat",
  $status_file = "/var/lib/icinga/status.dat",
  $status_update_interval = "10",
  $syslog_local_facility = "5",
  $temp_file = "/var/cache/icinga/icinga.tmp",
  $temp_path = "/tmp",
  $translate_passive_host_checks = "0",
  $use_aggressive_host_checking = "0",
  $use_daemon_log = "1",
  $use_embedded_perl_implicitly = "1",
  $use_large_installation_tweaks = "0",
  $use_regexp_matching = "0",
  $use_retained_program_state = "1",
  $use_retained_scheduling_info = "1",
  $use_syslog = "1",
  $use_syslog_local_facility = "0",
  $use_true_regexp_matching = "0",
) {

  if $check_external_commands == 1 {
    exec { 'icinga_dpkg_statoverride_var_lib_icinga_rw':
      command => '/usr/bin/dpkg-statoverride --update --add nagios www-data 2710 /var/lib/icinga/rw',
      notify  => Service['icinga'],
    }

    exec { 'icinga_dpkg_statoverride_var_lib_icinga':
      command => '/usr/bin/dpkg-statoverride --update --add nagios nagios 751 /var/lib/icinga',
      notify  => Service['icinga'],
    }
  }

  apt::source { 'formorer-icinga':
    release    => 'trusty',
    repos      => 'main',
    location   => 'http://ppa.launchpad.net/formorer/icinga/ubuntu',
    key        => '36862847',
    key_server => 'keyserver.ubuntu.com',
  }

  package { 'icinga':
    ensure  => present,
    require => Apt::Source['formorer-icinga'],
  }

  file { '/etc/icinga/icinga.cfg':
    content => template('icinga/icinga.cfg.erb'),
    require => Package['icinga']
    notify  => Service['icinga'],
  }

  service { 'icinga':
    ensure  => running,
    require => Package['icinga']
  }

}
