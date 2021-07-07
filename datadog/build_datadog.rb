# frozen_string_literal: true

require_relative '../config/environment'
require 'datadog_helper'

DatadogHelper.class_eval do
  setting = setting(
      ops_genie_team: 'wtf_bot',
      slack_channel: 'my-team-channel',
      service_name: 'wtf-bot',
      output_folder: "#{Rails.root}/datadog",
      output_environments: %w(production staging),
      dashboards: [{
         graphs: [
           graph_template('healthy_hosts'),
           {
             title: 'Health Dashboard',
             definition: {
               viz: 'timeseries',
               requests: [
                {
                  q: "avg:aws.elb.healthy_host_count{environment:$ENV, system:$SERVICE}"
                }]
             },
           },
         ]
       }],
          monitors: [
          {
              key: 'flapping_service',
              slack: true,
              definition: monitor_template('flapping_service', error_level: 2)
          },
          {
              key: 'hosts_down',
              slack: true,
              definition: monitor_template("hosts_down")
          }
      ]
  )
  setting.write_file
end
