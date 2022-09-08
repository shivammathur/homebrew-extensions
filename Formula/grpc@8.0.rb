# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.48.1.tgz"
  sha256 "74e22f8eaf833e605e72ef77df3d432bc6d99647df532d972f161874053859e0"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "74e18bb7ba1e7072b97f0e1cac999eedd1de00abb1f1541e7d00bfe8c85ab67d"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "3cef19cb140b937c8b016872bd5d4fd87c102bbd00b72ea68b52b3b87d6b4d2e"
    sha256 cellar: :any_skip_relocation, monterey:       "476df4d79ecb93cea82402e70fd103f403fe9bf129cbd5977864531b1acb337d"
    sha256 cellar: :any_skip_relocation, big_sur:        "a60ef40a14d0b9a251f3506a2b9f27705d9da0a713c369bd77b38d5337b8f55f"
    sha256 cellar: :any_skip_relocation, catalina:       "44809ba24971caa4763af338642101057979897b39361361764ff9aa1adc4455"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "01d032d8964a6fb2ea035afc078519f3c54b7f3fa8c7fa0c006f0c214e59c1a8"
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
