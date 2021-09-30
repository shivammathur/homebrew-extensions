# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.41.0.tgz"
  sha256 "62d7320d7e26db29254bbc5770b70ba1f902952b9c6f89d34461019e7f8086a2"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "0866337dc1f826f50c673767891d35de0a4d4247ac306614b5ec17c27cf58041"
    sha256 cellar: :any_skip_relocation, big_sur:       "5b13f71f70abddec3153a8877dc0361476fe197d7668fa3e154e00d8835de612"
    sha256 cellar: :any_skip_relocation, catalina:      "6cf6f86fed80ea55c489e740836d48564739ab20b861f1567f0f6142132bee93"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f00d9dd9136d8fed3dd783772a88e3187d7c8785ce6d888e517c2e7ab57487f4"
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
