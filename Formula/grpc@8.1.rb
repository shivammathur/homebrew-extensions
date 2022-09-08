# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.48.1.tgz"
  sha256 "74e22f8eaf833e605e72ef77df3d432bc6d99647df532d972f161874053859e0"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "9954ce6e694c0117b731fd0715f8976ed26533332b6d80a3ca9ad0c085c4f70d"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "476626c815bd7ab5f723b293b2f99df1eca8b6743ea1729d2c217b4e95776dba"
    sha256 cellar: :any_skip_relocation, monterey:       "ec3695e81be4fbc5a6d3805fc55f16650a66ff9bd7519f0ad8599a6816c82309"
    sha256 cellar: :any_skip_relocation, big_sur:        "9defa1b9576667bd1af256c24fbfbdb0b9742d9e2a00802369a473bf53c4d22e"
    sha256 cellar: :any_skip_relocation, catalina:       "b45327aff60b923333e160c1ec73a25960670e72441d8c8a68b1de44d63437a9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1843817ad47e4b98eb57e71ae0829a6fd2ce6480ea31c5ef24361d4286c8c526"
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
