# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.43.0.tgz"
  sha256 "f4b41a6398666221fa03f7e01d2591b4b0e32aaf1aeca52810e6ef0c4a16d055"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "238a1efa245f24b2a5250f76141c70e6d7993ea39db1a342f7ac1904bbb04f5b"
    sha256 cellar: :any_skip_relocation, big_sur:       "600a3db7cce37d69ff4ad421cf09ed37aa524113e39296627770f51b2b9dad8d"
    sha256 cellar: :any_skip_relocation, catalina:      "05060c5278e3405e87307fd7feb83d854a2d57a8938619d56f082045789f9b57"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9fe4acb93e0f2d7a5f91e00e61bd8aec4115b7f21a782be68c2311ee821e5e87"
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
