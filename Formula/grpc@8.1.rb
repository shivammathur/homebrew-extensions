# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.65.1.tgz"
  sha256 "78d14477f19793ac7b617bce8f8795b7f6b8888f338316f96eade83156e58e7a"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "ae9c8e03d29e3426047d117b1ad2b8768db01e6677c368b4642a9a2d5b655b7a"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "65aeebbf5ced71488015f756ab0171bc49d226bbf5b3ffb4903e9a6bd0fd560b"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "2e8c1e6fa021e952aa85dbce60d44d5fe9079c3c7c7b4b1ce2c144888b3bb49e"
    sha256 cellar: :any_skip_relocation, ventura:        "e1327b014e9a60630d0cc631576877fd626843b103f0e22583d74dbc69eb5129"
    sha256 cellar: :any_skip_relocation, monterey:       "98d1aecec35f74ed3ae37ccfa56cecebffea2bf00a066c9e7b2205ddb00ba689"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "56b571abf12892fb698c2a0d80388654820e6e44a5c70221f8dc2243dd221f9e"
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
