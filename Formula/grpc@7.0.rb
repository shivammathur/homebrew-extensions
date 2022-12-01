# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.51.1.tgz"
  sha256 "a8a79bf27bceeb8088c2a3a5a76c1146bbbd3e8d7a8a13e44ddbcfd715213ba9"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "bedeefe178e2cc9b90e21190ad99d14059c7d90ccb1044b59a62955aa4306716"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "77db7afd830891782d1604d23e442515e4dba2377ae89e73e4d759633b84234a"
    sha256 cellar: :any_skip_relocation, monterey:       "468fa74b7c0628de60002c6272d7a67a2a5e6009c664fab65fda18b64f424ea7"
    sha256 cellar: :any_skip_relocation, big_sur:        "32a1b6935147e6e9b22e1cd5c59fcdc8a1dc500ae837439a85c34a014716e487"
    sha256 cellar: :any_skip_relocation, catalina:       "e21aaaa0a5c172df3a49653a0572ff233f165a4399c310109d345fc1d9f9cff7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7f7fab8360d818f8d97c0bb43e5ba083d39d2a05dc813e18e4fbb91da7843bd4"
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
