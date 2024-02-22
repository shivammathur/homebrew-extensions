# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.62.0.tgz"
  sha256 "ceabf3c564cd3d61ca7a9a06ebdde777322e50701a454f1c5d8a5291afe59302"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "a2369102f85964ffe858cfd36bfde9503ae0979611b62071e0699a508cf78b5b"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "e6fa70c8bda7a44e2d326e19c0b2ad23f40908202c023a70b2668c925a752089"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "dbf089c7040da65f776c4b4ea0b722d2f4e85973df73e7adcc5cd348e845f643"
    sha256 cellar: :any_skip_relocation, ventura:        "b26d6c66de70f362b885c648095bd8ee54aaaae075750a0219fdca75466e2122"
    sha256 cellar: :any_skip_relocation, monterey:       "21a30157945799dbc34e80d6433bb91d65f24bc2bedeb4f966ff46fbfea3114c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7defb86a9f140091bb884fa6e248e6026fcf89791e2f1767f264fec36e07c95e"
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
