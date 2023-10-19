# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.59.1.tgz"
  sha256 "d789aab7c791647907c3bc3af2bd6b6e97348d1b50eaa59826be61c4a3c3d3ee"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "8d6f405fd5cdcc8663a8a1c115cbc91c96c836e84e465c5087f48e0e826826be"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "34f729412b48405b7340e8924ba5584cfe57a04e6c8d7d5cbc346210fca40690"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "7d99e418a58a5a43c5af3caa82cb2294fd2fac88219f07603ac27755816d1694"
    sha256 cellar: :any_skip_relocation, ventura:        "6c474cb39d070062cbe4004ddd390d5cd7ea2dd96e964eb9af4164196130c059"
    sha256 cellar: :any_skip_relocation, monterey:       "4ba3070cbc6fadec0d6a2fe8ffe8159e005117a3fc739d939902290b758a3ba6"
    sha256 cellar: :any_skip_relocation, big_sur:        "f3c2ccd38d23a15d759db8554b31131cde48973e7d0baf09ca8ef2bea1f958cf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6ee808540ad17612f425f6cd34d9eecaa3be2650478b8e655f9eefda18149c52"
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
