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
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "4889c3f486e85bd5d2839763a591f7243c05e84bb3e05e9c9cbbf287adeccea9"
    sha256 cellar: :any_skip_relocation, big_sur:       "81202143b90847bb180cf096ef2bee615d34cf281f54794326db162f33070152"
    sha256 cellar: :any_skip_relocation, catalina:      "03755034c8f3c4d8bf488ddca41c0707f55094ee9bed489d6816acbdfc316a78"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1eff5b6aa102c07b7b731bb119f5c907ab247283f040aadc130703a190e760cf"
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
