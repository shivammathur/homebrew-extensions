# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT84 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.61.0.tgz"
  sha256 "7efeff25faac9b8d92b3dc92e6c1e317e75d40a10bdc90bb3d91f2bf3aadf102"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "1b00534b02601914f55e6e1d590f26fdbaa15fd75632d1dbf1aecbc031093a03"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "bb02bb5081abe7c5770bde02fdee5e738ea0a4c39cf62496da354c12f0c2beb6"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "687d8710747f3bd51ed14719d20d3fa35ad721c4b3d10da4a3e33f01a0ee5119"
    sha256 cellar: :any_skip_relocation, ventura:        "ec85a87a6122031e021afb8cb114f66d3a1a7cbd318eb92d6f1379a909e9db96"
    sha256 cellar: :any_skip_relocation, monterey:       "36651465fba9b06efc7d67dc27037039a93d41129af10aba12a1efb37aa1867e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f8dd06eee61967bda800243e1ebe82d87e30ac9be2bda140631d62aadcc3e41d"
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
