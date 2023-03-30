# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.53.0.tgz"
  sha256 "10b214a785205bf8c5b3b8ebbeeddfdabce63a9c44399f250ba26763ae5646ab"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "284f09de9ed940ea7dfa61152777591c3b8215882128c425e87ba466e3c48c46"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "cb7efd9e5e2e8f63edbbc0159de594262b2823aab14800c27251c02a488ea9e3"
    sha256 cellar: :any_skip_relocation, monterey:       "132186cb850df683fed7fa0831d3f4d7833ee570865dda9013bd04ce813abdd4"
    sha256 cellar: :any_skip_relocation, big_sur:        "80532269e3453a089480b7b3769f9e15b481f2d279529a955f1352c99ed31607"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "57611f8b9f2854a1bc65970b665f5591346ca2cfb374c64aa5ba7b3b6c525333"
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
