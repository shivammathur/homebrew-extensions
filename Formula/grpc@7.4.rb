# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.47.0.tgz"
  sha256 "76e82b0786962ca1514ef43a96102b53156a2f114261baa29ef3383ee659cd6b"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8c360575698c8c71a9db2389b160cb28ffc44aebd9a839f5ef7dc82b34be4656"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "059d22bb909e336fc7c9773b51c135fa09e6786b9d354e1e8378310a2d973d2e"
    sha256 cellar: :any_skip_relocation, monterey:       "ebbaef681ad11a9a816c0dfe10547909192bed2d8ea65fbac05849b7d53a0a40"
    sha256 cellar: :any_skip_relocation, big_sur:        "de177ac3b4d60ca506a33ad72b82d7e31e4a8ba251af48efc9daba1a4bbdc628"
    sha256 cellar: :any_skip_relocation, catalina:       "6080f1ac4869c69c1e70d94b37ea9ad1b90d7cb284e604199841afb8462bf2f7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1ea295d7fed9447173d2a0e5c7712565ad1e4392e9fdb51910b1393f1cde0342"
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
