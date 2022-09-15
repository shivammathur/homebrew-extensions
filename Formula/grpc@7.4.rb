# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.48.1.tgz"
  sha256 "74e22f8eaf833e605e72ef77df3d432bc6d99647df532d972f161874053859e0"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "821460dcc8c5508a4b344d0643d7d16f4fd264e911abb7eed56f76b3707ee991"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "9348cd899ac0d9311ff7dbaad82df049e105c8c2a4eec0b63e72dcba82425cbf"
    sha256 cellar: :any_skip_relocation, monterey:       "92aea98c80b5ca9028318c61b965a63e09a305597f2d489fddb44c9c5fae7e22"
    sha256 cellar: :any_skip_relocation, big_sur:        "b5db38414e3439fc0b0c411b8226f584bfc2f1c6a955e80b6df592cfa87b28ef"
    sha256 cellar: :any_skip_relocation, catalina:       "c94dabcbb6040479b6b7f60ac393bd00befd604d2b39dfb8d7c9e43bd51aa82e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "91f788436858aad1305d3edc4dc04233ad1477aa52385323128336458832e3b5"
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
