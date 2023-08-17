# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.57.0.tgz"
  sha256 "b1ae19706fd3968584ed3079986b4cf1d6e557fc336761a336d73a435b9a7e60"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "e5f08eb01ec7e98efaaf8fd9dbce6d2098c6031747ef562a94842558b63965ec"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "55eb834a911a20a76600bb46ed0d2fac5d5578eb4a79a906cda78f9a3ccf3a93"
    sha256 cellar: :any_skip_relocation, ventura:        "003cb864c19b48070b4db7b676cc7288f26e870fec71bdf0ce3882074d6b4f67"
    sha256 cellar: :any_skip_relocation, monterey:       "e73c94bb7b1821d02a4946d6970671f5c28641d4a1ed195ab9123970457ba64b"
    sha256 cellar: :any_skip_relocation, big_sur:        "517b8cf682d65c753b71344705beef5867e84667b1577fe2a6f34454742d50f7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4dab54c70712617b571487858dacac3e4e24a0b8376495bc149c0d83fcdb4b01"
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
