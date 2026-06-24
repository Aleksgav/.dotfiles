# frozen_string_literal: true

module Linux
  module Arch
    NetbirdServer = Packager::Package::Builder.build do
      title 'NetBird Server'
      command 'yay -S --needed --noconfirm netbird-server'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
      # No post_install enablement on purpose: netbird-server.service ships only an example /etc/netbird-server/config.yaml.
      # Edit it (domain, IDP, keys), then run: sudo systemctl enable --now netbird-server.service
    end
  end
end
