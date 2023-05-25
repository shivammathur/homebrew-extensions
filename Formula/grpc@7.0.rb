# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.55.0.tgz"
  sha256 "75f9a465a4d1f6f337aa5dd83e5b5447064aa0a2b2776a72ec192ad7972c8295"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "672c832cc14390ee4c9444a40068badc3f0ecc0b4ea1e6cc18317bed61dd0abb"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "4a6eca4bd880b608cf1fa40a38eacc5a74d353c19c9ef9e3c9cc80c41fa88ca3"
    sha256 cellar: :any_skip_relocation, ventura:        "9f698aeee039b56b23a4c81514ad7cc97b58f59435be2b53389bfa712efcb61c"
    sha256 cellar: :any_skip_relocation, monterey:       "e8749934db2a7371623ecafd327aa3fb3b9ee982f7cfbf39c48b868aec13c806"
    sha256 cellar: :any_skip_relocation, big_sur:        "1641fe0e522603288d700aa25712314d1d6d5c90b7258708b26258981657bcb3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0b40d7919c4f33cdd499272bfea275932cf98122f062c8e25665ae1cb3fd5cf7"
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
