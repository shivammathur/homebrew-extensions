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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "36ef0e715910f504a86d08b052e5733d66a4278ecb544bec350aca4d972c4dd4"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "7fabedd31d145aa0a84958c5d0c146f3c5bbe107835d91c0bdd51ad311a02c01"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c105076d9f3e1efbad20cc8ffd5aaecf824faef1df92b92130e8bb1e5dd57707"
    sha256 cellar: :any_skip_relocation, ventura:        "34cba329e7427e0e0efc248958abab9eb526fbd06d19e401f56697b5f064635a"
    sha256 cellar: :any_skip_relocation, monterey:       "f68733680ee9427dc3fea6fba60a720f07a006fad89d25882724e792e7ae228c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1f0ff679c21b506ff4f25877f5c540b8bc28f2330fe66600e4e8d0cb433f2ca5"
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
