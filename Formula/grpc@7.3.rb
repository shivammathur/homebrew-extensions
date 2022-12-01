# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.51.1.tgz"
  sha256 "a8a79bf27bceeb8088c2a3a5a76c1146bbbd3e8d7a8a13e44ddbcfd715213ba9"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "57f4764a77ab7486865ce3c887d119bcd889a38bc622413d6a7b5611fff0d3ba"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "71948de7a44eb0920f73b8a88091cdebc143e0799dffeedbd7fe0d4f91553dd1"
    sha256 cellar: :any_skip_relocation, monterey:       "ac9b8ad625f6242288d6f5c1eb48902a256795165d6728055e1a9a46bfe4d910"
    sha256 cellar: :any_skip_relocation, big_sur:        "831f129b94feef7bce6465468f9518affaf9b205bc81250e0a13f6caa614da58"
    sha256 cellar: :any_skip_relocation, catalina:       "0d08f36cbfee852d9c552dec7910e2f7c53ed4be7e1cbca4932bf8f89adeb06b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8283d3963327616aa364677c57da0e34ff4f4042039e5e32636db30b8faf98d1"
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
