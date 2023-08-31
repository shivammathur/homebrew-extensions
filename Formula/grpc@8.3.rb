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
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_monterey: "56fc6f9ce4106aa424eb2c72b97b118ec873e443b458624fdc431f0213cb72b1"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "fa15e9dad512f572c4b8a7ca19f0614c40b17d94a174b8f06705fe34c828db2b"
    sha256 cellar: :any_skip_relocation, ventura:        "f8945a2a2e741e51da2543ab1acc362f3b608215d2c36753dafaf898af525cd6"
    sha256 cellar: :any_skip_relocation, monterey:       "3a25051542fd3e4039cc0560e905be8a28202b8e2fb27490fbd20f8b4c5388e0"
    sha256 cellar: :any_skip_relocation, big_sur:        "829bc41a842cc55eb1a85b1d3d40ec6ca61bdc4b6b7ae9e1f14abf1d3e0020ef"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "63c4615bf78d27020869ee587c77223ebce8d7170cd953bc92573af33cf5487c"
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
