# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.58.0.tgz"
  sha256 "083e6460e111cc09a12f749329eac1bb40b21ec728a10230f8942111500625f9"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c99cf58059e1f5cc36a42765edfe5fd9ae037678ddc8608b2a60ae94dd3e542a"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "e2b252fa50e13463cc2514deae2e1f1ac86347e82b845b39ace1634bdf8b22f3"
    sha256 cellar: :any_skip_relocation, ventura:        "874ae23612e3db9855200354ebefd84a415a4c924edf470cb17f6675a7cc025f"
    sha256 cellar: :any_skip_relocation, monterey:       "e1a88f74284b99b3b66e2359c3d23b5578777383f155ea60e04a8ba99354413f"
    sha256 cellar: :any_skip_relocation, big_sur:        "e61e3f346275acc2f74267169caaea51ace1bd0fb2744cffb8217035aea26add"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "697939343967ad63f5f898c5441880601d5a6e39a30569521f40241b99703d5a"
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
