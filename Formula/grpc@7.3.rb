# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.65.2.tgz"
  sha256 "5efbfd399f3be464e293bb0ec4a773fae9bb4a43b67362e1fac72bb4cae4bbc3"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "0489909e650496a295215e6e16839ed9f7d976dd1f3618ca9a6545443ef0c87d"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "5e73677b2ea28df1428276ce426842498025d820f4f7570f564d34abf3040779"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "5d491e7145609cedcaa7d2b6c51a7b195eee38626dafa279ee0193a668a619bd"
    sha256 cellar: :any_skip_relocation, ventura:        "d2c716840d8d515c6c6d022c9ac28846879d1f680017ac5c13ae67566c23b730"
    sha256 cellar: :any_skip_relocation, monterey:       "633c7af87c36408e706fbef8f0405edd83beb6d1c9c355ae253b85078b1cd037"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fc198d799624d30df4928e909dd2ee52b44be004a1a697e03328cb0179e17295"
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
