# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.63.0.tgz"
  sha256 "0d67d0935f1e4a1feabf96a64f24e32af1918cd09ea7bef89211520f938007ca"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "be8920efce3d0ac9363536674ed224d08c6c9d8617fe79a019736fb46afa2da6"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "389958002bee79fed80878a73206d379d822ef1ad5e47638603c061f59d6fe2c"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "b53cf11ae451dd3c306a963c7495d9b98a0ae06c7abb712866749ca47cbdaeaa"
    sha256 cellar: :any_skip_relocation, ventura:        "0a928a9d35cb0cf1cf19aefd89787a86a031b0b101991b73e6c394256e726f62"
    sha256 cellar: :any_skip_relocation, monterey:       "c5613a1cf2d1a321990ace9e902e8f6c6b815d99e2cad13e922aebf6d6b59b6c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c82c0463b75f7408ec854a38167c9879697169c6e99d59819950958440ae4758"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
