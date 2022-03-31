# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.45.0.tgz"
  sha256 "48f9c408167cd2c5df5d889526319f3ac4b16410599dab0ef693eef50e649488"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "5ed5dc45e4b53ee3895d577cedf1e63a45b341b1883d00c5a7450596732d7795"
    sha256 cellar: :any_skip_relocation, big_sur:       "11e579a20a7e1e4b9b9d7bc6f62045351762201861bb174ce6153ef76bfc8706"
    sha256 cellar: :any_skip_relocation, catalina:      "5588045513f62d7af5d04f77c782a4c7833b6a0f8116c057f8c424e2dcba5fb9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "52aecb7079e5fe8ff6feed7fd910cba5d87cb05548e354b72ef7d1608914150d"
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
