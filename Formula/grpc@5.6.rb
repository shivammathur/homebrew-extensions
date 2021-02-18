# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT56 < AbstractPhp56Extension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.33.1.tgz"
  sha256 "aa26eb1fb0d66216f709105d2605a8a72b20407076d1e9bb0bd7cb17a277582c"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "308cd8002c7140a2580511261a6d72fd498eb0a8380be4690e1155dfdfd31ab9"
    sha256 cellar: :any_skip_relocation, big_sur:       "f622cc6a4a7765f6801cea51606bb654c85b856ff3c967c0bce38221690123ee"
    sha256 cellar: :any_skip_relocation, catalina:      "a4bea154f0ed31c4f4fe7beb6f3cbe467057a7aad4a44f9db9f1e2c6c545f178"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
