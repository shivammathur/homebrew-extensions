# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT83 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.65.0.tgz"
  sha256 "bee9d16d8512189498708bb72b4bc893c1480cc39012045561de67f9872d6ca0"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "18dd6b35e9a26f2faf3ba35d6cd6427a8c91b6a687d8e263b4c417cfb8cc1057"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "700d11ad0f2befa35dd403fa0b12723af12277dd85bf4e147857980e3c6e74df"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "44c33ed86504bb9171b05ca79a62e5f8f267aaa80afed72f1d3f0f07dc12098d"
    sha256 cellar: :any_skip_relocation, ventura:        "3b9f92d5ebb7ca7a9e743d47af5903d0714a9e723cfa7aa98c385ff852914e3e"
    sha256 cellar: :any_skip_relocation, monterey:       "80c63aa25b233e64ad29164daaf7b8618fcbc95ae2705e10f8d99252e4bb65c5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3bc4bf97924f30af2b2d2309a375c9f225086afbb7ac3f9f1798c6a00ba363ae"
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
