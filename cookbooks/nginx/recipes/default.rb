if ['solo', 'app', 'app_master'].include?(node[:instance_role])

  # be sure to replace "app_name" with the name of your application.
  run_for_app("CircleBuilder2", "JewishBuilder") do |app_name, data|
    template "/etc/nginx/servers/#{app_name}.conf" do
      source "nginx.erb"
      owner node[:owner_name]
      group node[:owner_name]
      mode 0644
      backup false
      variables({
        :app_name => app_name,
        :user => node[:owner_name], 
        :framework_env => node[:environment][:framework_env]
      })
    end
  end
end
