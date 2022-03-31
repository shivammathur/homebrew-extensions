# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.45.0.tgz"
  sha256 "48f9c408167cd2c5df5d889526319f3ac4b16410599dab0ef693eef50e649488"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "e21464c7747ce277631fc545d86ae92a35147034340a3834d275788eb3e80b19"
    sha256 cellar: :any_skip_relocation, big_sur:       "fe9a09533a2ca188b0c43591fc07f33e0a69ee37e39c631739d4f5c08ff82369"
    sha256 cellar: :any_skip_relocation, catalina:      "44fbecf6814c1a4c0858b34ac32aa7974ddd722481408d35a99996f109c76078"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3dc103d1a947156b397013f31c05adb52df559f43bd52bbd2d8d4fed075b4cd4"
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
