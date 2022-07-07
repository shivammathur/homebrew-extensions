# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.47.0.tgz"
  sha256 "76e82b0786962ca1514ef43a96102b53156a2f114261baa29ef3383ee659cd6b"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d2748e845df5a2e1287c4842f55c17c6cb21c2d4b5c8779bc25fb0549e3f7f22"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "33f7d50441b17906cb0daccefabb92df370db729e47a49faf57f9c778182f65c"
    sha256 cellar: :any_skip_relocation, monterey:       "bd9a58b84de63048aef45bf645324032fd3585b3ed63d7057674d10f21f8610d"
    sha256 cellar: :any_skip_relocation, big_sur:        "2fc8c88be7d70a7afa69be4915d0da7a6cecbfe7354b29b275dbea276abe8071"
    sha256 cellar: :any_skip_relocation, catalina:       "177b49d2a94c2e16e71924e10c8eafc5203f3fef49b89c4930d620babea20dd1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "06adec73a3a6dc5394c25185c21f9b7c44f901647742093b199fa11f9879736b"
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
