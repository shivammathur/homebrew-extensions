# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.63.0.tgz"
  sha256 "0d67d0935f1e4a1feabf96a64f24e32af1918cd09ea7bef89211520f938007ca"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "3d92763ae91cffbfd247d112b7bd1d7876936dd8c2818174988a22d0c4db33c9"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "36962031bbc02723a1b10496bf195ed2dd707835c349e963d006b8741dee767a"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "967f51e6ff798fbba107b2419a19afc892c0ad80b096ccd442d34a86a0238f8b"
    sha256 cellar: :any_skip_relocation, ventura:        "2c807877c460cef734c1971a01837f29d3766da0e2d45842ab6ad59427ec9158"
    sha256 cellar: :any_skip_relocation, monterey:       "ff3d98d2f99fa8f2ac53450f9565ee50a1f293d3e2f48e1cca18dd3de2e18daa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2b80b76e76a1540bd3661f6bcc5028097a2c95248d9bde2036182c348df9ff37"
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
