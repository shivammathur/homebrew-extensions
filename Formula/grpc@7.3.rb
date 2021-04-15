# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.37.0.tgz"
  sha256 "591317e428276a05ca578dce778d4ade47d777a1efa9509db4dd480f82a5e822"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "270561bcf2bb8e91e2115b5c1a4b7fc884957da524548931e3f0d0fbc4e07c43"
    sha256 cellar: :any_skip_relocation, big_sur:       "62db439292ea989520eb67a7c0bc170d94c96e2185af393ff188970e9d368a2d"
    sha256 cellar: :any_skip_relocation, catalina:      "9de6107ef7d6d5bde78aafc03869bfabbdffbf07e55997b2ac5751bc24ce4177"
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
