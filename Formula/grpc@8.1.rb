# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.45.0.tgz"
  sha256 "48f9c408167cd2c5df5d889526319f3ac4b16410599dab0ef693eef50e649488"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "baa748b3fbbe515202a00d76e687ae1f7b170a266656de8a3faef20c1f73914e"
    sha256 cellar: :any_skip_relocation, big_sur:       "c5ff2a757963c7b4d9f48fcdb9235a0b052ebdafebcc3edd54cc2350a633bf83"
    sha256 cellar: :any_skip_relocation, catalina:      "60f86a50b619c230187e7fdc8dedea686e14fb741b5e91e806258eae545db292"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "78e5459243266236dfc6e1b4a93365155a82880d86c2257d9aa92c7dedd0626a"
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
