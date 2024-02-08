# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.61.0.tgz"
  sha256 "7efeff25faac9b8d92b3dc92e6c1e317e75d40a10bdc90bb3d91f2bf3aadf102"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "b4456a2fe09e5c8622e17a7d7f168a202af7fc8e10f35479092e4112d4a6567e"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "781a19283d4f0ebcd1f3257c8f3ed758eb78a4f32ca772bc1a916f2c0d8b7703"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a9c9d1fdbb831fb985e935617223229e9c46200e7cfd1657cf6278d669a4d5f8"
    sha256 cellar: :any_skip_relocation, ventura:        "3a09c85fcd012e440731d03baf58a1ba7e7a4b4c2cfa279f92a4d040ab08ffc4"
    sha256 cellar: :any_skip_relocation, monterey:       "a5c76e3947fb80a6a2ae65859ebb59454b3f16fee7cd8f5b79d1dd40cde5f722"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c984111a4c8d22adee7a160442010b2247729d4dc89ed2ca35ab62bd630f2e4f"
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
