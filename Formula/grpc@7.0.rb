# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.71.0.tgz"
  sha256 "da142bcf578ec9ce5340fdfaf92633f6589b89885bbf77c5910fd89e244aa4c2"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "30db6fbd35dc0d78e42086a0f0e2f53a76948a56766ab657a3e85309c4f84473"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7ab714e446f882b336bc3d177c0194d2afd9134b39d678fee0763cb96623655a"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "3bff66da1468f803aeda5efed71a938fd8b0c5d4d3325d420e574b4742ee91aa"
    sha256 cellar: :any_skip_relocation, ventura:       "5e1e877e5742f6ac6ff7b3a9109066774f2dc95a0d6176fd620cb9cd1fb80c47"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ff54c0bcd0804582736a24403512060091cc3bbc61fc153c2f94c2cba8e1b6c5"
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
