# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.66.0.tgz"
  sha256 "6f6b751bbf33a88f917ca11a5b32923223c106eb5f064b791f99c6f7a9c7e7c2"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "934827c806bebc9aeb290317c0306510b1ffc264885e4b476dde7d5a5a5e1310"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "9944dd4025883912fff3be56b8b990164a0bf78b40a1b7d253e5e4e440ee01e2"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "f32d06016c34af392ba3973a1cf8bf69f224798a2c8f344b27b58e845f223779"
    sha256 cellar: :any_skip_relocation, ventura:        "b9754ac5e61cd6ab8778378c6f1751a5834f7d72cab669bc6c78b4fe857764ef"
    sha256 cellar: :any_skip_relocation, monterey:       "477303d88c97158e90a1f1dd6ecf1a5fc78bb0a3f4cbad4b8a621a74832ffb8a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e1f4494f68127722c4474482bb50d3478c5665b44394e8170887a6ad307977dd"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
