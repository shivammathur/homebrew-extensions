# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "00d7f8893bda198b986a8f5f28294aaa9162b1c2b64b8ff416aa5a81a1bb5f62"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "0995a1b97c620ea8bc453b30f96a48945c8dff1a0fb186508b653df4fba7538a"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "dae4e2b59fc38665854de45a44cf638b1303b07c340587b2274d350c1559f216"
    sha256 cellar: :any_skip_relocation, ventura:       "0086fee2d6e305532b7811332518b95c508c59812ec2b100320748adfe0318ca"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "887978d5b0df993b591cbcf44666bc41178ade311a83afb4f6a31fa3dc3fcc8a"
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
