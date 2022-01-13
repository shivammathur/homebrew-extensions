# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.43.0.tgz"
  sha256 "f4b41a6398666221fa03f7e01d2591b4b0e32aaf1aeca52810e6ef0c4a16d055"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "23d245cfe2b5c5672cb3320d60cdfef5875962da807ffefc2f857735fa9d87b9"
    sha256 cellar: :any_skip_relocation, big_sur:       "7dd3403f2e70b87a686380900a4030d8d3531def52e98791742593cc79a70742"
    sha256 cellar: :any_skip_relocation, catalina:      "750a26871aec99bc207f3259ec671c677e0b4eba3514e57fe0f00c297a542b49"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "15287172a91efdf319ba7fc22f479db477016ec4f571701532ab6edfde1e4a3a"
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
