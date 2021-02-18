# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhp74Extension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.35.0.tgz"
  sha256 "d8de1ad5df0bc424699a44133141d9d9c936d3803ae01e5510350590b8c1e4ae"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "36326405c89b8b39f8e619ebdba82cc43e3d7d5dcfe148e2fba57d2a9302892c"
    sha256 cellar: :any_skip_relocation, big_sur:       "b56a801d8e19b0da37dbe4d1ad83a2a2a2f904469fe5db7019984e766f438960"
    sha256 cellar: :any_skip_relocation, catalina:      "1def3b21b82f6a548ec11e435e53b14d4be8b3898940c1e4f63437dc2fa8d830"
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
