# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT83 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.71.0.tgz"
  sha256 "da142bcf578ec9ce5340fdfaf92633f6589b89885bbf77c5910fd89e244aa4c2"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "058cefa30b439aeb981ffac2ef4c76ed70adf8cd5181557d63349f861ed8c7c7"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d030b60697d46bb2f45f4a813a160896ee62ef6223293b028137cfd8077850bb"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "9a41c79c1c0ad7157842600d437466fc294ddeb0fc7a2c6e210b42455f2dbfcd"
    sha256 cellar: :any_skip_relocation, ventura:       "e9595ae2f93fb8fd57e2ae62bd192f52845b25aa0f27862bc7fa5ad65cce71c7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2a73ded9c2a610e4b9d90cba93f81d0d21669c184406343b61624d8cc3ff13f8"
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
