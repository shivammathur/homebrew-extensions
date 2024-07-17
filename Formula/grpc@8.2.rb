# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.65.1.tgz"
  sha256 "78d14477f19793ac7b617bce8f8795b7f6b8888f338316f96eade83156e58e7a"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "cb6c22b5a8b6d62337459784cc6b8b604b6b1f5ec5522696690eeb4793874058"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8d970391adcee5972f2fdda36a0d0c57317f86f9cd3c42bf38fa39569b4ae8b3"
    sha256 cellar: :any_skip_relocation, ventura:        "b1e1d7c9a25da87538add565b7426467a8342255e896d042720af7096088be94"
    sha256 cellar: :any_skip_relocation, monterey:       "ae03a6d15cc3433d2ea1edcca8b5b2b7972b1f6d907ad125d2a8f06ae0eb3ff7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a50eee498b1eb19fa06bbbdf28863a504942b07c9597e7a2808570ecd3558bd4"
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
