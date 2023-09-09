# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT84 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.58.0.tgz"
  sha256 "083e6460e111cc09a12f749329eac1bb40b21ec728a10230f8942111500625f9"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "3ac3a7ba1a6ee0853ce42f555d1e57edc7690abfb2f4cf2c956f0aa20327716e"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "59301979eb6176116933f414b4de187ac09cf503e1797ad457f8c14524167840"
    sha256 cellar: :any_skip_relocation, ventura:        "2bd0c12da01fe7eb99f3a21b36048acd8586f2b66bb7eb85f2f6073ca606ed07"
    sha256 cellar: :any_skip_relocation, monterey:       "759854059b91fbdc498cd3d521fcd2e75fa3bc2556bd9a81224336c587aabed8"
    sha256 cellar: :any_skip_relocation, big_sur:        "ea9ae7ab81e88af61bb2909cc62e451740c6bac0c112350b9e757c16f94a53d0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f29adebadcc33101b4f383c9c68b0957c0eb24a9c76860307132e6fb272161de"
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
