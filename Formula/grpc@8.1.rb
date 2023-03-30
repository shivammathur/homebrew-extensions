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
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1c758f7170eda75887a3844aa293d2b2cc8b9ef4851f65e0ad794cc2c355cb2c"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "57480f03b10ddafdb810617a93b102096298890149d298b3057229b4777f7da7"
    sha256 cellar: :any_skip_relocation, monterey:       "eaa59e3e651cc717cac7f25639b86d872cf5963a64475adaf95e6eae2484db4e"
    sha256 cellar: :any_skip_relocation, big_sur:        "bd276f3f5a99cba0e446f41e2d570ba55200ee8b410a7d08c822ddf1f890ef88"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6dbdd93bed4368d5ee21dad1ac122636a7f65baebf2a87832723702b3d059ff8"
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
