# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT83 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.53.0.tgz"
  sha256 "10b214a785205bf8c5b3b8ebbeeddfdabce63a9c44399f250ba26763ae5646ab"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "469bf596cde6c81a9f5222bd581fca1e837b1a3adc22c3317885134302ce9844"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "49e24e395c4fc5db4dc42512fcab5778afdffe004ec6468f855f6cae65b3fa71"
    sha256 cellar: :any_skip_relocation, monterey:       "57ab22b09e5b17c6d0a88869a7596fec9ee4fa89374cfd165ec8df0944a2ea28"
    sha256 cellar: :any_skip_relocation, big_sur:        "2079dd3cf4dc4acb45fb8800f8da4ffa6c756560e8fa62fcca7cdaa91661e65c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "58ac19740e4c0868c318a46df081a73c88db52ec5593888331add4d034f46325"
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
