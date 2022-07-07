# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.47.0.tgz"
  sha256 "76e82b0786962ca1514ef43a96102b53156a2f114261baa29ef3383ee659cd6b"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c451cff0e40814fb6c9049bf9168926a881e86361e279266985a45210949ae43"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "8da6aae587a7d4a41515df6d8bd463db1862525f652a9dd588d5c7449c7e210a"
    sha256 cellar: :any_skip_relocation, monterey:       "1add2811ede3fa4bb00cf03429ea4e0f7631b812980453e15ad15e2a824178ec"
    sha256 cellar: :any_skip_relocation, big_sur:        "70f1e4e6cd2865f0f4a39c6fcd61a248539b7ef9f05170719f7a9dbfacfc47f0"
    sha256 cellar: :any_skip_relocation, catalina:       "091903038faa80b3d0056da95233d0693295275ab031686f156d20d4cf3e7cc4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1a8f9a2b9985f97bbadb428b7a6cab04baecc72792187237e8698a3681cc7679"
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
