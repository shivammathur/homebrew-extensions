# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.63.0.tgz"
  sha256 "0d67d0935f1e4a1feabf96a64f24e32af1918cd09ea7bef89211520f938007ca"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "b1be3704e62510e524810ea1c4afed3c8453a1f3783b010d480b76a8ffb8096c"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "3630481c9dc0dec43fcb32f254b693cfc18cc30726b0e8167d4990cf4a8b062f"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "109ae05871491452f550279ad1b540ff03f7cbadbbf8ad1b32499a9aa2711a6b"
    sha256 cellar: :any_skip_relocation, ventura:        "304afabbd22c1f82d0f0cbbc6ba4477357d746ecfb7e4fd1896d9265fa333d87"
    sha256 cellar: :any_skip_relocation, monterey:       "eb2d84c9b568601b6f7760f0629334c794bba4175e1acd1db512fac73da6d856"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5401f0fba98d5784c2d926135ef6b1fc3f4570ce64e21637af5275b32cbb7f4f"
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
