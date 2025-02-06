# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT85 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.70.0.tgz"
  sha256 "11336d7bc4465148db506348006dd5559ce478eee4bf1b080bb31b89de6974b7"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a228ff594d8ac89ccf769e35b84253e4728fad65890c9ec184ca17f7888610bc"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "6c2c26bd19a94af906c2f1d14fc814c7901194f6dca8c90b9ecb550bdb71171a"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "8be1ac3156bfef92579c318bf05f34ee3ddc2411cd018c6cf46b4e1f6e1461a5"
    sha256 cellar: :any_skip_relocation, ventura:       "ea344a1d5683dd3deb9e683e0415f887cb293d30508e144792bd136a53ded89d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4807f94afcfc4859a86a833b7b7097720336006be3b7a330403b122442504f7a"
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
