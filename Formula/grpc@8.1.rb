# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhp81Extension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.36.0.tgz"
  sha256 "819becd24872b95c52ad1f022ca71f6f5eed207605b19a26e479b1d5a62c8561"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "3c421316697ac5a00313f5497fad3db872928df6b68b3889546a72350dbef8bf"
    sha256 cellar: :any_skip_relocation, big_sur:       "c0a890192a95bd0ebe64a17527355f54e0b6e99ae95b029e0667a54ca79aae98"
    sha256 cellar: :any_skip_relocation, catalina:      "2479aebd14e88b37778ff74c82d8af45d66b05e176124d7ab7e8be454ddbfef2"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
