# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.46.3.tgz"
  sha256 "2aad61230afda3192eedad25be918bda628e6aa18bf1ed7e3bcf1944e6e4f4d5"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "91a961c5c86f171de91a42f6d284a662958735a39990a986fe94b9819b6b40e1"
    sha256 cellar: :any_skip_relocation, big_sur:       "20f907f7b35264f1c5f1222bed5c6e4bcfc801d497d0ec43454507dbdb4aa680"
    sha256 cellar: :any_skip_relocation, catalina:      "2aa2e2762cae6702bcb21cd1db16e29051181b1f79b4e3a39b3b883103ea8cec"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ae416f5adb57d96de8318ec0e17c9f6ef15f6b408da88a349904261b5834e3be"
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
