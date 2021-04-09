# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhp71Extension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.36.0.tgz"
  sha256 "819becd24872b95c52ad1f022ca71f6f5eed207605b19a26e479b1d5a62c8561"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "1120867b8a3300ed76ca0a7fac96a4f2641d90eace947fcdfe6c84d19ce6f6cc"
    sha256 cellar: :any_skip_relocation, big_sur:       "b00dc3edcb3cee7ab373a56948ff0bd62d1aea791f5d27f0f3bdddd4aa2ebcc7"
    sha256 cellar: :any_skip_relocation, catalina:      "958f6b4748ef67113183d5db7aa238e317af87fe6fca306618a73f4e8edda8ee"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
