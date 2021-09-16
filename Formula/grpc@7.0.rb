# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.40.0.tgz"
  sha256 "ebfb1a2e9e8378ab65efb48b2e7d8ff23f5c5514b29f63d9558556ae6436ebf1"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "b729b92c1a5e65d3af67c99ae233f34ca00b460c6b8dd34ecae8a995d3ce312c"
    sha256 cellar: :any_skip_relocation, big_sur:       "47b77590307253a932977c25e627209a6b4123c9896b533a968d6c149da3399b"
    sha256 cellar: :any_skip_relocation, catalina:      "9bf49739f300e2bfc4c84c97889ef35ba59f7c0f919a5af95c55a286a620ae61"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "427a6544df1bffaa8b9bf82101127ab7c32b516934960e4742acbcbf8afc2bb0"
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
