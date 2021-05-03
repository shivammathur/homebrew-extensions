# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.37.1.tgz"
  sha256 "2abefeea06491ac76862bacf16e78732ffbf4ffb0b0e4f74263d4f1a5c7745d6"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "8bc593694fb278d226106ea187ba51d66ea2d9c7a8976796871038acd5fa746f"
    sha256 cellar: :any_skip_relocation, big_sur:       "28d5ecdb92c5aae29297bb4071f46b985ec2524705d47fac9c4f3a36e8d4d924"
    sha256 cellar: :any_skip_relocation, catalina:      "466d7d7e31ba733965004114e02de1a812504500ab9af4afadfe1f3e0f8fc5e5"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
