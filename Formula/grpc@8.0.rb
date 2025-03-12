# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "69c0384121f0c51f395980df27c5547fbfb0082b3318dbddca14b11034d20ac5"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b4a2cb6121ed989bf3bfaf4e38cfa60ff8f130c55aa46e8ed096a80e8b582ea9"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "e1a96b1861cd1cb0be2224557ccefe4330ccb5134be252485e377c3b5a38ea4d"
    sha256 cellar: :any_skip_relocation, ventura:       "a7d1438557514b0a866e68780036c9ac06238f0c074bd69ce9b7ea424c0934f2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c7c20fd11cbbaad5a699068cbc5ae9fb852c64e0751777649b7539acd6bc7eec"
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
