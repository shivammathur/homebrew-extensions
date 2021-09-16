# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.40.0.tgz"
  sha256 "ebfb1a2e9e8378ab65efb48b2e7d8ff23f5c5514b29f63d9558556ae6436ebf1"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "2027c46f8560a0330d655d35c3be43dea93178d4bca56e07ff5635e16258147d"
    sha256 cellar: :any_skip_relocation, big_sur:       "7315d8f843bea0bea316a90287e86a4e4a0deac606703872c223fad8c69acf6a"
    sha256 cellar: :any_skip_relocation, catalina:      "547b59102eb2b423c8e1ee030af892f75abcdd585c7213cb704e7dde869517aa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "66f2fe535cd224e33326a0bada1e871c868c697aa08b0f7253ab6a7882e80cee"
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
