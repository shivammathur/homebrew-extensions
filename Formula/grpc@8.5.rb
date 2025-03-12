# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT85 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9a22ea852aca4579da457b90f48ab17cb263b3e7ae6fdac0e538d4b313c00f54"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ec484c32616e9991b6905be00959b7f318b538c183206c9e1ada0900ba1c230e"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "7d407ba3defd8ec1a237e186f3016187e672774e7ea04ae0b2f6e0fa5c016a3d"
    sha256 cellar: :any_skip_relocation, ventura:       "87041365b0416b2d27cef14dc4113b64515f3c8cb586864d7b5a37a6db5db975"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "03bbfcc1720fc0ce0d0799055df083775128869730937272d3cea2bab486d545"
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
