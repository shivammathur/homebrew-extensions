# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.52.1.tgz"
  sha256 "f8ce3ec8ab3678c70d57fe60982dcb6562a6cc162718cfbe74783915b49803c4"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "643bfa18ff0864841cdb2e03548f993d824001431290097c644288c9c2768127"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "e5ee0e0e04f15d97de70531ba71906ecd47e7032292acb1a0b551838a7c79962"
    sha256 cellar: :any_skip_relocation, monterey:       "20800b2b9f051e334c723daa9b7d1d0d09e581cb2c23a22687211cca541937fa"
    sha256 cellar: :any_skip_relocation, big_sur:        "4b2528825ed5982fa67b10cfcf45d67e215a9cd2feabc111ed232b46f04fc3e5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "488894495d1023d85fc4395edb54277e5fe3d58b70c6501bf2177eb5e8a1aba0"
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
