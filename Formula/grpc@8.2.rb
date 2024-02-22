# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.62.0.tgz"
  sha256 "ceabf3c564cd3d61ca7a9a06ebdde777322e50701a454f1c5d8a5291afe59302"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "d4611976271b32341ecf3af260b27e1d2979f5e162caa82c989b38da5c18aeca"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "8bf24aa30b6962c8a6008a8033d8b2e08a06f30686b1477117d0fe40edc5447f"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "ecd0d829297548b4818169ec595ce871ab5992f2090287057cd2e07df2b8e840"
    sha256 cellar: :any_skip_relocation, ventura:        "71ce06fc587437b2da9988f49bf388ed4943f989fa49edc1bfe087da391d4e4e"
    sha256 cellar: :any_skip_relocation, monterey:       "8098483bb736dba5582e1c7b0d727bd09b534936d48b900ee1983ae9e8c49085"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f6e9532441aa4284a668a5a220abba89bdda0d4ff9eb2aa0f069af403d955e8d"
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
