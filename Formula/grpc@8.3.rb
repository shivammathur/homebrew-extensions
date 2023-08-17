# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT83 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.57.0.tgz"
  sha256 "b1ae19706fd3968584ed3079986b4cf1d6e557fc336761a336d73a435b9a7e60"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "bc51d4ba97ce26af3a5e1809fd1c0c6ab46d1fec25785b31b894a9d893f73186"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "154d3de7ec418cdf291c68e19f26f7a3c6b0661708675d5fc9ad0286f63f6d02"
    sha256 cellar: :any_skip_relocation, ventura:        "dff5c4afd022a2e9ba7426d8efc936914b977ea00d4201df53967278923755ba"
    sha256 cellar: :any_skip_relocation, monterey:       "36e7955d2ea97ac3a7829048f7ade3218d0c53d2a022f352a548a46b5fbb79b8"
    sha256 cellar: :any_skip_relocation, big_sur:        "76a4e1338a6d6bd0fcf8af4f99f1d0b2aef8a925ab72c8a9f85dda4f33c745df"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6104021bf255203db2a83304cf44b2c1dabcfcdf3b0983f6e1cd3024bdf106e0"
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
