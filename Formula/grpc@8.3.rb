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
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1bc61129f60fc2f09935e3aef74b4e9acbf7b630987baea7b46ba6781eb548cb"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "25798a31189ff462faeb453a25cd413e8643fc12fad9d790b39260110bf0ac55"
    sha256 cellar: :any_skip_relocation, ventura:        "df583f988b1b75308d7737989d22effebaa8e6492ab741f3df8941b9394f3269"
    sha256 cellar: :any_skip_relocation, monterey:       "7d8448cf51363c45a5c4df192ceed0e81c4589946eda8ec6f13c118a38ad66cf"
    sha256 cellar: :any_skip_relocation, big_sur:        "bd265d1a833dda028469ee128bb0a3b8863b983a765d3cca95de5d6097020778"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "adfb50e2befe4876dd27c5bffbcb780eb7581e570a5b0efeb95e56b1bd6832db"
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
