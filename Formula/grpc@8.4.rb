# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT84 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.65.0.tgz"
  sha256 "bee9d16d8512189498708bb72b4bc893c1480cc39012045561de67f9872d6ca0"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "7928a8aa1cf5e1b9fbcf0144f6c7b8d2334f13dbd48d56fce39eb525adfae9b9"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "1329b20fdf8cf434637655ffe4ac9f22489e753a7ded3bd7ad125c98cf99f611"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "631271864022472c5ccd667d5f765d96c4443a97806e1f11a8a8af4f84cfd65a"
    sha256 cellar: :any_skip_relocation, ventura:        "e7736bd9aa35a501fd96905087924130bec53318ce5d6d259b8d46e1ad5ed41f"
    sha256 cellar: :any_skip_relocation, monterey:       "df0d8e8566d40f9ac4d94dbd6a0a640457c01d27487e8615d2cc075a5d772cf4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "026e201d87da222a7cbb6c293f02583a74436f7bec792d28e672b55c2e85a480"
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
