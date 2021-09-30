# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.41.0.tgz"
  sha256 "62d7320d7e26db29254bbc5770b70ba1f902952b9c6f89d34461019e7f8086a2"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "632c570b892ee982341d7c8172972d4dc6907b15c26f2e5c1cf13268306d471c"
    sha256 cellar: :any_skip_relocation, big_sur:       "69a716505a6963b208a737a30ba78c3ad1b04f61496eec4c48ecdaa3444b620f"
    sha256 cellar: :any_skip_relocation, catalina:      "493133f1b43186bec038abadbb3b500623d5cb4e6164bde4846e1094167d692e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "79168a7042582fc37ae48ee5fddbee04490971e7ba18169b374087db3bae3c98"
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
