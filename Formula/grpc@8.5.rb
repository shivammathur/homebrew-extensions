# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT85 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.69.0.tgz"
  sha256 "85ef59edd3517b377736c49a73799ead4729a82b960474b8842c9f89d2fbf222"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "801d818f43fc8a4c907628dd6e06b80d0a7ff5c77f63e707754a0c2eff38be97"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "38b22d3d7e66a4969fc050ef309871d0d9936243a9892e9ca3f9e0a7b9dd5b39"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "3901c7e574b08cc04c89975d8aa095b1868da3d1a678eee89af1e28d1e885e71"
    sha256 cellar: :any_skip_relocation, ventura:       "9b22c67865dff8f91ec84081673f6442f1faf607f5c3245e34fe6a986d8d277f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "add8a7f2935604cf2a795c0f3d1f31f502520d23c5521c633201608b8eb8a1e2"
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
