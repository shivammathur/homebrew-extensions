# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.43.0.tgz"
  sha256 "f4b41a6398666221fa03f7e01d2591b4b0e32aaf1aeca52810e6ef0c4a16d055"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "7b80bd82ab76a1bafc29d9d9a416dd8ed2dcaa07ccb638c866719373778b7590"
    sha256 cellar: :any_skip_relocation, big_sur:       "0b791e634ec200a691947d50e26d90672e76744c26c013f1e97a178c35d7f3f5"
    sha256 cellar: :any_skip_relocation, catalina:      "9e9d4a5d135d78e2a1f99bb5023388e8264fcab21cfe1ab5c6344bdb58722c32"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f64b8987a513030016179165d8221a2c76ef99a95cb92689263e2adb5ccdf08e"
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
