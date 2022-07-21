# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.48.0.tgz"
  sha256 "4b4ccb491355f938d28e63a476df92d5109263ea63ffee1e0249616461e26963"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "2d41e29b683f61f30da0e22b4218d4e6b1f61e81db894b8663adbb3f414a0e52"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "3fca6bf0c3f880c72909c1b6c1e517f0efebf1c48b2eb2ec96bd8479969a01f3"
    sha256 cellar: :any_skip_relocation, monterey:       "6dd1452d5441abfff97256b8f5bf8a64cba0f9817b3a7eb0f29fe952f1775e0b"
    sha256 cellar: :any_skip_relocation, big_sur:        "1a5b59f4c171e9dea0910be33da94c813fdf35d14566163c18b14b951c590cb9"
    sha256 cellar: :any_skip_relocation, catalina:       "2a7158cb02b1a531a509cc6aa802088173efa0535a0c83e72fe59e93954f9b0e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4b0c7de03ac07278d24a9bf469953ea166694c532d46275ce8d4f598d1aaedd3"
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
