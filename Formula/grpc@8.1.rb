# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.58.0.tgz"
  sha256 "083e6460e111cc09a12f749329eac1bb40b21ec728a10230f8942111500625f9"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "1d5c61f54197e5acf6030235dded2329a2631374d28c595dd90b1e9bf159ce34"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "2f76177dde4c99ac7804ee3e1d5ed9b189d89c19465cee9e171c5eb2e2b1647d"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "a55e3b783897be02e7fc322198de0b3a323b2def6fd43afc4792a01c0e2e6120"
    sha256 cellar: :any_skip_relocation, ventura:        "488b74e0a416baeccb4ead72837609dbf4f119a7fed93a392e83feb20a65c983"
    sha256 cellar: :any_skip_relocation, monterey:       "e36a5a86c8c080980d9ca5a10afd0c5be7805e2c5bd385954745ba8f8ace457c"
    sha256 cellar: :any_skip_relocation, big_sur:        "bbc6c2072e5ecc12fe22bcbade8c8937e5b09b9348a36a83efd07a2cb76e3a8a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e5ac05f3d03091d4042507a318733518051fda7340d78d2e5c75f23dd21a5cd0"
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
