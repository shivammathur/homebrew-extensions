# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.55.0.tgz"
  sha256 "75f9a465a4d1f6f337aa5dd83e5b5447064aa0a2b2776a72ec192ad7972c8295"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "6f913094850b20f29282c73da9f3a6be736d4e39be27c18f058ac0c4aa0f3648"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "b8eb05e17c369ad14f253ff78bc7f80e13060be382f9d8b3639f7267604a740a"
    sha256 cellar: :any_skip_relocation, ventura:        "9be30aeada191ff20e85e1631a82b34b428472aac562e91d3a8da6fa3907accc"
    sha256 cellar: :any_skip_relocation, monterey:       "f55f3454d827fc3b0d7c23d8a70dc85ba1b1dba4e44f7a18235d21a34a978ffd"
    sha256 cellar: :any_skip_relocation, big_sur:        "c3d2e21b7ec2626325233b4342e787b61b367eb70772ba4eaf0d636a6bef7632"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "97a23aeb6012fd76b765ab1ecf6821d6c00f1a1f8d727683918e0dd1561537a0"
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
