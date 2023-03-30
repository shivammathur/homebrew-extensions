# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.53.0.tgz"
  sha256 "10b214a785205bf8c5b3b8ebbeeddfdabce63a9c44399f250ba26763ae5646ab"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "795c215043c09623c1bdf0d47bacaef84253f67e10b04c9c4c0bc1e4e89cf375"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "8073a215bb9bf94567a9b1bca39de5029d2f0b341a89dd3121667210dda41e35"
    sha256 cellar: :any_skip_relocation, monterey:       "f92b7321124d3dbc26e4d4b5d1c3a4354e8d0e180d5e814571286950816fa276"
    sha256 cellar: :any_skip_relocation, big_sur:        "00c52f98f4525810be2d77d0bb6cf088c38cc67f2ca862b130234a0ad69499cc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2902926e5aae77f64a2172983427cc0686b2d044c5dfc56de0bbdbfdf6e51ad0"
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
